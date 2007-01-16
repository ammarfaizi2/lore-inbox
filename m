Return-Path: <linux-kernel-owner+w=401wt.eu-S932281AbXAPCGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbXAPCGb (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 21:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbXAPCDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 21:03:40 -0500
Received: from 64.221.212.177.ptr.us.xo.net ([64.221.212.177]:25129 "EHLO
	ext.agami.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932214AbXAPCDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 21:03:30 -0500
X-Greylist: delayed 510 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jan 2007 21:03:27 EST
From: Nate Diller <nate@agami.com>
To: Nate Diller <nate.diller@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Benjamin LaHaise <bcrl@kvack.org>,
       Alexander Viro <viro@zeniv.linux.org.uk>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Kenneth W Chen <kenneth.w.chen@intel.com>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       netdev@vger.kernel.org, ocfs2-devel@oss.oracle.com, linux-aio@kvack.org,
       xfs-masters@oss.sgi.com
Date: Mon, 15 Jan 2007 17:54:50 -0800
Message-Id: <20070116015450.9764.62432.patchbomb.py@nate-64.agami.com>
In-Reply-To: <20070116015450.9764.37697.patchbomb.py@nate-64.agami.com>
Subject: [PATCH -mm 9/10][RFC] aio: usb gadget remove aio file ops
X-OriginalArrivalTime: 16 Jan 2007 01:55:36.0694 (UTC) FILETIME=[6A79C160:01C73911]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the aio implementation from the usb gadget file system.  Aside
from making very creative (!) use of the aio retry path, it can't be of any
use performance-wise because it always kmalloc()s a bounce buffer for the
*whole* I/O size.  Perhaps the only reason to keep it around is the ability
to cancel I/O requests, which only applies when using the user space async
I/O interface.  I highly doubt that is enough incentive to justify the extra
complexity here or in user-space, so I think it's a safe bet to remove this. 
If that feature still desired, it would be possible to implement a sync
interface that does an interruptible sleep.

I can be convinced otherwise, but the alternatives are difficult.  See for
example the "fuse, get_user_pages, flush_anon_page, aliasing caches and all
that again" LKML thread recently for why it's waaay easier to kmalloc a
bounce buffer here, and (ab)use the retry interface.

---

diff -urpN -X dontdiff a/drivers/usb/gadget/inode.c b/drivers/usb/gadget/inode.c
--- a/drivers/usb/gadget/inode.c	2007-01-10 13:23:46.000000000 -0800
+++ b/drivers/usb/gadget/inode.c	2007-01-10 16:56:09.000000000 -0800
@@ -527,218 +527,6 @@ static int ep_ioctl (struct inode *inode
 
 /*----------------------------------------------------------------------*/
 
-/* ASYNCHRONOUS ENDPOINT I/O OPERATIONS (bulk/intr/iso) */
-
-struct kiocb_priv {
-	struct usb_request	*req;
-	struct ep_data		*epdata;
-	void			*buf;
-	const struct iovec	*iv;
-	unsigned long		nr_segs;
-	unsigned		actual;
-};
-
-static int ep_aio_cancel(struct kiocb *iocb, struct io_event *e)
-{
-	struct kiocb_priv	*priv = iocb->private;
-	struct ep_data		*epdata;
-	int			value;
-
-	local_irq_disable();
-	epdata = priv->epdata;
-	// spin_lock(&epdata->dev->lock);
-	kiocbSetCancelled(iocb);
-	if (likely(epdata && epdata->ep && priv->req))
-		value = usb_ep_dequeue (epdata->ep, priv->req);
-	else
-		value = -EINVAL;
-	// spin_unlock(&epdata->dev->lock);
-	local_irq_enable();
-
-	aio_put_req(iocb);
-	return value;
-}
-
-static int ep_aio_read_retry(struct kiocb *iocb)
-{
-	struct kiocb_priv	*priv = iocb->private;
-	ssize_t			total;
-	int			i, err = 0;
-
-  	/* we "retry" to get the right mm context for this: */
-
- 	/* copy stuff into user buffers */
- 	total = priv->actual;
- 	for (i=0; i < priv->nr_segs; i++) {
- 		ssize_t this = min((ssize_t)(priv->iv[i].iov_len), total);
-
- 		if (copy_to_user(priv->iv[i].iov_base, priv->buf, this)) {
- 			err = -EFAULT;
- 			break;
- 		}
-
- 		total -= this;
- 		if (total == 0)
- 			break;
- 	}
-  	kfree(priv->buf);
-  	kfree(priv);
-  	aio_put_req(iocb);
- 	return err;
-}
-
-static void ep_aio_complete(struct usb_ep *ep, struct usb_request *req)
-{
-	struct kiocb		*iocb = req->context;
-	struct kiocb_priv	*priv = iocb->private;
-	struct ep_data		*epdata = priv->epdata;
-
-	/* lock against disconnect (and ideally, cancel) */
-	spin_lock(&epdata->dev->lock);
-	priv->req = NULL;
-	priv->epdata = NULL;
-	if (priv->iv == NULL
-			|| unlikely(req->actual == 0)
-			|| unlikely(kiocbIsCancelled(iocb))) {
-		kfree(req->buf);
-		kfree(priv);
-		iocb->private = NULL;
-		/* aio_complete() reports bytes-transferred _and_ faults */
-		if (unlikely(kiocbIsCancelled(iocb)))
-			aio_put_req(iocb);
-		else
-			aio_complete(iocb, req->actual, req->status);
-	} else {
-		/* retry() won't report both; so we hide some faults */
-		if (unlikely(0 != req->status))
-			DBG(epdata->dev, "%s fault %d len %d\n",
-				ep->name, req->status, req->actual);
-
-		priv->buf = req->buf;
-		priv->actual = req->actual;
-		kick_iocb(iocb);
-	}
-	spin_unlock(&epdata->dev->lock);
-
-	usb_ep_free_request(ep, req);
-	put_ep(epdata);
-}
-
-static ssize_t
-ep_aio_rwtail(
-	struct kiocb	*iocb,
-	char		*buf,
-	size_t		len,
-	struct ep_data	*epdata,
-	const struct iovec *iv,
-	unsigned long 	nr_segs
-)
-{
-	struct kiocb_priv	*priv;
-	struct usb_request	*req;
-	ssize_t			value;
-
-	priv = kmalloc(sizeof *priv, GFP_KERNEL);
-	if (!priv) {
-		value = -ENOMEM;
-fail:
-		kfree(buf);
-		return value;
-	}
-	iocb->private = priv;
-	priv->iv = iv;
-	priv->nr_segs = nr_segs;
-
-	value = get_ready_ep(iocb->ki_filp->f_flags, epdata);
-	if (unlikely(value < 0)) {
-		kfree(priv);
-		goto fail;
-	}
-
-	iocb->ki_cancel = ep_aio_cancel;
-	get_ep(epdata);
-	priv->epdata = epdata;
-	priv->actual = 0;
-
-	/* each kiocb is coupled to one usb_request, but we can't
-	 * allocate or submit those if the host disconnected.
-	 */
-	spin_lock_irq(&epdata->dev->lock);
-	if (likely(epdata->ep)) {
-		req = usb_ep_alloc_request(epdata->ep, GFP_ATOMIC);
-		if (likely(req)) {
-			priv->req = req;
-			req->buf = buf;
-			req->length = len;
-			req->complete = ep_aio_complete;
-			req->context = iocb;
-			value = usb_ep_queue(epdata->ep, req, GFP_ATOMIC);
-			if (unlikely(0 != value))
-				usb_ep_free_request(epdata->ep, req);
-		} else
-			value = -EAGAIN;
-	} else
-		value = -ENODEV;
-	spin_unlock_irq(&epdata->dev->lock);
-
-	up(&epdata->lock);
-
-	if (unlikely(value)) {
-		kfree(priv);
-		put_ep(epdata);
-	} else
-		value = (iv ? -EIOCBRETRY : -EIOCBQUEUED);
-	return value;
-}
-
-static ssize_t
-ep_aio_read(struct kiocb *iocb, const struct iovec *iov,
-		unsigned long nr_segs, loff_t o)
-{
-	struct ep_data		*epdata = iocb->ki_filp->private_data;
-	char			*buf;
-	size_t			len = iov_length(iov, nr_segs);
-
-	if (unlikely(epdata->desc.bEndpointAddress & USB_DIR_IN))
-		return -EINVAL;
-
-	buf = kmalloc(len, GFP_KERNEL);
-	if (unlikely(!buf))
-		return -ENOMEM;
-
-	iocb->ki_retry = ep_aio_read_retry;
-	return ep_aio_rwtail(iocb, buf, len, epdata, iov, nr_segs);
-}
-
-static ssize_t
-ep_aio_write(struct kiocb *iocb, const struct iovec *iov,
-		unsigned long nr_segs, loff_t o)
-{
-	struct ep_data		*epdata = iocb->ki_filp->private_data;
-	char			*buf;
-	size_t			len = 0;
-	int			i = 0;
-
-	if (unlikely(!(epdata->desc.bEndpointAddress & USB_DIR_IN)))
-		return -EINVAL;
-
-	buf = kmalloc(iov_length(iov, nr_segs), GFP_KERNEL);
-	if (unlikely(!buf))
-		return -ENOMEM;
-
-	for (i=0; i < nr_segs; i++) {
-		if (unlikely(copy_from_user(&buf[len], iov[i].iov_base,
-				iov[i].iov_len) != 0)) {
-			kfree(buf);
-			return -EFAULT;
-		}
-		len += iov[i].iov_len;
-	}
-	return ep_aio_rwtail(iocb, buf, len, epdata, NULL, 0);
-}
-
-/*----------------------------------------------------------------------*/
-
 /* used after endpoint configuration */
 static const struct file_operations ep_io_operations = {
 	.owner =	THIS_MODULE,
@@ -748,9 +536,6 @@ static const struct file_operations ep_i
 	.write =	ep_write,
 	.ioctl =	ep_ioctl,
 	.release =	ep_release,
-
-	.aio_read =	ep_aio_read,
-	.aio_write =	ep_aio_write,
 };
 
 /* ENDPOINT INITIALIZATION

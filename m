Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262433AbUKQQ5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbUKQQ5i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 11:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbUKQQ4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 11:56:01 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:37346 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262411AbUKQQyA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 11:54:00 -0500
Date: Wed, 17 Nov 2004 22:20:21 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kai Makisara <Kai.Makisara@metla.fi>, Willem Riede <osst@riede.org>,
       coda@cs.cmu.edu
Subject: Re: [patch 0/4] Cleanup file_count usage
Message-ID: <20041117165021.GC3152@impedimenta.in.ibm.com>
References: <20041116135200.GA23257@impedimenta.in.ibm.com> <16794.32730.184008.344036@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16794.32730.184008.344036@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 09:31:54AM +1100, Paul Mackerras wrote:
> ... 
> I suggest that as a temporary compromise, we keep PPPIOCDETACH but
> make it zero file->private_data without freeing the ppp structure that
> it points to.  That will cause a memory leak but will avoid the
> possibility of using that memory after it is freed (in the case where
> the descriptor has been dup'd and another process is doing a poll on
> it).
>

How about this patch?  This doesn't leak memory hopefully. 

--- 
Patch to cleanup reads to f_count from ppp driver, deprecate PPPIOCDETACH 
ioctl, and print warning messages if the ioctl is used.  

A new 'detached' field is included in struct ppp_file, and the ppp
channel/interface is marked as detached when PPPIOCDETACH is invoked
instead of checking the f_count and failing the ioctl for 'if the fd was
dup'd' case. The ppp structure is freed on last close.
 
Patch tested with ppp-2.4.0 and ppp-2.4.2.  I could actually dial out :)

Signed-off-by: Ravikiran Thirumalai <kiran@in.ibm.com>

---
diff -ruN -X dontdiff2 linux-2.6.9/drivers/net/ppp_generic.c f_count-2.6.9/drivers/net/ppp_generic.c
--- linux-2.6.9/drivers/net/ppp_generic.c	2004-10-19 03:25:24.000000000 +0530
+++ f_count-2.6.9/drivers/net/ppp_generic.c	2004-11-16 22:26:36.000000000 +0530
@@ -82,6 +82,7 @@
 	int		hdrlen;		/* space to leave for headers */
 	int		index;		/* interface unit / channel number */
 	int		dead;		/* unit/channel has been shut down */
+	int		detached;	/* device has been detached */
 };
 
 #define PF_TO_X(pf, X)		((X *)((char *)(pf) - offsetof(X, file)))
@@ -401,7 +402,7 @@
 
 	ret = count;
 
-	if (pf == 0)
+	if (pf == 0 || (pf && pf->detached))
 		return -ENXIO;
 	add_wait_queue(&pf->rwait, &wait);
 	for (;;) {
@@ -447,7 +448,7 @@
 	struct sk_buff *skb;
 	ssize_t ret;
 
-	if (pf == 0)
+	if (pf == 0 || (pf && pf->detached))
 		return -ENXIO;
 	ret = -ENOMEM;
 	skb = alloc_skb(count + pf->hdrlen, GFP_KERNEL);
@@ -483,7 +484,7 @@
 	struct ppp_file *pf = file->private_data;
 	unsigned int mask;
 
-	if (pf == 0)
+	if (pf == 0 || (pf && pf->detached))
 		return 0;
 	poll_wait(file, &pf->rwait, wait);
 	mask = POLLOUT | POLLWRNORM;
@@ -549,31 +550,33 @@
 	if (pf == 0)
 		return ppp_unattached_ioctl(pf, file, cmd, arg);
 
+	if (pf && pf->detached)
+		return -EAGAIN;
+
 	if (cmd == PPPIOCDETACH) {
 		/*
+		 * This ioctl is deprecated and should not be used
+		 * ioctl is lying around for binary compatibility and
+		 * will be junked at 2.7. Userland can get the same
+		 * effect as PPPIOCDETACH by closing this fd and
+		 * reopening /dev/ppp
+		 *
 		 * We have to be careful here... if the file descriptor
 		 * has been dup'd, we could have another process in the
 		 * middle of a poll using the same file *, so we had
 		 * better not free the interface data structures -
-		 * instead we fail the ioctl.  Even in this case, we
-		 * shut down the interface if we are the owner of it.
-		 * Actually, we should get rid of PPPIOCDETACH, userland
-		 * (i.e. pppd) could achieve the same effect by closing
-		 * this fd and reopening /dev/ppp.
+		 * instead we mark the interface datastructure as detached
+		 * and shut down the interface if we are the owner of it.
 		 */
-		err = -EINVAL;
 		if (pf->kind == INTERFACE) {
 			ppp = PF_TO_PPP(pf);
 			if (file == ppp->owner)
 				ppp_shutdown_interface(ppp);
 		}
-		if (atomic_read(&file->f_count) <= 2) {
-			ppp_release(inode, file);
-			err = 0;
-		} else
-			printk(KERN_DEBUG "PPPIOCDETACH file->f_count=%d\n",
-			       atomic_read(&file->f_count));
-		return err;
+		pf->detached = 1;
+		printk(KERN_WARNING "PPPIOCDETACH ioctl is deprecated; "
+				"Upgrade to ppp-2.4.2 or above.\n");
+		return 0;
 	}
 
 	if (pf->kind == CHANNEL) {
@@ -790,7 +793,7 @@
 		down(&all_ppp_sem);
 		err = -ENXIO;
 		ppp = ppp_find_unit(unit);
-		if (ppp != 0) {
+		if (ppp != 0 && !ppp->file.detached) {
 			atomic_inc(&ppp->file.refcnt);
 			file->private_data = &ppp->file;
 			err = 0;
@@ -804,7 +807,7 @@
 		spin_lock_bh(&all_channels_lock);
 		err = -ENXIO;
 		chan = ppp_find_channel(unit);
-		if (chan != 0) {
+		if (chan != 0 && !chan->file.detached) {
 			atomic_inc(&chan->file.refcnt);
 			file->private_data = &chan->file;
 			err = 0;

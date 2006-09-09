Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWIIBgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWIIBgW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 21:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWIIBgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 21:36:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:60746 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751300AbWIIBgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 21:36:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=rDBQ9r9mmHMls0jov2o5SYMAPs7puV2C1g5FMvaXe3Z49O94tnERAROhMREGfGK8RPsespdCFv7PPQbNMi9Y1tTIYrEfxmF2fsx+PY82HOBBL/ihYnpEsv4771UKTBw/uDNU+EaLBNmoiV9mSXt2iL5GTrqKk611HjacYPfaotg=
Date: Sat, 9 Sep 2006 05:36:22 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC 2/2] kmemdup: some users
Message-ID: <20060909013622.GD5192@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 arch/i386/kernel/process.c        |    5 ++---
 drivers/i2c/i2c-dev.c             |    3 +--
 fs/posix_acl.c                    |    6 ++----
 mm/mempolicy.c                    |    3 +--
 net/rxrpc/transport.c             |    3 +--
 sound/pci/echoaudio/layla24_dsp.c |    4 ++--
 sound/usb/usbaudio.c              |   11 ++++-------
 sound/usb/usbmidi.c               |    3 +--
 8 files changed, 14 insertions(+), 24 deletions(-)

--- a/arch/i386/kernel/process.c
+++ b/arch/i386/kernel/process.c
@@ -433,13 +433,12 @@ int copy_thread(int nr, unsigned long cl
 
 	tsk = current;
 	if (unlikely(test_tsk_thread_flag(tsk, TIF_IO_BITMAP))) {
-		p->thread.io_bitmap_ptr = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
+		p->thread.io_bitmap_ptr = kmemdup(tsk->thread.io_bitmap_ptr,
+						IO_BITMAP_BYTES, GFP_KERNEL);
 		if (!p->thread.io_bitmap_ptr) {
 			p->thread.io_bitmap_max = 0;
 			return -ENOMEM;
 		}
-		memcpy(p->thread.io_bitmap_ptr, tsk->thread.io_bitmap_ptr,
-			IO_BITMAP_BYTES);
 		set_tsk_thread_flag(p, TIF_IO_BITMAP);
 	}
 
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -375,12 +375,11 @@ static int i2cdev_open(struct inode *ino
 	if (!adap)
 		return -ENODEV;
 
-	client = kmalloc(sizeof(*client), GFP_KERNEL);
+	client = kmemdup(&i2cdev_client_template, sizeof(*client), GFP_KERNEL);
 	if (!client) {
 		i2c_put_adapter(adap);
 		return -ENOMEM;
 	}
-	memcpy(client, &i2cdev_client_template, sizeof(*client));
 
 	/* registered with adapter, passed as client to user */
 	client->adapter = adap;
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -58,11 +58,9 @@ posix_acl_clone(const struct posix_acl *
 	if (acl) {
 		int size = sizeof(struct posix_acl) + acl->a_count *
 		           sizeof(struct posix_acl_entry);
-		clone = kmalloc(size, flags);
-		if (clone) {
-			memcpy(clone, acl, size);
+		clone = kmemdup(acl, size, flags);
+		if (clone)
 			atomic_set(&clone->a_refcount, 1);
-		}
 	}
 	return clone;
 }
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1309,12 +1309,11 @@ struct mempolicy *__mpol_copy(struct mem
 	atomic_set(&new->refcnt, 1);
 	if (new->policy == MPOL_BIND) {
 		int sz = ksize(old->v.zonelist);
-		new->v.zonelist = kmalloc(sz, SLAB_KERNEL);
+		new->v.zonelist = kmemdup(old->v.zonelist, sz, SLAB_KERNEL);
 		if (!new->v.zonelist) {
 			kmem_cache_free(policy_cache, new);
 			return ERR_PTR(-ENOMEM);
 		}
-		memcpy(new->v.zonelist, old->v.zonelist, sz);
 	}
 	return new;
 }
--- a/net/rxrpc/transport.c
+++ b/net/rxrpc/transport.c
@@ -381,11 +381,10 @@ static int rxrpc_incoming_msg(struct rxr
 
 		/* allocate a new message record */
 		ret = -ENOMEM;
-		msg = kmalloc(sizeof(struct rxrpc_message), GFP_KERNEL);
+		msg = kmemdup(jumbomsg, sizeof(struct rxrpc_message), GFP_KERNEL);
 		if (!msg)
 			goto error;
 
-		memcpy(msg, jumbomsg, sizeof(*msg));
 		list_add_tail(&msg->link, msgq);
 
 		/* adjust the jumbo packet */
--- a/sound/pci/echoaudio/layla24_dsp.c
+++ b/sound/pci/echoaudio/layla24_dsp.c
@@ -302,11 +302,11 @@ static int switch_asic(struct echoaudio 
 
 	/*  Check to see if this is already loaded */
 	if (asic != chip->asic_code) {
-		monitors = kmalloc(MONITOR_ARRAY_SIZE, GFP_KERNEL);
+		monitors = kmemdup(chip->comm_page->monitors,
+					MONITOR_ARRAY_SIZE, GFP_KERNEL);
 		if (! monitors)
 			return -ENOMEM;
 
-		memcpy(monitors, chip->comm_page->monitors, MONITOR_ARRAY_SIZE);
 		memset(chip->comm_page->monitors, ECHOGAIN_MUTED,
 		       MONITOR_ARRAY_SIZE);
 
--- a/sound/usb/usbaudio.c
+++ b/sound/usb/usbaudio.c
@@ -2008,10 +2008,9 @@ int snd_usb_ctl_msg(struct usb_device *d
 	void *buf = NULL;
 
 	if (size > 0) {
-		buf = kmalloc(size, GFP_KERNEL);
+		buf = kmemdup(data, size, GFP_KERNEL);
 		if (!buf)
 			return -ENOMEM;
-		memcpy(buf, data, size);
 	}
 	err = usb_control_msg(dev, pipe, request, requesttype,
 			      value, index, buf, size, timeout);
@@ -2800,12 +2799,11 @@ static int create_fixed_stream_quirk(str
 	int stream, err;
 	int *rate_table = NULL;
 
-	fp = kmalloc(sizeof(*fp), GFP_KERNEL);
+	fp = kmemdup(quirk->data, sizeof(*fp), GFP_KERNEL);
 	if (! fp) {
-		snd_printk(KERN_ERR "cannot malloc\n");
+		snd_printk(KERN_ERR "cannot memdup\n");
 		return -ENOMEM;
 	}
-	memcpy(fp, quirk->data, sizeof(*fp));
 	if (fp->nr_rates > 0) {
 		rate_table = kmalloc(sizeof(int) * fp->nr_rates, GFP_KERNEL);
 		if (!rate_table) {
@@ -2983,10 +2981,9 @@ static int create_ua1000_quirk(struct sn
 	    altsd->bNumEndpoints != 1)
 		return -ENXIO;
 
-	fp = kmalloc(sizeof(*fp), GFP_KERNEL);
+	fp = kmemdup(&ua1000_format, sizeof(*fp), GFP_KERNEL);
 	if (!fp)
 		return -ENOMEM;
-	memcpy(fp, &ua1000_format, sizeof(*fp));
 
 	fp->channels = alts->extra[4];
 	fp->iface = altsd->bInterfaceNumber;
--- a/sound/usb/usbmidi.c
+++ b/sound/usb/usbmidi.c
@@ -323,10 +323,9 @@ static int send_bulk_static_data(struct 
 				 const void *data, int len)
 {
 	int err;
-	void *buf = kmalloc(len, GFP_KERNEL);
+	void *buf = kmemdup(data, len, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
-	memcpy(buf, data, len);
 	dump_urb("sending", buf, len);
 	err = usb_bulk_msg(ep->umidi->chip->dev, ep->urb->pipe, buf, len,
 			   NULL, 250);


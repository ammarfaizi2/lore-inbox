Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVBHBdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVBHBdf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 20:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbVBHBdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 20:33:35 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:3597 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S261371AbVBHBbT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 20:31:19 -0500
Date: Mon, 7 Feb 2005 17:28:56 -0800
From: Christopher Li <chrisl@vmware.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.com>
Subject: [PATCH] resend: compat ioctl for submiting URB
Message-ID: <20050208012855.GH30560@vmware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.29.0.5; VDF: 6.29.0.52; host: mailout1.vmware.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here is the resend of the patch to support compatible URB ioctl
on 64 bit systems. This version already incorporate some feed back
I get from the list and I have not get any new input yet.

Change Log:
- Let usbdevfs directly handle 32 bit URB ioctl. More specifically:
  USBDEVFS_SUBMITURB32, USBDEVFS_REAPURB32 and USBDEVFS_REAPURBNDELAY32.
  Those asynchronous ioctls are too complicate to handle by the
  compatible layer.

Thanks

Chris


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=usbdevfs-compat-5

Index: linux-2.5/include/linux/compat_ioctl.h
===================================================================
--- linux-2.5.orig/include/linux/compat_ioctl.h	2005-01-26 17:23:57.000000000 -0800
+++ linux-2.5/include/linux/compat_ioctl.h	2005-02-07 15:10:54.000000000 -0800
@@ -692,6 +692,9 @@
 COMPATIBLE_IOCTL(USBDEVFS_CONNECTINFO)
 COMPATIBLE_IOCTL(USBDEVFS_HUB_PORTINFO)
 COMPATIBLE_IOCTL(USBDEVFS_RESET)
+COMPATIBLE_IOCTL(USBDEVFS_SUBMITURB32)
+COMPATIBLE_IOCTL(USBDEVFS_REAPURB32)
+COMPATIBLE_IOCTL(USBDEVFS_REAPURBNDELAY32)
 COMPATIBLE_IOCTL(USBDEVFS_CLEAR_HALT)
 /* MTD */
 COMPATIBLE_IOCTL(MEMGETINFO)
Index: linux-2.5/include/linux/usbdevice_fs.h
===================================================================
--- linux-2.5.orig/include/linux/usbdevice_fs.h	2005-01-25 12:08:02.000000000 -0800
+++ linux-2.5/include/linux/usbdevice_fs.h	2005-02-07 15:10:54.000000000 -0800
@@ -32,6 +32,7 @@
 #define _LINUX_USBDEVICE_FS_H
 
 #include <linux/types.h>
+#include <linux/compat.h>
 
 /* --------------------------------------------------------------------- */
 
@@ -123,6 +124,22 @@
 	char port [127];	/* e.g. port 3 connects to device 27 */
 };
 
+struct usbdevfs_urb32 {
+	unsigned char type;
+	unsigned char endpoint;
+	compat_int_t status;
+	compat_uint_t flags;
+	compat_caddr_t buffer;
+	compat_int_t buffer_length;
+	compat_int_t actual_length;
+	compat_int_t start_frame;
+	compat_int_t number_of_packets;
+	compat_int_t error_count;
+	compat_uint_t signr;
+	compat_caddr_t usercontext; /* unused */
+	struct usbdevfs_iso_packet_desc iso_frame_desc[0];
+};
+
 #define USBDEVFS_CONTROL           _IOWR('U', 0, struct usbdevfs_ctrltransfer)
 #define USBDEVFS_BULK              _IOWR('U', 2, struct usbdevfs_bulktransfer)
 #define USBDEVFS_RESETEP           _IOR('U', 3, unsigned int)
@@ -130,9 +147,12 @@
 #define USBDEVFS_SETCONFIGURATION  _IOR('U', 5, unsigned int)
 #define USBDEVFS_GETDRIVER         _IOW('U', 8, struct usbdevfs_getdriver)
 #define USBDEVFS_SUBMITURB         _IOR('U', 10, struct usbdevfs_urb)
+#define USBDEVFS_SUBMITURB32       _IOR('U', 10, struct usbdevfs_urb32)
 #define USBDEVFS_DISCARDURB        _IO('U', 11)
 #define USBDEVFS_REAPURB           _IOW('U', 12, void *)
+#define USBDEVFS_REAPURB32         _IOW('U', 12, u32)
 #define USBDEVFS_REAPURBNDELAY     _IOW('U', 13, void *)
+#define USBDEVFS_REAPURBNDELAY32   _IOW('U', 13, u32)
 #define USBDEVFS_DISCSIGNAL        _IOR('U', 14, struct usbdevfs_disconnectsignal)
 #define USBDEVFS_CLAIMINTERFACE    _IOR('U', 15, unsigned int)
 #define USBDEVFS_RELEASEINTERFACE  _IOR('U', 16, unsigned int)
@@ -143,5 +163,4 @@
 #define USBDEVFS_CLEAR_HALT        _IOR('U', 21, unsigned int)
 #define USBDEVFS_DISCONNECT        _IO('U', 22)
 #define USBDEVFS_CONNECT           _IO('U', 23)
-
 #endif /* _LINUX_USBDEVICE_FS_H */
Index: linux-2.5/fs/compat_ioctl.c
===================================================================
--- linux-2.5.orig/fs/compat_ioctl.c	2005-01-25 12:08:12.000000000 -0800
+++ linux-2.5/fs/compat_ioctl.c	2005-02-07 15:18:38.000000000 -0800
@@ -2570,229 +2570,11 @@
         return sys_ioctl(fd, USBDEVFS_BULK, (unsigned long)p);
 }
 
-/* This needs more work before we can enable it.  Unfortunately
- * because of the fancy asynchronous way URB status/error is written
- * back to userspace, we'll need to fiddle with USB devio internals
- * and/or reimplement entirely the frontend of it ourselves. -DaveM
- *
- * The issue is:
- *
- *	When an URB is submitted via usbdevicefs it is put onto an
- *	asynchronous queue.  When the URB completes, it may be reaped
- *	via another ioctl.  During this reaping the status is written
- *	back to userspace along with the length of the transfer.
- *
- *	We must translate into 64-bit kernel types so we pass in a kernel
- *	space copy of the usbdevfs_urb structure.  This would mean that we
- *	must do something to deal with the async entry reaping.  First we
- *	have to deal somehow with this transitory memory we've allocated.
- *	This is problematic since there are many call sites from which the
- *	async entries can be destroyed (and thus when we'd need to free up
- *	this kernel memory).  One of which is the close() op of usbdevicefs.
- *	To handle that we'd need to make our own file_operations struct which
- *	overrides usbdevicefs's release op with our own which runs usbdevicefs's
- *	real release op then frees up the kernel memory.
- *
- *	But how to keep track of these kernel buffers?  We'd need to either
- *	keep track of them in some table _or_ know about usbdevicefs internals
- *	(ie. the exact layout of its file private, which is actually defined
- *	in linux/usbdevice_fs.h, the layout of the async queues are private to
- *	devio.c)
- *
- * There is one possible other solution I considered, also involving knowledge
- * of usbdevicefs internals:
- *
- *	After an URB is submitted, we "fix up" the address back to the user
- *	space one.  This would work if the status/length fields written back
- *	by the async URB completion lines up perfectly in the 32-bit type with
- *	the 64-bit kernel type.  Unfortunately, it does not because the iso
- *	frame descriptors, at the end of the struct, can be written back.
- *
- * I think we'll just need to simply duplicate the devio URB engine here.
- */
-#if 0
-struct usbdevfs_urb32 {
-	unsigned char type;
-	unsigned char endpoint;
-	compat_int_t status;
-	compat_uint_t flags;
-	compat_caddr_t buffer;
-	compat_int_t buffer_length;
-	compat_int_t actual_length;
-	compat_int_t start_frame;
-	compat_int_t number_of_packets;
-	compat_int_t error_count;
-	compat_uint_t signr;
-	compat_caddr_t usercontext; /* unused */
-	struct usbdevfs_iso_packet_desc iso_frame_desc[0];
-};
-
-#define USBDEVFS_SUBMITURB32       _IOR('U', 10, struct usbdevfs_urb32)
-
-static int get_urb32(struct usbdevfs_urb *kurb,
-		     struct usbdevfs_urb32 *uurb)
-{
-	if (get_user(kurb->type, &uurb->type) ||
-	    __get_user(kurb->endpoint, &uurb->endpoint) ||
-	    __get_user(kurb->status, &uurb->status) ||
-	    __get_user(kurb->flags, &uurb->flags) ||
-	    __get_user(kurb->buffer_length, &uurb->buffer_length) ||
-	    __get_user(kurb->actual_length, &uurb->actual_length) ||
-	    __get_user(kurb->start_frame, &uurb->start_frame) ||
-	    __get_user(kurb->number_of_packets, &uurb->number_of_packets) ||
-	    __get_user(kurb->error_count, &uurb->error_count) ||
-	    __get_user(kurb->signr, &uurb->signr))
-		return -EFAULT;
-
-	kurb->usercontext = 0; /* unused currently */
-
-	return 0;
-}
-
-/* Just put back the values which usbdevfs actually changes. */
-static int put_urb32(struct usbdevfs_urb *kurb,
-		     struct usbdevfs_urb32 *uurb)
-{
-	if (put_user(kurb->status, &uurb->status) ||
-	    __put_user(kurb->actual_length, &uurb->actual_length) ||
-	    __put_user(kurb->error_count, &uurb->error_count))
-		return -EFAULT;
-
-	if (kurb->number_of_packets != 0) {
-		int i;
-
-		for (i = 0; i < kurb->number_of_packets; i++) {
-			if (__put_user(kurb->iso_frame_desc[i].actual_length,
-				       &uurb->iso_frame_desc[i].actual_length) ||
-			    __put_user(kurb->iso_frame_desc[i].status,
-				       &uurb->iso_frame_desc[i].status))
-				return -EFAULT;
-		}
-	}
-
-	return 0;
-}
-
-static int get_urb32_isoframes(struct usbdevfs_urb *kurb,
-			       struct usbdevfs_urb32 *uurb)
-{
-	unsigned int totlen;
-	int i;
-
-	if (kurb->type != USBDEVFS_URB_TYPE_ISO) {
-		kurb->number_of_packets = 0;
-		return 0;
-	}
-
-	if (kurb->number_of_packets < 1 ||
-	    kurb->number_of_packets > 128)
-		return -EINVAL;
-
-	if (copy_from_user(&kurb->iso_frame_desc[0],
-			   &uurb->iso_frame_desc[0],
-			   sizeof(struct usbdevfs_iso_packet_desc) *
-			   kurb->number_of_packets))
-		return -EFAULT;
-
-	totlen = 0;
-	for (i = 0; i < kurb->number_of_packets; i++) {
-		unsigned int this_len;
-
-		this_len = kurb->iso_frame_desc[i].length;
-		if (this_len > 1023)
-			return -EINVAL;
-
-		totlen += this_len;
-	}
-
-	if (totlen > 32768)
-		return -EINVAL;
-
-	kurb->buffer_length = totlen;
-
-	return 0;
-}
-
-static int do_usbdevfs_urb(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct usbdevfs_urb *kurb;
-	struct usbdevfs_urb32 *uurb;
-	mm_segment_t old_fs;
-	__u32 udata;
-	void *uptr, *kptr;
-	unsigned int buflen;
-	int err;
-
-	uurb = compat_ptr(arg);
-
-	err = -ENOMEM;
-	kurb = kmalloc(sizeof(struct usbdevfs_urb) +
-		       (sizeof(struct usbdevfs_iso_packet_desc) * 128),
-		       GFP_KERNEL);
-	if (!kurb)
-		goto out;
-
-	err = -EFAULT;
-	if (get_urb32(kurb, uurb))
-		goto out;
-
-	err = get_urb32_isoframes(kurb, uurb);
-	if (err)
-		goto out;
-
-	err = -EFAULT;
-	if (__get_user(udata, &uurb->buffer))
-		goto out;
-	uptr = compat_ptr(udata);
-
-	buflen = kurb->buffer_length;
-	err = verify_area(VERIFY_WRITE, uptr, buflen);
-	if (err)
-		goto out;
-
 
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	err = sys_ioctl(fd, USBDEVFS_SUBMITURB, (unsigned long) kurb);
-	set_fs(old_fs);
-
-	if (err >= 0) {
-		/* RED-PEN Shit, this doesn't work for async URBs :-( XXX */
-		if (put_urb32(kurb, uurb)) {
-			err = -EFAULT;
-		}
-	}
-
-out:
-	kfree(kurb);
-	return err;
-}
-#endif
-
-#define USBDEVFS_REAPURB32         _IOW('U', 12, u32)
-#define USBDEVFS_REAPURBNDELAY32   _IOW('U', 13, u32)
-
-static int do_usbdevfs_reapurb(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-        mm_segment_t old_fs;
-        void *kptr;
-        int err;
-
-        old_fs = get_fs();
-        set_fs(KERNEL_DS);
-        err = sys_ioctl(fd,
-                        (cmd == USBDEVFS_REAPURB32 ?
-                         USBDEVFS_REAPURB :
-                         USBDEVFS_REAPURBNDELAY),
-                        (unsigned long) &kptr);
-        set_fs(old_fs);
-
-        if (err >= 0 &&
-            put_user((u32)(u64)kptr, (u32 __user *)compat_ptr(arg)))
-                err = -EFAULT;
-
-        return err;
-}
+/*
+ *  USBDEVFS_SUBMITURB, USBDEVFS_REAPURB and USBDEVFS_REAPURBNDELAY
+ *  are handled in usbdevfs core.			-Christopher Li
+ */
 
 struct usbdevfs_disconnectsignal32 {
         compat_int_t signr;
@@ -3332,9 +3114,6 @@
 /* Usbdevfs */
 HANDLE_IOCTL(USBDEVFS_CONTROL32, do_usbdevfs_control)
 HANDLE_IOCTL(USBDEVFS_BULK32, do_usbdevfs_bulk)
-/*HANDLE_IOCTL(USBDEVFS_SUBMITURB32, do_usbdevfs_urb)*/
-HANDLE_IOCTL(USBDEVFS_REAPURB32, do_usbdevfs_reapurb)
-HANDLE_IOCTL(USBDEVFS_REAPURBNDELAY32, do_usbdevfs_reapurb)
 HANDLE_IOCTL(USBDEVFS_DISCSIGNAL32, do_usbdevfs_discsignal)
 /* i2c */
 HANDLE_IOCTL(I2C_FUNCS, w_long)
Index: linux-2.5/drivers/usb/core/devio.c
===================================================================
--- linux-2.5.orig/drivers/usb/core/devio.c	2005-02-07 15:10:54.000000000 -0800
+++ linux-2.5/drivers/usb/core/devio.c	2005-02-07 15:10:54.000000000 -0800
@@ -816,9 +816,11 @@
 	return status;
 }
 
-static int proc_submiturb(struct dev_state *ps, void __user *arg)
+	
+static int proc_do_submiturb(struct dev_state *ps, struct usbdevfs_urb *uurb,
+			     struct usbdevfs_iso_packet_desc __user *iso_frame_desc,
+			     void __user *arg)
 {
-	struct usbdevfs_urb uurb;
 	struct usbdevfs_iso_packet_desc *isopkt = NULL;
 	struct usb_host_endpoint *ep;
 	struct async *as;
@@ -826,42 +828,40 @@
 	unsigned int u, totlen, isofrmlen;
 	int ret, interval = 0, ifnum = -1;
 
-	if (copy_from_user(&uurb, arg, sizeof(uurb)))
-		return -EFAULT;
-	if (uurb.flags & ~(USBDEVFS_URB_ISO_ASAP|USBDEVFS_URB_SHORT_NOT_OK|
+	if (uurb->flags & ~(USBDEVFS_URB_ISO_ASAP|USBDEVFS_URB_SHORT_NOT_OK|
 			   URB_NO_FSBR|URB_ZERO_PACKET))
 		return -EINVAL;
-	if (!uurb.buffer)
+	if (!uurb->buffer)
 		return -EINVAL;
-	if (uurb.signr != 0 && (uurb.signr < SIGRTMIN || uurb.signr > SIGRTMAX))
+	if (uurb->signr != 0 && (uurb->signr < SIGRTMIN || uurb->signr > SIGRTMAX))
 		return -EINVAL;
-	if (!(uurb.type == USBDEVFS_URB_TYPE_CONTROL && (uurb.endpoint & ~USB_ENDPOINT_DIR_MASK) == 0)) {
-		if ((ifnum = findintfep(ps->dev, uurb.endpoint)) < 0)
+	if (!(uurb->type == USBDEVFS_URB_TYPE_CONTROL && (uurb->endpoint & ~USB_ENDPOINT_DIR_MASK) == 0)) {
+		if ((ifnum = findintfep(ps->dev, uurb->endpoint)) < 0)
 			return ifnum;
 		if ((ret = checkintf(ps, ifnum)))
 			return ret;
 	}
-	if ((uurb.endpoint & ~USB_ENDPOINT_DIR_MASK) != 0)
-		ep = ps->dev->ep_in [uurb.endpoint & USB_ENDPOINT_NUMBER_MASK];
+	if ((uurb->endpoint & ~USB_ENDPOINT_DIR_MASK) != 0)
+		ep = ps->dev->ep_in [uurb->endpoint & USB_ENDPOINT_NUMBER_MASK];
 	else
-		ep = ps->dev->ep_out [uurb.endpoint & USB_ENDPOINT_NUMBER_MASK];
+		ep = ps->dev->ep_out [uurb->endpoint & USB_ENDPOINT_NUMBER_MASK];
 	if (!ep)
 		return -ENOENT;
-	switch(uurb.type) {
+	switch(uurb->type) {
 	case USBDEVFS_URB_TYPE_CONTROL:
 		if ((ep->desc.bmAttributes & USB_ENDPOINT_XFERTYPE_MASK)
 				!= USB_ENDPOINT_XFER_CONTROL)
 			return -EINVAL;
 		/* min 8 byte setup packet, max arbitrary */
-		if (uurb.buffer_length < 8 || uurb.buffer_length > PAGE_SIZE)
+		if (uurb->buffer_length < 8 || uurb->buffer_length > PAGE_SIZE)
 			return -EINVAL;
 		if (!(dr = kmalloc(sizeof(struct usb_ctrlrequest), GFP_KERNEL)))
 			return -ENOMEM;
-		if (copy_from_user(dr, uurb.buffer, 8)) {
+		if (copy_from_user(dr, uurb->buffer, 8)) {
 			kfree(dr);
 			return -EFAULT;
 		}
-		if (uurb.buffer_length < (le16_to_cpup(&dr->wLength) + 8)) {
+		if (uurb->buffer_length < (le16_to_cpup(&dr->wLength) + 8)) {
 			kfree(dr);
 			return -EINVAL;
 		}
@@ -869,11 +869,11 @@
 			kfree(dr);
 			return ret;
 		}
-		uurb.endpoint = (uurb.endpoint & ~USB_ENDPOINT_DIR_MASK) | (dr->bRequestType & USB_ENDPOINT_DIR_MASK);
-		uurb.number_of_packets = 0;
-		uurb.buffer_length = le16_to_cpup(&dr->wLength);
-		uurb.buffer += 8;
-		if (!access_ok((uurb.endpoint & USB_DIR_IN) ?  VERIFY_WRITE : VERIFY_READ, uurb.buffer, uurb.buffer_length)) {
+		uurb->endpoint = (uurb->endpoint & ~USB_ENDPOINT_DIR_MASK) | (dr->bRequestType & USB_ENDPOINT_DIR_MASK);
+		uurb->number_of_packets = 0;
+		uurb->buffer_length = le16_to_cpup(&dr->wLength);
+		uurb->buffer += 8;
+		if (!access_ok((uurb->endpoint & USB_DIR_IN) ?  VERIFY_WRITE : VERIFY_READ, uurb->buffer, uurb->buffer_length)) {
 			kfree(dr);
 			return -EFAULT;
 		}
@@ -886,29 +886,29 @@
 			return -EINVAL;
 		/* allow single-shot interrupt transfers, at bogus rates */
 		}
-		uurb.number_of_packets = 0;
-		if (uurb.buffer_length > MAX_USBFS_BUFFER_SIZE)
+		uurb->number_of_packets = 0;
+		if (uurb->buffer_length > MAX_USBFS_BUFFER_SIZE)
 			return -EINVAL;
-		if (!access_ok((uurb.endpoint & USB_DIR_IN) ? VERIFY_WRITE : VERIFY_READ, uurb.buffer, uurb.buffer_length))
+		if (!access_ok((uurb->endpoint & USB_DIR_IN) ? VERIFY_WRITE : VERIFY_READ, uurb->buffer, uurb->buffer_length))
 			return -EFAULT;
 		break;
 
 	case USBDEVFS_URB_TYPE_ISO:
 		/* arbitrary limit */
-		if (uurb.number_of_packets < 1 || uurb.number_of_packets > 128)
+		if (uurb->number_of_packets < 1 || uurb->number_of_packets > 128)
 			return -EINVAL;
 		if ((ep->desc.bmAttributes & USB_ENDPOINT_XFERTYPE_MASK)
 				!= USB_ENDPOINT_XFER_ISOC)
 			return -EINVAL;
 		interval = 1 << min (15, ep->desc.bInterval - 1);
-		isofrmlen = sizeof(struct usbdevfs_iso_packet_desc) * uurb.number_of_packets;
+		isofrmlen = sizeof(struct usbdevfs_iso_packet_desc) * uurb->number_of_packets;
 		if (!(isopkt = kmalloc(isofrmlen, GFP_KERNEL)))
 			return -ENOMEM;
-		if (copy_from_user(isopkt, &((struct usbdevfs_urb __user *)arg)->iso_frame_desc, isofrmlen)) {
+		if (copy_from_user(isopkt, iso_frame_desc, isofrmlen)) {
 			kfree(isopkt);
 			return -EFAULT;
 		}
-		for (totlen = u = 0; u < uurb.number_of_packets; u++) {
+		for (totlen = u = 0; u < uurb->number_of_packets; u++) {
 			if (isopkt[u].length > 1023) {
 				kfree(isopkt);
 				return -EINVAL;
@@ -919,11 +919,11 @@
 			kfree(isopkt);
 			return -EINVAL;
 		}
-		uurb.buffer_length = totlen;
+		uurb->buffer_length = totlen;
 		break;
 
 	case USBDEVFS_URB_TYPE_INTERRUPT:
-		uurb.number_of_packets = 0;
+		uurb->number_of_packets = 0;
 		if ((ep->desc.bmAttributes & USB_ENDPOINT_XFERTYPE_MASK)
 				!= USB_ENDPOINT_XFER_INT)
 			return -EINVAL;
@@ -931,23 +931,23 @@
 			interval = 1 << min (15, ep->desc.bInterval - 1);
 		else
 			interval = ep->desc.bInterval;
-		if (uurb.buffer_length > MAX_USBFS_BUFFER_SIZE)
+		if (uurb->buffer_length > MAX_USBFS_BUFFER_SIZE)
 			return -EINVAL;
-		if (!access_ok((uurb.endpoint & USB_DIR_IN) ? VERIFY_WRITE : VERIFY_READ, uurb.buffer, uurb.buffer_length))
+		if (!access_ok((uurb->endpoint & USB_DIR_IN) ? VERIFY_WRITE : VERIFY_READ, uurb->buffer, uurb->buffer_length))
 			return -EFAULT;
 		break;
 
 	default:
 		return -EINVAL;
 	}
-	if (!(as = alloc_async(uurb.number_of_packets))) {
+	if (!(as = alloc_async(uurb->number_of_packets))) {
 		if (isopkt)
 			kfree(isopkt);
 		if (dr)
 			kfree(dr);
 		return -ENOMEM;
 	}
-	if (!(as->urb->transfer_buffer = kmalloc(uurb.buffer_length, GFP_KERNEL))) {
+	if (!(as->urb->transfer_buffer = kmalloc(uurb->buffer_length, GFP_KERNEL))) {
 		if (isopkt)
 			kfree(isopkt);
 		if (dr)
@@ -956,16 +956,16 @@
 		return -ENOMEM;
 	}
         as->urb->dev = ps->dev;
-        as->urb->pipe = (uurb.type << 30) | __create_pipe(ps->dev, uurb.endpoint & 0xf) | (uurb.endpoint & USB_DIR_IN);
-        as->urb->transfer_flags = uurb.flags;
-	as->urb->transfer_buffer_length = uurb.buffer_length;
+        as->urb->pipe = (uurb->type << 30) | __create_pipe(ps->dev, uurb->endpoint & 0xf) | (uurb->endpoint & USB_DIR_IN);
+        as->urb->transfer_flags = uurb->flags;
+	as->urb->transfer_buffer_length = uurb->buffer_length;
 	as->urb->setup_packet = (unsigned char*)dr;
-	as->urb->start_frame = uurb.start_frame;
-	as->urb->number_of_packets = uurb.number_of_packets;
+	as->urb->start_frame = uurb->start_frame;
+	as->urb->number_of_packets = uurb->number_of_packets;
 	as->urb->interval = interval;
         as->urb->context = as;
         as->urb->complete = async_completed;
-	for (totlen = u = 0; u < uurb.number_of_packets; u++) {
+	for (totlen = u = 0; u < uurb->number_of_packets; u++) {
 		as->urb->iso_frame_desc[u].offset = totlen;
 		as->urb->iso_frame_desc[u].length = isopkt[u].length;
 		totlen += isopkt[u].length;
@@ -974,15 +974,15 @@
 		kfree(isopkt);
 	as->ps = ps;
         as->userurb = arg;
-	if (uurb.endpoint & USB_DIR_IN)
-		as->userbuffer = uurb.buffer;
+	if (uurb->endpoint & USB_DIR_IN)
+		as->userbuffer = uurb->buffer;
 	else
 		as->userbuffer = NULL;
-	as->signr = uurb.signr;
+	as->signr = uurb->signr;
 	as->ifnum = ifnum;
 	as->task = current;
-	if (!(uurb.endpoint & USB_DIR_IN)) {
-		if (copy_from_user(as->urb->transfer_buffer, uurb.buffer, as->urb->transfer_buffer_length)) {
+	if (!(uurb->endpoint & USB_DIR_IN)) {
+		if (copy_from_user(as->urb->transfer_buffer, uurb->buffer, as->urb->transfer_buffer_length)) {
 			free_async(as);
 			return -EFAULT;
 		}
@@ -997,6 +997,16 @@
         return 0;
 }
 
+static int proc_submiturb(struct dev_state *ps, void __user *arg)
+{
+	struct usbdevfs_urb uurb;
+
+	if (copy_from_user(&uurb, arg, sizeof(uurb)))
+		return -EFAULT;
+
+	return proc_do_submiturb(ps, &uurb, (((struct usbdevfs_urb __user *)arg)->iso_frame_desc), arg);
+}
+
 static int proc_unlinkurb(struct dev_state *ps, void __user *arg)
 {
 	struct async *as;
@@ -1008,10 +1018,11 @@
 	return 0;
 }
 
-static int processcompl(struct async *as)
+static int processcompl(struct async *as, void __user * __user *arg)
 {
 	struct urb *urb = as->urb;
 	struct usbdevfs_urb __user *userurb = as->userurb;
+	void __user *addr = as->userurb;
 	unsigned int i;
 
 	if (as->userbuffer)
@@ -1034,16 +1045,19 @@
 			     &userurb->iso_frame_desc[i].status))
 			return -EFAULT;
 	}
+
+	free_async(as);
+
+	if (put_user(addr, (void __user * __user *)arg))
+		return -EFAULT;
 	return 0;
 }
 
-static int proc_reapurb(struct dev_state *ps, void __user *arg)
+static struct async* reap_as(struct dev_state *ps)
 {
         DECLARE_WAITQUEUE(wait, current);
 	struct async *as = NULL;
-	void __user *addr;
 	struct usb_device *dev = ps->dev;
-	int ret;
 
 	add_wait_queue(&ps->wait, &wait);
 	for (;;) {
@@ -1058,16 +1072,14 @@
 	}
 	remove_wait_queue(&ps->wait, &wait);
 	set_current_state(TASK_RUNNING);
-	if (as) {
-		ret = processcompl(as);
-		addr = as->userurb;
-		free_async(as);
-		if (ret)
-			return ret;
-		if (put_user(addr, (void __user * __user *)arg))
-			return -EFAULT;
-		return 0;
-	}
+	return as;
+}
+
+static int proc_reapurb(struct dev_state *ps, void __user *arg)
+{
+	struct async *as = reap_as(ps);
+	if (as) 
+		return processcompl(as, (void __user * __user *)arg);
 	if (signal_pending(current))
 		return -EINTR;
 	return -EIO;
@@ -1076,21 +1088,107 @@
 static int proc_reapurbnonblock(struct dev_state *ps, void __user *arg)
 {
 	struct async *as;
-	void __user *addr;
-	int ret;
 
 	if (!(as = async_getcompleted(ps)))
 		return -EAGAIN;
-	ret = processcompl(as);
-	addr = as->userurb;
+	return processcompl(as, (void __user * __user *)arg);
+}
+
+#ifdef CONFIG_COMPAT
+
+static int get_urb32(struct usbdevfs_urb *kurb,
+		     struct usbdevfs_urb32 __user *uurb)
+{
+	__u32  uptr;
+	if (get_user(kurb->type, &uurb->type) ||
+	    __get_user(kurb->endpoint, &uurb->endpoint) ||
+	    __get_user(kurb->status, &uurb->status) ||
+	    __get_user(kurb->flags, &uurb->flags) ||
+	    __get_user(kurb->buffer_length, &uurb->buffer_length) ||
+	    __get_user(kurb->actual_length, &uurb->actual_length) ||
+	    __get_user(kurb->start_frame, &uurb->start_frame) ||
+	    __get_user(kurb->number_of_packets, &uurb->number_of_packets) ||
+	    __get_user(kurb->error_count, &uurb->error_count) ||
+	    __get_user(kurb->signr, &uurb->signr))
+		return -EFAULT;
+
+	if (__get_user(uptr, &uurb->buffer))
+		return -EFAULT;
+	kurb->buffer = compat_ptr(uptr);
+	if (__get_user(uptr, &uurb->buffer))
+		return -EFAULT;
+	kurb->usercontext = compat_ptr(uptr);
+
+	return 0;
+}
+
+static int proc_submiturb_compat(struct dev_state *ps, void __user *arg)
+{
+	struct usbdevfs_urb uurb;
+
+	if (get_urb32(&uurb,(struct usbdevfs_urb32 *)arg))
+		return -EFAULT;
+
+	return proc_do_submiturb(ps, &uurb, ((struct usbdevfs_urb __user *)arg)->iso_frame_desc, arg);
+}
+
+static int processcompl_compat(struct async *as, void __user * __user *arg)
+{
+	struct urb *urb = as->urb;
+	struct usbdevfs_urb32 __user *userurb = as->userurb;
+	void __user *addr = as->userurb;
+	unsigned int i;
+
+	if (as->userbuffer)
+		if (copy_to_user(as->userbuffer, urb->transfer_buffer, urb->transfer_buffer_length))
+			return -EFAULT;
+	if (put_user(urb->status, &userurb->status))
+		return -EFAULT;
+	if (put_user(urb->actual_length, &userurb->actual_length))
+		return -EFAULT;
+	if (put_user(urb->error_count, &userurb->error_count))
+		return -EFAULT;
+
+	if (!(usb_pipeisoc(urb->pipe)))
+		return 0;
+	for (i = 0; i < urb->number_of_packets; i++) {
+		if (put_user(urb->iso_frame_desc[i].actual_length,
+			     &userurb->iso_frame_desc[i].actual_length))
+			return -EFAULT;
+		if (put_user(urb->iso_frame_desc[i].status,
+			     &userurb->iso_frame_desc[i].status))
+			return -EFAULT;
+	}
+
 	free_async(as);
-	if (ret)
-		return ret;
-	if (put_user(addr, (void __user * __user *)arg))
+	if (put_user((u32)(u64)addr, (u32 __user *)arg))
 		return -EFAULT;
 	return 0;
 }
 
+static int proc_reapurb_compat(struct dev_state *ps, void __user *arg)
+{
+	struct async *as = reap_as(ps);
+	if (as) 
+		return processcompl_compat(as, (void __user * __user *)arg);
+	if (signal_pending(current))
+		return -EINTR;
+	return -EIO;
+}
+
+static int proc_reapurbnonblock_compat(struct dev_state *ps, void __user *arg)
+{
+	struct async *as;
+
+	printk("reapurbnblock\n");
+	if (!(as = async_getcompleted(ps)))
+		return -EAGAIN;
+	printk("reap got as %p\n", as);
+	return processcompl_compat(as, (void __user * __user *)arg);
+}
+
+#endif
+
 static int proc_disconnectsignal(struct dev_state *ps, void __user *arg)
 {
 	struct usbdevfs_disconnectsignal ds;
@@ -1302,6 +1400,27 @@
 			inode->i_mtime = CURRENT_TIME;
 		break;
 
+#ifdef CONFIG_COMPAT
+
+	case USBDEVFS_SUBMITURB32:
+		snoop(&dev->dev, "%s: SUBMITURB32\n", __FUNCTION__);
+		ret = proc_submiturb_compat(ps, p);
+		if (ret >= 0)
+			inode->i_mtime = CURRENT_TIME;
+		break;
+
+	case USBDEVFS_REAPURB32:
+		snoop(&dev->dev, "%s: REAPURB32\n", __FUNCTION__);
+		ret = proc_reapurb_compat(ps, p);
+		break;
+
+	case USBDEVFS_REAPURBNDELAY32:
+		snoop(&dev->dev, "%s: REAPURBDELAY32\n", __FUNCTION__);
+		ret = proc_reapurbnonblock_compat(ps, p);
+		break;
+
+#endif
+
 	case USBDEVFS_DISCARDURB:
 		snoop(&dev->dev, "%s: DISCARDURB\n", __FUNCTION__);
 		ret = proc_unlinkurb(ps, p);

--+HP7ph2BbKc20aGI--

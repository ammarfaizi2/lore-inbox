Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262840AbVA2BJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262840AbVA2BJX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 20:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262841AbVA2BJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 20:09:22 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:20143 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262840AbVA2BHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 20:07:21 -0500
Date: Fri, 28 Jan 2005 16:23:04 -0500
From: Christopher Li <chrisl@vmware.com>
To: linux kernel mail list <linux-kernel@vger.kernel.org>
Cc: linux-usb-devel@lists.sourceforge.net
Subject: compat ioctl for submiting URB
Message-ID: <20050128212304.GA11024@64m.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

The compatible ioctl is missing for submitting URB from 32 bit
application on a x86_64 system. For people who need to refresh
their mind, please read the big comment after do_usbdevfs_bulk
in fs/compat_ioctl.c

VMware is a big user of the usbdevfs, we translate guest USB
IO to usbdevfs, by submitting URB. On the x86_64 system, we
need those compatible ioctl for submitting URBs. For now we
make a hack to submit it through the vmmon driver. But that
is very ugly. 

I do want this problem get fixed in the linux kernel eventually.
I have been toying with two different ways to solve it. It seems
that it is unavoidable to get hands dirty in the usbdevfs internals.
The first one is just educate the usbdevfs to know about the 32 bit
URB ioctls. So it don't need to keep around a bounce buffer.

The second idea is have a bounce buffer, and let the usbdevfs internals
to know about his bounce buffer and free it when the async structure
destroyed (except for reap).

I attach a patch just implement the first approach. Any comment are
welcome. 

Chris


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=usbdevfs-compat-3

Index: linux-2.5/include/linux/compat_ioctl.h
===================================================================
--- linux-2.5.orig/include/linux/compat_ioctl.h	2005-01-26 17:23:57.000000000 -0800
+++ linux-2.5/include/linux/compat_ioctl.h	2005-01-28 16:35:14.000000000 -0800
@@ -692,6 +692,7 @@
 COMPATIBLE_IOCTL(USBDEVFS_CONNECTINFO)
 COMPATIBLE_IOCTL(USBDEVFS_HUB_PORTINFO)
 COMPATIBLE_IOCTL(USBDEVFS_RESET)
+COMPATIBLE_IOCTL(USBDEVFS_SUBMITURB32)
 COMPATIBLE_IOCTL(USBDEVFS_CLEAR_HALT)
 /* MTD */
 COMPATIBLE_IOCTL(MEMGETINFO)
Index: linux-2.5/include/linux/usbdevice_fs.h
===================================================================
--- linux-2.5.orig/include/linux/usbdevice_fs.h	2005-01-25 12:08:02.000000000 -0800
+++ linux-2.5/include/linux/usbdevice_fs.h	2005-01-28 16:35:14.000000000 -0800
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
@@ -130,6 +147,7 @@
 #define USBDEVFS_SETCONFIGURATION  _IOR('U', 5, unsigned int)
 #define USBDEVFS_GETDRIVER         _IOW('U', 8, struct usbdevfs_getdriver)
 #define USBDEVFS_SUBMITURB         _IOR('U', 10, struct usbdevfs_urb)
+#define USBDEVFS_SUBMITURB32       _IOR('U', 10, struct usbdevfs_urb32)
 #define USBDEVFS_DISCARDURB        _IO('U', 11)
 #define USBDEVFS_REAPURB           _IOW('U', 12, void *)
 #define USBDEVFS_REAPURBNDELAY     _IOW('U', 13, void *)
@@ -143,5 +161,4 @@
 #define USBDEVFS_CLEAR_HALT        _IOR('U', 21, unsigned int)
 #define USBDEVFS_DISCONNECT        _IO('U', 22)
 #define USBDEVFS_CONNECT           _IO('U', 23)
-
 #endif /* _LINUX_USBDEVICE_FS_H */
Index: linux-2.5/include/linux/usb.h
===================================================================
--- linux-2.5.orig/include/linux/usb.h	2005-01-25 12:07:54.000000000 -0800
+++ linux-2.5/include/linux/usb.h	2005-01-28 16:35:14.000000000 -0800
@@ -608,6 +608,7 @@
 #define URB_NO_FSBR		0x0020	/* UHCI-specific */
 #define URB_ZERO_PACKET		0x0040	/* Finish bulk OUTs with short packet */
 #define URB_NO_INTERRUPT	0x0080	/* HINT: no non-error interrupt needed */
+#define URB_COMPAT		0x0100	/* compat mode */
 
 struct usb_iso_packet_descriptor {
 	unsigned int offset;
Index: linux-2.5/fs/compat_ioctl.c
===================================================================
--- linux-2.5.orig/fs/compat_ioctl.c	2005-01-25 12:08:12.000000000 -0800
+++ linux-2.5/fs/compat_ioctl.c	2005-01-28 16:35:14.000000000 -0800
@@ -2570,228 +2570,19 @@
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
+/*
+ * The USBDEVFS_SUBMITURB, USBDEVFS_REAPURB and USBDEVFS_REAPURBNDELAY
+ * is handle in usbdevfs core.				-Christopher Li
+ */
 
 #define USBDEVFS_REAPURB32         _IOW('U', 12, u32)
 #define USBDEVFS_REAPURBNDELAY32   _IOW('U', 13, u32)
 
 static int do_usbdevfs_reapurb(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
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
+	cmd = (cmd == USBDEVFS_REAPURB32) ?  USBDEVFS_REAPURB : USBDEVFS_REAPURBNDELAY;
+	return sys_ioctl(fd, cmd, arg);
 }
 
 struct usbdevfs_disconnectsignal32 {
@@ -3332,7 +3123,6 @@
 /* Usbdevfs */
 HANDLE_IOCTL(USBDEVFS_CONTROL32, do_usbdevfs_control)
 HANDLE_IOCTL(USBDEVFS_BULK32, do_usbdevfs_bulk)
-/*HANDLE_IOCTL(USBDEVFS_SUBMITURB32, do_usbdevfs_urb)*/
 HANDLE_IOCTL(USBDEVFS_REAPURB32, do_usbdevfs_reapurb)
 HANDLE_IOCTL(USBDEVFS_REAPURBNDELAY32, do_usbdevfs_reapurb)
 HANDLE_IOCTL(USBDEVFS_DISCSIGNAL32, do_usbdevfs_discsignal)
Index: linux-2.5/drivers/usb/core/urb.c
===================================================================
--- linux-2.5.orig/drivers/usb/core/urb.c	2005-01-25 12:55:19.000000000 -0800
+++ linux-2.5/drivers/usb/core/urb.c	2005-01-28 16:35:14.000000000 -0800
@@ -312,6 +312,7 @@
 	allowed = URB_ASYNC_UNLINK;	// affects later unlinks
 	allowed |= (URB_NO_TRANSFER_DMA_MAP | URB_NO_SETUP_DMA_MAP);
 	allowed |= URB_NO_INTERRUPT;
+	allowed |= URB_COMPAT;
 	switch (temp) {
 	case PIPE_BULK:
 		if (is_out)
Index: linux-2.5/drivers/usb/core/devio.c
===================================================================
--- linux-2.5.orig/drivers/usb/core/devio.c	2005-01-25 12:08:25.000000000 -0800
+++ linux-2.5/drivers/usb/core/devio.c	2005-01-28 16:35:14.000000000 -0800
@@ -803,9 +803,11 @@
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
@@ -813,42 +815,40 @@
 	unsigned int u, totlen, isofrmlen;
 	int ret, interval = 0, ifnum = -1;
 
-	if (copy_from_user(&uurb, arg, sizeof(uurb)))
-		return -EFAULT;
-	if (uurb.flags & ~(USBDEVFS_URB_ISO_ASAP|USBDEVFS_URB_SHORT_NOT_OK|
-			   URB_NO_FSBR|URB_ZERO_PACKET))
+	if (uurb->flags & ~(USBDEVFS_URB_ISO_ASAP|USBDEVFS_URB_SHORT_NOT_OK|
+			   URB_NO_FSBR|URB_ZERO_PACKET|URB_COMPAT))
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
@@ -856,11 +856,11 @@
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
@@ -873,29 +873,29 @@
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
@@ -906,11 +906,11 @@
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
@@ -918,23 +918,23 @@
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
@@ -943,16 +943,16 @@
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
@@ -961,15 +961,15 @@
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
@@ -984,6 +984,90 @@
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
+#ifdef CONFIG_IA32_EMULATION
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
+	free_async(as);
+	if (put_user((u32)(u64)addr, (u32 __user *)arg))
+		return -EFAULT;
+	return 0;
+}
+
+#endif
+
 static int proc_unlinkurb(struct dev_state *ps, void __user *arg)
 {
 	struct async *as;
@@ -995,12 +1079,17 @@
 	return 0;
 }
 
-static int processcompl(struct async *as)
+static int processcompl(struct async *as, void __user * __user *arg)
 {
 	struct urb *urb = as->urb;
 	struct usbdevfs_urb __user *userurb = as->userurb;
+	void __user *addr = as->userurb;
 	unsigned int i;
 
+#ifdef CONFIG_IA32_EMULATION
+	if (as->urb->transfer_flags & URB_COMPAT)
+		return processcompl_compat(as, arg);
+#endif
 	if (as->userbuffer)
 		if (copy_to_user(as->userbuffer, urb->transfer_buffer, urb->transfer_buffer_length))
 			return -EFAULT;
@@ -1021,6 +1110,11 @@
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
 
@@ -1028,9 +1122,7 @@
 {
         DECLARE_WAITQUEUE(wait, current);
 	struct async *as = NULL;
-	void __user *addr;
 	struct usb_device *dev = ps->dev;
-	int ret;
 
 	add_wait_queue(&ps->wait, &wait);
 	for (;;) {
@@ -1045,16 +1137,8 @@
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
+	if (as) 
+		return processcompl(as, (void __user * __user *)arg);
 	if (signal_pending(current))
 		return -EINTR;
 	return -EIO;
@@ -1063,19 +1147,10 @@
 static int proc_reapurbnonblock(struct dev_state *ps, void __user *arg)
 {
 	struct async *as;
-	void __user *addr;
-	int ret;
 
 	if (!(as = async_getcompleted(ps)))
 		return -EAGAIN;
-	ret = processcompl(as);
-	addr = as->userurb;
-	free_async(as);
-	if (ret)
-		return ret;
-	if (put_user(addr, (void __user * __user *)arg))
-		return -EFAULT;
-	return 0;
+	return processcompl(as, (void __user * __user *)arg);
 }
 
 static int proc_disconnectsignal(struct dev_state *ps, void __user *arg)
@@ -1289,6 +1364,16 @@
 			inode->i_mtime = CURRENT_TIME;
 		break;
 
+#ifdef CONFIG_IA32_EMULATION
+
+	case USBDEVFS_SUBMITURB32:
+		snoop(&dev->dev, "%s: SUBMITURB32\n", __FUNCTION__);
+		ret = proc_submiturb_compat(ps, p);
+		if (ret >= 0)
+			inode->i_mtime = CURRENT_TIME;
+		break;
+#endif
+
 	case USBDEVFS_DISCARDURB:
 		snoop(&dev->dev, "%s: DISCARDURB\n", __FUNCTION__);
 		ret = proc_unlinkurb(ps, p);

--0F1p//8PRICkK4MW--

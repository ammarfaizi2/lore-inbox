Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbVJRBQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbVJRBQM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 21:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbVJRBQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 21:16:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29899 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751275AbVJRBQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 21:16:11 -0400
Date: Mon, 17 Oct 2005 18:15:54 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-usb-devel@lists.sourceforge.net
Cc: zaitcev@redhat.com, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: usb: Patch for USBDEVFS_IOCTL from 32-bit programs
Message-Id: <20051017181554.77d0d45d.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dell supplied me with the following test:

#include<stdio.h>
#include<errno.h>
#include<sys/ioctl.h>
#include<fcntl.h>
#include<linux/usbdevice_fs.h>

main(int argc,char*argv[])
{
   struct usbdevfs_hub_portinfo hubPortInfo = {0};
   struct usbdevfs_ioctl command = {0};
   command.ifno = 0;
   command.ioctl_code = USBDEVFS_HUB_PORTINFO;
   command.data = (void*)&hubPortInfo;
   int fd, ret;
   if(argc != 2) {
     fprintf(stderr,"Usage: %s /proc/bus/usb/<BusNo>/<HubID>\n",argv[0]);
     fprintf(stderr,"Example: %s /proc/bus/usb/001/001\n",argv[0]);
     exit(1);
   }
   errno = 0;
   fd = open(argv[1],O_RDWR);
   if(fd < 0) {
     perror("open failed:"); 
     exit(errno);
   }
   errno = 0;
   ret = ioctl(fd,USBDEVFS_IOCTL,&command);
   printf("IOCTL return status:%d\n",ret);
   if(ret<0) {
     perror("IOCTL failed:");
     close(fd);
     exit(3);
   } else {
       printf("IOCTL passed:Num of ports %d\n",hubPortInfo.nports);
       close(fd);
       exit(0);
   }
   return 0;
}

I have verified that it breaks if built in 32 bit mode on x86_64 and that
the patch below fixes it.

Signed-off-by: Pete Zaitcev <zaitcev@redhat.com>

---

I'm cross-posting to l-k because someone I know was making sounds at
a notion of #ifdef CONFIG_COMPAT. But I think this solutions is superior
to adding anything outside of devio.c.

-- Pete

diff -urp -X dontdiff linux-2.6.14-rc3/drivers/usb/core/devio.c linux-2.6.14-rc3-lem/drivers/usb/core/devio.c
--- linux-2.6.14-rc3/drivers/usb/core/devio.c	2005-10-07 21:28:12.000000000 -0700
+++ linux-2.6.14-rc3-lem/drivers/usb/core/devio.c	2005-10-07 21:36:02.000000000 -0700
@@ -1230,23 +1230,20 @@ static int proc_releaseinterface(struct 
 	return 0;
 }
 
-static int proc_ioctl (struct dev_state *ps, void __user *arg)
+static int proc_ioctl(struct dev_state *ps, struct usbdevfs_ioctl *ctl)
 {
-	struct usbdevfs_ioctl	ctrl;
 	int			size;
 	void			*buf = NULL;
 	int			retval = 0;
 	struct usb_interface    *intf = NULL;
 	struct usb_driver       *driver = NULL;
 
-	/* get input parameters and alloc buffer */
-	if (copy_from_user(&ctrl, arg, sizeof (ctrl)))
-		return -EFAULT;
-	if ((size = _IOC_SIZE (ctrl.ioctl_code)) > 0) {
+	/* alloc buffer */
+	if ((size = _IOC_SIZE (ctl->ioctl_code)) > 0) {
 		if ((buf = kmalloc (size, GFP_KERNEL)) == NULL)
 			return -ENOMEM;
-		if ((_IOC_DIR(ctrl.ioctl_code) & _IOC_WRITE)) {
-			if (copy_from_user (buf, ctrl.data, size)) {
+		if ((_IOC_DIR(ctl->ioctl_code) & _IOC_WRITE)) {
+			if (copy_from_user (buf, ctl->data, size)) {
 				kfree(buf);
 				return -EFAULT;
 			}
@@ -1262,9 +1259,9 @@ static int proc_ioctl (struct dev_state 
 
 	if (ps->dev->state != USB_STATE_CONFIGURED)
 		retval = -EHOSTUNREACH;
-	else if (!(intf = usb_ifnum_to_if (ps->dev, ctrl.ifno)))
+	else if (!(intf = usb_ifnum_to_if (ps->dev, ctl->ifno)))
                retval = -EINVAL;
-	else switch (ctrl.ioctl_code) {
+	else switch (ctl->ioctl_code) {
 
 	/* disconnect kernel driver from interface */
 	case USBDEVFS_DISCONNECT:
@@ -1296,7 +1293,7 @@ static int proc_ioctl (struct dev_state 
 		if (driver == NULL || driver->ioctl == NULL) {
 			retval = -ENOTTY;
 		} else {
-			retval = driver->ioctl (intf, ctrl.ioctl_code, buf);
+			retval = driver->ioctl (intf, ctl->ioctl_code, buf);
 			if (retval == -ENOIOCTLCMD)
 				retval = -ENOTTY;
 		}
@@ -1305,15 +1302,42 @@ static int proc_ioctl (struct dev_state 
 
 	/* cleanup and return */
 	if (retval >= 0
-			&& (_IOC_DIR (ctrl.ioctl_code) & _IOC_READ) != 0
+			&& (_IOC_DIR (ctl->ioctl_code) & _IOC_READ) != 0
 			&& size > 0
-			&& copy_to_user (ctrl.data, buf, size) != 0)
+			&& copy_to_user (ctl->data, buf, size) != 0)
 		retval = -EFAULT;
 
 	kfree(buf);
 	return retval;
 }
 
+static int proc_ioctl_default(struct dev_state *ps, void __user *arg)
+{
+	struct usbdevfs_ioctl	ctrl;
+
+	if (copy_from_user(&ctrl, arg, sizeof (ctrl)))
+		return -EFAULT;
+	return proc_ioctl(ps, &ctrl);
+}
+
+#ifdef CONFIG_COMPAT
+static int proc_ioctl_compat(struct dev_state *ps, void __user *arg)
+{
+	struct usbdevfs_ioctl32 __user *uioc;
+	struct usbdevfs_ioctl ctrl;
+	u32 udata;
+
+	uioc = compat_ptr(arg);
+	if (get_user(ctrl.ifno, &uioc->ifno) ||
+	    get_user(ctrl.ioctl_code, &uioc->ioctl_code) ||
+	    __get_user(udata, &uioc->data))
+		return -EFAULT;
+	ctrl.data = compat_ptr(udata);
+
+	return proc_ioctl(ps, &ctrl);
+}
+#endif
+
 /*
  * NOTE:  All requests here that have interface numbers as parameters
  * are assuming that somehow the configuration has been prevented from
@@ -1414,6 +1438,10 @@ static int usbdev_ioctl(struct inode *in
 		ret = proc_reapurbnonblock_compat(ps, p);
 		break;
 
+	case USBDEVFS_IOCTL32:
+		snoop(&dev->dev, "%s: IOCTL\n", __FUNCTION__);
+		ret = proc_ioctl_compat(ps, p);
+		break;
 #endif
 
 	case USBDEVFS_DISCARDURB:
@@ -1448,7 +1476,7 @@ static int usbdev_ioctl(struct inode *in
 
 	case USBDEVFS_IOCTL:
 		snoop(&dev->dev, "%s: IOCTL\n", __FUNCTION__);
-		ret = proc_ioctl(ps, p);
+		ret = proc_ioctl_default(ps, p);
 		break;
 	}
 	usb_unlock_device(dev);
diff -urp -X dontdiff linux-2.6.14-rc3/fs/compat_ioctl.c linux-2.6.14-rc3-lem/fs/compat_ioctl.c
--- linux-2.6.14-rc3/fs/compat_ioctl.c	2005-10-07 21:28:15.000000000 -0700
+++ linux-2.6.14-rc3-lem/fs/compat_ioctl.c	2005-10-17 18:06:40.000000000 -0700
@@ -3050,6 +3050,7 @@ HANDLE_IOCTL(TIOCSSERIAL, serial_struct_
 HANDLE_IOCTL(USBDEVFS_CONTROL32, do_usbdevfs_control)
 HANDLE_IOCTL(USBDEVFS_BULK32, do_usbdevfs_bulk)
 HANDLE_IOCTL(USBDEVFS_DISCSIGNAL32, do_usbdevfs_discsignal)
+COMPATIBLE_IOCTL(USBDEVFS_IOCTL32)
 /* i2c */
 HANDLE_IOCTL(I2C_FUNCS, w_long)
 HANDLE_IOCTL(I2C_RDWR, do_i2c_rdwr_ioctl)
diff -urp -X dontdiff linux-2.6.14-rc3/include/linux/usbdevice_fs.h linux-2.6.14-rc3-lem/include/linux/usbdevice_fs.h
--- linux-2.6.14-rc3/include/linux/usbdevice_fs.h	2005-10-07 21:28:26.000000000 -0700
+++ linux-2.6.14-rc3-lem/include/linux/usbdevice_fs.h	2005-10-07 21:36:02.000000000 -0700
@@ -140,6 +140,12 @@ struct usbdevfs_urb32 {
 	compat_caddr_t usercontext; /* unused */
 	struct usbdevfs_iso_packet_desc iso_frame_desc[0];
 };
+
+struct usbdevfs_ioctl32 {
+	s32 ifno;
+	s32 ioctl_code;
+	compat_caddr_t data;
+};
 #endif
 
 #define USBDEVFS_CONTROL           _IOWR('U', 0, struct usbdevfs_ctrltransfer)
@@ -160,6 +166,7 @@ struct usbdevfs_urb32 {
 #define USBDEVFS_RELEASEINTERFACE  _IOR('U', 16, unsigned int)
 #define USBDEVFS_CONNECTINFO       _IOW('U', 17, struct usbdevfs_connectinfo)
 #define USBDEVFS_IOCTL             _IOWR('U', 18, struct usbdevfs_ioctl)
+#define USBDEVFS_IOCTL32           _IOWR('U', 18, struct usbdevfs_ioctl32)
 #define USBDEVFS_HUB_PORTINFO      _IOR('U', 19, struct usbdevfs_hub_portinfo)
 #define USBDEVFS_RESET             _IO('U', 20)
 #define USBDEVFS_CLEAR_HALT        _IOR('U', 21, unsigned int)

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264904AbRFYRiL>; Mon, 25 Jun 2001 13:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265726AbRFYRiC>; Mon, 25 Jun 2001 13:38:02 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:52751 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264904AbRFYRhx>;
	Mon, 25 Jun 2001 13:37:53 -0400
Date: Mon, 25 Jun 2001 10:35:21 -0700
From: Greg KH <greg@kroah.com>
To: rio500-devel <rio500-devel@lists.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-usb-devel@lists.sourceforge.net
Subject: Re: [patch] rio500 devfs support
Message-ID: <20010625103521.A17036@kroah.com>
In-Reply-To: <20010619175224.A1137@glitch.snoozer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010619175224.A1137@glitch.snoozer.net>; from haphazard@socket.net on Tue, Jun 19, 2001 at 05:52:24PM -0500
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 19, 2001 at 05:52:24PM -0500, Gregory T. Norris wrote:
> The attached diff adds devfs support to the rio500 driver, so that
> /dev/usb/rio500 gets created automagically.  It was generated against
> 2.4.5, but probably applies fine against any recent kernel.  Comments
> are welcome (but be gentle, this is my first attempt at a kernel
> patch :-).

Here's a small change that makes the node a child of the usb devfs
entry.  It also enables the node to only be present when the device is
actually present.  The patch is against 2.4.6-pre5.

thanks,

greg k-h

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usb-rio500-2.4.6-pre5.patch"

diff -Nru a/drivers/usb/rio500.c b/drivers/usb/rio500.c
--- a/drivers/usb/rio500.c	Mon Jun 25 10:31:03 2001
+++ b/drivers/usb/rio500.c	Mon Jun 25 10:31:03 2001
@@ -38,13 +38,14 @@
 #include <linux/spinlock.h>
 #include <linux/usb.h>
 #include <linux/smp_lock.h>
+#include <linux/devfs_fs_kernel.h>
 
 #include "rio500_usb.h"
 
 /*
  * Version Information
  */
-#define DRIVER_VERSION "v1.0.0"
+#define DRIVER_VERSION "v1.1"
 #define DRIVER_AUTHOR "Cesar Miquel <miquel@df.uba.ar>"
 #define DRIVER_DESC "USB Rio 500 driver"
 
@@ -60,6 +61,7 @@
 
 struct rio_usb_data {
         struct usb_device *rio_dev;     /* init: probe_rio */
+        devfs_handle_t devfs;           /* devfs device */
         unsigned int ifnum;             /* Interface number of the USB device */
         int isopen;                     /* nz if open */
         int present;                    /* Device is present on the bus */
@@ -69,6 +71,8 @@
 	struct semaphore lock;          /* general race avoidance */
 };
 
+extern devfs_handle_t usb_devfs_handle;	/* /dev/usb dir. */
+
 static struct rio_usb_data rio_instance;
 
 static int open_rio(struct inode *inode, struct file *file)
@@ -416,6 +420,15 @@
 	return read_count;
 }
 
+static struct
+file_operations usb_rio_fops = {
+	read:		read_rio,
+	write:		write_rio,
+	ioctl:		ioctl_rio,
+	open:		open_rio,
+	release:	close_rio,
+};
+
 static void *probe_rio(struct usb_device *dev, unsigned int ifnum,
 		       const struct usb_device_id *id)
 {
@@ -439,6 +452,14 @@
 	}
 	dbg("probe_rio: ibuf address:%p", rio->ibuf);
 
+	rio->devfs = devfs_register(usb_devfs_handle, "rio500",
+				    DEVFS_FL_DEFAULT, USB_MAJOR,
+				    RIO_MINOR,
+				    S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP |
+				    S_IWGRP, &usb_rio_fops, NULL);
+	if (rio->devfs == NULL)
+		dbg("probe_rio: device node registration failed");
+	
 	init_MUTEX(&(rio->lock));
 
 	return rio;
@@ -448,6 +469,8 @@
 {
 	struct rio_usb_data *rio = (struct rio_usb_data *) ptr;
 
+	devfs_unregister(rio->devfs);
+
 	if (rio->isopen) {
 		rio->isopen = 0;
 		/* better let it finish - the release will do whats needed */
@@ -461,15 +484,6 @@
 
 	rio->present = 0;
 }
-
-static struct
-file_operations usb_rio_fops = {
-	read:		read_rio,
-	write:		write_rio,
-	ioctl:		ioctl_rio,
-	open:		open_rio,
-	release:	close_rio,
-};
 
 static struct usb_device_id rio_table [] = {
 	{ USB_DEVICE(0x0841, 1) }, 		/* Rio 500 */

--SUOF0GtieIMvvwua--

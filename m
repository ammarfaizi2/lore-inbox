Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286765AbSABFrH>; Wed, 2 Jan 2002 00:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286779AbSABFq6>; Wed, 2 Jan 2002 00:46:58 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:3852 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S286766AbSABFqm>;
	Wed, 2 Jan 2002 00:46:42 -0500
Date: Tue, 1 Jan 2002 21:45:43 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: NFS "dev_t" issues..
Message-ID: <20020101214543.A25673@kroah.com>
In-Reply-To: <Pine.LNX.4.33.0201011402560.13397-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201011402560.13397-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 05 Dec 2001 02:39:40 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 01, 2002 at 02:15:58PM -0800, Linus Torvalds wrote:
> 
> I made a pre6, which contains a new-and-anal "kdev_t".

Here's a patch to fix the usb code drivers.

thanks,

greg k-h


diff -Nru a/drivers/usb/acm.c b/drivers/usb/acm.c
--- a/drivers/usb/acm.c	Tue Jan  1 21:33:37 2002
+++ b/drivers/usb/acm.c	Tue Jan  1 21:33:37 2002
@@ -297,7 +297,7 @@
 
 static int acm_tty_open(struct tty_struct *tty, struct file *filp)
 {
-	struct acm *acm = acm_table[MINOR(tty->device)];
+	struct acm *acm = acm_table[minor(tty->device)];
 
 	if (!acm || !acm->dev) return -EINVAL;
 
diff -Nru a/drivers/usb/bluetooth.c b/drivers/usb/bluetooth.c
--- a/drivers/usb/bluetooth.c	Tue Jan  1 21:33:37 2002
+++ b/drivers/usb/bluetooth.c	Tue Jan  1 21:33:37 2002
@@ -360,7 +360,7 @@
 	tty->driver_data = NULL;
 
 	/* get the bluetooth object associated with this tty pointer */
-	bluetooth = get_bluetooth_by_minor (MINOR(tty->device));
+	bluetooth = get_bluetooth_by_minor (minor(tty->device));
 
 	if (bluetooth_paranoia_check (bluetooth, __FUNCTION__)) {
 		return -ENODEV;
diff -Nru a/drivers/usb/dabusb.c b/drivers/usb/dabusb.c
--- a/drivers/usb/dabusb.c	Tue Jan  1 21:33:37 2002
+++ b/drivers/usb/dabusb.c	Tue Jan  1 21:33:37 2002
@@ -579,7 +579,7 @@
 
 static int dabusb_open (struct inode *inode, struct file *file)
 {
-	int devnum = MINOR (inode->i_rdev);
+	int devnum = minor (inode->i_rdev);
 	pdabusb_t s;
 
 	if (devnum < DABUSB_MINOR || devnum >= (DABUSB_MINOR + NRDABUSB))
diff -Nru a/drivers/usb/dc2xx.c b/drivers/usb/dc2xx.c
--- a/drivers/usb/dc2xx.c	Tue Jan  1 21:33:37 2002
+++ b/drivers/usb/dc2xx.c	Tue Jan  1 21:33:37 2002
@@ -298,7 +298,7 @@
 	int			value = 0;
 
 	down (&state_table_mutex);
-	subminor = MINOR (inode->i_rdev) - USB_CAMERA_MINOR_BASE;
+	subminor = minor (inode->i_rdev) - USB_CAMERA_MINOR_BASE;
 	if (subminor < 0 || subminor >= MAX_CAMERAS
 			|| !(camera = minor_data [subminor])) {
 		up (&state_table_mutex);
diff -Nru a/drivers/usb/hiddev.c b/drivers/usb/hiddev.c
--- a/drivers/usb/hiddev.c	Tue Jan  1 21:33:37 2002
+++ b/drivers/usb/hiddev.c	Tue Jan  1 21:33:37 2002
@@ -218,7 +218,7 @@
 static int hiddev_open(struct inode * inode, struct file * file) {
 	struct hiddev_list *list;
 
-	int i = MINOR(inode->i_rdev) - HIDDEV_MINOR_BASE;
+	int i = minor(inode->i_rdev) - HIDDEV_MINOR_BASE;
 
 	if (i >= HIDDEV_MINORS || !hiddev_table[i])
 		return -ENODEV;
diff -Nru a/drivers/usb/printer.c b/drivers/usb/printer.c
--- a/drivers/usb/printer.c	Tue Jan  1 21:33:37 2002
+++ b/drivers/usb/printer.c	Tue Jan  1 21:33:37 2002
@@ -201,7 +201,7 @@
 
 static int usblp_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev) - USBLP_MINOR_BASE;
+	int minor = minor(inode->i_rdev) - USBLP_MINOR_BASE;
 	struct usblp *usblp;
 	int retval;
 
diff -Nru a/drivers/usb/scanner.c b/drivers/usb/scanner.c
--- a/drivers/usb/scanner.c	Tue Jan  1 21:33:37 2002
+++ b/drivers/usb/scanner.c	Tue Jan  1 21:33:37 2002
@@ -365,7 +365,7 @@
 	struct scn_usb_data *scn;
 	struct usb_device *dev;
 
-	kdev_t scn_minor;
+	int scn_minor;
 
 	int err=0;
 
@@ -432,7 +432,7 @@
 {
 	struct scn_usb_data *scn;
 
-	kdev_t scn_minor;
+	int scn_minor;
 
 	scn_minor = USB_SCN_MINOR (inode);
 
@@ -469,7 +469,7 @@
 	ssize_t bytes_written = 0; /* Overall count of bytes written */
 	ssize_t ret = 0;
 
-	kdev_t scn_minor;
+	int scn_minor;
 
 	int this_write;		/* Number of bytes to write */
 	int partial;		/* Number of bytes successfully written */
@@ -556,8 +556,7 @@
 	ssize_t bytes_read;	/* Overall count of bytes_read */
 	ssize_t ret;
 
-	kdev_t scn_minor;
-
+	int scn_minor;
 	int partial;		/* Number of bytes successfully read */
 	int this_read;		/* Max number of bytes to read */
 	int result;
@@ -671,7 +670,7 @@
 {
 	struct usb_device *dev;
 
-	kdev_t scn_minor;
+	int scn_minor;
 
 	scn_minor = USB_SCN_MINOR(inode);
 
@@ -810,8 +809,7 @@
 
 	int ep_cnt;
 	int ix;
-
-	kdev_t scn_minor;
+	int scn_minor;
 
 	char valid_device = 0;
 	char have_bulk_in, have_bulk_out, have_intr;
diff -Nru a/drivers/usb/scanner.h b/drivers/usb/scanner.h
--- a/drivers/usb/scanner.h	Tue Jan  1 21:33:37 2002
+++ b/drivers/usb/scanner.h	Tue Jan  1 21:33:37 2002
@@ -203,7 +203,7 @@
 #define IS_EP_BULK_OUT(ep) (IS_EP_BULK(ep) && ((ep).bEndpointAddress & USB_ENDPOINT_DIR_MASK) == USB_DIR_OUT)
 #define IS_EP_INTR(ep) ((ep).bmAttributes == USB_ENDPOINT_XFER_INT ? 1 : 0)
 
-#define USB_SCN_MINOR(X) MINOR((X)->i_rdev) - SCN_BASE_MNR
+#define USB_SCN_MINOR(X) minor((X)->i_rdev) - SCN_BASE_MNR
 
 #ifdef DEBUG
 #define SCN_DEBUG(X) X
@@ -243,7 +243,7 @@
 	devfs_handle_t devfs;	/* devfs device */
 	struct urb scn_irq;
 	unsigned int ifnum;	/* Interface number of the USB device */
-	kdev_t scn_minor;	/* Scanner minor - used in disconnect() */
+	int scn_minor;		/* Scanner minor - used in disconnect() */
 	unsigned char button;	/* Front panel buffer */
 	char isopen;		/* Not zero if the device is open */
 	char present;		/* Not zero if device is present */
diff -Nru a/drivers/usb/serial/usbserial.c b/drivers/usb/serial/usbserial.c
--- a/drivers/usb/serial/usbserial.c	Tue Jan  1 21:33:37 2002
+++ b/drivers/usb/serial/usbserial.c	Tue Jan  1 21:33:37 2002
@@ -514,14 +514,14 @@
 	tty->driver_data = NULL;
 
 	/* get the serial object associated with this tty pointer */
-	serial = get_serial_by_minor (MINOR(tty->device));
+	serial = get_serial_by_minor (minor(tty->device));
 
 	if (serial_paranoia_check (serial, __FUNCTION__)) {
 		return -ENODEV;
 	}
 
 	/* set up our port structure making the tty driver remember our port object, and us it */
-	portNumber = MINOR(tty->device) - serial->minor;
+	portNumber = minor(tty->device) - serial->minor;
 	port = &serial->port[portNumber];
 	tty->driver_data = port;
 	port->tty = tty;

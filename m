Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263851AbTCVRfJ>; Sat, 22 Mar 2003 12:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263749AbTCVRar>; Sat, 22 Mar 2003 12:30:47 -0500
Received: from verein.lst.de ([212.34.181.86]:22534 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S263674AbTCVR3X>;
	Sat, 22 Mar 2003 12:29:23 -0500
Date: Sat, 22 Mar 2003 18:40:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalda@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix usb_devfs_handle abuse
Message-ID: <20030322184025.E21623@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalda@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches are in preparation of making the first argument
of devfs_register always NULL.

Many usb drivers use the usb_devfs_handle variable instead of just
adding the usb/ prefix directly to their devfs_register calls.  Fix
that and make usb_devfs_handle static and unexported.


diff -Nru a/drivers/usb/class/usblp.c b/drivers/usb/class/usblp.c
--- a/drivers/usb/class/usblp.c	Sat Mar 22 17:02:37 2003
+++ b/drivers/usb/class/usblp.c	Sat Mar 22 17:02:37 2003
@@ -186,8 +186,6 @@
 }
 #endif
 
-extern devfs_handle_t usb_devfs_handle;			/* /dev/usb dir. */
-
 /* Quirks: various printer quirks are handled by this table & its flags. */
 
 struct quirk_printer_struct {
@@ -820,7 +818,7 @@
 	struct usblp *usblp = 0;
 	int protocol;
 	int retval;
-	char name[6];
+	char name[10];
 
 	/* Malloc and start initializing usblp structure so we can use it
 	 * directly. */
@@ -909,8 +907,8 @@
 #endif
 
 	/* If we have devfs, create with perms=660. */
-	sprintf(name, "lp%d", usblp->minor);
-	usblp->devfs = devfs_register(usb_devfs_handle, name,
+	sprintf(name, "usb/lp%d", usblp->minor);
+	usblp->devfs = devfs_register(NULL, name,
 				      DEVFS_FL_DEFAULT, USB_MAJOR,
 				      usblp->minor,
 				      S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP |
diff -Nru a/drivers/usb/core/file.c b/drivers/usb/core/file.c
--- a/drivers/usb/core/file.c	Sat Mar 22 17:02:37 2003
+++ b/drivers/usb/core/file.c	Sat Mar 22 17:02:37 2003
@@ -28,8 +28,7 @@
 #endif
 #include <linux/usb.h>
 
-devfs_handle_t usb_devfs_handle;	/* /dev/usb dir. */
-EXPORT_SYMBOL(usb_devfs_handle);
+static devfs_handle_t usb_devfs_handle;	/* /dev/usb dir. */
 
 #define MAX_USB_MINORS	256
 static struct file_operations *usb_minors[MAX_USB_MINORS];
diff -Nru a/drivers/usb/image/scanner.c b/drivers/usb/image/scanner.c
--- a/drivers/usb/image/scanner.c	Sat Mar 22 17:02:37 2003
+++ b/drivers/usb/image/scanner.c	Sat Mar 22 17:02:37 2003
@@ -878,7 +878,7 @@
 
 	char valid_device = 0;
 	char have_bulk_in, have_bulk_out, have_intr;
-	char name[10];
+	char name[14];
 
 	dbg("probe_scanner: USB dev address:%p", dev);
 
@@ -1099,9 +1099,9 @@
 	scn->scn_minor = scn_minor;
 	scn->isopen = 0;
 
-	sprintf(name, "scanner%d", scn->scn_minor - SCN_BASE_MNR);
+	sprintf(name, "usb/scanner%d", scn->scn_minor - SCN_BASE_MNR);
 	
-	scn->devfs = devfs_register(usb_devfs_handle, name,
+	scn->devfs = devfs_register(NULL, name,
 				    DEVFS_FL_DEFAULT, USB_MAJOR,
 				    scn->scn_minor,
 				    S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP |
diff -Nru a/drivers/usb/image/scanner.h b/drivers/usb/image/scanner.h
--- a/drivers/usb/image/scanner.h	Sat Mar 22 17:02:37 2003
+++ b/drivers/usb/image/scanner.h	Sat Mar 22 17:02:37 2003
@@ -352,6 +352,4 @@
 };
 #define to_scanner(d) container_of(d, struct scn_usb_data, kobj)
 
-extern devfs_handle_t usb_devfs_handle;
-
 static struct usb_driver scanner_driver;
diff -Nru a/drivers/usb/misc/auerswald.c b/drivers/usb/misc/auerswald.c
--- a/drivers/usb/misc/auerswald.c	Sat Mar 22 17:02:37 2003
+++ b/drivers/usb/misc/auerswald.c	Sat Mar 22 17:02:37 2003
@@ -72,9 +72,6 @@
 #endif
 
 
-/* prefix for the device descriptors in /dev/usb */
-#define AU_PREFIX	"auer"
-
 /* Number of read buffers for each device */
 #define AU_RBUFFERS     10
 
@@ -243,7 +240,7 @@
 typedef struct
 {
 	struct semaphore 	mutex;         	    /* protection in user context */
-	char 			name[16];	    /* name of the /dev/usb entry */
+	char 			name[20];	    /* name of the /dev/usb entry */
 	unsigned int		dtindex;	    /* index in the device table */
 	devfs_handle_t 		devfs;	 	    /* devfs device node */
 	struct usb_device *	usbdev;      	    /* USB device handle */
@@ -260,9 +257,6 @@
 	wait_queue_head_t 	bufferwait;         /* wait for a control buffer */
 } auerswald_t,*pauerswald_t;
 
-/* the global usb devfs handle */
-extern devfs_handle_t usb_devfs_handle;
-
 /* array of pointers to our devices that are currently connected */
 static pauerswald_t dev_table[AUER_MAX_DEVICES];
 
@@ -1440,7 +1434,7 @@
 
 	cp->open_count++;
 	ccp->auerdev = cp;
-	dbg("open %s as /dev/usb/%s", cp->dev_desc, cp->name);
+	dbg("open %s as /dev/%s", cp->dev_desc, cp->name);
 	up (&cp->mutex);
 
 	/* file IO stuff */
@@ -1970,7 +1964,7 @@
 	}
 
 	/* Give the device a name */
-	sprintf (cp->name, AU_PREFIX "%d", dtindex);
+	sprintf (cp->name, "usb/auer%d", dtindex);
 
 	/* Store the index */
 	cp->dtindex = dtindex;
@@ -1978,8 +1972,7 @@
 	up (&dev_table_mutex);
 
 	/* initialize the devfs node for this device and register it */
-	cp->devfs = devfs_register (usb_devfs_handle, cp->name,
-				    DEVFS_FL_DEFAULT, USB_MAJOR,
+	cp->devfs = devfs_register(NULL, cp->name, 0, USB_MAJOR,
 				    AUER_MINOR_BASE + dtindex,
 				    S_IFCHR | S_IRUGO | S_IWUGO,
 				    &auerswald_fops, NULL);
@@ -2089,7 +2082,7 @@
 		return;
 
 	down (&cp->mutex);
-	info ("device /dev/usb/%s now disconnecting", cp->name);
+	info ("device /dev/%s now disconnecting", cp->name);
 
 	/* remove from device table */
 	/* Nobody can open() this device any more */
diff -Nru a/drivers/usb/misc/brlvger.c b/drivers/usb/misc/brlvger.c
--- a/drivers/usb/misc/brlvger.c	Sat Mar 22 17:02:37 2003
+++ b/drivers/usb/misc/brlvger.c	Sat Mar 22 17:02:37 2003
@@ -144,8 +144,6 @@
 #define rcvcontrolmsg(priv,a,b,c,d,e,f) \
     controlmsg(priv, USB_DIR_IN, a,b,c,d,e,f)
 
-extern devfs_handle_t usb_devfs_handle; /* /dev/usb dir. */
-
 /* ----------------------------------------------------------------------- */
 
 /* Data */
@@ -294,7 +292,7 @@
 	/* protects against reentrance: once we've found a free slot
 	   we reserve it.*/
 	static DECLARE_MUTEX(reserve_sem);
-        char devfs_name[16];
+        char devfs_name[20];
 
 	actifsettings = dev->actconfig->interface->altsetting;
 
@@ -375,8 +373,8 @@
 	};
 	dbg("Display length: %d", priv->plength);
 
-	sprintf(devfs_name, "brlvger%d", priv->subminor);
-	priv->devfs = devfs_register(usb_devfs_handle, devfs_name,
+	sprintf(devfs_name, "usb/brlvger%d", priv->subminor);
+	priv->devfs = devfs_register(NULL, devfs_name,
 				     DEVFS_FL_DEFAULT, USB_MAJOR,
 				     BRLVGER_MINOR+priv->subminor,
 				     S_IFCHR |S_IRUSR|S_IWUSR |S_IRGRP|S_IWGRP,
diff -Nru a/drivers/usb/misc/rio500.c b/drivers/usb/misc/rio500.c
--- a/drivers/usb/misc/rio500.c	Sat Mar 22 17:02:37 2003
+++ b/drivers/usb/misc/rio500.c	Sat Mar 22 17:02:37 2003
@@ -76,8 +76,6 @@
 	struct semaphore lock;          /* general race avoidance */
 };
 
-extern devfs_handle_t usb_devfs_handle;	/* /dev/usb dir. */
-
 static struct rio_usb_data rio_instance;
 
 static int open_rio(struct inode *inode, struct file *file)
@@ -478,7 +476,7 @@
 	}
 	dbg("probe_rio: ibuf address:%p", rio->ibuf);
 
-	rio->devfs = devfs_register(usb_devfs_handle, "rio500",
+	rio->devfs = devfs_register(NULL, "usb/rio500",
 				    DEVFS_FL_DEFAULT, USB_MAJOR,
 				    RIO_MINOR,
 				    S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP |
diff -Nru a/drivers/usb/net/rtl8150.c b/drivers/usb/net/rtl8150.c
--- a/drivers/usb/net/rtl8150.c	Sat Mar 22 17:02:37 2003
+++ b/drivers/usb/net/rtl8150.c	Sat Mar 22 17:02:37 2003
@@ -107,7 +107,6 @@
 typedef struct rtl8150 rtl8150_t;
 
 /* the global usb devfs handle */
-extern devfs_handle_t usb_devfs_handle;
 unsigned long multicast_filter_limit = 32;
 
 static void fill_skb_pool(rtl8150_t *);
diff -Nru a/drivers/usb/usb-skeleton.c b/drivers/usb/usb-skeleton.c
--- a/drivers/usb/usb-skeleton.c	Sat Mar 22 17:02:37 2003
+++ b/drivers/usb/usb-skeleton.c	Sat Mar 22 17:02:37 2003
@@ -119,9 +119,6 @@
 };
 
 
-/* the global usb devfs handle */
-extern devfs_handle_t usb_devfs_handle;
-
 /* prevent races between open() and disconnect() */
 static DECLARE_MUTEX (disconnect_sem);
 
@@ -514,7 +511,7 @@
 	size_t buffer_size;
 	int i;
 	int retval;
-	char name[10];
+	char name[14];
 
 
 	/* See if the device offered us matches what we can accept */
@@ -609,9 +606,9 @@
 	}
 
 	/* initialize the devfs node for this device and register it */
-	sprintf(name, "skel%d", dev->minor);
+	sprintf(name, "usb/skel%d", dev->minor);
 
-	dev->devfs = devfs_register (usb_devfs_handle, name,
+	dev->devfs = devfs_register(NULL, name,
 				     DEVFS_FL_DEFAULT, USB_MAJOR,
 				     dev->minor,
 				     S_IFCHR | S_IRUSR | S_IWUSR |

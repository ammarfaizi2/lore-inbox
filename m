Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263117AbTCSQiX>; Wed, 19 Mar 2003 11:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263118AbTCSQiW>; Wed, 19 Mar 2003 11:38:22 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:16261
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263117AbTCSQiO>; Wed, 19 Mar 2003 11:38:14 -0500
Subject: PATCH: I2O updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-cCPEs6C3jvrJxPmp2cBX"
Organization: 
Message-Id: <1048096801.30751.59.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 19 Mar 2003 18:00:02 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cCPEs6C3jvrJxPmp2cBX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This brings the I2O layer up to date. It fixes the i2o scsi hang
on boot. It fixes the stack abuse by the i2o_proc code and it 
merges i2o_pci into i2o_core. I2O is now dead so no other 
transports are likely to appear, so this always rather messy
abstraction can go.

Having applied this "rm i2o_pci.c"


-- 
Alan Cox <alan@lxorguk.ukuu.org.uk>

--=-cCPEs6C3jvrJxPmp2cBX
Content-Disposition: inline; filename=a1
Content-Type: text/x-patch; name=a1; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65=
/include/linux/i2o.h linux-2.5.65-ac1/include/linux/i2o.h
--- linux-2.5.65/include/linux/i2o.h	2003-02-10 18:38:03.000000000 +0000
+++ linux-2.5.65-ac1/include/linux/i2o.h	2003-03-13 20:35:36.000000000 +000=
0
@@ -23,7 +23,7 @@
 #include <linux/i2o-dev.h>
=20
 /* How many different OSM's are we allowing */
-#define MAX_I2O_MODULES		64
+#define MAX_I2O_MODULES		4
=20
 /* How many OSMs can register themselves for device status updates? */
 #define I2O_MAX_MANAGERS	4
@@ -76,10 +76,16 @@
 };
=20
 /*
- *	Resource data for each PCI I2O controller
+ * Each I2O controller has one of these objects
  */
-struct i2o_pci
+struct i2o_controller
 {
+	char name[16];
+	int unit;
+	int type;
+	int enabled;
+=09
+	struct pci_dev *pdev;		/* PCI device */
 	int		irq;
 	int		short_req:1;	/* Use small block sizes        */
 	int		dpt:1;		/* Don't quiesce                */
@@ -88,25 +94,6 @@
 	int		mtrr_reg0;
 	int		mtrr_reg1;
 #endif
-};
-
-/*
- * Transport types supported by I2O stack
- */
-#define I2O_TYPE_PCI		0x01		/* PCI I2O controller */
-
-
-/*
- * Each I2O controller has one of these objects
- */
-struct i2o_controller
-{
-	struct pci_dev *pdev;		/* PCI device */
-
-	char name[16];
-	int unit;
-	int type;
-	int enabled;
=20
 	struct notifier_block *event_notifer;	/* Events */
 	atomic_t users;
@@ -143,22 +130,6 @@
=20
 	struct proc_dir_entry *proc_entry;	/* /proc dir */
=20
-	union {					/* Bus information */
-		struct i2o_pci pci;
-	} bus;
-
-	/* Bus specific destructor */
-	void (*destructor)(struct i2o_controller *);
-
-	/* Bus specific attach/detach */
-	int (*bind)(struct i2o_controller *, struct i2o_device *);
-
-	/* Bus specific initiator */
-	int (*unbind)(struct i2o_controller *, struct i2o_device *);
-
-	/* Bus specific enable/disable */
-	void (*bus_enable)(struct i2o_controller *);
-	void (*bus_disable)(struct i2o_controller *);
=20
 	void *page_frame;			/* Message buffers */
 	dma_addr_t page_frame_map;		/* Cache map */

--=-cCPEs6C3jvrJxPmp2cBX
Content-Description: 
Content-Disposition: inline; filename=a1
Content-Type: text/x-patch; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65=
/include/linux/i2o.h linux-2.5.65-ac1/include/linux/i2o.h
--- linux-2.5.65/include/linux/i2o.h	2003-02-10 18:38:03.000000000 +0000
+++ linux-2.5.65-ac1/include/linux/i2o.h	2003-03-13 20:35:36.000000000 +000=
0
@@ -23,7 +23,7 @@
 #include <linux/i2o-dev.h>
=20
 /* How many different OSM's are we allowing */
-#define MAX_I2O_MODULES		64
+#define MAX_I2O_MODULES		4
=20
 /* How many OSMs can register themselves for device status updates? */
 #define I2O_MAX_MANAGERS	4
@@ -76,10 +76,16 @@
 };
=20
 /*
- *	Resource data for each PCI I2O controller
+ * Each I2O controller has one of these objects
  */
-struct i2o_pci
+struct i2o_controller
 {
+	char name[16];
+	int unit;
+	int type;
+	int enabled;
+=09
+	struct pci_dev *pdev;		/* PCI device */
 	int		irq;
 	int		short_req:1;	/* Use small block sizes        */
 	int		dpt:1;		/* Don't quiesce                */
@@ -88,25 +94,6 @@
 	int		mtrr_reg0;
 	int		mtrr_reg1;
 #endif
-};
-
-/*
- * Transport types supported by I2O stack
- */
-#define I2O_TYPE_PCI		0x01		/* PCI I2O controller */
-
-
-/*
- * Each I2O controller has one of these objects
- */
-struct i2o_controller
-{
-	struct pci_dev *pdev;		/* PCI device */
-
-	char name[16];
-	int unit;
-	int type;
-	int enabled;
=20
 	struct notifier_block *event_notifer;	/* Events */
 	atomic_t users;
@@ -143,22 +130,6 @@
=20
 	struct proc_dir_entry *proc_entry;	/* /proc dir */
=20
-	union {					/* Bus information */
-		struct i2o_pci pci;
-	} bus;
-
-	/* Bus specific destructor */
-	void (*destructor)(struct i2o_controller *);
-
-	/* Bus specific attach/detach */
-	int (*bind)(struct i2o_controller *, struct i2o_device *);
-
-	/* Bus specific initiator */
-	int (*unbind)(struct i2o_controller *, struct i2o_device *);
-
-	/* Bus specific enable/disable */
-	void (*bus_enable)(struct i2o_controller *);
-	void (*bus_disable)(struct i2o_controller *);
=20
 	void *page_frame;			/* Message buffers */
 	dma_addr_t page_frame_map;		/* Cache map */

--=-cCPEs6C3jvrJxPmp2cBX--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265650AbTAOBH1>; Tue, 14 Jan 2003 20:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265661AbTAOBH1>; Tue, 14 Jan 2003 20:07:27 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:40713 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265650AbTAOBGV>;
	Tue, 14 Jan 2003 20:06:21 -0500
Date: Tue, 14 Jan 2003 17:14:58 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] TTY changes for 2.5.58
Message-ID: <20030115011458.GC18283@kroah.com>
References: <20030115011312.GA18283@kroah.com> <20030115011409.GB18283@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030115011409.GB18283@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1026, 2003/01/14 16:57:38-08:00, greg@kroah.com

TTY: Added .owner for tty drivers in the drivers/usb/ directory


diff -Nru a/drivers/usb/class/bluetty.c b/drivers/usb/class/bluetty.c
--- a/drivers/usb/class/bluetty.c	Tue Jan 14 17:07:00 2003
+++ b/drivers/usb/class/bluetty.c	Tue Jan 14 17:07:00 2003
@@ -1107,20 +1107,17 @@
 		return -EIO;
 	}
 
-	MOD_INC_USE_COUNT;
 	info("USB Bluetooth converter detected");
 
 	for (minor = 0; minor < BLUETOOTH_TTY_MINORS && bluetooth_table[minor]; ++minor)
 		;
 	if (bluetooth_table[minor]) {
 		err("No more free Bluetooth devices");
-		MOD_DEC_USE_COUNT;
 		return -ENODEV;
 	}
 
 	if (!(bluetooth = kmalloc(sizeof(struct usb_bluetooth), GFP_KERNEL))) {
 		err("Out of memory");
-		MOD_DEC_USE_COUNT;
 		return -ENOMEM;
 	}
 
@@ -1236,7 +1233,6 @@
 
 	/* free up any memory that we allocated */
 	kfree (bluetooth);
-	MOD_DEC_USE_COUNT;
 	return -EIO;
 }
 
@@ -1295,13 +1291,12 @@
 	} else {
 		info("device disconnected");
 	}
-
-	MOD_DEC_USE_COUNT;
 }
 
 
 static struct tty_driver bluetooth_tty_driver = {
 	.magic =		TTY_DRIVER_MAGIC,
+	.owner =		THIS_MODULE,
 	.driver_name =		"usb-bluetooth",
 	.name =			"usb/ttub/%d",
 	.major =		BLUETOOTH_TTY_MAJOR,
diff -Nru a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
--- a/drivers/usb/class/cdc-acm.c	Tue Jan 14 17:07:00 2003
+++ b/drivers/usb/class/cdc-acm.c	Tue Jan 14 17:07:00 2003
@@ -320,8 +320,6 @@
 	tty->driver_data = acm;
 	acm->tty = tty;
 
-	MOD_INC_USE_COUNT;
-
         lock_kernel();
 
 	if (acm->used++) {
@@ -369,7 +367,6 @@
 			kfree(acm);
 		}
 	}
-	MOD_DEC_USE_COUNT;
 }
 
 static int acm_tty_write(struct tty_struct *tty, int from_user, const unsigned char *buf, int count)
@@ -724,6 +721,7 @@
 
 static struct tty_driver acm_tty_driver = {
 	.magic =		TTY_DRIVER_MAGIC,
+	.owner =		THIS_MODULE,
 	.driver_name =		"acm",
 	.name =			"usb/acm/%d",
 	.major =		ACM_TTY_MAJOR,
diff -Nru a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
--- a/drivers/usb/serial/usb-serial.c	Tue Jan 14 17:07:00 2003
+++ b/drivers/usb/serial/usb-serial.c	Tue Jan 14 17:07:00 2003
@@ -1257,6 +1257,7 @@
 
 struct tty_driver usb_serial_tty_driver = {
 	.magic =		TTY_DRIVER_MAGIC,
+	.owner =		THIS_MODULE,
 	.driver_name =		"usbserial",
 #ifndef CONFIG_DEVFS_FS
 	.name =			"ttyUSB",

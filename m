Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbREMAmc>; Sat, 12 May 2001 20:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261363AbREMAmW>; Sat, 12 May 2001 20:42:22 -0400
Received: from Huntington-Beach.Blue-Labs.org ([208.179.59.198]:31016 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S261362AbREMAmH>; Sat, 12 May 2001 20:42:07 -0400
Message-ID: <3AFDD848.3060604@blue-labs.org>
Date: Sat, 12 May 2001 17:41:44 -0700
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5-pre1 i686; en-US; rv:0.9) Gecko/20010505
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/telephony/phonedev.c (brings this code up to date with Quicknet CVS)
Content-Type: multipart/mixed;
 boundary="------------070400060502020409080508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070400060502020409080508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

phonedev.diff is against 2.4.4 and brings the file phonedev.c up to date 
with respect to the Quicknet CVS.  Changes are very minor, mostly #if 
LINUX_VERSION_CODE matching and structure updates.  Small off by one 
fixes and file operation semantics updates.

There is no impact to other files or functions functions.

David


--------------070400060502020409080508
Content-Type: text/plain;
 name="phonedev.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="phonedev.diff"

--- drivers/telephony/phonedev.c	Tue Sep 19 08:31:53 2000
+++ /zip/code/VoIP/ixj/phonedev.c	Sat May 12 17:32:05 2001
@@ -12,8 +12,14 @@
  *
  * Fixes:       Mar 01 2000 Thomas Sparr, <thomas.l.sparr@telia.com>
  *              phone_register_device now works with unit!=PHONE_UNIT_ANY
+ *
+ *              May 12 2001 David Ford, <david@blue-labs.org>
+ *              brought kernel version up to date with CVS, minor changes
  */
 
+#if LINUX_VERSION_CODE < 0x020400
+#include <linux/config.h>
+#endif
 #include <linux/version.h>
 #include <linux/module.h>
 #include <linux/types.h>
@@ -23,13 +29,16 @@
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/phonedev.h>
+#if LINUX_VERSION_CODE >= 0x020400
 #include <linux/init.h>
+#endif
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
 #include <linux/kmod.h>
+#if LINUX_VERSION_CODE >= 0x020400
 #include <linux/sem.h>
-
+#endif
 
 #define PHONE_NUM_DEVICES	256
 
@@ -38,8 +47,9 @@
  */
 
 static struct phone_device *phone_device[PHONE_NUM_DEVICES];
+#if LINUX_VERSION_CODE >= 0x020400
 static DECLARE_MUTEX(phone_lock);
-
+#endif
 /*
  *    Open a phone device.
  */
@@ -49,26 +59,48 @@
 	unsigned int minor = MINOR(inode->i_rdev);
 	int err = 0;
 	struct phone_device *p;
+#if LINUX_VERSION_CODE >= 0x020400
 	struct file_operations *old_fops, *new_fops = NULL;
-
+#endif
 	if (minor >= PHONE_NUM_DEVICES)
 		return -ENODEV;
 
+#if LINUX_VERSION_CODE >= 0x020400
 	down(&phone_lock);
+#endif
 	p = phone_device[minor];
+#if LINUX_VERSION_CODE < 0x020400
+	if (p == NULL) {
+#else
 	if (p)
 		new_fops = fops_get(p->f_op);
 	if (!new_fops) {
+#endif
 		char modname[32];
 
+#if LINUX_VERSION_CODE >= 0x020400
 		up(&phone_lock);
+#endif
 		sprintf(modname, "char-major-%d-%d", PHONE_MAJOR, minor);
 		request_module(modname);
+#if LINUX_VERSION_CODE >= 0x020400
 		down(&phone_lock);
+#endif
 		p = phone_device[minor];
-		if (p == NULL || (new_fops = fops_get(p->f_op)) == NULL)
-		{
-			err=-ENODEV;
+#if LINUX_VERSION_CODE < 0x020400
+		if (p == NULL)
+			return -ENODEV;
+	}
+	if (p->open) {
+		err = p->open(p, file);	/* Tell the device it is open */
+		if (err)
+			return err;
+	}
+	file->f_op = p->f_op;
+	return 0;
+#else
+		if (p == NULL || (new_fops = fops_get(p->f_op)) == NULL) {
+			err = -ENODEV;
 			goto end;
 		}
 	}
@@ -81,9 +113,10 @@
 		file->f_op = fops_get(old_fops);
 	}
 	fops_put(old_fops);
-end:
+      end:
 	up(&phone_lock);
 	return err;
+#endif
 }
 
 /*
@@ -101,20 +134,25 @@
 
 	if (unit != PHONE_UNIT_ANY) {
 		base = unit;
-		end = unit + 1;  /* enter the loop at least one time */
+		end = unit;
 	}
-	
+#if LINUX_VERSION_CODE >= 0x020400
 	down(&phone_lock);
+#endif
 	for (i = base; i < end; i++) {
 		if (phone_device[i] == NULL) {
 			phone_device[i] = p;
 			p->minor = i;
 			MOD_INC_USE_COUNT;
+#if LINUX_VERSION_CODE >= 0x020400
 			up(&phone_lock);
+#endif
 			return 0;
 		}
 	}
+#if LINUX_VERSION_CODE >= 0x020400
 	up(&phone_lock);
+#endif
 	return -ENFILE;
 }
 
@@ -124,48 +162,90 @@
 
 void phone_unregister_device(struct phone_device *pfd)
 {
+#if LINUX_VERSION_CODE >= 0x020400
 	down(&phone_lock);
+#endif
 	if (phone_device[pfd->minor] != pfd)
 		panic("phone: bad unregister");
 	phone_device[pfd->minor] = NULL;
+#if LINUX_VERSION_CODE >= 0x020400
 	up(&phone_lock);
+#endif
 	MOD_DEC_USE_COUNT;
 }
 
 
-static struct file_operations phone_fops =
-{
-	owner:		THIS_MODULE,
-	open:		phone_open,
+static struct file_operations phone_fops = {
+#if LINUX_VERSION_CODE >= 0x020400
+	owner:THIS_MODULE,
+	open:phone_open,
+#else
+	NULL,
+	NULL,
+	NULL,
+	NULL,			/* readdir */
+	NULL,
+	NULL,
+	NULL,
+	phone_open,
+	NULL,			/* flush */
+	NULL
+#endif
 };
 
 /*
- *	Board init functions
+ *    Board init functions
  */
- 
+
+#if LINUX_VERSION_CODE < 0x020400
+extern int ixj_init(void);
 
 /*
  *    Initialise Telephony for linux
  */
 
+int telephony_init(void)
+#else
 static int __init telephony_init(void)
+#endif
 {
 	printk(KERN_INFO "Linux telephony interface: v1.00\n");
 	if (register_chrdev(PHONE_MAJOR, "telephony", &phone_fops)) {
 		printk("phonedev: unable to get major %d\n", PHONE_MAJOR);
 		return -EIO;
 	}
-
+#if LINUX_VERSION_CODE < 0x020400
+	/*
+	 *    Init kernel installed drivers
+	 */
+#ifdef CONFIG_PHONE_IXJ
+	ixj_init();
+#endif
+#endif
 	return 0;
 }
 
+#ifdef MODULE
+#if LINUX_VERSION_CODE < 0x020400
+int init_module(void)
+{
+	return telephony_init();
+}
+
+void cleanup_module(void)
+#else
 static void __exit telephony_exit(void)
+#endif
 {
 	unregister_chrdev(PHONE_MAJOR, "telephony");
 }
 
+#endif
+
+#if LINUX_VERSION_CODE >= 0x020400
 module_init(telephony_init);
 module_exit(telephony_exit);
+#endif
 
 EXPORT_SYMBOL(phone_register_device);
 EXPORT_SYMBOL(phone_unregister_device);

--------------070400060502020409080508--


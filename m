Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285893AbRLHKap>; Sat, 8 Dec 2001 05:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285895AbRLHKag>; Sat, 8 Dec 2001 05:30:36 -0500
Received: from mail-7.tiscalinet.it ([195.130.225.153]:26480 "EHLO
	mail.tiscalinet.it") by vger.kernel.org with ESMTP
	id <S285893AbRLHKaa>; Sat, 8 Dec 2001 05:30:30 -0500
From: Alessandro Amici <amici@tiscalinet.it>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] devfs support in char/raw.c
Date: Sat, 8 Dec 2001 11:31:35 +0100
X-Mailer: KMail [version 1.3.2]
Cc: alexamici@tiscalinet.it
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_N8T0NISFB94OUWGSP0WB"
Message-Id: <20011208103135.7DA0EE005@alan.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_N8T0NISFB94OUWGSP0WB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

[please cc me on reply]

Hi,

the following patch enables devfs support for the raw devices.
It is a blatant cut-and-copy from other drivers, and it passed the
basic tests I could figure out (mainly xine dvd raw access) - with and
without devfs.

Without devfs I find the raw devices under /dev on my Debian box,
but man raw(8) itself introduces the /dev/raw/ directory.
So, the proposed devices naming scheme is:

/dev/raw/rawctl
/dev/raw/raw1
...
/dev/raw/raw64

I would like to submit the patch to the maintainer, but I failed to
find who he is! (Stephen Tweedie?)

Alessandro





--------------Boundary-00=_N8T0NISFB94OUWGSP0WB
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch-2.4.16-raw_devfs"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="patch-2.4.16-raw_devfs"

--- drivers/char/raw.c-orig	Sun Sep 23 05:35:43 2001
+++ drivers/char/raw.c	Fri Dec  7 19:45:30 2001
@@ -15,6 +15,7 @@
 #include <linux/raw.h>
 #include <linux/capability.h>
 #include <linux/smp_lock.h>
+#include <linux/devfs_fs_kernel.h>
 #include <asm/uaccess.h>
 
 #define dprintk(x...) 
@@ -51,10 +52,26 @@
 static int __init raw_init(void)
 {
 	int i;
-	register_chrdev(RAW_MAJOR, "raw", &raw_fops);
+	devfs_handle_t devfs_handle;
+	char name_buf[8];
+
+	if (devfs_register_chrdev(RAW_MAJOR, "raw", &raw_fops))
+		printk("unable to get major %d for raw devs\n", RAW_MAJOR);
+
+	devfs_handle = devfs_mk_dir(NULL, "raw", NULL);
+	devfs_register (devfs_handle, "rawctl", DEVFS_FL_DEFAULT,
+			RAW_MAJOR, 0, S_IFCHR | S_IRUGO | S_IWUGO,
+			&raw_fops, NULL);
 
 	for (i = 0; i < 256; i++)
 		init_MUTEX(&raw_devices[i].mutex);
+
+	for (i = 1; i < 64; i++) {
+		sprintf(name_buf, "raw%d", i);
+		devfs_register (devfs_handle, name_buf, DEVFS_FL_DEFAULT,
+				RAW_MAJOR, i, S_IFCHR | S_IRUGO | S_IWUGO,
+				&raw_fops, NULL);
+	}
 
 	return 0;
 }

--------------Boundary-00=_N8T0NISFB94OUWGSP0WB--

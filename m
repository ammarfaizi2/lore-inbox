Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286374AbSAAXhL>; Tue, 1 Jan 2002 18:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286372AbSAAXhC>; Tue, 1 Jan 2002 18:37:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14097 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S286395AbSAAXg4>;
	Tue, 1 Jan 2002 18:36:56 -0500
Message-ID: <3C324816.488F2AA5@mandrakesoft.com>
Date: Tue, 01 Jan 2002 18:36:54 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
CC: viro@math.psu.edu
Subject: PATCH 2.5.2.6: fix up serial, sysrq
Content-Type: multipart/mixed;
 boundary="------------347F065D0CF87611B8021295"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------347F065D0CF87611B8021295
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The kdev_none change might not be correct, please check.  It's the place
in sysrq where the code immediately above syncs local disks, and then
syncs non-local disks.  The better change might be to simply remove the
second check altogether, instead of changing it as I have done.
-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
--------------347F065D0CF87611B8021295
Content-Type: text/plain; charset=us-ascii;
 name="char.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="char.patch"

diff -u -r1.4 serial.c
--- drivers/char/serial.c	2002/01/01 22:41:09	1.4
+++ drivers/char/serial.c	2002/01/01 23:19:45
@@ -5827,7 +5827,7 @@
 
 static kdev_t serial_console_device(struct console *c)
 {
-	return MKDEV(TTY_MAJOR, 64 + c->index);
+	return mk_kdev(TTY_MAJOR, 64 + c->index);
 }
 
 /*
diff -u -r1.2 sysrq.c
--- drivers/char/sysrq.c	2001/12/11 04:04:49	1.2
+++ drivers/char/sysrq.c	2002/01/01 23:19:45
@@ -105,7 +105,7 @@
 /* Guesses if the device is a local hard drive */
 static int is_local_disk(kdev_t dev) {
 	unsigned int major;
-	major = MAJOR(dev);
+	major = major(dev);
 
 	switch (major) {
 	case IDE0_MAJOR:
@@ -206,7 +206,7 @@
 	for (sb = sb_entry(super_blocks.next);
 	     sb != sb_entry(&super_blocks); 
 	     sb = sb_entry(sb->s_list.next))
-		if (!is_local_disk(sb->s_dev) && MAJOR(sb->s_dev))
+		if (!is_local_disk(sb->s_dev) && !kdev_none(sb->s_dev))
 			go_sync(sb, remount_flag);
 
 	unlock_kernel();

--------------347F065D0CF87611B8021295--


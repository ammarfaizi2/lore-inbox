Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318085AbSHZMCY>; Mon, 26 Aug 2002 08:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318086AbSHZMCX>; Mon, 26 Aug 2002 08:02:23 -0400
Received: from gate.in-addr.de ([212.8.193.158]:33285 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S318085AbSHZMCW>;
	Mon, 26 Aug 2002 08:02:22 -0400
Date: Mon, 26 Aug 2002 14:06:42 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] loop device failing on demand (2.4)
Message-ID: <20020826120642.GP7119@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="M/SuVGWktc5uNpra"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The attached small patch allows to "fail" a loop device on demand. Any further
request to the loop device will simply fail.

Even though it of course doesn't simulate the failures one might see in the
field, it is kind of handy for automated tests, for example for multipath I/O.

Done by Jens Axboe. The reason why I am sending it: I need it most and he is
on vacation.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Immortality is an adequate definition of high availability for me.
	--- Gregory F. Pfister


--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="loopdevice.patch"

diff -ur /opt/kernel/linux-2.4.20-pre1/drivers/block/loop.c linux/drivers/block/loop.c
--- /opt/kernel/linux-2.4.20-pre1/drivers/block/loop.c	2002-08-03 02:39:43.000000000 +0200
+++ linux/drivers/block/loop.c	2002-08-09 09:59:42.000000000 +0200
@@ -473,6 +473,11 @@
 	atomic_inc(&lo->lo_pending);
 	spin_unlock_irq(&lo->lo_lock);
 
+	if (lo->lo_flags & LO_FLAGS_FAIL) {
+		printk("%s: failing %s\n", kdevname(rbh->b_rdev), rw == WRITE ? "write" : "read");
+		goto err;
+	}
+
 	if (rw == WRITE) {
 		if (lo->lo_flags & LO_FLAGS_READ_ONLY)
 			goto err;
@@ -877,6 +880,14 @@
 	case LOOP_GET_STATUS:
 		err = loop_get_status(lo, (struct loop_info *) arg);
 		break;
+	case LOOP_SET_FAIL:
+		lo->lo_flags |= LO_FLAGS_FAIL;
+		err = 0;
+		break;
+	case LOOP_CLEAR_FAIL:
+		lo->lo_flags &= ~LO_FLAGS_FAIL;
+		err = 0;
+		break;
 	case BLKGETSIZE:
 		if (lo->lo_state != Lo_bound) {
 			err = -ENXIO;
diff -ur /opt/kernel/linux-2.4.20-pre1/include/linux/loop.h linux/include/linux/loop.h
--- /opt/kernel/linux-2.4.20-pre1/include/linux/loop.h	2001-09-17 22:16:30.000000000 +0200
+++ linux/include/linux/loop.h	2002-08-08 12:01:56.000000000 +0200
@@ -78,6 +78,7 @@
 #define LO_FLAGS_DO_BMAP	1
 #define LO_FLAGS_READ_ONLY	2
 #define LO_FLAGS_BH_REMAP	4
+#define LO_FLAGS_FAIL		8
 
 /* 
  * Note that this structure gets the wrong offsets when directly used
@@ -151,5 +152,7 @@
 #define LOOP_CLR_FD	0x4C01
 #define LOOP_SET_STATUS	0x4C02
 #define LOOP_GET_STATUS	0x4C03
+#define LOOP_SET_FAIL	0x4c04
+#define LOOP_CLEAR_FAIL	0x4c05
 
 #endif

--M/SuVGWktc5uNpra--

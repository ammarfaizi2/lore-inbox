Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVCHTeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVCHTeo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 14:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVCHTbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 14:31:52 -0500
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:3344 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262070AbVCHTZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 14:25:27 -0500
Date: Tue, 8 Mar 2005 20:25:30 +0100
From: Jean Delvare <khali@linux-fr.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Daniel Staaf <dst@bostream.nu>, LKML <linux-kernel@vger.kernel.org>,
       Andrei Mikhailovsky <andrei@arhont.com>,
       Ian Campbell <icampbell@arcom.com>,
       Ronald Bultje <rbultje@ronald.bitfreak.net>,
       Gerd Knorr <kraxel@bytesex.org>
Subject: [PATCH 2.6] Fix i2c messsage flags in video drivers
Message-Id: <20050308202530.2fbfae9a.khali@linux-fr.org>
In-Reply-To: <20050308201504.6aee36d5.khali@linux-fr.org>
References: <1110024688.5494.2.camel@whale.core.arhont.com>
	<422A5473.7030306@osdl.org>
	<1110115990.5611.2.camel@whale.core.arhont.com>
	<422CCBF4.1060902@osdl.org>
	<20050308201504.6aee36d5.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

While working on the saa7110 driver I found a problem with the way
various video drivers (found on Zoran-based boards) prepare i2c messages
to be used by i2c_transfer. The drivers improperly copy the i2c client
flags as the message flags, while both sets are mostly unrelated. The
net effect in this case is to trigger an I2C block read instead of the
expected I2C block write. The fix is simply not to pass any flag,
because none are needed.

I think this patch qualifies hands down as a "critical bug fix" to be
included in whatever bug-fix-only trees exist these days. As far as I
can see, all Zoran-based boards are broken in 2.6.11 without this patch.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

diff -u -rN linux-2.6.11-bk3/drivers/media/video.orig/adv7170.c linux-2.6.11-bk3/drivers/media/video/adv7170.c
--- linux-2.6.11-bk3/drivers/media/video.orig/adv7170.c	Tue Mar  8 10:27:14 2005
+++ linux-2.6.11-bk3/drivers/media/video/adv7170.c	Tue Mar  8 12:19:04 2005
@@ -130,7 +130,7 @@
 		u8 block_data[32];
 
 		msg.addr = client->addr;
-		msg.flags = client->flags;
+		msg.flags = 0;
 		while (len >= 2) {
 			msg.buf = (char *) block_data;
 			msg.len = 0;
diff -u -rN linux-2.6.11-bk3/drivers/media/video.orig/adv7175.c linux-2.6.11-bk3/drivers/media/video/adv7175.c
--- linux-2.6.11-bk3/drivers/media/video.orig/adv7175.c	Tue Mar  8 10:27:14 2005
+++ linux-2.6.11-bk3/drivers/media/video/adv7175.c	Tue Mar  8 12:18:57 2005
@@ -126,7 +126,7 @@
 		u8 block_data[32];
 
 		msg.addr = client->addr;
-		msg.flags = client->flags;
+		msg.flags = 0;
 		while (len >= 2) {
 			msg.buf = (char *) block_data;
 			msg.len = 0;
diff -u -rN linux-2.6.11-bk3/drivers/media/video.orig/bt819.c linux-2.6.11-bk3/drivers/media/video/bt819.c
--- linux-2.6.11-bk3/drivers/media/video.orig/bt819.c	Tue Mar  8 10:27:15 2005
+++ linux-2.6.11-bk3/drivers/media/video/bt819.c	Tue Mar  8 12:18:51 2005
@@ -146,7 +146,7 @@
 		u8 block_data[32];
 
 		msg.addr = client->addr;
-		msg.flags = client->flags;
+		msg.flags = 0;
 		while (len >= 2) {
 			msg.buf = (char *) block_data;
 			msg.len = 0;
diff -u -rN linux-2.6.11-bk3/drivers/media/video.orig/saa7114.c linux-2.6.11-bk3/drivers/media/video/saa7114.c
--- linux-2.6.11-bk3/drivers/media/video.orig/saa7114.c	Tue Mar  8 10:27:15 2005
+++ linux-2.6.11-bk3/drivers/media/video/saa7114.c	Tue Mar  8 12:18:20 2005
@@ -163,7 +163,7 @@
 		u8 block_data[32];
 
 		msg.addr = client->addr;
-		msg.flags = client->flags;
+		msg.flags = 0;
 		while (len >= 2) {
 			msg.buf = (char *) block_data;
 			msg.len = 0;
diff -u -rN linux-2.6.11-bk3/drivers/media/video.orig/saa7185.c linux-2.6.11-bk3/drivers/media/video/saa7185.c
--- linux-2.6.11-bk3/drivers/media/video.orig/saa7185.c	Tue Mar  8 10:27:15 2005
+++ linux-2.6.11-bk3/drivers/media/video/saa7185.c	Tue Mar  8 12:18:12 2005
@@ -118,7 +118,7 @@
 		u8 block_data[32];
 
 		msg.addr = client->addr;
-		msg.flags = client->flags;
+		msg.flags = 0;
 		while (len >= 2) {
 			msg.buf = (char *) block_data;
 			msg.len = 0;



-- 
Jean Delvare

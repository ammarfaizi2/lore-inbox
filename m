Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261398AbSKZWwm>; Tue, 26 Nov 2002 17:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbSKZWwm>; Tue, 26 Nov 2002 17:52:42 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:4481 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261398AbSKZWwj>; Tue, 26 Nov 2002 17:52:39 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Date: Tue, 26 Nov 2002 23:58:02 +0100
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Con Kolivas <conman@kolivas.net>, Andrea Arcangeli <andrea@suse.de>,
       Jens Axboe <axboe@suse.de>
MIME-Version: 1.0
Message-Id: <200211262343.02093.m.c.p@wolk-project.de>
Subject: [PATCH 2.4.20-rc4] 2.4.19 / 2.4.20 Pauses/stopps with high disk I/O
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_Q4H7MN5UBKQHID580NK5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_Q4H7MN5UBKQHID580NK5
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Con, Andrea, Jens,

Con and me were testing your, Andrea, lowlatency elevator hack the last d=
ays.=20
It's much impressive that I/O pauses/stopps are almost gone with the hack=
,=20
even though the throughput is decreased (22mb/s to 12mb/s for my mashine)=
=2E

Con did a 3 line change to drivers/block/ll_rw_blk.c and=20
include/linux/elevator.h and those pauses/stopps are _totally_ gone. Even=
=20
throughput increased from 12mb/s, with the lowlat elevator from Andrea, t=
o=20
14mb/s with that 3 liner. Patch attached + Config option for 2.4.20-rc4.

Exchanging the files mentioned above with the 2.4.18 ones has either no e=
ffect=20
to throughput (22mb/s) and also has no pauses/stopps.

We think the approach with the lowlatency elevator's is fine, but there m=
ust=20
have changed something very seriously in the mentioned files that this oc=
cur=20
with >=3D 2.4.19.

This is just a "we want to inform you about it" mail :)

Have fun!

ciao, Marc




--------------Boundary-00=_Q4H7MN5UBKQHID580NK5
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.4.20-rc4-elevator-lowlatency.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.4.20-rc4-elevator-lowlatency.patch"

# Patch from: Con Kolivas (private Mail) / me

diff -ruN linux-old/Documentation/Configure.help linux-wolk/Documentation/Configure.help
--- linux-old/Documentation/Configure.help	Mon Feb 25 20:37:51 2002
+++ linux-wolk/Documentation/Configure.help	Sat Apr 27 23:52:48 2002
@@ -867,6 +867,18 @@
 
   If unsure, say N.
 
+Low Latency Elevator
+CONFIG_BLK_DEV_ELEVATOR_LOWLAT
+  If you are building your kernel for desktop usage it is highly
+  recommended to say Y here. With this option set, you can have the
+  highest disk i/o you ever dreamed of and still have interactive
+  behaviour of your kernel without stops/pauses or kinda that.
+  For sure, this decreases throughput, for me from 22mb/s to 14mb/s
+  but this is unrelevant for desktop usage.
+
+  If unsure, or if you're building a kernel for serverusage,
+  say N, otherwise say Y.
+
 ISA-PNP EIDE support
 CONFIG_BLK_DEV_ISAPNP
   If you have an ISA EIDE card that is PnP (Plug and Play) and
diff -urN linux-old/drivers/block/Config-elevator.in linux-wolk/drivers/block/Config-elevator.in
--- linux-old/drivers/block/Config-elevator.in	Thu Jan  1 01:00:00 1970
+++ linux-wolk/drivers/block/Config-elevator.in	Mon Sep 17 13:46:19 2001
@@ -0,0 +1,10 @@
+#
+# Elevator configuration
+#
+mainmenu_option next_comment
+comment 'Elevator'
+
+bool 'Low Latency Elevator' CONFIG_BLK_DEV_ELEVATOR_LOWLAT
+
+endmenu
+
diff -urN linux-old/arch/i386/config.in linux-wolk/arch/i386/config.in
--- linux-old/arch/i386/config.in	Thu Jan  1 01:00:00 1970
+++ linux-wolk/arch/i386/config.in	Mon Sep 17 13:46:19 2001
@@ -326,6 +326,8 @@
 
 source drivers/block/Config.in
 
+source drivers/block/Config-elevator.in
+
 source drivers/md/Config.in
 
 if [ "$CONFIG_NET" = "y" ]; then
diff -urN linux-2.4.19/arch/i386/config.in linux-2.4.19-ck14/arch/i386/config.in
--- linux-2.4.19/drivers/block/ll_rw_blk.c	2002-08-03 13:14:45.000000000 +1000
+++ linux-2.4.19-ck14/drivers/block/ll_rw_blk.c	2002-11-26 21:55:18.000000000 +1100
@@ -432,9 +433,13 @@
 
 	si_meminfo(&si);
 	megs = si.totalram >> (20 - PAGE_SHIFT);
+#ifndef CONFIG_BLK_DEV_ELEVATOR_LOWLAT
 	nr_requests = 128;
 	if (megs < 32)
 		nr_requests /= 2;
+#else
+	nr_requests = 4;
+#endif
 	blk_grow_request_list(q, nr_requests);
 
 	init_waitqueue_head(&q->wait_for_requests[0]);
diff -urN linux-2.4.19/include/linux/elevator.h linux-2.4.19-ck14/include/linux/elevator.h
--- linux-2.4.19/include/linux/elevator.h	2001-02-16 11:58:34.000000000 +1100
+++ linux-2.4.19-ck14/include/linux/elevator.h	2002-11-26 22:45:01.000000000 +1100
@@ -91,6 +91,7 @@
 	elevator_noop_merge_req,	/* elevator_merge_req_fn */	\
 	})
 
+#ifndef CONFIG_BLK_DEV_ELEVATOR_LOWLAT
 #define ELEVATOR_LINUS							\
 ((elevator_t) {								\
 	2048,				/* read passovers */		\
@@ -100,4 +101,17 @@
 	elevator_linus_merge_req,	/* elevator_merge_req_fn */	\
 	})
 
-#endif
+#else	/* CONFIG_BLK_DEV_ELEVATOR_LOWLAT */
+
+#define ELEVATOR_LINUS							\
+((elevator_t) {								\
+	0,				/* read passovers */		\
+	0,				/* write passovers */		\
+									\
+	elevator_linus_merge,		/* elevator_merge_fn */		\
+	elevator_linus_merge_req,	/* elevator_merge_req_fn */	\
+	})
+
+#endif	/* CONFIG_BLK_DEV_ELEVATOR_LOWLAT */
+
+#endif	/* _LINUX_ELEVATOR_H */

--------------Boundary-00=_Q4H7MN5UBKQHID580NK5--


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131569AbQKQL5X>; Fri, 17 Nov 2000 06:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129720AbQKQL5E>; Fri, 17 Nov 2000 06:57:04 -0500
Received: from linus.st-and.ac.uk ([138.251.32.11]:12030 "EHLO
	linus.st-andrews.ac.uk") by vger.kernel.org with ESMTP
	id <S129076AbQKQL4y>; Fri, 17 Nov 2000 06:56:54 -0500
Message-Id: <l03130300b63ac27dc63a@[138.251.135.28]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 17 Nov 2000 11:26:40 +0000
To: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
From: Mark Hindley <mh15@st-andrews.ac.uk>
Subject: [PATCH] ALS-110 opl3 and mpu401 under 2.4.0-test10
Cc: Thomas Molina <tmolina@home.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please consider this patch which fixes some problems I have been having
with mu ALS-110 card under 2.4 kernels.

There are 2 fixes:

1) pnp info in sb_card.c does not match what the card reports, so isapnp
doesn't identify the opl3 device

2) The other relates to the uart401 detection. If you build the sb driver
into the kernel and then pass the commandline uart401=1 this is interpreted
as the io parameter for the uart401 module not a command for the sb driver.
I have renamed the uart401 detection command to uart401probe. Obviously it
isn't a problem with a modular driver, but the change shouldn't matter.


Mark


--- drivers/sound/sb_card.c	Fri Nov 17 10:22:36 2000
+++ drivers/sound/sb_card.c	Fri Nov 17 10:12:37 2000
@@ -50,6 +50,10 @@
  *
  * 21-09-2000 Got rid of attach_sbmpu
  * 	Arnaldo Carvalho de Melo <acme@conectiva.com.br>
+ *
+ * 17-11-2000 Renamed parameter uart401 to uart401probe to avoid conflict
with uart401 module
+ *      Bugfix ALS-110 pnp info
+ *      Mark Hindley <mh15@st-andrews.ac.uk>
  */

 #include <linux/config.h>
@@ -195,7 +199,7 @@
 static int isapnpjump	= 0;
 static int multiple	= 1;
 static int reverse	= 0;
-static int uart401	= 0;
+static int uart401probe	= 0;

 static int audio_activated[SB_CARDS_MAX] = {0};
 static int mpu_activated[SB_CARDS_MAX]   = {0};
@@ -222,12 +226,12 @@
 MODULE_PARM(isapnpjump,	"i");
 MODULE_PARM(multiple,	"i");
 MODULE_PARM(reverse,	"i");
-MODULE_PARM(uart401,	"i");
+MODULE_PARM(uart401probe,	"i");
 MODULE_PARM_DESC(isapnp,	"When set to 0, Plug & Play support will be
disabled");
 MODULE_PARM_DESC(isapnpjump,	"Jumps to a specific slot in the driver's
PnP table. Use the source, Luke.");
 MODULE_PARM_DESC(multiple,	"When set to 0, will not search for
multiple cards");
 MODULE_PARM_DESC(reverse,	"When set to 1, will reverse ISAPnP search
order");
-MODULE_PARM_DESC(uart401,	"When set to 1, will attempt to detect and
enable the mpu on some clones");
+MODULE_PARM_DESC(uart401probe,	"When set to 1, will attempt to detect and
enable the mpu on some clones");
 #endif

 MODULE_PARM_DESC(io,		"Soundblaster i/o base address
(0x220,0x240,0x260,0x280)");
@@ -454,8 +458,8 @@
 		ISAPNP_VENDOR('A','L','S'), ISAPNP_DEVICE(0x0110),
 		ISAPNP_VENDOR('@','@','@'), ISAPNP_FUNCTION(0x1001),
 		ISAPNP_VENDOR('@','X','@'), ISAPNP_FUNCTION(0x1001),
-		ISAPNP_VENDOR('@','H','@'), ISAPNP_FUNCTION(0x0001),
-		1,0,0,0},
+	        ISAPNP_VENDOR('@','H','@'), ISAPNP_FUNCTION(0x1001),
+	        1,0,0,0},
 	{"ALS120",
 		ISAPNP_VENDOR('A','L','S'), ISAPNP_DEVICE(0x0120),
 		ISAPNP_VENDOR('@','@','@'), ISAPNP_FUNCTION(0x2001),
@@ -557,7 +561,7 @@
 	}

 	/* Cards with separate MPU device (ALS, CMI, etc.) */
-	if(!uart401)
+	if(!uart401probe)
 		return(sb_dev[card]);
 	if((mpu_dev[card] = isapnp_find_dev(bus,
sb_isapnp_list[slot].mpu_vendor, sb_isapnp_list[slot].mpu_function, NULL)))
 	{





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

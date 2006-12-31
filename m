Return-Path: <linux-kernel-owner+w=401wt.eu-S932342AbWLaBEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWLaBEa (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 20:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWLaBEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 20:04:30 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:45782 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932342AbWLaBE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 20:04:29 -0500
Message-id: <1497922962154918808@wsc.cz>
In-reply-to: <152402571305932932@wsc.cz>
Subject: [PATCH 2/8] Char: moxa, do not initialize global static
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sun, 31 Dec 2006 02:04:30 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

moxa, do not initialize global static

Remove useless initialization of variables a) statically b) dynamically
at module_init c) dynamically after kzalloc (those with '= 0/NULL')

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit bc5dff44602d67db9d08ae1735e6f29162264704
tree 02ad9d888e7a5f274d04214a52bb176b3c3ec89a
parent fdcf97c855168c011b18ff68930bcc93e6c625c6
author Jiri Slaby <jirislaby@gmail.com> Sun, 31 Dec 2006 01:37:23 +0059
committer Jiri Slaby <jirislaby@gmail.com> Sun, 31 Dec 2006 01:37:23 +0059

 drivers/char/moxa.c |   24 ++++--------------------
 1 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/char/moxa.c b/drivers/char/moxa.c
index 4db1dc4..80a2bdf 100644
--- a/drivers/char/moxa.c
+++ b/drivers/char/moxa.c
@@ -194,9 +194,9 @@ static int verbose = 0;
 static int ttymajor = MOXAMAJOR;
 /* Variables for insmod */
 #ifdef MODULE
-static int baseaddr[] 	= 	{0, 0, 0, 0};
-static int type[]	=	{0, 0, 0, 0};
-static int numports[] 	=	{0, 0, 0, 0};
+static int baseaddr[4];
+static int type[4];
+static int numports[4];
 #endif
 
 MODULE_AUTHOR("William Chen");
@@ -348,10 +348,7 @@ static int __init moxa_init(void)
 	moxaDriver->type = TTY_DRIVER_TYPE_SERIAL;
 	moxaDriver->subtype = SERIAL_TYPE_NORMAL;
 	moxaDriver->init_termios = tty_std_termios;
-	moxaDriver->init_termios.c_iflag = 0;
-	moxaDriver->init_termios.c_oflag = 0;
 	moxaDriver->init_termios.c_cflag = B9600 | CS8 | CREAD | CLOCAL | HUPCL;
-	moxaDriver->init_termios.c_lflag = 0;
 	moxaDriver->init_termios.c_ispeed = 9600;
 	moxaDriver->init_termios.c_ospeed = 9600;
 	moxaDriver->flags = TTY_DRIVER_REAL_RAW;
@@ -361,25 +358,13 @@ static int __init moxa_init(void)
 		ch->type = PORT_16550A;
 		ch->port = i;
 		INIT_WORK(&ch->tqueue, do_moxa_softint);
-		ch->tty = NULL;
 		ch->close_delay = 5 * HZ / 10;
 		ch->closing_wait = 30 * HZ;
-		ch->count = 0;
-		ch->blocked_open = 0;
 		ch->cflag = B9600 | CS8 | CREAD | CLOCAL | HUPCL;
 		init_waitqueue_head(&ch->open_wait);
 		init_waitqueue_head(&ch->close_wait);
 	}
 
-	for (i = 0; i < MAX_BOARDS; i++) {
-		moxa_boards[i].boardType = 0;
-		moxa_boards[i].numPorts = 0;
-		moxa_boards[i].baseAddr = 0;
-		moxa_boards[i].busType = 0;
-		moxa_boards[i].pciInfo.busNum = 0;
-		moxa_boards[i].pciInfo.devNum = 0;
-	}
-	MoxaDriverInit();
 	printk("Tty devices major number = %d\n", ttymajor);
 
 	if (tty_register_driver(moxaDriver)) {
@@ -391,7 +376,6 @@ static int __init moxa_init(void)
 		init_timer(&moxaEmptyTimer[i]);
 		moxaEmptyTimer[i].function = check_xmit_empty;
 		moxaEmptyTimer[i].data = (unsigned long) & moxaChannels[i];
-		moxaEmptyTimer_on[i] = 0;
 	}
 
 	init_timer(&moxaTimer);
@@ -1470,7 +1454,7 @@ static char moxaLowChkFlag[MAX_PORTS];
 static int moxaLowWaterChk;
 static int moxaCard;
 static mon_st moxaLog;
-static int moxaFuncTout;
+static int moxaFuncTout = HZ / 2;
 static ushort moxaBreakCnt[MAX_PORTS];
 
 static void moxadelay(int);

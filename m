Return-Path: <linux-kernel-owner+w=401wt.eu-S932345AbWLaBEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWLaBEV (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 20:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWLaBEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 20:04:21 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:45780 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932333AbWLaBEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 20:04:20 -0500
Message-id: <152402571305932932@wsc.cz>
Subject: [PATCH 1/8] Char: moxa, remove unused allocated page
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sun, 31 Dec 2006 02:04:19 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

moxa, remove unused allocated page

moxaXmitBuff is almost unused -- only one byte from the whole PAGE_SIZE
bytes is used. Do not alloc so much space for almost anything. Also remove
lock protecting this page allocation.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit fdcf97c855168c011b18ff68930bcc93e6c625c6
tree a87c0cef9ad40eb3ff2a981ecaa7ac08711809ac
parent c614729fee9638269d0881cf6ab895f19122225a
author Jiri Slaby <jirislaby@gmail.com> Sun, 31 Dec 2006 01:08:54 +0059
committer Jiri Slaby <jirislaby@gmail.com> Sun, 31 Dec 2006 01:08:54 +0059

 drivers/char/moxa.c |   24 +-----------------------
 1 files changed, 1 insertions(+), 23 deletions(-)

diff --git a/drivers/char/moxa.c b/drivers/char/moxa.c
index f391a24..4db1dc4 100644
--- a/drivers/char/moxa.c
+++ b/drivers/char/moxa.c
@@ -212,12 +212,10 @@ module_param(verbose, bool, 0644);
 
 static struct tty_driver *moxaDriver;
 static struct moxa_str moxaChannels[MAX_PORTS];
-static unsigned char *moxaXmitBuff;
 static int moxaTimer_on;
 static struct timer_list moxaTimer;
 static int moxaEmptyTimer_on[MAX_PORTS];
 static struct timer_list moxaEmptyTimer[MAX_PORTS];
-static struct semaphore moxaBuffSem;
 
 /*
  * static functions:
@@ -343,7 +341,6 @@ static int __init moxa_init(void)
 	if (!moxaDriver)
 		return -ENOMEM;
 
-	init_MUTEX(&moxaBuffSem);
 	moxaDriver->owner = THIS_MODULE;
 	moxaDriver->name = "ttyMX";
 	moxaDriver->major = ttymajor;
@@ -360,8 +357,6 @@ static int __init moxa_init(void)
 	moxaDriver->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(moxaDriver, &moxa_ops);
 
-	moxaXmitBuff = NULL;
-
 	for (i = 0, ch = moxaChannels; i < MAX_PORTS; i++, ch++) {
 		ch->type = PORT_16550A;
 		ch->port = i;
@@ -533,7 +528,6 @@ static int moxa_open(struct tty_struct *tty, struct file *filp)
 	struct moxa_str *ch;
 	int port;
 	int retval;
-	unsigned long page;
 
 	port = PORTNO(tty);
 	if (port == MAX_PORTS) {
@@ -543,21 +537,6 @@ static int moxa_open(struct tty_struct *tty, struct file *filp)
 		tty->driver_data = NULL;
 		return (-ENODEV);
 	}
-	down(&moxaBuffSem);
-	if (!moxaXmitBuff) {
-		page = get_zeroed_page(GFP_KERNEL);
-		if (!page) {
-			up(&moxaBuffSem);
-			return (-ENOMEM);
-		}
-		/* This test is guarded by the BuffSem so no longer needed
-		   delete me in 2.5 */
-		if (moxaXmitBuff)
-			free_page(page);
-		else
-			moxaXmitBuff = (unsigned char *) page;
-	}
-	up(&moxaBuffSem);
 
 	ch = &moxaChannels[port];
 	ch->count++;
@@ -739,8 +718,7 @@ static void moxa_put_char(struct tty_struct *tty, unsigned char c)
 		return;
 	port = ch->port;
 	spin_lock_irqsave(&moxa_lock, flags);
-	moxaXmitBuff[0] = c;
-	MoxaPortWriteData(port, moxaXmitBuff, 1);
+	MoxaPortWriteData(port, &c, 1);
 	spin_unlock_irqrestore(&moxa_lock, flags);
 	/************************************************
 	if ( !(ch->statusflags & LOWWAIT) && (MoxaPortTxFree(port) <= 100) )

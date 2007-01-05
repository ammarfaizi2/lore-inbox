Return-Path: <linux-kernel-owner+w=401wt.eu-S1161161AbXAERKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161161AbXAERKp (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 12:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161162AbXAERKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 12:10:44 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:51010 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161160AbXAERKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 12:10:43 -0500
Message-id: <572728011959124127@wsc.cz>
In-reply-to: <16079316021425814645@wsc.cz>
Subject: [PATCH 2/7] Char: moxa, use del_timer_sync
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Fri,  5 Jan 2007 18:10:52 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

moxa, use del_timer_sync

Use del_timer_sync in most timer deletions, we don't want to oops in the
timer function.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 040f78a69ad874e2976ab93a55cde2dc02df7d66
tree 22edf4da2daee70849b8ddfb4c4f04efb8d7bf59
parent 49a3eb961ed6dca0e44778f26910e9e4ed6fd491
author Jiri Slaby <jirislaby@gmail.com> Wed, 03 Jan 2007 12:28:56 +0059
committer Jiri Slaby <jirislaby@gmail.com> Fri, 05 Jan 2007 17:38:49 +0059

 drivers/char/moxa.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/moxa.c b/drivers/char/moxa.c
index da2a1d1..9eb8fa6 100644
--- a/drivers/char/moxa.c
+++ b/drivers/char/moxa.c
@@ -424,10 +424,10 @@ static void __exit moxa_exit(void)
 	if (verbose)
 		printk("Unloading module moxa ...\n");
 
-	del_timer(&moxaTimer);
+	del_timer_sync(&moxaTimer);
 
 	for (i = 0; i < MAX_PORTS; i++)
-		del_timer(&moxaEmptyTimer[i]);
+		del_timer_sync(&moxaEmptyTimer[i]);
 
 	if (tty_unregister_driver(moxaDriver))
 		printk("Couldn't unregister MOXA Intellio family serial driver\n");
@@ -529,7 +529,7 @@ static void moxa_close(struct tty_struct *tty, struct file *filp)
 	if (ch->asyncflags & ASYNC_INITIALIZED) {
 		setup_empty_event(tty);
 		tty_wait_until_sent(tty, 30 * HZ);	/* 30 seconds timeout */
-		del_timer(&moxaEmptyTimer[ch->port]);
+		del_timer_sync(&moxaEmptyTimer[ch->port]);
 	}
 	shut_down(ch);
 	MoxaPortFlushData(port, 2);
@@ -1004,7 +1004,7 @@ static void check_xmit_empty(unsigned long data)
 	struct moxa_str *ch;
 
 	ch = (struct moxa_str *) data;
-	del_timer(&moxaEmptyTimer[ch->port]);
+	del_timer_sync(&moxaEmptyTimer[ch->port]);
 	if (ch->tty && (ch->statusflags & EMPTYWAIT)) {
 		if (MoxaPortTxQueue(ch->port) == 0) {
 			ch->statusflags &= ~EMPTYWAIT;

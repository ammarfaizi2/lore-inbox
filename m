Return-Path: <linux-kernel-owner+w=401wt.eu-S932480AbWLaBEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbWLaBEm (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 20:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWLaBEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 20:04:41 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:45785 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932439AbWLaBEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 20:04:40 -0500
Message-id: <11679175832013430@wsc.cz>
In-reply-to: <152402571305932932@wsc.cz>
Subject: [PATCH 3/8] Char: moxa, timers cleanup
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sun, 31 Dec 2006 02:04:40 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

moxa, timers cleanup

Use kernel macros and functions for timer encapsulation -- do not access
fileds directly. Also del_timer on inactive is legal, so that noting if it
runs is senseless, delete these variables.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 8171e38961018ef16df52084d1356f891f43ba6f
tree 0001e745280d863e774609d428afa2154bfba487
parent bc5dff44602d67db9d08ae1735e6f29162264704
author Jiri Slaby <jirislaby@gmail.com> Sun, 31 Dec 2006 01:40:02 +0059
committer Jiri Slaby <jirislaby@gmail.com> Sun, 31 Dec 2006 01:40:02 +0059

 drivers/char/moxa.c |   54 +++++++++++++--------------------------------------
 1 files changed, 14 insertions(+), 40 deletions(-)

diff --git a/drivers/char/moxa.c b/drivers/char/moxa.c
index 80a2bdf..84797a0 100644
--- a/drivers/char/moxa.c
+++ b/drivers/char/moxa.c
@@ -210,13 +210,6 @@ module_param_array(numports, int, NULL, 0);
 module_param(ttymajor, int, 0);
 module_param(verbose, bool, 0644);
 
-static struct tty_driver *moxaDriver;
-static struct moxa_str moxaChannels[MAX_PORTS];
-static int moxaTimer_on;
-static struct timer_list moxaTimer;
-static int moxaEmptyTimer_on[MAX_PORTS];
-static struct timer_list moxaEmptyTimer[MAX_PORTS];
-
 /*
  * static functions:
  */
@@ -300,6 +293,10 @@ static const struct tty_operations moxa_ops = {
 	.tiocmset = moxa_tiocmset,
 };
 
+static struct tty_driver *moxaDriver;
+static struct moxa_str moxaChannels[MAX_PORTS];
+static DEFINE_TIMER(moxaTimer, moxa_poll, 0, 0);
+static struct timer_list moxaEmptyTimer[MAX_PORTS];
 static DEFINE_SPINLOCK(moxa_lock);
 
 #ifdef CONFIG_PCI
@@ -372,17 +369,11 @@ static int __init moxa_init(void)
 		put_tty_driver(moxaDriver);
 		return -1;
 	}
-	for (i = 0; i < MAX_PORTS; i++) {
-		init_timer(&moxaEmptyTimer[i]);
-		moxaEmptyTimer[i].function = check_xmit_empty;
-		moxaEmptyTimer[i].data = (unsigned long) & moxaChannels[i];
-	}
+	for (i = 0; i < MAX_PORTS; i++)
+		setup_timer(&moxaEmptyTimer[i], check_xmit_empty,
+				(unsigned long)&moxaChannels[i]);
 
-	init_timer(&moxaTimer);
-	moxaTimer.function = moxa_poll;
-	moxaTimer.expires = jiffies + (HZ / 50);
-	moxaTimer_on = 1;
-	add_timer(&moxaTimer);
+	mod_timer(&moxaTimer, jiffies + HZ / 50);
 
 	/* Find the boards defined in source code */
 	numBoards = 0;
@@ -468,12 +459,10 @@ static void __exit moxa_exit(void)
 	if (verbose)
 		printk("Unloading module moxa ...\n");
 
-	if (moxaTimer_on)
-		del_timer(&moxaTimer);
+	del_timer(&moxaTimer);
 
 	for (i = 0; i < MAX_PORTS; i++)
-		if (moxaEmptyTimer_on[i])
-			del_timer(&moxaEmptyTimer[i]);
+		del_timer(&moxaEmptyTimer[i]);
 
 	if (tty_unregister_driver(moxaDriver))
 		printk("Couldn't unregister MOXA Intellio family serial driver\n");
@@ -589,7 +578,6 @@ static void moxa_close(struct tty_struct *tty, struct file *filp)
 	if (ch->asyncflags & ASYNC_INITIALIZED) {
 		setup_empty_event(tty);
 		tty_wait_until_sent(tty, 30 * HZ);	/* 30 seconds timeout */
-		moxaEmptyTimer_on[ch->port] = 0;
 		del_timer(&moxaEmptyTimer[ch->port]);
 	}
 	shut_down(ch);
@@ -885,14 +873,10 @@ static void moxa_poll(unsigned long ignored)
 	struct tty_struct *tp;
 	int i, ports;
 
-	moxaTimer_on = 0;
 	del_timer(&moxaTimer);
 
 	if (MoxaDriverPoll() < 0) {
-		moxaTimer.function = moxa_poll;
-		moxaTimer.expires = jiffies + (HZ / 50);
-		moxaTimer_on = 1;
-		add_timer(&moxaTimer);
+		mod_timer(&moxaTimer, jiffies + HZ / 50);
 		return;
 	}
 	for (card = 0; card < MAX_BOARDS; card++) {
@@ -932,10 +916,7 @@ static void moxa_poll(unsigned long ignored)
 		}
 	}
 
-	moxaTimer.function = moxa_poll;
-	moxaTimer.expires = jiffies + (HZ / 50);
-	moxaTimer_on = 1;
-	add_timer(&moxaTimer);
+	mod_timer(&moxaTimer, jiffies + HZ / 50);
 }
 
 /******************************************************************************/
@@ -1062,11 +1043,7 @@ static void setup_empty_event(struct tty_struct *tty)
 
 	spin_lock_irqsave(&moxa_lock, flags);
 	ch->statusflags |= EMPTYWAIT;
-	moxaEmptyTimer_on[ch->port] = 0;
-	del_timer(&moxaEmptyTimer[ch->port]);
-	moxaEmptyTimer[ch->port].expires = jiffies + HZ;
-	moxaEmptyTimer_on[ch->port] = 1;
-	add_timer(&moxaEmptyTimer[ch->port]);
+	mod_timer(&moxaEmptyTimer[ch->port], jiffies + HZ);
 	spin_unlock_irqrestore(&moxa_lock, flags);
 }
 
@@ -1075,7 +1052,6 @@ static void check_xmit_empty(unsigned long data)
 	struct moxa_str *ch;
 
 	ch = (struct moxa_str *) data;
-	moxaEmptyTimer_on[ch->port] = 0;
 	del_timer(&moxaEmptyTimer[ch->port]);
 	if (ch->tty && (ch->statusflags & EMPTYWAIT)) {
 		if (MoxaPortTxQueue(ch->port) == 0) {
@@ -1083,9 +1059,7 @@ static void check_xmit_empty(unsigned long data)
 			tty_wakeup(ch->tty);
 			return;
 		}
-		moxaEmptyTimer[ch->port].expires = jiffies + HZ;
-		moxaEmptyTimer_on[ch->port] = 1;
-		add_timer(&moxaEmptyTimer[ch->port]);
+		mod_timer(&moxaEmptyTimer[ch->port], jiffies + HZ);
 	} else
 		ch->statusflags &= ~EMPTYWAIT;
 }

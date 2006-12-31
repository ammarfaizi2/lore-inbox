Return-Path: <linux-kernel-owner+w=401wt.eu-S932333AbWLaBE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWLaBE5 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 20:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbWLaBE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 20:04:57 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:45793 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932333AbWLaBEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 20:04:50 -0500
Message-id: <2970917086546717235@wsc.cz>
In-reply-to: <152402571305932932@wsc.cz>
Subject: [PATCH 4/8] Char: moxa, remove hangup bottomhalf
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sun, 31 Dec 2006 02:04:50 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

moxa, remove hangup bottomhalf

call tty_hangup directly, we do not need a bottomhalf for this.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 9146480faf6469f789229e4f09d99a90b3e05c26
tree 58eb5f2f3943a17ad05b3fd869ab987e63a4fe14
parent 8171e38961018ef16df52084d1356f891f43ba6f
author Jiri Slaby <jirislaby@gmail.com> Sun, 31 Dec 2006 01:42:55 +0059
committer Jiri Slaby <jirislaby@gmail.com> Sun, 31 Dec 2006 01:42:55 +0059

 drivers/char/moxa.c |   25 +++----------------------
 1 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/char/moxa.c b/drivers/char/moxa.c
index 84797a0..ef2558f 100644
--- a/drivers/char/moxa.c
+++ b/drivers/char/moxa.c
@@ -159,7 +159,6 @@ struct moxa_str {
 	int cflag;
 	wait_queue_head_t open_wait;
 	wait_queue_head_t close_wait;
-	struct work_struct tqueue;
 };
 
 struct mxser_mstatus {
@@ -178,9 +177,6 @@ static struct mxser_mstatus GMStatus[MAX_PORTS];
 #define EMPTYWAIT	0x4
 #define THROTTLE	0x8
 
-/* event */
-#define MOXA_EVENT_HANGUP	1
-
 #define SERIAL_DO_RESTART
 
 
@@ -213,7 +209,6 @@ module_param(verbose, bool, 0644);
 /*
  * static functions:
  */
-static void do_moxa_softint(struct work_struct *);
 static int moxa_open(struct tty_struct *, struct file *);
 static void moxa_close(struct tty_struct *, struct file *);
 static int moxa_write(struct tty_struct *, const unsigned char *, int);
@@ -354,7 +349,6 @@ static int __init moxa_init(void)
 	for (i = 0, ch = moxaChannels; i < MAX_PORTS; i++, ch++) {
 		ch->type = PORT_16550A;
 		ch->port = i;
-		INIT_WORK(&ch->tqueue, do_moxa_softint);
 		ch->close_delay = 5 * HZ / 10;
 		ch->closing_wait = 30 * HZ;
 		ch->cflag = B9600 | CS8 | CREAD | CLOCAL | HUPCL;
@@ -482,20 +476,6 @@ static void __exit moxa_exit(void)
 module_init(moxa_init);
 module_exit(moxa_exit);
 
-static void do_moxa_softint(struct work_struct *work)
-{
-	struct moxa_str *ch = container_of(work, struct moxa_str, tqueue);
-	struct tty_struct *tty;
-
-	if (ch && (tty = ch->tty)) {
-		if (test_and_clear_bit(MOXA_EVENT_HANGUP, &ch->event)) {
-			tty_hangup(tty);	/* FIXME: module removal race here - AKPM */
-			wake_up_interruptible(&ch->open_wait);
-			ch->asyncflags &= ~ASYNC_NORMAL_ACTIVE;
-		}
-	}
-}
-
 static int moxa_open(struct tty_struct *tty, struct file *filp)
 {
 	struct moxa_str *ch;
@@ -908,8 +888,9 @@ static void moxa_poll(unsigned long ignored)
 					if (MoxaPortDCDON(ch->port))
 						wake_up_interruptible(&ch->open_wait);
 					else {
-						set_bit(MOXA_EVENT_HANGUP, &ch->event);
-						schedule_work(&ch->tqueue);
+						tty_hangup(tp);
+						wake_up_interruptible(&ch->open_wait);
+						ch->asyncflags &= ~ASYNC_NORMAL_ACTIVE;
 					}
 				}
 			}

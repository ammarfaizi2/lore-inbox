Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269789AbUJANtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269789AbUJANtZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 09:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269790AbUJANtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 09:49:25 -0400
Received: from nl-ams-slo-l4-01-pip-7.chellonetwork.com ([213.46.243.25]:5461
	"EHLO amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S269789AbUJANtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 09:49:22 -0400
Date: Fri, 1 Oct 2004 15:49:10 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] tty fall-out (was: Re: Linux 2.6.9-rc3)
In-Reply-To: <Pine.LNX.4.58.0409292036010.2976@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61.0410011546590.26491@anakin>
References: <Pine.LNX.4.58.0409292036010.2976@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2004, Linus Torvalds wrote:
> Alan Cox:
>   o tty locking cleanup and fixes

The two patches below (compile)fix some fall-out from the tty cleanups.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.9-rc3/drivers/char/generic_serial.c.orig	2004-09-30 12:53:35.000000000 +0200
+++ linux-2.6.9-rc3/drivers/char/generic_serial.c	2004-10-01 12:47:40.000000000 +0200
@@ -691,7 +691,7 @@ void gs_close(struct tty_struct * tty, s
 	unsigned long flags;
 	struct gs_port *port;
 	
-	func_enter ()
+	func_enter ();
 
 	if (!tty) return;
 
--- linux-2.6.9-rc3/drivers/char/moxa.c.orig	2004-09-30 12:53:35.000000000 +0200
+++ linux-2.6.9-rc3/drivers/char/moxa.c	2004-10-01 12:43:17.000000000 +0200
@@ -952,7 +952,7 @@ static void moxa_poll(unsigned long igno
 				if (MoxaPortTxQueue(ch->port) <= WAKEUP_CHARS) {
 					if (!tp->stopped) {
 						ch->statusflags &= ~LOWWAIT;
-						tty_wakeup(tty);
+						tty_wakeup(tp);
 						wake_up_interruptible(&tp->write_wait);
 					}
 				}
@@ -1119,7 +1119,7 @@ static void check_xmit_empty(unsigned lo
 	if (ch->tty && (ch->statusflags & EMPTYWAIT)) {
 		if (MoxaPortTxQueue(ch->port) == 0) {
 			ch->statusflags &= ~EMPTYWAIT;
-			tty_wakeup(tty);
+			tty_wakeup(ch->tty);
 			wake_up_interruptible(&ch->tty->write_wait);
 			return;
 		}

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbVHQBna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVHQBna (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 21:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbVHQBna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 21:43:30 -0400
Received: from gate.crashing.org ([63.228.1.57]:9667 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750763AbVHQBn3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 21:43:29 -0400
Subject: [PATCH] [Fwd: Console locking and blanking]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Aug 2005 11:41:14 +1000
Message-Id: <1124242875.8848.10.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had WARN_CONSOLE_UNLOCKED warnings when calling TIOCLINUX 
TIOCL_BLANKSCREEN and TIOCL_UNBLANKSCREEN.

(I'm blind and I use a braille display. I use those functions to blank 
my laptop's screen so people don't read it, and hopefully to conserve 
power.)

The warnings are from these places:
do_blank_screen at drivers/char/vt.c:2754 (Not tainted)
save_screen at drivers/char/vt.c:575 (Not tainted)
do_unblank_screen at drivers/char/vt.c:2822 (Not tainted)
set_palette at drivers/char/vt.c:2908 (Not tainted)

At a glance I would think the following patch ought to fix that. Tested on 
one machine. Could you please tell me if this is correct and/or forward 
the patch where appropriate...

Signed-off-by: Stéphane Doyon <s.doyon@videotron.ca>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

--- linux-2.6.12/drivers/char/vt.c.orig	2005-08-16 15:39:14.000000000 -0400
+++ linux-2.6.12/drivers/char/vt.c	2005-08-16 15:41:04.000000000 -0400
@@ -2272,7 +2272,9 @@
  			ret = paste_selection(tty);
  			break;
  		case TIOCL_UNBLANKSCREEN:
+			acquire_console_sem();
  			unblank_screen();
+			release_console_sem();
  			break;
  		case TIOCL_SELLOADLUT:
  			ret = sel_loadlut(p);
@@ -2317,8 +2319,10 @@
  			}
  			break;
  		case TIOCL_BLANKSCREEN:	/* until explicitly unblanked, not only poked */
+			acquire_console_sem();
  			ignore_poke = 1;
  			do_blank_screen(0);
+			release_console_sem();
  			break;
  		case TIOCL_BLANKEDSCREEN:
  			ret = console_blanked;


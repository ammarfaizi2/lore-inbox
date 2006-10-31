Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422660AbWJaAmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422660AbWJaAmz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 19:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422658AbWJaAmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 19:42:46 -0500
Received: from av2.karneval.cz ([81.27.192.122]:49168 "EHLO av2.karneval.cz")
	by vger.kernel.org with ESMTP id S1422646AbWJaAmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 19:42:19 -0500
Message-id: <642139641257723381@karneval.cz>
Subject: [PATCH 5/9] Char: sx, simplify timer logic
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: <R.E.Wolff@BitWizard.nl>
Cc: <support@specialix.co.uk>
Date: Tue, 31 Oct 2006 01:42:17 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sx, simplify timer logic

Use kernel helpers for changing timer internals.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit ff54cb9cb0f690ad9414bc8c800b8fdfb38199a2
tree e3af70b31ec8df40137157f21e0e7641b4e3bf15
parent 10fd13e67b848584d1553b524d2e925ad60a1b4f
author Jiri Slaby <jirislaby@gmail.com> Tue, 31 Oct 2006 00:43:49 +0100
committer Jiri Slaby <jirislaby@gmail.com> Tue, 31 Oct 2006 00:43:49 +0100

 drivers/char/sx.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/char/sx.c b/drivers/char/sx.c
index fe5fabb..3e71bf8 100644
--- a/drivers/char/sx.c
+++ b/drivers/char/sx.c
@@ -1304,10 +1304,7 @@ static void sx_pollfunc(unsigned long da
 
 	sx_interrupt(0, board);
 
-	init_timer(&board->timer);
-
-	board->timer.expires = jiffies + sx_poll;
-	add_timer(&board->timer);
+	mod_timer(&board->timer, jiffies + sx_poll);
 	func_exit();
 }
 
@@ -2006,14 +2003,10 @@ static int sx_init_board(struct sx_board
 
 		/* The timer should be initialized anyway: That way we can
 		   safely del_timer it when the module is unloaded. */
-		init_timer(&board->timer);
+		setup_timer(&board->timer, sx_pollfunc, (unsigned long)board);
 
-		if (board->poll) {
-			board->timer.data = (unsigned long)board;
-			board->timer.function = sx_pollfunc;
-			board->timer.expires = jiffies + board->poll;
-			add_timer(&board->timer);
-		}
+		if (board->poll)
+			mod_timer(&board->timer, jiffies + board->poll);
 	} else {
 		board->irq = 0;
 	}

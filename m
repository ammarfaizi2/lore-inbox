Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030390AbWJCWEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030390AbWJCWEw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030479AbWJCWEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:04:52 -0400
Received: from av1.karneval.cz ([81.27.192.123]:28498 "EHLO av1.karneval.cz")
	by vger.kernel.org with ESMTP id S1030390AbWJCWEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:04:51 -0400
Message-id: <123432101123@karneval.cz>
Subject: [PATCH 1/6] Char: mxser_new, revert spin_lock changes
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <support@moxa.com.tw>
Date: Wed,  4 Oct 2006 00:04:46 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, revert spin_lock changes

Some spinlock changes were introduced in 1.9.1 original moxa driver. Revert
them, since they cause machine not responding.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 4c32efcfdb10227313ef7271ffc4658dbdf2d81c
tree 38ec2fc437a458f796279818fbadfacf8ead43ab
parent e92271cac3db8e9f64b79132553e607e8c84f42d
author Jiri Slaby <jirislaby@gmail.com> Tue, 03 Oct 2006 22:25:27 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Tue, 03 Oct 2006 22:25:27 +0200

 drivers/char/mxser_new.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index 4e881ac..db89d73 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -1687,22 +1687,12 @@ static void mxser_startrx(struct tty_str
  */
 static void mxser_throttle(struct tty_struct *tty)
 {
-	struct mxser_port *info = tty->driver_data;
-	unsigned long flags;
-
-	spin_lock_irqsave(&info->slock, flags);
 	mxser_stoprx(tty);
-	spin_unlock_irqrestore(&info->slock, flags);
 }
 
 static void mxser_unthrottle(struct tty_struct *tty)
 {
-	struct mxser_port *info = tty->driver_data;
-	unsigned long flags;
-
-	spin_lock_irqsave(&info->slock, flags);
 	mxser_startrx(tty);
-	spin_unlock_irqrestore(&info->slock, flags);
 }
 
 static void mxser_set_termios(struct tty_struct *tty, struct termios *old_termios)
@@ -1930,7 +1920,6 @@ static irqreturn_t mxser_interrupt(int i
 				}
 				/* above add by Victor Yu. 09-13-2002 */
 
-				spin_lock(&port->slock);
 				/* following add by Victor Yu. 09-02-2002 */
 				status = inb(port->ioaddr + UART_LSR);
 
@@ -1981,7 +1970,6 @@ static irqreturn_t mxser_interrupt(int i
 					if (status & UART_LSR_THRE)
 						mxser_transmit_chars(port);
 				}
-				spin_unlock(&port->slock);
 			} while (int_cnt++ < MXSER_ISR_PASS_LIMIT);
 		}
 		if (pass_counter++ > MXSER_ISR_PASS_LIMIT)

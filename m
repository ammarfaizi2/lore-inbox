Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbUDCE7W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 23:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbUDCE7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 23:59:22 -0500
Received: from mail016.syd.optusnet.com.au ([211.29.132.167]:1928 "EHLO
	mail016.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261604AbUDCE7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 23:59:17 -0500
Date: Sat, 3 Apr 2004 15:02:29 +1000
From: Adam Nielsen <a.nielsen@optushome.com.au>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Fix kernel lockup in RTL-8169 gigabit ethernet driver
Message-Id: <20040403150229.75ec6b98.a.nielsen@optushome.com.au>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This is a tiny patch that fixes a particularly annoying bug
in the Realtek 8169 gigabit ethernet driver.  Due to a logic error,
there is a loop in an interrupt handler that often goes infinite, thus
locking up the entire computer.  The attached patch fixes the problem.

I have patched against linux-2.6.5-rc2-bk6, however the source file in
question hasn't been modified for a long time, so the patch should apply
cleanly to any recent kernel version.

Cheers,
Adam.

--- linux-2.6.5-rc2-bk6/drivers/net/r8169.c	2004-03-27 17:38:03.000000000 +1000
+++ linux-2.6.5-rc2-bk6a/drivers/net/r8169.c	2004-03-31 18:45:10.000000000 +1000
@@ -33,6 +33,12 @@
 	- Copy mc_filter setup code from 8139cp
 	  (includes an optimization, and avoids set_bit use)
 
+VERSION 1.2a <2004/03/31> Adam Nielsen (a.nielsen@optushome.com.au)
+
+	"else break;" added to the if-statement in rtl8169_tx_interrupt() to prevent
+	an infinite loop and the resulting kernel lockup when the interrupt is called
+	with a dirty buffer (perhaps when there's nothing to transmit?)
+
 */
 
 #include <linux/module.h>
@@ -892,7 +898,7 @@
 			tp->Tx_skbuff[entry] = NULL;
 			dirty_tx++;
 			tx_left--;
-		}
+		} else break;
 	}
 
 	if (tp->dirty_tx != dirty_tx) {

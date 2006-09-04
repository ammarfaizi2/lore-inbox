Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbWIDNRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbWIDNRW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 09:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWIDNRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 09:17:21 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40621 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964910AbWIDNRU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 09:17:20 -0400
Subject: [PATCH] specialix - remove private speed decoding
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 04 Sep 2006 14:39:57 +0100
Message-Id: <1157377198.30801.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/drivers/char/specialix.c linux-2.6.18-rc5-mm1/drivers/char/specialix.c
--- linux.vanilla-2.6.18-rc5-mm1/drivers/char/specialix.c	2006-09-01 13:39:04.000000000 +0100
+++ linux-2.6.18-rc5-mm1/drivers/char/specialix.c	2006-09-01 13:52:48.000000000 +0100
@@ -1087,24 +1087,16 @@
 		port->MSVR =  (sx_in(bp, CD186x_MSVR) & MSVR_RTS);
 	spin_unlock_irqrestore(&bp->lock, flags);
 	dprintk (SX_DEBUG_TERMIOS, "sx: got MSVR=%02x.\n", port->MSVR);
-	baud = C_BAUD(tty);
+	baud = tty_get_baud_rate(tty);
 
-	if (baud & CBAUDEX) {
-		baud &= ~CBAUDEX;
-		if (baud < 1 || baud > 2)
-			port->tty->termios->c_cflag &= ~CBAUDEX;
-		else
-			baud += 15;
-	}
-	if (baud == 15) {
+	if (baud == 38400) {
 		if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_HI)
 			baud ++;
 		if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_VHI)
 			baud += 2;
 	}
 
-
-	if (!baud_table[baud]) {
+	if (!baud) {
 		/* Drop DTR & exit */
 		dprintk (SX_DEBUG_TERMIOS, "Dropping DTR...  Hmm....\n");
 		if (!SX_CRTSCTS (tty)) {
@@ -1134,7 +1126,7 @@
 		                  "This is an untested option, please be carefull.\n",
 		                  port_No (port), tmp);
 	else
-		tmp = (((SX_OSCFREQ + baud_table[baud]/2) / baud_table[baud] +
+		tmp = (((SX_OSCFREQ + baud/2) / baud +
 		         CD186x_TPC/2) / CD186x_TPC);
 
 	if ((tmp < 0x10) && time_before(again, jiffies)) {


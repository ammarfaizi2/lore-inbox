Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWIDNK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWIDNK4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 09:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWIDNK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 09:10:56 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42927 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964825AbWIDNKz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 09:10:55 -0400
Subject: [PATCH] generic_serial - remove private decoding of baud rate bits
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 04 Sep 2006 14:33:32 +0100
Message-Id: <1157376813.30801.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The driver has no business doing this work itself any more and hasn't
for some years. When the new speed stuff goes in this will break
entirely so fix it up ready.

Also remove a #if 0 around a comment....


Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/drivers/char/generic_serial.c linux-2.6.18-rc5-mm1/drivers/char/generic_serial.c
--- linux.vanilla-2.6.18-rc5-mm1/drivers/char/generic_serial.c	2006-08-30 18:27:18.000000000 +0100
+++ linux-2.6.18-rc5-mm1/drivers/char/generic_serial.c	2006-09-01 13:52:24.000000000 +0100
@@ -746,11 +746,9 @@
 		gs_dprintk (GS_DEBUG_TERMIOS, "termios structure (%p):\n", tiosp);
 	}
 
-#if 0
 	/* This is an optimization that is only allowed for dumb cards */
 	/* Smart cards require knowledge of iflags and oflags too: that 
 	   might change hardware cooking mode.... */
-#endif
 	if (old_termios) {
 		if(   (tiosp->c_iflag == old_termios->c_iflag)
 		   && (tiosp->c_oflag == old_termios->c_oflag)
@@ -774,14 +772,7 @@
 		if(!memcmp(tiosp->c_cc, old_termios->c_cc, NCC)) printk("c_cc changed\n");
 	}
 
-	baudrate = tiosp->c_cflag & CBAUD;
-	if (baudrate & CBAUDEX) {
-		baudrate &= ~CBAUDEX;
-		if ((baudrate < 1) || (baudrate > 4))
-			tiosp->c_cflag &= ~CBAUDEX;
-		else
-			baudrate += 15;
-	}
+	baudrate = tty_get_baud_rate(tty);
 
 	baudrate = gs_baudrates[baudrate];
 	if ((tiosp->c_cflag & CBAUD) == B38400) {


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWIDNMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWIDNMk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 09:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWIDNMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 09:12:40 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43951 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964830AbWIDNMj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 09:12:39 -0400
Subject: [PATCH] istallion: Remove private baud rate decoding, which is
	also broken in this case on some platforms
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 04 Sep 2006 14:35:16 +0100
Message-Id: <1157376916.30801.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/drivers/char/istallion.c linux-2.6.18-rc5-mm1/drivers/char/istallion.c
--- linux.vanilla-2.6.18-rc5-mm1/drivers/char/istallion.c	2006-09-01 13:39:04.000000000 +0100
+++ linux-2.6.18-rc5-mm1/drivers/char/istallion.c	2006-09-01 13:52:32.000000000 +0100
@@ -612,16 +614,6 @@
 #define	MINOR2BRD(min)		(((min) & 0xc0) >> 6)
 #define	MINOR2PORT(min)		((min) & 0x3f)
 
-/*
- *	Define a baud rate table that converts termios baud rate selector
- *	into the actual baud rate value. All baud rate calculations are based
- *	on the actual baud rate required.
- */
-static unsigned int	stli_baudrates[] = {
-	0, 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800, 2400, 4800,
-	9600, 19200, 38400, 57600, 115200, 230400, 460800, 921600
-};
-
 /*****************************************************************************/
 
 /*
@@ -2747,15 +2739,7 @@
 /*
  *	Start of by setting the baud, char size, parity and stop bit info.
  */
-	pp->baudout = tiosp->c_cflag & CBAUD;
-	if (pp->baudout & CBAUDEX) {
-		pp->baudout &= ~CBAUDEX;
-		if ((pp->baudout < 1) || (pp->baudout > 4))
-			tiosp->c_cflag &= ~CBAUDEX;
-		else
-			pp->baudout += 15;
-	}
-	pp->baudout = stli_baudrates[pp->baudout];
+	pp->baudout = tty_get_baud_rate(portp->tty);
 	if ((tiosp->c_cflag & CBAUD) == B38400) {
 		if ((portp->flags & ASYNC_SPD_MASK) == ASYNC_SPD_HI)
 			pp->baudout = 57600;


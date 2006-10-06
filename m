Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422727AbWJFXB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422727AbWJFXB6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 19:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422725AbWJFXB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 19:01:58 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:61848 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1422728AbWJFXB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 19:01:56 -0400
Message-id: <34287982324@wsc.cz>
Subject: [PATCH 2/6] Char: mxser_new, testbit for bit testing
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <support@moxa.com.tw>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sat,  7 Oct 2006 01:01:56 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, testbit for bit testing

Use testbit like in tty subsystem for TTY_IO_ERROR testing.

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 104fc67145e462bc89c0f778a1907f96cd150873
tree 8d0fff4e5ead2913954f3a73127e74e898d0d1f2
parent f1ec019ded64c90bc2c8017a41bd77c8f900711c
author Jiri Slaby <jirislaby@gmail.com> Fri, 06 Oct 2006 23:39:18 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Fri, 06 Oct 2006 23:39:18 +0200

 drivers/char/mxser_new.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index 1f53e07..84d72aa 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -461,7 +461,8 @@ static int mxser_block_til_ready(struct 
 	 * If non-blocking mode is set, or the port is not enabled,
 	 * then make the check up front and then exit.
 	 */
-	if ((filp->f_flags & O_NONBLOCK) || (tty->flags & (1 << TTY_IO_ERROR))) {
+	if ((filp->f_flags & O_NONBLOCK) ||
+			test_bit(TTY_IO_ERROR, &tty->flags)) {
 		port->flags |= ASYNC_NORMAL_ACTIVE;
 		return 0;
 	}
@@ -1437,7 +1438,7 @@ static int mxser_tiocmget(struct tty_str
 
 	if (tty->index == MXSER_PORTS)
 		return -ENOIOCTLCMD;
-	if (tty->flags & (1 << TTY_IO_ERROR))
+	if (test_bit(TTY_IO_ERROR, &tty->flags))
 		return -EIO;
 
 	control = info->MCR;
@@ -1464,7 +1465,7 @@ static int mxser_tiocmset(struct tty_str
 
 	if (tty->index == MXSER_PORTS)
 		return -ENOIOCTLCMD;
-	if (tty->flags & (1 << TTY_IO_ERROR))
+	if (test_bit(TTY_IO_ERROR, &tty->flags))
 		return -EIO;
 
 	spin_lock_irqsave(&info->slock, flags);
@@ -1798,10 +1799,10 @@ static int mxser_ioctl(struct tty_struct
 	}
 	/* above add by Victor Yu. 01-05-2004 */
 
-	if ((cmd != TIOCGSERIAL) && (cmd != TIOCMIWAIT) && (cmd != TIOCGICOUNT)) {
-		if (tty->flags & (1 << TTY_IO_ERROR))
-			return -EIO;
-	}
+	if (cmd != TIOCGSERIAL && cmd != TIOCMIWAIT && cmd != TIOCGICOUNT &&
+			test_bit(TTY_IO_ERROR, &tty->flags))
+		return -EIO;
+
 	switch (cmd) {
 	case TCSBRK:		/* SVID version: non-zero arg --> no break */
 		retval = tty_check_change(tty);

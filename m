Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267620AbTGLBCl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 21:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267614AbTGLBCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 21:02:41 -0400
Received: from ossipee.unh.edu ([132.177.137.39]:2493 "EHLO ossipee.unh.edu")
	by vger.kernel.org with ESMTP id S267595AbTGLBCh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 21:02:37 -0400
Date: Fri, 11 Jul 2003 21:17:16 -0400
From: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>
To: linux-ppp@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: [PATCH] [2.5] adding ppp xon/xoff support
Message-ID: <20030712011716.GB4694@bouh.unh.edu>
Reply-To: Samuel Thibault <samuel.thibault@fnac.net>
Mail-Followup-To: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>,
	linux-ppp@vger.kernel.org, linux-kernel@vger.kernel.org,
	torvalds@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i-nntp
X-MailScanner-Information: http://pubpages.unh.edu/notes/mailfiltering.html
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-8.7, required 5,
	BAYES_01, PATCH_UNIFIED_DIFF, USER_AGENT_MUTT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch wasn't applied, probably because the misplaced else
statement, here is a corrected version. This would at last make linux
support xon/xoff for ppp connections (it hasn't been available since 2.0
at least).

Please apply,

Regards,
Samuel Thibault

diff -ur linux-2.5.71-orig/drivers/net/ppp_async.c linux-2.5.71-perso/drivers/net/ppp_async.c
--- linux-2.5.71-orig/drivers/net/ppp_async.c	2003-06-14 17:13:03.000000000 -0400
+++ linux-2.5.71-perso/drivers/net/ppp_async.c	2003-07-06 13:51:23.000000000 -0400
@@ -893,6 +893,24 @@
 			process_input_packet(ap);
 		} else if (c == PPP_ESCAPE) {
 			ap->state |= SC_ESCAPE;
+		} else if (I_IXON(ap->tty)) {
+			if (c == STOP_CHAR(ap->tty)) {
+				if (!ap->tty->stopped) {
+					ap->tty->stopped = 1;
+					if (ap->tty->driver->stop)
+						(ap->tty->driver->stop)(ap->tty);
+				}
+			} else if (c == START_CHAR(ap->tty)) {
+				if (ap->tty->stopped) {
+					ap->tty->stopped = 0;
+					if (ap->tty->driver->start)
+						(ap->tty->driver->start)(ap->tty);
+					if ((test_bit(TTY_DO_WRITE_WAKEUP, &ap->tty->flags)) &&
+					    ap->tty->ldisc.write_wakeup)
+						(ap->tty->ldisc.write_wakeup)(ap->tty);
+					wake_up_interruptible(&ap->tty->write_wait);
+				}
+			}
 		}
 		/* otherwise it's a char in the recv ACCM */
 		++n;

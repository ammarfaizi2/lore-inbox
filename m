Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264035AbTFHWl2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 18:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264026AbTFHWl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 18:41:27 -0400
Received: from dixville.unh.edu ([132.177.137.38]:38097 "EHLO dixville.unh.edu")
	by vger.kernel.org with ESMTP id S264023AbTFHWlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 18:41:25 -0400
Date: Sun, 8 Jun 2003 18:54:58 -0400
From: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>
To: linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org,
       torvalds@transmeta.com
Subject: [PATCH][2.5] PPP still doesn't support XON/XOFF
Message-ID: <20030608225457.GB628@bouh.unh.edu>
Reply-To: Samuel Thibault <samuel.thibault@fnac.net>
Mail-Followup-To: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>,
	linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org,
	torvalds@transmeta.com
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

The ppp net driver still doesn't support xon/xoff (just try calling pppd
xonxoff and try to stop kernel sending data with ^S) although the pppd
man page clearly tells it does, here is a patch which handles it.

Regards,
Samuel Thibault

--- linux-2.5.70-bk12/drivers/net/ppp_async.c	2003-05-26 21:00:45.000000000 -0400
+++ linux-2.5.70-bk12-perso/drivers/net/ppp_async.c	2003-06-08 16:02:51.000000000 -0400
@@ -893,6 +893,25 @@
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
+			} else
+			if (c == START_CHAR(ap->tty)) {
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

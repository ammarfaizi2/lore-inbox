Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270278AbTGZVU3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 17:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269969AbTGZVU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 17:20:29 -0400
Received: from unity.unh.edu ([132.177.137.40]:44427 "EHLO unity.unh.edu")
	by vger.kernel.org with ESMTP id S270275AbTGZVU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 17:20:26 -0400
Date: Sat, 26 Jul 2003 17:35:31 -0400
From: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>
To: Paul Mackerras <paulus@samba.org>, linux-ppp@vger.kernel.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH] [2.6] adding xon/xoff support to ppp
Message-ID: <20030726213531.GA1148@bouh.unh.edu>
Reply-To: Samuel Thibault <samuel.thibault@fnac.net>
Mail-Followup-To: Paul Mackerras <paulus@samba.org>,
	linux-ppp@vger.kernel.org, linux-kernel@vger.kernel.org,
	torvalds@osdl.org
References: <20030712011716.GB4694@bouh.unh.edu> <16143.25800.785348.314274@cargo.ozlabs.ibm.com> <20030712024216.GA399@bouh.unh.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030712024216.GA399@bouh.unh.edu>
User-Agent: Mutt/1.4i-nntp
X-MailScanner-Information: http://pubpages.unh.edu/notes/mailfiltering.html
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-8.4, required 5,
	BAYES_10, IN_REP_TO, PATCH_UNIFIED_DIFF, REFERENCES,
	USER_AGENT_MUTT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems to have been dropped again, so I resend it.

Linux' ppp has not been implementing xon/xoff since 2.0 at least (a
thread on linux-ppp clearly stated that some years ago: just type
"pppd xonxoff": without the patch you can't stop the flow), here is a
patch to correct this on 2.6.0-test1 kernel. It has been well tested and
updated over the 2.2, 2.4 and 2.6 kernels.

Regards,
Samuel thibault



Add xon/xoff support to the ppp line discipline for async ports.

--- linux-2.6.0-test1-orig/drivers/char/tty_io.c	2003-07-26 17:25:28.000000000 -0400
+++ linux-2.6.0-test1-perso/drivers/char/tty_io.c	2003-07-14 01:11:25.000000000 -0400
@@ -611,6 +611,8 @@
 		(tty->driver->stop)(tty);
 }
 
+EXPORT_SYMBOL(stop_tty);
+
 void start_tty(struct tty_struct *tty)
 {
 	if (!tty->stopped || tty->flow_stopped)
@@ -629,6 +631,8 @@
 	wake_up_interruptible(&tty->write_wait);
 }
 
+EXPORT_SYMBOL(start_tty);
+
 static ssize_t tty_read(struct file * file, char * buf, size_t count, 
 			loff_t *ppos)
 {
--- linux-2.6.0-test1-orig/drivers/net/ppp_async.c	2003-07-26 17:23:56.000000000 -0400
+++ linux-2.6.0-test1-perso/drivers/net/ppp_async.c	2003-07-14 01:12:45.000000000 -0400
@@ -891,6 +891,11 @@
 			process_input_packet(ap);
 		} else if (c == PPP_ESCAPE) {
 			ap->state |= SC_ESCAPE;
+		} else if (I_IXON(ap->tty)) {
+			if (c == STOP_CHAR(ap->tty))
+				stop_tty(ap->tty);
+			else if (c == START_CHAR(ap->tty))
+				start_tty(ap->tty);
 		}
 		/* otherwise it's a char in the recv ACCM */
 		++n;


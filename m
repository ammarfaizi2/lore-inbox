Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267341AbTGLC1n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 22:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267332AbTGLC1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 22:27:43 -0400
Received: from unity.unh.edu ([132.177.137.40]:4044 "EHLO unity.unh.edu")
	by vger.kernel.org with ESMTP id S267307AbTGLC1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 22:27:39 -0400
Date: Fri, 11 Jul 2003 22:42:16 -0400
From: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-ppp@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] [2.5] adding ppp xon/xoff support
Message-ID: <20030712024216.GA399@bouh.unh.edu>
Reply-To: Samuel Thibault <samuel.thibault@fnac.net>
Mail-Followup-To: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>,
	Paul Mackerras <paulus@samba.org>, linux-ppp@vger.kernel.org,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20030712011716.GB4694@bouh.unh.edu> <16143.25800.785348.314274@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16143.25800.785348.314274@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4i-nntp
X-MailScanner-Information: http://pubpages.unh.edu/notes/mailfiltering.html
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-6.7, required 5,
	BAYES_20, IN_REP_TO, PATCH_UNIFIED_DIFF, QUOTED_EMAIL_TEXT,
	REFERENCES, REPLY_WITH_QUOTES, USER_AGENT_MUTT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le sam 12 jui 2003 11:30:48 GMT, Paul Mackerras a tapoté sur son clavier :
> Samuel Thibault writes:
> 
> > This patch wasn't applied, probably because the misplaced else
> > statement, here is a corrected version. This would at last make linux
> > support xon/xoff for ppp connections (it hasn't been available since 2.0
> > at least).
> > 
> > Please apply,
> 
> Have you tested it?  If so, how?

I've been testing it for 3 years now :) I have my own ppp implementation
on my calculator, and I really needed xon/xoff.

I've just tested it again with 2.5.75: I run a program on the calc which
shows the current buffer length and sends a XOFF as soon as 100 bytes are
available.

I then launch /usr/sbin/pppd /dev/ttyS0 9600 local xonxoff passive on
the linux side.

Without the patch, the buffer length increases until the buffer is full.
With the patch, it stops at 106 bytes as expected (2 configure
requests, the calculator being too slow to be able to send XOFF as soon
as the 100th bytes arrives). If you launch pppd without any argument
(hence having /dev/tty1 used by pppd), you can even see the keyboard
scroll lock light lit when pressing ^S (the tty->stop() stuff seems to do
that)

Well, I had a look at tty_io.c, and it changed a little bit, so although
it works in my case, the previous patch might not be sufficient. Here is a
maybe much better patch which has tty_io.c export start_tty() and
stop_tty(), so that ppp_async can call them even when module-loaded.
(I tested it again)

Regards,
Samuel Thibault

diff -ur linux-2.5.75-orig/drivers/char/tty_io.c linux-2.5.75-perso/drivers/char/tty_io.c
--- linux-2.5.75-orig/drivers/char/tty_io.c	2003-07-11 22:37:57.000000000 -0400
+++ linux-2.5.75-perso/drivers/char/tty_io.c	2003-07-11 22:37:31.000000000 -0400
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
diff -ur linux-2.5.75-orig/drivers/net/ppp_async.c linux-2.5.75-perso/drivers/net/ppp_async.c
--- linux-2.5.75-orig/drivers/net/ppp_async.c	2003-07-10 16:12:49.000000000 -0400
+++ linux-2.5.75-perso/drivers/net/ppp_async.c	2003-07-11 22:24:37.000000000 -0400
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

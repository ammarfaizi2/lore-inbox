Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272575AbTHFVc1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 17:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272071AbTHFVcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 17:32:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:62345 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272570AbTHFVbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 17:31:10 -0400
Date: Wed, 6 Aug 2003 14:32:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Florent Coste <coste.florent@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re 2.6.0-test2-mm4
Message-Id: <20030806143251.6b84c749.akpm@osdl.org>
In-Reply-To: <3F317097.4070401@free.fr>
References: <3F2F0ED0.4060707@free.fr>
	<20030804225737.007b6934.akpm@osdl.org>
	<3F317097.4070401@free.fr>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florent Coste <coste.florent@free.fr> wrote:
>
> - test2-mm2 :  pppd starts ok (i use & follow 2.5.x & 2.6-test branch 
>  since ~2.5.40 .... 2.5.72-mm2 was ok for instance)
>  - test2-mm3-1 : pppd does not start, kobject badness trace, full traces 
>  in my last email and parts above :

The `badness' thing is just telling us that netdevices aren't fully up to
speed with the kobject layer yet.  Don't worry about that.

As for the ppp problem: don't know, sorry.  There was a small change in ppp
between those two kernel versions, so it would be useful if you could do a
`patch -R' of the below, see if that fixes mm3-1.  Thanks.

diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Wed Aug  6 14:30:49 2003
+++ b/drivers/char/tty_io.c	Wed Aug  6 14:30:49 2003
@@ -611,6 +611,8 @@
 		(tty->driver->stop)(tty);
 }
 
+EXPORT_SYMBOL(stop_tty);
+
 void start_tty(struct tty_struct *tty)
 {
 	if (!tty->stopped || tty->flow_stopped)
@@ -628,6 +630,8 @@
 		(tty->ldisc.write_wakeup)(tty);
 	wake_up_interruptible(&tty->write_wait);
 }
+
+EXPORT_SYMBOL(start_tty);
 
 static ssize_t tty_read(struct file * file, char * buf, size_t count, 
 			loff_t *ppos)
diff -Nru a/drivers/net/ppp_async.c b/drivers/net/ppp_async.c
--- a/drivers/net/ppp_async.c	Wed Aug  6 14:30:49 2003
+++ b/drivers/net/ppp_async.c	Wed Aug  6 14:30:49 2003
@@ -891,6 +891,11 @@
 			process_input_packet(ap);
 		} else if (c == PPP_ESCAPE) {
 			ap->state |= SC_ESCAPE;
+		} else if (I_IXON(ap->tty)) {
+			if (c == START_CHAR(ap->tty))
+				start_tty(ap->tty);
+			else if (c == STOP_CHAR(ap->tty))
+				stop_tty(ap->tty);
 		}
 		/* otherwise it's a char in the recv ACCM */
 		++n;


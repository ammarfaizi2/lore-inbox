Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUE1Ud2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUE1Ud2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 16:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUE1Ud2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 16:33:28 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:39492 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S261451AbUE1UdO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 16:33:14 -0400
Subject: Re: [PATCH][RFC] 2.6.6 tty_io.c hangup locking
From: Paul Fulghum <paulkf@microgate.com>
To: Jurjen Oskam <jurjen@stupendous.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040528201139.GA12281@quadpro.stupendous.org>
References: <20040527174509.GA1654@quadpro.stupendous.org>
	 <1085769769.2106.23.camel@deimos.microgate.com>
	 <20040528201139.GA12281@quadpro.stupendous.org>
Content-Type: text/plain
Organization: 
Message-Id: <1085776389.2106.36.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 May 2004 15:33:10 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-28 at 15:11, Jurjen Oskam wrote:

> It was not only a warning here, but the pptp client also didn't work again
> until after rebooting. Every time the connection was retried (every 10
> seconds or so) the message appeared. Perhaps this is a problem in the pptp
> client, but after rebooting it worked.

That sounds like a different problem.
The warning itself is harmless.

I see another patch (not from me) related to closing a tty device
(also in tty_io.c) that has gone into 2.6.7-rc1
that may be related. I include that patch below


> As for the patch: applied to vanilla 2.6.5 (applied cleanly, offset -5
> lines) and compiling now.
> 
> One problem though: I'm running 2.6 for about two weeks now (with a 24x7
> pptp connection), and I encountered this problem just once. I've seen a
> report that someone got this error when his connection was severed, so
> I'll try to pull the phone cable a few times and see how it recovers, both
> with and without your patch. I'll report back when I know more.


In order to see the warning, the synctty line discipline must
be waiting to push more send data to the tty device when disconnecting.
If the line is idle, then the warning will not appear on hangup.

You can try and provoke the warning in the unpatched kernel
by causing a hangup while sending lots of data.

--
Paul Fulghum
paulkf@microgate.com


diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Sat May 22 22:55:13 2004
+++ b/drivers/char/tty_io.c	Sat May 22 22:55:13 2004
@@ -1267,6 +1267,18 @@
 #endif
 
 	/*
+	 * Prevent flush_to_ldisc() from rescheduling the work for later.  Then
+	 * kill any delayed work.
+	 */
+	clear_bit(TTY_DONT_FLIP, &tty->flags);
+	cancel_delayed_work(&tty->flip.work);
+
+	/*
+	 * Wait for ->hangup_work and ->flip.work handlers to terminate
+	 */
+	flush_scheduled_work();
+
+	/*
 	 * Shutdown the current line discipline, and reset it to N_TTY.
 	 * N.B. why reset ldisc when we're releasing the memory??
 	 */
@@ -1282,18 +1294,6 @@
 		module_put(o_tty->ldisc.owner);
 		o_tty->ldisc = ldiscs[N_TTY];
 	}
-	
-	/*
-	 * Prevent flush_to_ldisc() from rescheduling the work for later.  Then
-	 * kill any delayed work.
-	 */
-	clear_bit(TTY_DONT_FLIP, &tty->flags);
-	cancel_delayed_work(&tty->flip.work);
-
-	/*
-	 * Wait for ->hangup_work and ->flip.work handlers to terminate
-	 */
-	flush_scheduled_work();
 
 	/* 
 	 * The release_mem function takes care of the details of clearing




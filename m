Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269208AbUIYD0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269208AbUIYD0f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 23:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269213AbUIYD0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 23:26:34 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:18044 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S269209AbUIYD0F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 23:26:05 -0400
Subject: Re: 2.6.9-rc2-mm3
From: Paul Fulghum <paulkf@microgate.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20040925013135.GJ9106@holomorphy.com>
References: <Xine.LNX.4.44.0409241127220.7816-300000@thoron.boston.redhat.com>
	 <Xine.LNX.4.44.0409241210220.8009-100000@thoron.boston.redhat.com>
	 <20040925013135.GJ9106@holomorphy.com>
Content-Type: text/plain
Message-Id: <1096082711.7111.38.camel@at2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 24 Sep 2004 22:25:11 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-24 at 20:31, William Lee Irwin III wrote:
> Thanks for tracking these down. Those appear to be the culprits here
> also. Are there patches implementing the fixes Paul Fulghum suggested
> yet? Successful bootlog on 4x x86-64 included as a MIME attachment.

My suggestion was flawed in that it could
violate POSIX requirements (as Russell pointed out).

Removing the lock from tty_termios_baud_rate(), tty_io.c
corrects the problem for the path from change_termios()
to tty_termios_baud_rate(), which is causing the deadlock.

This may not be, and probably is not,
correct for all paths to tty_termios_baud_rate().

The following patch (against 2.6.9-rc2-mm3)
fixes the deadlock for testing purposes,
but is not a complete solution.

As Alan works through this feedback,
the final fix will emerge.

-- 
Paul Fulghum
paulkf@microgate.com

--- a/drivers/char/tty_io.c	2004-09-24 22:12:40.000000000 -0500
+++ b/drivers/char/tty_io.c	2004-09-24 22:14:53.000000000 -0500
@@ -2478,9 +2478,7 @@
 int tty_termios_baud_rate(struct termios *termios)
 {
 	unsigned int cbaud;
-	unsigned long flags;
 
-	spin_lock_irqsave(&tty_termios_lock, flags);
 	cbaud = termios->c_cflag & CBAUD;
 
 	if (cbaud & CBAUDEX) {
@@ -2491,7 +2489,6 @@
 		else
 			cbaud += 15;
 	}
-	spin_unlock_irqrestore(&tty_termios_lock, flags);
 	return baud_table[cbaud];
 }
 



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752110AbWFLQml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbWFLQml (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 12:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbWFLQml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 12:42:41 -0400
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:17119 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1752110AbWFLQml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 12:42:41 -0400
Date: Mon, 12 Jun 2006 12:36:11 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.16.18 kernel freezes while pppd is exiting
To: Paul Fulghum <paulkf@microgate.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <200606121239_MC3-1-C23E-9AF9@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <1150124830.3703.6.camel@amdx2.microgate.com>

On Mon, 12 Jun 2006 10:07:10 -0500, Paul Fulghum wrote:

> Here is a patch to serialize flush_to_ldisc
> with per device granularity. It should fix the
> corruption of the free list that is the probably
> cause of the freeze you are seeing. Test it to
> see if there are any ill effects (it works fine here
> on an AMD x2 SMP kernel). I realize that
> the problem happens infrequently, so you won't
> be able to tell quickly if it fixed the freeze.

I already applied this, which should keep it from freezing and
will print a warning, so I will apply your patch and then check
the log every time pppd exits.



Check for infinite loops in tty_buffer_free_all().  Hangs have only
been seen in the second loop, but check both anyway.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.16.20-d4.orig/drivers/char/tty_io.c
+++ 2.6.16.20-d4/drivers/char/tty_io.c
@@ -240,11 +240,23 @@ static int check_tty_count(struct tty_st
 static void tty_buffer_free_all(struct tty_struct *tty)
 {
 	struct tty_buffer *thead;
+	int free_loops;
+
+	free_loops = 0;
 	while((thead = tty->buf.head) != NULL) {
+		if (++free_loops > 9999) {
+			WARN_ON(1);
+			break;
+		}
 		tty->buf.head = thead->next;
 		kfree(thead);
 	}
+	free_loops = 0;
 	while((thead = tty->buf.free) != NULL) {
+		if (++free_loops > 9999) {
+			WARN_ON(1);
+			break;
+		}
 		tty->buf.free = thead->next;
 		kfree(thead);
 	}
-- 
Chuck

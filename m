Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWJIIe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWJIIe2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 04:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWJIIe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 04:34:28 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:50918 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932393AbWJIIe1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 04:34:27 -0400
Date: Mon, 9 Oct 2006 10:26:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Tilman Schmidt <tilman@imap.cc>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch] lockdep: fix printk recursion logic
Message-ID: <20061009082634.GA18103@elte.hu>
References: <72sfz-wa-1@gated-at.bofh.it> <4526E0AC.9070105@imap.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4526E0AC.9070105@imap.cc>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Tilman Schmidt <tilman@imap.cc> wrote:

> Problem description:
> > While X is running, output from printk() appears in syslog (eg.
> > /var/log/messages) only after a key is pressed on the system keyboard,
> > even though it is visible with dmesg immediately.
> (from lkml message <450BF1CC.2070309@imap.cc> - see that message
> for further details)
> 
> The problem did not exist in 2.6.17, so I think it qualifies as a 
> regression.
> 
> The following naive patch fixes the problem for me, without any 
> apparent ill effects (ie. the menace of lockup never manifested 
> itself):
> 
> --- a/kernel/printk.c   2006-10-07 00:51:09.000000000 +0200
> +++ b/kernel/printk.c   2006-10-07 00:51:41.000000000 +0200
> @@ -826,8 +826,7 @@ void release_console_sem(void)
>                  * from within the scheduler code, then do not lock
>                  * up due to self-recursion:
>                  */
> -               if (!lockdep_internal())
> -                       wake_up_interruptible(&log_wait);
> +               wake_up_interruptible(&log_wait);

the reason is that i initially only had the chunk above to protect 
against lockdep recursion within vprintk() - it grew the 'outer' 
lockdep_off()/on() protection only later on. But that lockdep_off() made 
the release_console_sem() within vprintk() always happen under the 
lockdep_internal() condition, causing your bug.

so the right solution is your patch: to remove the inner protection 
against recursion here - the outer one is enough.

Andrew, could we use the patch below - it also removes a now stale 
comment. Also for -stable review i think.

	Ingo

---------------->
Subject: lockdep: fix printk recursion logic
From: Ingo Molnar <mingo@elte.hu>

bug reported and fixed by Tilman Schmidt <tilman@imap.cc>: if
lockdep is enabled then log messages make it to /var/log/messages
belatedly. The reason is a missed wakeup of klogd.

initially there was only a lockdep_internal() protection against
lockdep recursion within vprintk() - it grew the 'outer'
lockdep_off()/on() protection only later on. But that lockdep_off() made
the release_console_sem() within vprintk() always happen under the
lockdep_internal() condition, causing the bug.

the right solution to remove the inner protection against
recursion here - the outer one is enough.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/printk.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

Index: linux/kernel/printk.c
===================================================================
--- linux.orig/kernel/printk.c
+++ linux/kernel/printk.c
@@ -801,15 +801,8 @@ void release_console_sem(void)
 	console_locked = 0;
 	up(&console_sem);
 	spin_unlock_irqrestore(&logbuf_lock, flags);
-	if (wake_klogd && !oops_in_progress && waitqueue_active(&log_wait)) {
-		/*
-		 * If we printk from within the lock dependency code,
-		 * from within the scheduler code, then do not lock
-		 * up due to self-recursion:
-		 */
-		if (!lockdep_internal())
-			wake_up_interruptible(&log_wait);
-	}
+	if (wake_klogd && !oops_in_progress && waitqueue_active(&log_wait))
+		wake_up_interruptible(&log_wait);
 }
 EXPORT_SYMBOL(release_console_sem);
 

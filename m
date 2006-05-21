Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWEUANK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWEUANK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 20:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWEUANJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 20:13:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63636 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932284AbWEUANH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 20:13:07 -0400
Date: Sat, 20 May 2006 17:12:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: p.lundkvist@telia.com, linux-kernel@vger.kernel.org, rjw@sisk.pl
Subject: Re: [PATCH] Page writeback broken after resume: wb_timer lost
Message-Id: <20060520171244.4399bc54.akpm@osdl.org>
In-Reply-To: <20060520225018.GC8490@elf.ucw.cz>
References: <20060520130326.GA6092@localhost>
	<20060520103728.6f3b3798.akpm@osdl.org>
	<20060520225018.GC8490@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> Refrigerator looks like this:
> 
>  /* Refrigerator is place where frozen processes are stored :-). */
>  void refrigerator(void)
>  {
>          /* Hmm, should we be allowed to suspend when there are
>  realtime
>             processes around? */
>          long save;
>          save = current->state;
>          pr_debug("%s entered refrigerator\n", current->comm);
>          printk("=");
> 
>          frozen_process(current);
>          spin_lock_irq(&current->sighand->siglock);
>          recalc_sigpending(); /* We sent fake signal, clean it up */
>          spin_unlock_irq(&current->sighand->siglock);
> 
>          while (frozen(current)) {
>                  current->state = TASK_UNINTERRUPTIBLE;
>                  schedule();
>          }
>          pr_debug("%s left refrigerator\n", current->comm);
>          current->state = save;
>  }

Well that's a crock, isn't it?


Peter, does this fix it?


From: Andrew Morton <akpm@osdl.org>

pdflush is carefully designed to ensure that all wakeups have some
corresponding work to do - if a woken-up pdflush thread discovers that it
hasn't been given any work to do then this is considered an error.

That all broke when swsusp came along - because a timer-delivered wakeup to a
frozen pdflush thread will just get lost.  This causes the pdflush thread to
get lost as well: the writeback timer is supposed to be re-armed by pdflush in
process context, but pdflush doesn't execute the callout which does this.

Fix that up by ignoring the return value from try_to_freeze(): jsut proceed,
see if we have any work pending and only go back to sleep if that is not the
case.


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 mm/pdflush.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff -puN mm/pdflush.c~pdflush-handle-resume-wakeups mm/pdflush.c
--- devel/mm/pdflush.c~pdflush-handle-resume-wakeups	2006-05-20 17:02:21.000000000 -0700
+++ devel-akpm/mm/pdflush.c	2006-05-20 17:11:25.000000000 -0700
@@ -104,13 +104,8 @@ static int __pdflush(struct pdflush_work
 		list_move(&my_work->list, &pdflush_list);
 		my_work->when_i_went_to_sleep = jiffies;
 		spin_unlock_irq(&pdflush_lock);
-
 		schedule();
-		if (try_to_freeze()) {
-			spin_lock_irq(&pdflush_lock);
-			continue;
-		}
-
+		try_to_freeze();
 		spin_lock_irq(&pdflush_lock);
 		if (!list_empty(&my_work->list)) {
 			printk("pdflush: bogus wakeup!\n");
@@ -118,7 +113,7 @@ static int __pdflush(struct pdflush_work
 			continue;
 		}
 		if (my_work->fn == NULL) {
-			printk("pdflush: NULL work function\n");
+			printk("pflush: resuming\n");
 			continue;
 		}
 		spin_unlock_irq(&pdflush_lock);
_




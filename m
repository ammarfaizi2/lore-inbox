Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWETWvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWETWvB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 18:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWETWvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 18:51:01 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58520 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932216AbWETWvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 18:51:00 -0400
Date: Sun, 21 May 2006 00:50:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Lundkvist <p.lundkvist@telia.com>, linux-kernel@vger.kernel.org,
       "Rafael J.  Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Page writeback broken after resume: wb_timer lost
Message-ID: <20060520225018.GC8490@elf.ucw.cz>
References: <20060520130326.GA6092@localhost> <20060520103728.6f3b3798.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060520103728.6f3b3798.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I have noticed for some time that nr_dirty never drops but
> > increases except when VM pressure forces it down. This only
> > occurs after a resume, never on a freshly booted system.
> > 
> > It seems the wb_timer is lost when the timer function is
> > trying to start a frozen pdflush thread, and this occurs
> > during suspend or resume.
> > 
> > I have included a patch which work for me. Don't know if the
> > test also should include a check for freezing to be safe, ie
> >   if ( !frozen(..) && !freezing(..) )

Yep, I have seen this too. Sync took *way* too long and I believe I
lost some data because of this problem.

> Maybe the code over in page-writeback.c should just rearm the timee within
> the timer handler rather than waiting for a pdflush thread to do it.  I'll
> think about that.
> 
> But the main questions is: what on earth is going on here?  We've taken a
> kernel thread and we've done a wake_up_process() on it, but because it was
> in a frozen state it just never gets to run, even after the resume. 
> Presumably it goes back into interruptible sleep after the resume.  We took
> it off the list (in the expectation that it'd run again) so we've lost
> control of it.

I guess you should not try to wake up process while it is frozen. Such
wakeups are likely to get lost. Should we add some BUG_ON() somewhere?

...we have to eat some wakeups, because we fake some.

Or perhaps we should do WARN_ON(frozen(current)) just after schedule()
below?

> Pavel, Rafael: this amounts to a lost wakeup.  What's the story?

								Pavel

Refrigerator looks like this:

/* Refrigerator is place where frozen processes are stored :-). */
void refrigerator(void)
{
        /* Hmm, should we be allowed to suspend when there are
realtime
           processes around? */
        long save;
        save = current->state;
        pr_debug("%s entered refrigerator\n", current->comm);
        printk("=");

        frozen_process(current);
        spin_lock_irq(&current->sighand->siglock);
        recalc_sigpending(); /* We sent fake signal, clean it up */
        spin_unlock_irq(&current->sighand->siglock);

        while (frozen(current)) {
                current->state = TASK_UNINTERRUPTIBLE;
                schedule();
        }
        pr_debug("%s left refrigerator\n", current->comm);
        current->state = save;
}

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

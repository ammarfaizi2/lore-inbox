Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVDZHYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVDZHYz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 03:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVDZHYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 03:24:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59554 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261381AbVDZHYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 03:24:00 -0400
Date: Tue, 26 Apr 2005 15:27:42 +0800
From: David Teigland <teigland@redhat.com>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 3/7] dlm: recovery
Message-ID: <20050426072742.GF12096@redhat.com>
References: <20050425151239.GD6826@redhat.com> <29495f1d05042509426681c4a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29495f1d05042509426681c4a0@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 09:42:21AM -0700, Nish Aravamudan wrote:
> On 4/25/05, David Teigland <teigland@redhat.com> wrote:

> > +int dlm_wait_function(struct dlm_ls *ls, int (*testfn) (struct dlm_ls *ls))
> > +{
> > +       int error = 0;
> > +
> > +       for (;;) {
> > +               wait_event_interruptible_timeout(ls->ls_wait_general,
> > +                                       testfn(ls) ||
> > +                                       test_bit(LSFL_LS_STOP, &ls->ls_flags),
> 
> Shouldn't this be
>      dlm_recover_stopped(ls) and not test_bit()?

yes, done

> > +                                       (dlm_config.recover_timer * HZ));
> > +               if (testfn(ls))
> > +                       break;
> > +               if (dlm_recovery_stopped(ls)) {
> > +                       error = -1;
> > +                       break;
> > +               }
> > +       }
> > +
> > +       return error;
> > +}
> 
> Rather than wrap an infinite loop in an infinite loop, since all you
> really want the second loop for is a periodic gurantee of
> recover_timer seconds, wouldn't it be easier to have a sof-timer set
> up to go off in that amount of time, and have it's callback do an
> unconditional wake-up on the local wait-queue then mod_timer the timer
> back in? Or might there be other tasks sleeping on the same
> wait-queue? At that point, since your code does not seem to care about
> signals (uses interruptible version, but doesn't check for
> signal_pending() return value from wait_event), you probably could
> just use the stock version of wait_event(). The conditions would be
> checked in wait_event() on the desired periodic basis, just as they
> are now, but maybe slightly more efficiently (and cleaner code, IMO :)
> ). If you do *need* interruptible, please put in a comment as to why.


Don't need inter, wait_event_timeout should work.  Let's see if I followed
all that; are you suggesting:

static void dlm_wait_timer_fn(unsigned long data)
{
        struct dlm_ls *ls = (struct dlm_ls *) data;
        wake_up(&ls->ls_wait_general);
}

int dlm_wait_function(struct dlm_ls *ls, int (*testfn) (struct dlm_ls *ls))
{
        struct timer_list timer;
        int error = 0;

        init_timer(&timer);
        timer.function = dlm_wait_timer_fn;
        timer.data = (long) ls;

        for (;;) {
                mod_timer(&timer, jiffies + (dlm_config.recover_timer * HZ));

                wait_event(ls->ls_wait_general,
                           testfn(ls) || dlm_recovery_stopped(ls));

                if (timer_pending(&timer))
                        del_timer(&timer);

                if (testfn(ls))
                        break;
                if (dlm_recovery_stopped(ls)) {
                        error = -1;
                        break;
                }
        }
        return error;
}

[Another thread should usually be calling wake_up().]

This is actually how it was some months ago, but I thought the timers made
it more complicated given that wait_event_timeout is available.  Do you
really think the timers are nicer if we don't use interruptible?


> > +int dlm_wait_status_low(struct dlm_ls *ls, unsigned int wait_status)
> > +{
> > +       struct dlm_rcom *rc = (struct dlm_rcom *) ls->ls_recover_buf;
> > +       int error = 0, nodeid = ls->ls_low_nodeid;
> > +
> > +       for (;;) {
> > +               error = dlm_recovery_stopped(ls);
> > +               if (error)
> > +                       goto out;
> > +
> > +               error = dlm_rcom_status(ls, nodeid);
> > +               if (error)
> > +                       break;
> > +
> > +               if (rc->rc_result & wait_status)
> > +                       break;
> > +               else {
> > +                       set_current_state(TASK_INTERRUPTIBLE);
> > +                       schedule_timeout(HZ >> 1);
> 
> 500 ms is a long time! What's the justification? No comments?
> Especially considering you will wake up on *every* signal. It's
> unlikely you'll actually sleep for 500 ms. Also, please use
> msleep_interruptible(), unless you expect to be woken by  wait-queues
> (I didn't have enough time to trace all the possible code paths :) )
> -- in which case, make it explicit with comments, please.

This is polling the status of a remote node.  All I'm after here is a
delay between the dlm_rcom_status() calls so that repeated status messages
aren't flooding the network.  We keep sending status messages until the
remote node reports the status we want to see.

When the remote node has _failed_ we're repeating these status requests
hopelessly until the membership system detects the node failure and
recovery is aborted (dlm_recovery_stopped) -- up to several seconds.  When
the remote node is just _slower_ at doing recovery, I'm guessing the
difference is on average a second.

Given that info, do you have a suggested delay?  I've already switched to
msleep.

Dave


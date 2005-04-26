Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbVDZQf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVDZQf7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 12:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVDZQeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 12:34:10 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:39759 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261654AbVDZQaZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 12:30:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G8XJiYBwsW1Oz8+H8q/UyMy/r3ihDxIM2/Sc9tq6LzK4ZdTYRyed3pcmr40NP4d7Ubw9MBz/sUOuTHzGVs9poyh2/vyK5SZ42D8oakWdmggqdfs0lnoyXbciaewz/4VwWEKyo/4O4QrTpv1j6MIEgj1EmFYNa3scWPCl+qA/L4I=
Message-ID: <29495f1d05042609301d47351e@mail.gmail.com>
Date: Tue, 26 Apr 2005 09:30:25 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: David Teigland <teigland@redhat.com>
Subject: Re: [PATCH 3/7] dlm: recovery
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20050426072742.GF12096@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050425151239.GD6826@redhat.com>
	 <29495f1d05042509426681c4a0@mail.gmail.com>
	 <20050426072742.GF12096@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/05, David Teigland <teigland@redhat.com> wrote:
> On Mon, Apr 25, 2005 at 09:42:21AM -0700, Nish Aravamudan wrote:
> > On 4/25/05, David Teigland <teigland@redhat.com> wrote:
 
<snip>

> > Rather than wrap an infinite loop in an infinite loop, since all you
> > really want the second loop for is a periodic gurantee of
> > recover_timer seconds, wouldn't it be easier to have a sof-timer set
> > up to go off in that amount of time, and have it's callback do an
> > unconditional wake-up on the local wait-queue then mod_timer the timer
> > back in? Or might there be other tasks sleeping on the same
> > wait-queue? At that point, since your code does not seem to care about
> > signals (uses interruptible version, but doesn't check for
> > signal_pending() return value from wait_event), you probably could
> > just use the stock version of wait_event(). The conditions would be
> > checked in wait_event() on the desired periodic basis, just as they
> > are now, but maybe slightly more efficiently (and cleaner code, IMO :)
> > ). If you do *need* interruptible, please put in a comment as to why.
> 
> Don't need inter, wait_event_timeout should work.  Let's see if I followed
> all that; are you suggesting:
> 
> static void dlm_wait_timer_fn(unsigned long data)
> {
>         struct dlm_ls *ls = (struct dlm_ls *) data;

You can do the mod_timer() here if you make the timer_list global
(dlm_timer or something).

mod_timer(&dlm_timer, jiffies + dlm_config.recover_timer * HZ;

>         wake_up(&ls->ls_wait_general);
> }
> 
> int dlm_wait_function(struct dlm_ls *ls, int (*testfn) (struct dlm_ls *ls))
> {
>         struct timer_list timer;
>         int error = 0;
> 
>         init_timer(&timer);
>         timer.function = dlm_wait_timer_fn;
>         timer.data = (long) ls;

do an

timer.expires = jiffies + (dlm_config.recover_timer * HZ);
add_timer(&dlm_timer);

before wait_event().

>         for (;;) {

Should not be need anymore.

>                 mod_timer(&timer, jiffies + (dlm_config.recover_timer * HZ));

Neither should this.

>                 wait_event(ls->ls_wait_general,
>                            testfn(ls) || dlm_recovery_stopped(ls));

So, now, you get woken up every so often to check the conditions *in*
wait_event() and if either is set you'll return to this context.
Otherwise, you'll go back to sleep in wait_event() -- that's why you
shouldn't need the infinite loop here.

>                 if (timer_pending(&timer))
>                         del_timer(&timer);

Good, this makes sure that you won't have the callback happening again
:) Do you need the sync version?

>                 if (testfn(ls))
>                         break;

Since you don't modify error in this case, you won't need this anymore

>                 if (dlm_recovery_stopped(ls)) {
>                         error = -1;
>                         break;
>                 }

Shouldn't need the break anymore, since you there is no loop.

>         }
>         return error;
> }
> 
> [Another thread should usually be calling wake_up().]
> 
> This is actually how it was some months ago, but I thought the timers made
> it more complicated given that wait_event_timeout is available.  Do you
> really think the timers are nicer if we don't use interruptible?

The reason I think timers are nicer is that you don't need to nest
wait_event*() in a loop (and really, it looks strange when you do).
Complicated or not, I think they are the "right thing" for this case.

> > > +int dlm_wait_status_low(struct dlm_ls *ls, unsigned int wait_status)
> > > +{
> > > +       struct dlm_rcom *rc = (struct dlm_rcom *) ls->ls_recover_buf;
> > > +       int error = 0, nodeid = ls->ls_low_nodeid;
> > > +
> > > +       for (;;) {
> > > +               error = dlm_recovery_stopped(ls);
> > > +               if (error)
> > > +                       goto out;
> > > +
> > > +               error = dlm_rcom_status(ls, nodeid);
> > > +               if (error)
> > > +                       break;
> > > +
> > > +               if (rc->rc_result & wait_status)
> > > +                       break;
> > > +               else {
> > > +                       set_current_state(TASK_INTERRUPTIBLE);
> > > +                       schedule_timeout(HZ >> 1);
> >
> > 500 ms is a long time! What's the justification? No comments?
> > Especially considering you will wake up on *every* signal. It's
> > unlikely you'll actually sleep for 500 ms. Also, please use
> > msleep_interruptible(), unless you expect to be woken by  wait-queues
> > (I didn't have enough time to trace all the possible code paths :) )
> > -- in which case, make it explicit with comments, please.
> 
> This is polling the status of a remote node.  All I'm after here is a
> delay between the dlm_rcom_status() calls so that repeated status messages
> aren't flooding the network.  We keep sending status messages until the
> remote node reports the status we want to see.
> 
> When the remote node has _failed_ we're repeating these status requests
> hopelessly until the membership system detects the node failure and
> recovery is aborted (dlm_recovery_stopped) -- up to several seconds.  When
> the remote node is just _slower_ at doing recovery, I'm guessing the
> difference is on average a second.
> 
> Given that info, do you have a suggested delay?  I've already switched to
> msleep.

Nope, that seems reasonable (500ms).

Thanks,
Nish

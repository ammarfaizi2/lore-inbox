Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131075AbRA3RwA>; Tue, 30 Jan 2001 12:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131717AbRA3Rvt>; Tue, 30 Jan 2001 12:51:49 -0500
Received: from hermes.mixx.net ([212.84.196.2]:45328 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S131075AbRA3Rvj>;
	Tue, 30 Jan 2001 12:51:39 -0500
Message-ID: <3A76FEAC.878B1FAF@innominate.de>
Date: Tue, 30 Jan 2001 18:49:32 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty@innominate.de, Russell@innominate.de, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list
In-Reply-To: <3A74451F.DA29FD17@uow.edu.au> <E14NPEr-0005LR-00@halfway> <3A76A35F.6CD57281@innominate.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> Rusty Russell wrote:
> >
> > In message <3A74451F.DA29FD17@uow.edu.au> you write:
> > >       http://www.uwsg.iu.edu/hypermail/linux/kernel/0005.3/0269.html
> > >
> > > A lot of the timer deletion races are hard to fix because of
> > > the deadlock problem.
> >
> > Hmmm...
> >
> >         For 2.5, changing the timer interface to disallow mod_timer or
> > add_timer (equivalent) on self, and making the timerfn return num
> > jiffies to next run (0 = don't rerun) would solve this, right?
> > I don't see a maintainable way of solving this otherwise,
> 
> It seems silly not to provide direct support for such a simple, useful
> mechanism as a periodic timer.  This can be accomplished easily by
> adding a field 'periodic' to struct timer_list.  If 'periodic' is
> non-zero then run_timer_list uses it to set the 'expires' field and
> re-inserts the timer.
> 
> For what it's worth, this is backward compatible with the existing
> strategy.  The timer_list->function is still in complete control of
> things if it wants to be, but forbidding it from re-adding itself sounds
> like an awfully good idea.

Whoops, this post from Alexy makes it quite clear why I can't do that:

	http://www.wcug.wwu.edu/lists/netdev/200005/msg00050.html
	Timers are self-destructable as rule. See? Normal usage
	for timer is to have it allocated inside an object and
	timer event detroys the object together with timer.

I did a quick scan through timer usage, and sure enough, I found
self-destructive behaviour as Alexy describes, for example, in
ax25_std_heartbeat_expiry.  Your suggestion is good and simple, but
requires every timer_list->function to be changed, a couple of hundred
places to check.

It would be nice to have a nice easy transition instead of a
jump-off-the-cliff and change all usage approach.  Hmm, a hack is
coming... I'll add a new, improved function field beside the old one,
call it ->timer_event, and it can force rescheduling as you suggested. 
If ->timer_event is non-null it gets called instead of ->function, and
the timer may be requeued.  For good measure, I'll leave my ->period
field in there because it just makes sense.  Then I can write a generic
->timer_event that just returns the ->period.

/me: hack, hack, hack

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

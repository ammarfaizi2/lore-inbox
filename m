Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbVLGKLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbVLGKLj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 05:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbVLGKLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 05:11:38 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:11942 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750770AbVLGKLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 05:11:37 -0500
Date: Wed, 7 Dec 2005 11:11:37 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: tglx@linutronix.de, zippel@linux-m68k.org, linux-kernel@vger.kernel.org,
       rostedt@goodmis.org, johnstul@us.ibm.com
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
Message-ID: <20051207101137.GA25796@elte.hu>
References: <20051206000126.589223000@tglx.tec.linutronix.de> <Pine.LNX.4.61.0512061628050.1610@scrub.home> <1133908082.16302.93.camel@tglx.tec.linutronix.de> <20051207013122.3f514718.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051207013122.3f514718.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.6 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > We decided to rename 'ktimer' because Andrew pretty much vetoed the
> >  'ktimeout' queue

let me defuse things a bit here: the above sentence might sound a bit 
bitter, but we really, truly are not. You were more like the sane voice 
slapping us back into reality: for the next 2 years we do not want to be 
buried in tons of timer_list->ktimeout patches, causing disruption all 
across the kernel (and external trees). You definitely did not 'veto' it 
in any way, and in fact you are carrying it in -mm currently.

I did the ktimeout queue in an hour or so, and i dont have strong
feelings about it. I very much agree with you that a mass rename could
easily cause more problems than the added clarity adds - still i had to
try the ktimeout queue, because i'm hopelessly purist at heart :)

Maybe in a few years all substantial kernel code will be managed by a 
network of GIT repositories, and GIT will be extended with automatic 
'mass namespace change' capabilities, making an overnight switchover 
much more practical.

> Well I whined about the rename of timer_list to ktimeout and asked why 
> it happened.  I don't think anyone replied.

we thought we had this issue covered way too many times :) but find 
below my original justification for the ktimeout patch-queue. This is 
just for historical interest now i think.

[ insert the text below here. Time passes as everyone reads it :-) ]

once we take 'mass change of timer_list to ktimeout' out of the possible 
things to do, we've only got these secondary possibilities:

	'struct timer_list, struct ktimer'
	'struct timer_list, struct ptimer'
	'struct timer_list, struct hrtimer'

and having eliminated the first option due to being impractical to pull 
off, we had the choice between 'ptimer' and 'hrtimer', and went for the 
last one, for the following reason [snipped from a mail to Roman]:

| we decided against "ptimer" because it could be confused with "process 
| timers" and "posix timers". hrtimers is a clear term that indicates 
| what those timers do, so we picked up Andrew's suggestion as a way out 
| the endless naming discussion.

but really ... facing an imperfect naming situation (i do not think 
timer_list is the correct name - just as much as struct inode_list would 
not be correct - but it is the historic name and i think you are right 
that we've got to live with it) i'm alot less passionate about which one 
to pick. If we had the chance to have perfect naming, i'd definitely 
spend the effort to get it right, but now lets just go with the most 
descriptive one: 'struct hrtimer'.

	Ingo

-----
regarding naming. This is something best left to native speakers, but 
i'm not giving up the issue just yet :-)

i always sensed and agreed that 'struct ktimer' and 'struct timer_list' 
together is confusing. Same for kernel/ktimers.c and kernel/timers.c. So 
no argument about that, this situation cannot continue.

but the reason i am still holding on to 'struct ktimer' is that i think 
the end result should be:

 - 'struct ktimer' (for precise timers where the event of expiry is the 
                    main function)

 - 'struct ktimeout' (for the wheel-based timeouts, where expiry is an 
                      exception)

Similarly, kernel/ktimer.c for ktimers, and kernel/ktimeout.c for 
timeouts.

see the attached finegrained patchqueue that does all the changes to 
rename 'timers' to 'timeouts' [and to clean up the resulting subsystem], 
to see what i'm trying to achieve.

For now i'm ignoring the feasibility of a 'mass API change' issues - 
those are better up to lkml. The queue does build and compile fine on a 
rather big .config so the only question is - do we want it. Note that 
the patch does not have to touch even a single non-subsystem user of the 
timer.c APIs, so the renaming is robust.

IMO it looks a lot less confusing and dualistic that way. The rename is 
technically feasible and robust mainly because we can do this:

#define timer_list timeout

for the transition period (see the patch-queue). Fortunately timer_list 
is not a generic name. (it's also an incorrect name because it implies 
implementation) Here's the full list of mappings that occur:

#define timer_list			ktimeout

#define TIMER_INITIALIZER		KTIMEOUT_INITIALIZER 
#define DEFINE_TIMER			DEFINE_KTIMEOUT
#define init_timer			ktimeout_init
#define setup_timer			ktimeout_setup
#define timer_pending			ktimeout_pending
#define add_timer_on			ktimeout_add_on
#define del_timer			ktimeout_del
#define __mod_timer			__ktimeout_mod
#define mod_timer			ktimeout_mod
#define next_timer_interrupt		ktimeout_next_interrupt
#define add_timer			ktimeout_add
#define try_to_del_timer_sync		ktimeout_try_to_del_sync
#define del_timer_sync			ktimeout_del_sync
#define del_singleshot_timer_sync	ktimeout_del_singleshot_sync
#define init_timers			init_ktimeouts
#define run_local_timers		run_local_ktimeouts

but maybe 'struct ptimer' and 'struct ktimeout' is the better choice? I 
dont think so, but it's a possibility.

so i believe that:

	- 'struct ktimer', 'struct ktimeout'

is in theory superior naming, compared to:

	- 'struct ptimer', 'struct timer_list'

again, ignoring all the 'do we want to have a massive namespace change' 
issues.

	Ingo

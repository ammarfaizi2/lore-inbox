Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVDIIW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVDIIW6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 04:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVDIIW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 04:22:58 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:16768 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261311AbVDIIWx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 04:22:53 -0400
Date: Sat, 9 Apr 2005 01:22:14 -0700
To: Thomas Renninger <trenn@suse.de>
Cc: Frank Sorenson <frank@tuxrocks.com>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] Updated: Dynamic Tick version 050408-1
Message-ID: <20050409082214.GB29867@atomide.com>
References: <425451A0.7020000@tuxrocks.com> <20050407082136.GF13475@atomide.com> <4255A7AF.8050802@tuxrocks.com> <4255B247.4080906@tuxrocks.com> <20050408062537.GB4477@atomide.com> <20050408075001.GC4477@atomide.com> <42564584.4080606@tuxrocks.com> <42566C22.4040509@suse.de> <20050408115535.GI4477@atomide.com> <4256800A.6040407@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4256800A.6040407@suse.de>
User-Agent: Mutt/1.5.6+20040907i
From: Tony Lindgren <tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 02:58:50PM +0200, Thomas Renninger wrote:
> Tony Lindgren wrote:
> > * Thomas Renninger <trenn@suse.de> [050408 04:34]:
> >>Here are some figures about idle/C-states:
> >>
> >>Passing bm_history=0xF to processor module makes it going into C3 and deeper.
> >>Passing lower values, deeper states are reached more often, but system could freeze:
> > 
> > Hmm, I wonder why it freezes? Is it ACPI issue or related to dyn-tick?
> > 
> It's an ACPI issue.

OK

> As far as I understand: If there has been bus master activity in the last
> xx(~30?!?) ms, C3 and deeper sleep states must not be triggered.
> If running into it, the system just freezes without any further output
> or response.

OK

> >>Figures NO_IDLE_HZ disabled, HZ=1000 (max sleep 1ms)
> > ...
> >>Total switches between C-states:  20205
> >>Switches between C-states per second:  1063 per second
> >>
> >>Figures NO_IDLE_HZ enabled, processor.bm_history=0xF HZ=1000:
> > ...
> >>Total switches between C-states:  4659
> >>Switches between C-states per second:  65 per second
> > 
> > The reduction in C state changes should produce some power savings,
> > assuming the C states do something...
> >
> I heard on this machine battery lasts half an hour longer since
> C4 state is used, hopefully we can get some more minutes by using it
> more often and longer ...

Yeah, it would be interesting to know how much of a difference it makes.

> >>I buffer C-state times in an array and write them to /dev/cstX.
> >>From there I calc the stats from userspace.
> >>
> >>Tony: If you like I can send you the patch and dump prog for
> >>http://www.muru.com/linux/dyntick/ ?
> > 
> > Yeah, that would nice to have!
> 
> -> I'll send you privately.

OK

> >>I try to find a better algorithm (directly adjust slept time to
> >>C-state latency or something) for NO_IDLE_HZ (hints are very welcome)
> >>and try to come up with new figures soon.
> > 
> > I suggest we modify idle so we can call it with the estimated sleep
> > length in usecs. Then the idle loop can directly decide when to go to
> > C2 or C3 depening on the estimated sleep length.
> 
> The sleep time history could be enough?

Well we already know when the next timer interrupt is scheduled to
happen, so make use of that information would make the state selection
easy. And we should probably at some point also account for the wake-up
latency so we can program the timer a bit early depending on the sleep
state.

> I don't know how to calc C1 state sleep time (from drivers/acpi/processor_idle.c):
> 		/*
>                  * TBD: Can't get time duration while in C1, as resumes
> 		 *      go to an ISR rather than here.  Need to instrument
> 		 *      base interrupt handler.
> 		 */
> 
> It probably would help to go to deeper states faster.

Yes, we should be able to go directly to deeper states with the next
timer interrupt value.

> Whatabout reprogramming timer interrupt for C1 (latency==0), so that it comes out after e.g. 1 ms again.
> If it really stayed sleeping for 1ms, 5 times, the machine is really idle and deeper
> states are adjusted after sleep time and C-state latency...
> (Or only disable timer interrupt after C1 slept long enough X times?)

I'm not sure if I follow this one... But if we know the next timer
interrupt is 500ms away, we should go directly to C3/C4, and no
other calculations should be needed.

Regards,

Tony

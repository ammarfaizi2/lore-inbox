Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVDTMmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVDTMmA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 08:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVDTMmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 08:42:00 -0400
Received: from ns2.suse.de ([195.135.220.15]:58563 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261592AbVDTMlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 08:41:55 -0400
Message-ID: <42664A0E.3050808@suse.de>
Date: Wed, 20 Apr 2005 14:24:46 +0200
From: Thomas Renninger <trenn@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050317
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Tony Lindgren <tony@atomide.com>, Frank Sorenson <frank@tuxrocks.com>,
       linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>,
       ML ACPI-devel <acpi-devel@lists.sourceforge.net>,
       Bodo Bauer <bb@suse.de>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Updated: Dynamic Tick version 050408-1 - C-state measures
References: <4255A7AF.8050802@tuxrocks.com> <4255B247.4080906@tuxrocks.com> <20050408062537.GB4477@atomide.com> <20050408075001.GC4477@atomide.com> <42564584.4080606@tuxrocks.com> <42566C22.4040509@suse.de> <20050408115535.GI4477@atomide.com> <42651C38.6090807@suse.de> <20050419152723.GA9509@isilmar.linta.de> <42657222.5080601@suse.de> <20050420114433.GA28362@isilmar.linta.de>
In-Reply-To: <20050420114433.GA28362@isilmar.linta.de>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski wrote:
> On Tue, Apr 19, 2005 at 11:03:30PM +0200, Thomas Renninger wrote:
>>>"All" we need to do is to update the "diff". Without dynamic ticks, if the
>>>idle loop didn't get called each jiffy, it was a big hint that there was so
>>>much activity in between, and if there is activity, there is most likely
>>>also bus master activity, or at least more work to do, so interrupt activity
>>>is likely. Therefore we assume there was bm_activity even if there was none.
>>>
>>If I understand this right you want at least wait 32 (or whatever value) ms if there was bm activity,
>>before it is allowed to trigger C3/C4?
> 
> That's the theory of operation of the current algorithm. I think that we
> should do that small change to the current algorithm which allows us to keep
> C3/C4 working with dyn-idle first, and then think of a very small abstraction
> layer to test different idle algroithms, and -- possibly -- use different
> ones for different usages.
> 
>>I think the problem is (at least I made the experience with this particular
>>machine) that bm activity comes very often and regularly (each 30-150ms?).
>>
>>I think the approach to directly adjust the latency to a deeper sleep state if the
>>average bus master and OS activity is low is very efficient.
>>
>>Because I don't consider whether there was bm_activity the last ms, I only
>>consider the average, it seems to happen that I try to trigger
>>C3/C4 when there is just something copied and some bm active ?!?
> 
> I don't think that this is perfect behaviour: if the system is idle, and
> there is _currently_ bus master activity, the CPU should be put into C1 or
> C2 type sleep. If you select C3 and actually enter it, you're risking
> DMA issues, AFAICS.
> 
On my system triggering C3/C4 is just ignored (sleep_ticks < 0).
These ignorings (C3/C4 failures) seem to directly depend on how much bm_activity
there actually is.
With the current method (wait at least 30 ms if there was bm activity before
triggering C3/C4) these failures never happened.
As mentioned using bm_promotion_ms you can lower the failures, but never reach zero.
If these failures lead to system freezes on other systems, my next sentence is valid
(I meant my patch).

>>The patch is useless if these failures end up in system freezes on
>>other machines...
> 
> I know that my patch is useless in its current form, but I wanted to share
> it as a different way of doing things. 
> 
>>The problem with the old approach is, that after (doesn't matter C1-Cx)
>>sleep and dyn_idle_tick, the chance to wake up because of bm activity is
>>very likely.
>>You enter idle() again -> there was bm_activity -> C2. Wake up after e.g.
>>50ms, because of bm_activity again (bm_sts bit set) -> stay in C2, wake up
>>after 40ms -> bm activity... You only have the chance to get into deeper
>>states if the sleeps are interrupted by an interrupt, not bm activity.
> 
> That's a side-effect, indeed. However: if there _is_ bus master activity, we
> must not enter C3, AFAICS.
> 

What about a mixed approach: only reprogram timer if you want to go to deeper
sleeping states (C3-Cx) when bm activity comes in place?

It's the only way you can say: the last xy ms there was no bm activity (use bm_history),
now it's safe to sleep and also be efficient: don't sleep forever in C1/C2 -> bm_sts bit
will probably be set afterwards and you need to wait another xy ms in C1/C2
-> endless loop ...

Like that the timer is only disabled where it is really useful, on C3-Cx machines
(or are there other cases?).


    Thomas

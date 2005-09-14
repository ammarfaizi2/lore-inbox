Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932547AbVINTkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbVINTkf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 15:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbVINTkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 15:40:35 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:28664 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932547AbVINTke
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 15:40:34 -0400
Message-ID: <43287C52.7050002@mvista.com>
Date: Wed, 14 Sep 2005 12:38:58 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>
Subject: Re: 2.6.13-rt6, ktimer subsystem
References: <20050913100040.GA13103@elte.hu>
In-Reply-To: <20050913100040.GA13103@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i have released the 2.6.13-rt6 tree, which can be downloaded from the 
> usual place:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 
> there are lots of small updates all across and there's a big feature as 
> well in this release: a complete rework of the high-resolution timers 
> framework, from Thomas Gleixner, called 'ktimers'.
> 
> under the ktimer framework the HR (and posix) timers live in a separate 
> domain, have their own (per-CPU) rbtree to stay scalable and 
> deterministic even with a high number of timers. Another positive effect 
> of the introduction of separate ktimers is that kernel/timer.c is now 
> using preemptible locks again, removing the cascade() worst-case 
> latency. The cleanup factor is high as well: the ktimer framework 
> slashes 1300+ lines off the HRT code. See kernel/ktimer.c for details.
> 
> the end-effect of ktimers is a much more deterministic HRT engine. The 
> original merging of HR timers into the stock timer wheel was a Bad Idea 
> (tm). We intend to push the ktimer subsystem upstream as well.

Well, having spent a bit of time looking at the code it appears that a 
lot of the ideas we looked at and discarded (see 
high-res-timers-discourse@lists.sourceforge.net) are in this.  Shame it 
was all done with out reference or comment to that list, anyone on it or 
even the lkml.

I DO agree that it _looks_ nicer, cleaner and so on.  But there are a 
lot of things we rejected in here and they really do need, at least, a 
hard look.

A few of the top issues:

time in nanoseconds 64-bits, requires a divide to do much of anything 
with it.  Divides are slow and should be avoided if possible.  This is 
especially true in the embedded market.


The rbtree is a high overhead tree.  I suspect performance problems 
here.  If it is the right answer here, then why not use it for normal 
timers?  A list of timers is a rather unique thing and, I think, 
deserves a management structure that accounts for the fact that the 
elements in the tree are perishable.

It appears that the "monotonic_clock" is being used to drive ktimers. 
The "monotonic_clock" was NEVER meant to poke outside of the kernel.  It 
is a raw kernel clock that is only required to be monotonic with nothing 
said about accuracy.  It should NOT be confused with CLOCK_MONOTONIC 
which is directly tied to xtime and therefor is ntp corrected.

These are only the concerns I have from having a rather quick look at 
the code.  I am sure that there are other issues...



-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/

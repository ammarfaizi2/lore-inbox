Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267881AbUJLVmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267881AbUJLVmn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 17:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267882AbUJLVmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 17:42:43 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:25338 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S267881AbUJLVlH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 17:41:07 -0400
From: "Sven Dietrich" <sdietrich@mvista.com>
To: "Bill Huey \(hui\)" <bhuey@lnxw.com>,
       "Thomas Gleixner" <tglx@linutronix.de>
Cc: <dwalker@mvista.com>, "Ingo Molnar" <mingo@elte.hu>,
       "Andrew Morton" <akpm@osdl.org>, <amakarov@ru.mvista.com>,
       <ext-rt-dev@mvista.com>, "LKML" <linux-kernel@vger.kernel.org>
Subject: RE: [Ext-rt-dev] Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
Date: Tue, 12 Oct 2004 14:41:02 -0700
Message-ID: <EOEGJOIIAIGENMKBPIAEGEJGDKAA.sdietrich@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20041012211201.GA28590@nietzsche.lynx.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I emailed the mmlinux project about 2 months ago, 
telling you that we were doing this.

There was no response.

I am sorry that the early stage of our development upsets you.

It was intended to promote discussion, and that seems to be working.

We are aware of the issues you describe, and are making
every effort to raise awareness of these problems.

It is difficult to solve them for a team of 1 or N,
in a maintainable fashion, as it requires some level 
of awareness by the maintainers that we are looking
at it from that angle.

Thanks for the insights, we look forward to seeing your
implementation added to the smorgasbord ;)

Sven



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Bill Huey (hui)
> Sent: Tuesday, October 12, 2004 2:12 PM
> To: Thomas Gleixner
> Cc: dwalker@mvista.com; Ingo Molnar; Andrew Morton;
> amakarov@ru.mvista.com; ext-rt-dev@mvista.com; LKML
> Subject: Re: [Ext-rt-dev] Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
> 
> 
> On Tue, Oct 12, 2004 at 09:46:34PM +0200, Thomas Gleixner wrote:
> > Both patches (MV & Ingos) have their good bits, but both share the same
> > ugliness and are hard to compare and harder to combine. The conversion
> > of spin_lock to _spin_lock and substitution of spin_lock by mutexes,
> > semaphores or what ever makes it more than hard to keep the code in a
> > readable form.
> > 
> > If there is the tendency to touch the concurrency controls in general
> > all over the kernel, then I would suggest a script driven overhaul of
> > all concurrency controls like spin_locks, mutexes and semaphores to
> > general macros like 
> > 
> > enter_critical_section(TYPE, &var, &flags, whatever);
> > leave_critical_section(TYPE, &var, flags, whatever);
> 
> FreeBSD uses these things, but it they create severe pipeline stalls
> since they toggle interrupt flags on entry and exit. The current scheme
> in Linux with preempt_count use to be a curse when I was working on an
> equivalent implementation of there stuff at:
> 
> 	http://mmlinux.sf.net
> 
> It's a project I've been working for a long time and I'm farther than
> them in the area of stability and most likely the problem space in general.
> They are 7 and I am a single engineer though.
> 
> I don't have the latest sources up and I'm going to up load them in a
> couple of hours. I've been playing with it for about 2 months, late July,
> since it was able to boot reliably and I've felt/measure how a fully
> preemptable kernel like this can perform. I'm getting about 4-6 usecs
> average latency in the system from interrupt exception frame to the start
> of the irq-thread in question. Tons of events were at 2 usecs which I
> thought was insane at the time, but a ndelay insert into the path verified
> this to be correct.  The majority of the spread was at 5 and 10 usecs,
> pushing to about 12 usecs. That's fantastic latency performance and I
> was floored when the measurements were validating my preemption ideas
> at the time.
> 
> > where TYPE might be SPIN_LOCK, SPIN_LOCK_IRQ, MUTEX, PMUTEX or whatever
> > we have and come up with in the future.
> 
> There's two problems that need to be solved at this moment regarding
> this issue. One is long term which should have a clear differentiation
> of what is a persistent spinlock across a compile .config context
> (choice of preemptable or standard kernels) is useful since it clearly
> identifies which devices and low level systems. The other is Ingo's need
> to be able to rapidly change mutexes at the drop of a hat. Eventually,
> the long term goal will impose on stylistic issues in the Linux kernel
> community and papers/documentation will have to be written to describe
> these changes across all kernel subsystems and drivers. It's complete
> epic flame bait.
> 
> In my system, I do exactly what you just outlined. With a three character
> "vim" command, I capitalize the entire word, spin_lock -> SPIN_LOCK
> repeated with a ".". I choose this convention because capitals standout
> broadly in the source code. It's good because having this kind of
> visibility can show static/compile time sleep violations that are the
> main source of instability, and almost certainly all of the deadlocks
> in Monta Vista's current preemption release.
> 
> My tree is stable. I was able to hammer this machine for 2-3 days straight
> (no networking, that's another major can of worms) with deadlocking
> using multipule mass "find / -exec egrep" of some sort that stress both
> process creation and all parts of the IO system.
> 
> The lock graph changes I made ironically outlined some serious Linux
> structural problems as it concerns latency. Through my effort of fixing
> all of the sleep violation, I came all of the way back to the start of
> the project which is that all major systems have become non-preemptable
> again.
> 
> That graph that I saw from Lee is consistent with my results in that a
> deadlock prone system will have phenomenal latency performance at the
> expense of being absolutely incorrect. It's just a flat out broken
> system at this point that they've released.
> 
> > This could be done in a first step and then it is clearly identifiable
> > and it gives us more flexibility to wrap different implementations and
> > lets us change particular points in a more clear way.
> 
> Yes, I agree, but the convention needs to be standardized.
>  
> > I would be willing to provide some scripted conversion aid, if there is
> > enough interest to that. I started with some test files and the results
> > are quite encouraging.
> 
> No, all of this can only be manual at this time, either through static
> analysis by a compiler, like what Ingo did over the weekend or by hand
> with runtime sleep violation checks.
> 
> Give me a bit of time to upload those files. I was just given permission
> to talk about this openly now. But I can definitely tell you that I had
> this running months before Monta Vista's announcement over the weekend.
> 
> Full preemption has just heated up in serious way. :) It's going to be
> interesting.
>  
> > Any thoughts ?
> 
> bill
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

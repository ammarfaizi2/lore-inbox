Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313537AbSGUUlm>; Sun, 21 Jul 2002 16:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313638AbSGUUlm>; Sun, 21 Jul 2002 16:41:42 -0400
Received: from dsl-213-023-043-192.arcor-ip.net ([213.23.43.192]:2974 "EHLO
	starship") by vger.kernel.org with ESMTP id <S313537AbSGUUlj>;
	Sun, 21 Jul 2002 16:41:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Mark Spencer <markster@linux-support.net>
Subject: Re: Zaptel Pseudo TDM Bus
Date: Sun, 21 Jul 2002 22:46:11 +0200
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0207211352560.25617-100000@hoochie.linux-support.net>
In-Reply-To: <Pine.LNX.4.33.0207211352560.25617-100000@hoochie.linux-support.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17WNan-0002b5-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 July 2002 20:59, Mark Spencer wrote:
> > In my quick tour I was looking for where the saw-off between kernel and
> > user space is in the source tree, and I began to get the feeling the
> > whole thing is kernel space, is this correct?
> 
> Nope, in general the saw-off is that signal processing and protocol
> implementations that are beyond a few bits of logic are done in userspace.

See the other poster's comment about providing a clear separation of kernel
and userspace components in your source tree.  It just makes it easier to
get oriented.

> The exceptions are echo cancellation (which has to be done very close to
> the itnerface) and RBS protocols which are easy and important enough to be
> done in the kernel.  DTMF detection and the FSK modems for Caller*ID and
> ADSI are done in userspace, as well as the PRI implementation (libpri).
>
> [...]
>
> > It strikes me that much of what you're doing qualifies as hard realtime
> > programming, particularly where you are doing things like interleaving file
> > transmission with realtime voice.  I'm thinking that this may be a good
> > chance to give the new Adeos OS-layering technology a test drive, with a view
> > to achieving more reliable, lower latency signal processing and equipment
> > control.  If things work out, this could qualify as the first genuine
> > consumer-oriented hard realtime application for Linux.
> 
> Actually, Linux right out of the box on modern PC hardware (400+Mhz) seems
> more than fine for the task.  We even have people running this on 200Mhz
> cyrix machines (single channels) and I've been able to driver a T1 on a
> 233 Mhz PII, although I don't think I'd recommend this configuration
> officially!  I'd be happy to see what hard-realtime might be able to do in
> terms of pushing the hardware requirements even lower, but it seems pretty
> exciting just as it is!

Hard realtime isn't about efficiency, it's about meeting deadlines.  While 
you may be seeing very good average interrupt response latency in Linux, it's 
well known that response times on the order of milliseconds are not uncommon, 
and there is no way to prove that you won't get the occasional spike into the 
tens or hundreds of milliseconds, even with low latency patches applied to 
spinlocks and preemption enabled.  Hard realtime is about being able to prove 
that such spikes never happen.  As a bonus, you can work with much smaller 
packet sizes because you have confidence that you'll be able to service the 
interrupts on time.

That said, Adeos does offer what appears to be an very efficient model for 
handling interrupts.  (Caveat: I haven't tried it myself yet, much less 
measured it, just eyeballed the code)  You can load a module directly into
the interrupt pipeline and bypass all of Linux's interrupt machinery, even
bypass cli (it just sets a flag in Adeos).

In any event, it's not clear to me how you are going to be able to do echo 
cancelation reliably unless you are able to provide guaranteed response
latency.

> One more thing that might be interesting would be seeing how small we
> could push the "chunk size".  Right now, we use a chunk size of 8, but
> a chunk size of 1 (that is, interrupting for EVERY sample) would put us
> at a level indistinguishable from hard TDM.

An interrupt rate of 20 KHz is no problem on modern hardware, in fact I
was able to that with a 20 MHz 386.  What is your sample rate?

-- 
Daniel

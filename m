Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265697AbUFUDSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265697AbUFUDSt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 23:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265994AbUFUDSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 23:18:49 -0400
Received: from opersys.com ([64.40.108.71]:38916 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S265697AbUFUDSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 23:18:46 -0400
Message-ID: <40D6529F.6060305@opersys.com>
Date: Sun, 20 Jun 2004 23:14:39 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: ganzinger@mvista.com
CC: Geoff Levand <geoffrey.levand@am.sony.com>,
       high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Philippe Gerum <rpm@xenomai.org>
Subject: Re: [ANNOUNCE] high-res-timers patches for 2.6.6
References: <40C7BE29.9010600@am.sony.com> <40CA4D23.2010006@opersys.com> <40CE1128.8030806@mvista.com>
In-Reply-To: <40CE1128.8030806@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


George Anzinger wrote:
> I don't see how this delivers any added value to the user.  I suppose 
> code running at the kernel level might gain something, but at the user 
> level we still have to deal with preemption latencies, which are the 
> biggest problem (and, aside from messing up the accuracy of the timers, 
> are NOT timer issues at all).

Actually I think the point I'm trying to make can't be fairly conveyed
without providing a lot of background of what can be done with Adeos. I
would suggest that those interested do some digging. Among other things,
you may want to read about RTAI/fusion:
http://www.fdn.fr/~brouchou/rtai/rtai-doc-prj/rtai-fusion.html
http://www.fdn.fr/~brouchou/rtai/modules.php?name=Content&pa=showpage&pid=1

Here's a quote from Philippe on how this compares to HRT:
> Last time I checked (i.e. two days ago on a 2.6.6), hi-res timers were
> not capable of providing 1Khz periodic timings for 10mn with no overrun
> through clock_nanosleep(), even with no additional load on the machine.
> fusion is able to do that directly through a plain nanosleep(); in fact
> it is able to sustain 10Khz periodic timings with a compilation, disk
> I/O and interrupt flooding in the background. Frankly, IMHO, determinism
> with really hi-res timing in user-space is a territory which will remain
> ruled by RTAI for quite a long time; vanilla Linux will always look
> miserable at some point in this respect unless, e.g. stuff like that
> (which is otherwise perfectly sound for a GPOS) disappears from its code
> base:
> 
> kernel/softirq.c:
> 
> /*
>  * We restart softirq processing MAX_SOFTIRQ_RESTART times,
>  * and we fall back to softirqd after that.
>  *
>  * This number has been established via experimentation.
>  * The two things to balance is latency against fairness -
>  * we want to handle softirqs as soon as possible, but they
>  * should not be able to lock up the box.
>  */
> #define MAX_SOFTIRQ_RESTART 10
> 
> asmlinkage void __do_softirq(void)
> 
> --
> 
> But, hey! I WANT to be able to lock up this box! :o)

Unfortunately, there's no sustained vendor push behind this kind of stuff
as their is for HRT, but my experience has been that this is for lack of
understanding of what Linux can/should be able to provide as a GPOS then
anything else (i.e. a lot of "embedded"/"carrier-grade" vendors seem to
somehow believe that eventually plain vanilla Linux could become hard-rt
simply by virtue of adding more and more features on top of it ...
preemption, HRT, interrupt threading, etc.etc.etc. While the fact of the
matter is that Linux is a GPOS and that it really should catter for the
average case and leave the hard-rt part to something built with that in
mind.) For having been involved with the use of Linux in real-time systems
for over 5 years now, I firmly believe any potential solution to determinism
in Linux goes through something like Adeos. The example of RTAI/fusion is
just one out of many of what can be achieved with such an approach while
making it simple for application developers to create applications built
on "standard" APIs.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546


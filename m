Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVE3SFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVE3SFu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 14:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVE3SFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 14:05:49 -0400
Received: from smtpout.mac.com ([17.250.248.89]:13053 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261665AbVE3SE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 14:04:58 -0400
In-Reply-To: <m1k6lgwqro.fsf@muc.de>
References: <934f64a205052715315c21d722@mail.gmail.com> <A53A981B-98F9-42EC-8939-60A528FEC34E@mac.com> <m1r7fpvupa.fsf@muc.de> <429B289D.7070308@nortel.com> <20050530164003.GB8141@muc.de> <429B4957.7070405@nortel.com> <m1k6lgwqro.fsf@muc.de>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <02485B05-6AE5-4727-8778-D73B2D202772@mac.com>
Cc: Chris Friesen <cfriesen@nortel.com>, john cooper <john.cooper@timesys.com>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: spinaphore conceptual draft
Date: Mon, 30 May 2005 14:04:36 -0400
To: Andi Kleen <ak@muc.de>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 30, 2005, at 13:46:35, Andi Kleen wrote:
>> tsc goes backwards on AMD?  Under what circumstances (I'm curious,
>> since I'm running one...)
>
> It is not synchronized between CPUs and slowly drifts and can even run
> at completely different frequencies there when you use powernow! on a
> MP system.

Unsynchronized is fine, we're only taking differences of short times.
Slow drift is likewise OK too.  As to the different frequencies, how
different are we talking about?  Also, on such a system, is there any
way to determine a relative frequency, even if unreliable or  
occasionally
off?

> It can be used reliably when you only do deltas on same CPU
> and correct for the changing frequency. However then you run
> into other problems, like it being quite slow on Intel.

The deltas here are generally short, always on the same CPU, and can be
corrected for changing frequency, assuming that said frequency is
available somehow.

Ideally it would be some sort of CPU cycle-counter, just so I can say
"In between lock and unlock, the CPU did 1000 cycles", for some value
of "cycle".

> I suspect any attempt to use time stamps in locks is a bad
> idea because of this.

Something like this could be built only for CPUs that do support that
kind of cycle counter.

> My impression is that the aggressive bus access avoidance the
> original poster was trying to implement is not that useful
> on modern systems anyways which have fast busses. Also
> it is not even clear it even saves anything; after all the
> CPU will always snoop cache accesses for all cache lines
> and polling for the EXCLUSIVE transition of the local cache line
> is probably either free or very cheap.

The idea behind these locks is for bigger systems (8-way or more) for
heavily contended locks (say 32 threads doing write() on the same fd).
In such a system, cacheline snooping isn't practical at the hardware
level, and a lock such as this should be able to send several CPUs to
do other useful work (If there's any to be done) and minimize the
cacheline banging.

> Optimizing for the congested case is always a bad idea anyways; in
> case lock congestion is a problem it is better to fix the lock.  And
> when you have a really congested lock that for some reason cannot be
> fixed then using some kind of queued lock (which also gives you
> fairness on NUMA) is probably a better idea. But again you should
> really fix the the lock instead, everything else is the wrong answer.

Good point

> BTW Getting the fairness on the backoff scheme right would have been
> probably a major problem.

Largely this is a fast guess heuristic, so max_time_before_schedule
could be this (and this would even work with priority inheritance):

effective_priority * waiters * avg_wait_time / 10;

> The thing that seems to tickle CPU vendors much more is to avoid
> wasting CPU time on SMT or on Hypervisors while spinning.  That can be
> all done with much simpler hints (like rep ; nop).

On such a system, a lock like this would take advantage of all the
properties of normal spinlocks, including any changes like that.



Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$  
r  !y?(-)
------END GEEK CODE BLOCK------




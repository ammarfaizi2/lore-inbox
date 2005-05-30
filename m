Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbVE3S5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVE3S5d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 14:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVE3S5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 14:57:33 -0400
Received: from smtpout.mac.com ([17.250.248.72]:57845 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261701AbVE3SzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 14:55:19 -0400
In-Reply-To: <20050530184059.GA2222@ucw.cz>
References: <934f64a205052715315c21d722@mail.gmail.com> <A53A981B-98F9-42EC-8939-60A528FEC34E@mac.com> <m1r7fpvupa.fsf@muc.de> <429B289D.7070308@nortel.com> <20050530164003.GB8141@muc.de> <429B4957.7070405@nortel.com> <m1k6lgwqro.fsf@muc.de> <02485B05-6AE5-4727-8778-D73B2D202772@mac.com> <20050530184059.GA2222@ucw.cz>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D051ED6E-5CE3-40AD-99A5-F860B465FCA8@mac.com>
Cc: Andi Kleen <ak@muc.de>, Chris Friesen <cfriesen@nortel.com>,
       john cooper <john.cooper@timesys.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: spinaphore conceptual draft
Date: Mon, 30 May 2005 14:54:52 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 30, 2005, at 14:40:59, Vojtech Pavlik wrote:
> On Mon, May 30, 2005 at 02:04:36PM -0400, Kyle Moffett wrote:
>> Unsynchronized is fine, we're only taking differences of short times.
>
> If you ask on two CPUs in a quick succession, you can get a negative
> time difference.

But not on the same CPU, which is the only thing done in the given
implementation.

>
>> Slow drift is likewise OK too.  As to the different frequencies, how
>> different are we talking about?
>
> 1GHz vs 2GHz, for example.

Fine, a ratio of 2 or even probably 4 is ok.  If it was a ratio of 10:1
or 20:1, that might be an issue if we had no between-CPU ratio  
adjustment,
but otherwise it's just guesstimation, so it's not that important to be
accurate.

>> Also, on such a system, is there any way to determine a relative
>> frequency, even if unreliable or  occasionally off?
>
> You can measure it. With cpufreq you have a good guess when you switch
> that the new frequency will have a certain ratio to the old one.

The time periods under consideration are so small (and due to the way
it's used, especially WRT the running average, if the CPU changes
frequencies in mid-calculation, we don't really care about same-CPU
changes, as long as we can usually guess about between-CPU ratios.

>> The deltas here are generally short, always on the same CPU, and  
>> can be
>> corrected for changing frequency, assuming that said frequency is
>> available somehow.
>
> The fact the deltas are on the same CPU helps. The shortness of the
> interval doesn't, since on AMD CPUs RDTSC is executed speculatively  
> and
> out-of-order, and the order of two close RDTSC instructions isn't
> guaranteed, as far as I remember.

Not exactly that short.  There will usually be several hundred  
instructions
in between, at _least_, otherwise you'd just use a normal spinlock to
minimize overhead.

>> Ideally it would be some sort of CPU cycle-counter, just so I can say
>> "In between lock and unlock, the CPU did 1000 cycles", for some value
>> of "cycle".
> This may be doable if precision isn't required.

This is a best-guess as to whether the CPU should put the process to  
sleep
and go do something else if it can or just poll.  If we're wrong either
way it doesn't matter much, we'll effectively default back to the old
dumb behavior.

> RDTSC on older Intel CPUs takes something like 6 cycles. On P4's it
> takes much more, since it's decoded to a microcode MSR access.

Ick!  Is there any other kind of fast cycle counter on a P4?

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$  
r  !y?(-)
------END GEEK CODE BLOCK------




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318950AbSH1USr>; Wed, 28 Aug 2002 16:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318948AbSH1USr>; Wed, 28 Aug 2002 16:18:47 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:39560 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S318950AbSH1USp>; Wed, 28 Aug 2002 16:18:45 -0400
Date: Wed, 28 Aug 2002 22:19:47 +0200
From: Dominik Brodowski <devel@brodo.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
Message-ID: <20020828221947.A816@brodo.de>
References: <20020828134600.A19189@brodo.de> <Pine.LNX.4.33.0208281140030.4507-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <Pine.LNX.4.33.0208281140030.4507-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Aug 28, 2002 at 11:47:54AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 11:47:54AM -0700, Linus Torvalds wrote:
> 
> On Wed, 28 Aug 2002, Dominik Brodowski wrote:
> > 
> > The following patches add CPU frequency and volatage scaling
> > support (Intel SpeedStep, AMD PowerNow, etc.) to kernel 2.5.32
> 
> The thing is, this interface appears fundamentally broken with respect to
> CPU's that change their frequency on the fly. I happen to know one such 
> CPU rather well myself.
Do these CPUs need kernel support? E.g. do udelay() calls work as
expected? If so, there's no need to make a driver aware of something
which isn't in its scope to control. CPUFreq is basically for those many
systems where frequency switches need to be called from the OS. 

> What is this interface supposed to do about a CPU that can change its 
> frequency dynamically several hundred times a second? Having the OS 
> control it simply isn't an option - the overhead of the control is _way_ 
> more than is acceptable at that level.
Well, that's probably the idea that's behind the microcode approach of
certain CPUs. However, for many voltage-scaling-able CPUs there is no such
microcode, and so the OS _needs_ to do it.

> In other words: there is no valid way that a _user_ can set the policy
> right now: the user can set the frequency, but since any sane policy
> depends on how busy the CPU is, the user isn't even, the right person to
> _do_ that, since the user doesn't _know_.
This is only true on CPUs where frequency switches can occur "on the fly"
with very low latency. Most voltage-scaling CPUs are currently found on 
mobile systems. For those notebook users it is a big step forward to have
this ability of switching between "full speed" and "low speed" depending on
the power source. And on LART systems even dynamic switching _from
userspace_ has proven to be successful (see OLS talk my Erik Mouw).
Please note that even a "kernel-based frequency selector" needs large parts
of the cpufreq core and drivers: udelay() calls need to be accurate,
external limitations (like on ARM systems) need to be integrated, and the
frequency and voltage switching mechanisms need to be implemented --
so is there any reason why this "kernel-based frequency selector" couldn't 
just use the existing interface: cpufreq_set()?

> Also note that policy is not just about how busy the CPU is, but also 
> about how _hot_ the CPU is. Again, a user-mode application (that maybe 
> polls the situation every minute or so), simply _cannot_ handle this 
> situation. You need to have the ability to poll the CPU tens of times a 
> second to react to heat events, and clearly user mode cannot do that 
> without impacting performance in a big way.
IMHO a cpufreq interface shouldn't become too bloated. If it would try to
drop the frequency quite aggressively this should be enough,
critical-temperature shutdown / throttling mechanisms will take
care of emergenices.

> The interface needs to be improved upon. It is simply _not_ valid to say
> "run at this speed" as the primary policy.
This is right. But a sane kernel-based frequency selector doesn't exist yet.
Even if it existed, it would need large parts of the cpufreq patches
submitted today. And these offer some support which isn't the best thing
since sliced bread but still is happily used by users.

	Dominik

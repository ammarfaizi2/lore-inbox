Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318626AbSH1SlS>; Wed, 28 Aug 2002 14:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318726AbSH1SlS>; Wed, 28 Aug 2002 14:41:18 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45582 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318626AbSH1SlR>; Wed, 28 Aug 2002 14:41:17 -0400
Date: Wed, 28 Aug 2002 11:47:54 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dominik Brodowski <devel@brodo.de>
cc: <cpufreq@www.linux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
In-Reply-To: <20020828134600.A19189@brodo.de>
Message-ID: <Pine.LNX.4.33.0208281140030.4507-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Aug 2002, Dominik Brodowski wrote:
> 
> The following patches add CPU frequency and volatage scaling
> support (Intel SpeedStep, AMD PowerNow, etc.) to kernel 2.5.32

The thing is, this interface appears fundamentally broken with respect to
CPU's that change their frequency on the fly. I happen to know one such 
CPU rather well myself.

What is this interface supposed to do about a CPU that can change its 
frequency dynamically several hundred times a second? Having the OS 
control it simply isn't an option - the overhead of the control is _way_ 
more than is acceptable at that level.

In short, this interface is too broken to be called generic. 

A quote from Peter Anvin:

  "What is worse is that the interface is, in my opinion, fundamentally
   broken for *ALL* CPUs.  It doesn't present a policy interface to the
   kernel, instead it presents a frequency-setting interface and expect
   the policy to be done in userspace.  The kernel is the only part of the
   system which has sufficient information (idle times of all CPUs, for
   example) to do a decent job managing the CPU frequency efficiently.  
   On Transmeta CPUs this policy should simply be passed down to CMS, of
   course; on other CPUs the kernel needs to manage it."

In other words: there is no valid way that a _user_ can set the policy
right now: the user can set the frequency, but since any sane policy
depends on how busy the CPU is, the user isn't even, the right person to
_do_ that, since the user doesn't _know_.

Also note that policy is not just about how busy the CPU is, but also 
about how _hot_ the CPU is. Again, a user-mode application (that maybe 
polls the situation every minute or so), simply _cannot_ handle this 
situation. You need to have the ability to poll the CPU tens of times a 
second to react to heat events, and clearly user mode cannot do that 
without impacting performance in a big way.

The interface needs to be improved upon. It is simply _not_ valid to say
"run at this speed" as the primary policy.

		Linus


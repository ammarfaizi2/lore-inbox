Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319040AbSH1XjN>; Wed, 28 Aug 2002 19:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319045AbSH1XjN>; Wed, 28 Aug 2002 19:39:13 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13065 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319040AbSH1XjM>; Wed, 28 Aug 2002 19:39:12 -0400
Date: Wed, 28 Aug 2002 16:49:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Dominik Brodowski <devel@brodo.de>, <cpufreq@www.linux.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
In-Reply-To: <1030577178.7190.85.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208281633410.27728-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 29 Aug 2002, Alan Cox wrote:
> 
> One of the policies I need from the kernel is "run at the frequency I
> told you to run". Its a policy, its not the general case policy. The
> /proc file is that policy.

That's ok, but the current code DOES NOT DO THAT.

The current code has no support at all for the notion of policies, and 
gives absolutely _zero_ support for it. It blindly assumes that the CPU 
can (and should) run at one frequency, and as long as it does that, I 
don't want it in the kernel.

> cpufreq is cpu speed control not power management policy. I agree
> entirely that most people should not be using echo "500" >/proc/... as a
> power management policy. 
> 
> Likewise /dev/hda is not a file system and peopel should not be using dd
> to store there files.

You've had that argument before, and it was bogus then - and it is bogus 
now.

It is possible to put a filesystem on top of /dev/hda - because the block
layer is designed to allow it. It is not possible to build sane policy
upon the current frequency patches, because it is _not_ designed for 
passing down the policy.

Exactly because some chips _need_ to have the policy passed down, the 
lowest levels need to be able to pass it down.

It is _then_ ok to say that "if you do a 'echo 500 > /proc/cpu/freq', that
will also imply a policy of a fixed frequency". But if the frequency
setting code does not allow for any policy interface AT ALL, then it is
fundamentally broken.

That's my beef with it. We should not have "generic" interfaces that are
known to be fundamentally broken. As it is, the code - as designed - is
useless for a growing class of devices.

Think of it as a layering issue:
 - user level policy
 - kernel interface (possibly many - for different policies)
 - low-level driver

Ok?

Now, what the current patches do is (a) one kernel interface (the 
fixed-frequency one) and (b) low-level drivers.

The kernel interface is fine - it doesn't do what I think many people 
might want to do, but it's simple and I agree that other policies can be 
implemented with other interfaces. Fine. 

But the fact that low-level drivers don't even support the notion of a 
policy means that they are useless for any other interface. And I'm saying 
that it's a clear design bug, and for no good reason. 

		Linus


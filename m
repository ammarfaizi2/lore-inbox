Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271621AbRHUJWB>; Tue, 21 Aug 2001 05:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271623AbRHUJVv>; Tue, 21 Aug 2001 05:21:51 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:10983 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271621AbRHUJVp>;
	Tue, 21 Aug 2001 05:21:45 -0400
Date: Tue, 21 Aug 2001 10:21:56 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: David Lang <david.lang@digitalinsight.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: RE: Entropy from net devices - keyboard & IDE just as 'bad' [was
 Re: [PATCH] let Net Devices feed Entropy, updated (1/2)]
Message-ID: <608038730.998389316@[169.254.45.213]>
In-Reply-To: <Pine.LNX.4.33.0108210042520.32719-100000@dlang.diginsite.com>
In-Reply-To: <Pine.LNX.4.33.0108210042520.32719-100000@dlang.diginsite.com>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

> so as I see this discussion it goes something like this.
>
> 1. the entropy pool is not large enough on headless machines.
> 2. you don't want to use urandom as there are theoretical attacks against
> it
>
> so as a result you propose adding an option to weaken random (network
> traffic is not that random which is a large part of why it's not included
> now)

An option, yes.

> you are trading one theoretical attack for another known attack (a
> difficult attack to pull off yes, but still known)

Not exactly, because to break /dev/random (with the config option on)
you have to (a) do the work that would have broken /dev/urandom, and
(b) break the translation of network traffic into entropy. If you
were using /dev/urandom only, you'd have to just do (a). IE if the
two alternatives are /dev/urandom, and /dev/random with Robert's
patch, the latter is certainly more secure (i.e. it's not a tradeoff).

> as for the arguments that applications all use random and would have to be
> changed to use urandom.
>
> don't forget that it's not the names that matter to the kernel it's the
> major/minor numbers. you can rename random to really.random and urandom to
> random and your software will not know the difference.

This is a fair point, but doesn't take into account the 'waiting for
sufficient entropy' point - which of course relies on network traffic
timing being sufficiently unobservable that it constitutes valid entropy.

> if you were arguing that the network traffic was truly random and that it
> should be added in as well that would be a different story, but you're not
> saying that you just don't want the incomvienience of blocking while
> waiting for truely random data but want to fool yourself into thinking
> that you are.

Well, I was arguing that network traffic was sufficiently unobservable
that it constitutes valid entropy under some circumstances, until I went
and read the code. It is so (it seems to me) on some i386 versions, where
the cycle clock is used. It is definitely not (and neither are any of
the other interrupt timings) where jiffies are used, for a start
because /proc/interrupts gives you the jiffie count (timer interrupts)
and the other interrupt counters simultaneously. So my argument is
that in some situations (where you know are happy with the extent
to which there is no observation of your wire locally), net IRQs
are no worse than the other sources of entropy, and sometimes they
are better (consider keyboards connected by radio). Obviously, in
cases like 802.11, they are substantially worse (and, no doubt, we
could omit Robert's patch from things like 802.11 drivers which
are obvious 'don't do that' cases).

--
Alex Bligh

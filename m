Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312027AbSCXVNe>; Sun, 24 Mar 2002 16:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312031AbSCXVNY>; Sun, 24 Mar 2002 16:13:24 -0500
Received: from 93dyn76.com21.casema.net ([62.234.24.76]:51162 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S312027AbSCXVNH>; Sun, 24 Mar 2002 16:13:07 -0500
Message-Id: <200203242112.WAA09406@cave.bitwizard.nl>
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <Pine.LNX.4.33.0203161203050.31971-100000@penguin.transmeta.com>
 from Linus Torvalds at "Mar 16, 2002 12:14:06 pm"
To: Linus Torvalds <torvalds@transmeta.com>
Date: Sun, 24 Mar 2002 22:12:58 +0100 (MET)
CC: yodaiken@fsmlabs.com, Andi Kleen <ak@suse.de>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-notice1: This Email contains my Email address. This grants you the right
X-notice2: to communicate with me using this address, related to the subject
X-notice3: in this message. Unsollicitated mass-mailings are explictly 
X-notice4: forbidden here, and by Dutch law. 
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> We may get there some day, but right now 2M pages are not usable for use 
> access.
> 
> 64kB would be fine, though.

[...]

> Give up on large pages - it's just not happening. Even when a 64kB page 
> would make sense from a technology standpoint these days, backwards 
> compatibility makes people stay at 4kB.

I would think that "large page support" that the processors give you
is indeed unusable, but what do you think about "software large(r)
pages"?

What I mean is that instead of doing the 4k that the ia32 hardware
gives us, we pretend that pages are (e.g.) 8k. Thus we always load a
pair of page table entries. memmap ends up having 8k granularity, IO
is done on page-sized (i.e. 8k in this case) chunks etc etc. (%)

So we have a "PAGE_SIZE" define all around the kernel. Keep that the
same (for compatibility), but make a "REAL_PAGE_SIZE" that governs the
loop that actually sets the page table (or tlb) entries.... Note that
a first implementation may actually effectivly reduce the size of the
TLB on machines with a software loaded TLB....

Why would I want this? Well, suppose I have a machine that unavoidably
has to swap on some of its workload. In practise you will almost
double the disk troughput by increasing the page size by a factor of
two.  If the hit rate on the "extra page" that you swap in by
pretending pages are 8k and not 4k is over a couple of percents (*),
then this is advantageous: A seek plus transfer of 4k costs say 10ms +
0.16us while a seek plus transfer of 8k costs 10ms + .33 us (#). Thus
the "penalty" of the extra 4k transfer is very, very small.

Now, for all the reasons you mention, keeping 4k as the "default" on
Intel is good. But a config option:

                on      on
	       intel   alpha
page size: 	4k
		8k	8k
		16k 	16k 
		32k	32k
		64k	64k
		128k	128k

would also be good for some people. 

				Roger. 

(*) Actually it has to be a "couple of percents better than the 4k
page that we had to evict to be able to accomodate the current extra
4k...

(#) A 10k RPM disk rotates in 6ms, so average rotational latency is
about 3ms, and with an average seek time of 7ms, that comes to 10ms.

(%) And we get ext2 8k block size support on ia32!

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 

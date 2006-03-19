Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751533AbWCSRpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbWCSRpn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 12:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbWCSRpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 12:45:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9355 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751530AbWCSRpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 12:45:43 -0500
Date: Sun, 19 Mar 2006 09:43:26 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Jackson <pj@sgi.com>
cc: akpm@osdl.org, kernel-stuff@comcast.net, linux-kernel@vger.kernel.org,
       alex-kernel@digriz.org.uk, jun.nakajima@intel.com, davej@redhat.com
Subject: Re: OOPS: 2.6.16-rc6 cpufreq_conservative
In-Reply-To: <20060318210840.e7156b6b.pj@sgi.com>
Message-ID: <Pine.LNX.4.64.0603190933531.3826@g5.osdl.org>
References: <200603181525.14127.kernel-stuff@comcast.net>
 <Pine.LNX.4.64.0603181321310.3826@g5.osdl.org> <20060318165302.62851448.akpm@osdl.org>
 <Pine.LNX.4.64.0603181827530.3826@g5.osdl.org> <20060318210840.e7156b6b.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Mar 2006, Paul Jackson wrote:
>
> If find_first_bit and find_next_bit suck so bad, then why just fix
> their use in the for_each_cpu_mask().  How about the other uses?

find_first_bit/find_next_bit don't actually suck. They're perfectly 
efficient for large bitmaps, which is what they were designed for (ie they 
were written for doing the free-block/inode bitmaps for minixfs 
originally).

In other words, they are meant for bitmaps of _thousands_ of bits, and 
for potentially sparse bitmaps.

Now, the CPU masks _can_ be large too, but commonly they are not. In this 
example, the "bitmap" was exactly two bits: cpu 0 and cpu 1. Using a 
complex "find_next_bit" for something like that is just overkill.

> And if we fix the cpu loop to the API Linus suggests, we should do the
> same with the node loops

Yes. Almost ever "for_each_xyzzy" tends to be more easily written as a 
macro if we also have a ending condition.

> And for those of us with too many CPUs, how about something like
> (totally untested and probably totally bogus):
> 
> 	#if NR_CPUS <= BITS_IN_LONG
> 	 ... as per Linus, shifting a mask right ...
> 	#else
> 	#define for_each_cpu_mask(cpu, mask)
> 		{ for (cpu = 0; cpu < NR_CPUS; cpu++) {
> 			if (!(test_bit(cpu, mask))
> 				continue;
> 	#endif
> 
> 	#define end_for_each_cpu_mask	} }	

Yes, except you'd probably be better off with testing whole words at a 
time, since a large NR_CPUs can often be because somebody wanted to 
support 256 CPU machines, and then used the same binary on a 8-way setup.

That would most helpfully be done with a double loop (outer one iterating 
over the bitmask words, inner one over the bits), but then it's hard to 
make "break" do the right thing inside the loop.

		Linus

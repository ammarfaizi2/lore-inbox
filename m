Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbTKENiR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 08:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262887AbTKENiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 08:38:17 -0500
Received: from intra.cyclades.com ([64.186.161.6]:8927 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262884AbTKENiQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 08:38:16 -0500
Date: Wed, 5 Nov 2003 11:35:24 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Linus Torvalds <torvalds@osdl.org>
Cc: john stultz <johnstul@us.ibm.com>, Joel Becker <Joel.Becker@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: get_cycles() on i386
In-Reply-To: <Pine.LNX.4.44.0311041545030.20373-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0311051134490.13581-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Nov 2003, Linus Torvalds wrote:

> 
> On 4 Nov 2003, john stultz wrote:
> > 
> > CONFIG_X86_TSC be the devil. Personally, I'd much prefer dropping the
> > compile time option and using dynamic detection. Something like (not
> > recently tested and i believe against 2.5.something, but you get the
> > idea):
> 
> Some of the users are really timing-critical (eg scheduler).
> 
> How about just using the "alternative()" infrastructure that we already 
> have in 2.6.x for this? See <asm-i386/system.h> for details.
> 
> We don't have an "alternative_output()" available yet, but using that it
> would look something like:
> 
> 	static inline unsigned long long get_cycle(void)
> 	{
> 		unsigned long long tsc;
> 
> 		alternative_output(
> 			"xorl %%eax,%%eax ; xorl %%edx,%%edx",
> 			"rdtsc",
> 			X86_FEATURE_TSC,
> 			"=A" (tsc));
> 		return tsc;
> 	 }
> 
> which should allow for "perfect" code (well, gcc tends to mess up 64-bit 
> stuff, but you get the idea).
> 
> We use the "alternative_input()" thing for prefetch() handling (see 
> <asm-i386/processor.h>).

I'm not confident this is something for 2.4.

The "if (cpu_has_tsc)" fix from John sounds fine. 


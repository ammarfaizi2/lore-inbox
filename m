Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750989AbWFDS4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWFDS4s (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 14:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWFDS4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 14:56:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33160 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750984AbWFDS4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 14:56:48 -0400
Subject: Re: [RFC] Per-architecture randomization
From: Arjan van de Ven <arjan@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <448327ED.1040105@comcast.net>
References: <44825E42.5090902@comcast.net>
	 <1149411968.3109.79.camel@laptopd505.fenrus.org>
	 <44830703.3000905@comcast.net>
	 <1149441301.3109.120.camel@laptopd505.fenrus.org>
	 <448327ED.1040105@comcast.net>
Content-Type: text/plain
Date: Sun, 04 Jun 2006 20:56:45 +0200
Message-Id: <1149447406.3109.142.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-04 at 14:35 -0400, John Richard Moser wrote:

> Stack and mmap() VMA alignment is based on PAGE_SIZE.

which breaks ppc64 for hugetlbs at least.

> Explain "randomization within each region."  I thought mmap()
> randomization just shifted the mmap() base around at process start?

ia64 and iirc also ppc64 have different regions in the VA space for
different types of mmaps. Hugetlb, executable, non-cachable etc etc.


> 
> > 
> >>   - Less code to maintain
> > 
> > we're talking less than a handful lines of code again, most of which is
> > NOT shareable.
> > 
> 
> The relevant parts are sharable.  I just moved this stuff out into
> fs/exec.c:

... and made it a lot more complex.

> Yes, this is the same solution as with TASK_SIZE (which is about 3 lines
> above this...)

the rules for mmap_base vary per architecture, and even per binary time.
In fact the meaning of it is very much free for the architecture to
determine/use.
> >> 2.  I can get away with exactly 1 arch_align_stack() function, instead
> >> of 1 per architecture.
> > 
> > I don't think that that is fundamentally possible, see above.
> 
> Did it already, for any STACK_ALIGN, any PAGE_SIZE, any level of
> entropy, and for stacks that grow up and down.  The only situations that
> I haven't handled are stacks that grow up and down at the same time,

ok so you haven't dealt with ia64 yet ;)

>  and
> stacks that teleport data to other dimensional planes.

and with stacks that need different alignment based on binary type (mips
has 4 or so of those) or .. or ..


> The level of stack entropy was definitely not per-architecture; 

no but it COULD be. I haven't looked at the ia64 randomization, but I'd
not be surprised if it was different


> >> Part of the bulk stems from the fact that I didn't do randomization
> >> based on range, but based on bits of entropy.  
> > 
> > I don't understand why you want to do that. It will make code a lot more
> > complex, and at the same time it limits you to powers-of-two in
> > practice.
> > 
> 
> In practice if you can assume an attacker can reasonably break 17 bits
> of entropy, then you can assume that he can possibly (but unlikely)
> double his attack efficiency and break 18 bits.  You would want to step
> it up to 20 bits or so to get a few steps beyond "unlikely" into "we are
> pretty confident this is impossible."

I think you totally missed the point. *I DON'T CARE ABOUT "BITS OF
ENTROPY" IN THE CODE*. The code cares about how much it is in actual
bytes. Sure when talking about it in documents or analysis it may make
sense to do the bits math. BUT NOT IN THE CODE.

That was my point, and all there was to it. You add complexity and
limitations TO THE CODE for no good reason at all.




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267444AbUG2VNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267444AbUG2VNk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 17:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbUG2VLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 17:11:03 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:55013 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265102AbUG2VIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 17:08:01 -0400
Date: Thu, 29 Jul 2004 23:07:53 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: 2.6.8-rc2-mm1 link errors
Message-ID: <20040729210752.GB23589@fs.tum.de>
References: <1091057256.2871.637.camel@nighthawk> <20040728164920.5ad4c114.akpm@osdl.org> <1091066773.2871.866.camel@nighthawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091066773.2871.866.camel@nighthawk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 07:06:13PM -0700, Dave Hansen wrote:
> On Wed, 2004-07-28 at 16:49, Andrew Morton wrote:
> > Nope.   Could you take a look at the code in the top-level
> > Makefile which is doing this, work out why it broke?
> 
> It seems to come down to this warning:
> 
> arch/i386/kernel/irq.c
> {standard input}: Assembler messages:
> {standard input}:3565: Warning: setting incorrect section type for
> .bss.page_aligned
> 
> Which comes from this code in the 4k stacks code:
> 
> static char softirq_stack[NR_CPUS * THREAD_SIZE]  __attribute__((__aligned__(THREAD_SIZE), __section__(".bss.page_aligned")));
> static char hardirq_stack[NR_CPUS * THREAD_SIZE]  __attribute__((__aligned__(THREAD_SIZE), __section__(".bss.page_aligned")));
> 
> Removing the __section__() fixes it, as does moving to gcc 3.2 or 3.3,
> but gcc 2.95 and 3.0 still exhibit the problem.  It seems the 4k stack
> developers like newer compilers than I do :) 
> 
> The gcc 2.95 section declaration looks like this:
> 	.section        .bss.page_aligned,"aw",@progbits
> while the 3.1 section looks like this:
> 	.section        .bss.page_aligned,"aw",@nobits
> 
> It's definitely a bug that's been fixed:
> http://sources.redhat.com/ml/binutils/2002-10/msg00507.html
> 
> I've been told that I can fix it with a carefully crafted assembly file
> and maybe a change to the linker script, but all that it buys us is a
> little space in the uncompressed kernel image.  Plus, the warning will
> still be there at compile-time.  
> 
> I say, put them back in plain old BSS.  Patch attached.

Thanks, your patch solves a problem with gcc 2.95 in my modular test 
.comnfig I didn't have time to debug.

> -- Dave

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


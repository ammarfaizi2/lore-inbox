Return-Path: <linux-kernel-owner+w=401wt.eu-S1753905AbWL2AGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905AbWL2AGw (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 19:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753916AbWL2AGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 19:06:52 -0500
Received: from ozlabs.org ([203.10.76.45]:47234 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753905AbWL2AGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 19:06:51 -0500
Subject: Re: [PATCH] Use correct macros in raid code, not raw asm
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Neil Brown <neilb@suse.de>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>
In-Reply-To: <20061228155659.462eaa9c.akpm@osdl.org>
References: <1167348861.30506.46.camel@localhost.localdomain>
	 <20061228155659.462eaa9c.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 29 Dec 2006 11:06:43 +1100
Message-Id: <1167350803.30506.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-28 at 15:56 -0800, Andrew Morton wrote:
> On Fri, 29 Dec 2006 10:34:21 +1100
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
> > This make sure it's paravirtualized correctly when CONFIG_PARAVIRT=y.
> > 
> > Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> > 
> > diff -r 4ff048622391 drivers/md/raid6x86.h
> > --- a/drivers/md/raid6x86.h	Thu Dec 28 16:52:54 2006 +1100
> > +++ b/drivers/md/raid6x86.h	Fri Dec 29 10:09:38 2006 +1100
> > @@ -75,13 +75,14 @@ static inline unsigned long raid6_get_fp
> >  	unsigned long cr0;
> >  
> >  	preempt_disable();
> > -	asm volatile("mov %%cr0,%0 ; clts" : "=r" (cr0));
> > +	cr0 = read_cr0();
> > +	clts();
> >  	return cr0;
> >  }
> >  
> >  static inline void raid6_put_fpu(unsigned long cr0)
> >  {
> > -	asm volatile("mov %0,%%cr0" : : "r" (cr0));
> > +	write_cr0(cr0);
> >  	preempt_enable();
> >  }
> >  
> 
> Perhaps we also need:
> 
> --- a/drivers/md/raid6x86.h~use-correct-macros-in-raid-code-not-raw-asm-include
> +++ a/drivers/md/raid6x86.h
> @@ -21,6 +21,8 @@
>  
>  #if defined(__i386__) || defined(__x86_64__)
>  
> +#include <asm/system.h>
> +

The code looks like it's designed to be included from userspace for
testing; as it compiles without this include (and has no other
includes), I chose not to add it.

Linus makes a good point, but someone who actually knows the code
should, y'know, test it and stuff...

Rusty.



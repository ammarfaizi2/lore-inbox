Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314351AbSDRNo6>; Thu, 18 Apr 2002 09:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314353AbSDRNo5>; Thu, 18 Apr 2002 09:44:57 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:19527 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S314351AbSDRNoz>; Thu, 18 Apr 2002 09:44:55 -0400
Date: Thu, 18 Apr 2002 09:44:44 -0400
From: Doug Ledford <dledford@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: jh@suse.cz, linux-kernel@vger.kernel.org, jakub@redhat.com, aj@suse.de,
        ak@suse.de, pavel@atrey.karlin.mff.cuni.cz
Subject: Re: SSE related security hole
Message-ID: <20020418094444.A2450@redhat.com>
Mail-Followup-To: Doug Ledford <dledford@redhat.com>,
	Andrea Arcangeli <andrea@suse.de>, jh@suse.cz,
	linux-kernel@vger.kernel.org, jakub@redhat.com, aj@suse.de,
	ak@suse.de, pavel@atrey.karlin.mff.cuni.cz
In-Reply-To: <20020417194249.B23438@redhat.com> <20020418072615.I14322@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2002 at 07:26:15AM +0200, Andrea Arcangeli wrote:
> On Wed, Apr 17, 2002 at 07:42:49PM -0400, Doug Ledford wrote:
> > --- i387.c.save	Wed Apr 17 19:22:47 2002
> > +++ i387.c	Wed Apr 17 19:28:27 2002
> > @@ -33,8 +33,26 @@
> >  void init_fpu(void)
> >  {
> >  	__asm__("fninit");
> > -	if ( cpu_has_xmm )
> > +	if ( cpu_has_mmx )
> > +		asm volatile("xorq %%mm0, %%mm0;
> > +			      xorq %%mm1, %%mm1;
> > +			      xorq %%mm2, %%mm2;
> > +			      xorq %%mm3, %%mm3;
> > +			      xorq %%mm4, %%mm4;
> > +			      xorq %%mm5, %%mm5;
> > +			      xorq %%mm6, %%mm6;
> > +			      xorq %%mm7, %%mm7");
> 
> This mean the mmx isn't really backwards compatible and that's
> potentially a problem for all the legacy x86 multiuser operative
> systems.  That's an hardware design bug, not a software problem.  In
> short running a 2.[02] kernel on a MMX capable CPU isn't secure, the
> same potentially applies to windows NT and other unix, no matter of SSE.

Why is that not backwards compatible?  I've never heard of anywhere that 
specifies that the starting value in the mmx registers will be anything of 
consequence?  Also, even though register space is (possibly) shared with 
the FP register stack, clearing out the MMX registers does not actually 
harm the FP register stack since the fninit already blows the stack away, 
which forces the application to load fp data before it can use the fpu 
again.

> I verified with this simple proggy:
> 
> main()
> {
> 	long long x = 2;
> 	long long z = 3;
> 
> 	asm volatile("movq %0, %%mm0":: "m" (x));
> 	asm volatile("fninit");
> 	asm volatile("movq %%mm0, %0": "=m" (z):);
> 
> 	printf("%d\n", z);
> }
> 
> it prints 2 here, while it should print zero or at least random to be
> backwards compatible.

I verified the same here last night with a similar test.

> The patch has a couple of problems. xorq doesn't exists. Since there are
> no params you should also drop one %. Also I think we need an emms after
> the mmx operations to remain binary compatible with the x86 ABI.

I did mention that it was an untested and even uncompiled patch in my 
email after all ;-)

> How does this look?

I'm fine with this.

> --- 2.4.19pre7aa1/arch/i386/kernel/i387.c.~1~	Thu Apr 18 05:23:12 2002
> +++ 2.4.19pre7aa1/arch/i386/kernel/i387.c	Thu Apr 18 07:20:26 2002
> @@ -33,8 +33,28 @@
>  void init_fpu(void)
>  {
>  	__asm__("fninit");
> -	if ( cpu_has_xmm )
> +	if (cpu_has_mmx) {
> +		asm volatile("pxor %mm0, %mm0\n\t"
> +			     "movq %mm0, %mm1\n\t"
> +			     "movq %mm0, %mm2\n\t"
> +			     "movq %mm0, %mm3\n\t"
> +			     "movq %mm0, %mm4\n\t"
> +			     "movq %mm0, %mm5\n\t"
> +			     "movq %mm0, %mm6\n\t"
> +			     "movq %mm0, %mm7\n\t"
> +			     "emms\n");
> +	}
> +	if ( cpu_has_xmm ) {
> +		asm volatile("xorps %xmm0, %xmm0\n\t"
> +			     "xorps %xmm1, %xmm1\n\t"
> +			     "xorps %xmm2, %xmm2\n\t"
> +			     "xorps %xmm3, %xmm3\n\t"
> +			     "xorps %xmm4, %xmm4\n\t"
> +			     "xorps %xmm5, %xmm5\n\t"
> +			     "xorps %xmm6, %xmm6\n\t"
> +			     "xorps %xmm7, %xmm7\n");
>  		load_mxcsr(0x1f80);
> +	}
>  		
>  	current->used_math = 1;
>  }
> 
> Andrea

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  

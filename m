Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314275AbSDRJKh>; Thu, 18 Apr 2002 05:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314278AbSDRJKg>; Thu, 18 Apr 2002 05:10:36 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:26351 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S314275AbSDRJKf>; Thu, 18 Apr 2002 05:10:35 -0400
Message-ID: <3CBE8D89.AA3950DB@redhat.com>
Date: Thu, 18 Apr 2002 10:10:33 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-0.24smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SSE related security hole
In-Reply-To: <20020417194249.B23438@redhat.com> <20020418072615.I14322@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Wed, Apr 17, 2002 at 07:42:49PM -0400, Doug Ledford wrote:
> > --- i387.c.save       Wed Apr 17 19:22:47 2002
> > +++ i387.c    Wed Apr 17 19:28:27 2002
> > @@ -33,8 +33,26 @@
> >  void init_fpu(void)
> >  {
> >       __asm__("fninit");
> > -     if ( cpu_has_xmm )
> > +     if ( cpu_has_mmx )
> > +             asm volatile("xorq %%mm0, %%mm0;
> > +                           xorq %%mm1, %%mm1;
> > +                           xorq %%mm2, %%mm2;
> > +                           xorq %%mm3, %%mm3;
> > +                           xorq %%mm4, %%mm4;
> > +                           xorq %%mm5, %%mm5;
> > +                           xorq %%mm6, %%mm6;
> > +                           xorq %%mm7, %%mm7");
> 
> This mean the mmx isn't really backwards compatible and that's
> potentially a problem for all the legacy x86 multiuser operative
> systems.  That's an hardware design bug, not a software problem.  In
> short running a 2.[02] kernel on a MMX capable CPU isn't secure, the
> same potentially applies to windows NT and other unix, no matter of SSE.
> 
> I verified with this simple proggy:
> 
> main()
> {
>         long long x = 2;
>         long long z = 3;
> 
>         asm volatile("movq %0, %%mm0":: "m" (x));
>         asm volatile("fninit");
>         asm volatile("movq %%mm0, %0": "=m" (z):);
> 
>         printf("%d\n", z);
> }
> 
> it prints 2 here, while it should print zero or at least random to be
> backwards compatible.
> 
> SSE was a completly different issue, that is a software bug.  SSE is
> disabled by non aware OS, and so if we enable it we also must take care
> of clearing it at the first math fault.
> 
> > +     if ( cpu_has_xmm ) {
> > +             asm volatile("xorps %%xmm0, %%xmm0;
> > +                           xorps %%xmm1, %%xmm1;
> > +                           xorps %%xmm2, %%xmm2;
> > +                           xorps %%xmm3, %%xmm3;
> > +                           xorps %%xmm4, %%xmm4;
> > +                           xorps %%xmm5, %%xmm5;
> > +                           xorps %%xmm6, %%xmm6;
> > +                           xorps %%xmm7, %%xmm7");
> 
> The patch has a couple of problems. xorq doesn't exists. Since there are
> no params you should also drop one %. Also I think we need an emms after
> the mmx operations to remain binary compatible with the x86 ABI.
> 
> How does this look?
> 
> --- 2.4.19pre7aa1/arch/i386/kernel/i387.c.~1~   Thu Apr 18 05:23:12 2002
> +++ 2.4.19pre7aa1/arch/i386/kernel/i387.c       Thu Apr 18 07:20:26 2002
> @@ -33,8 +33,28 @@
>  void init_fpu(void)
>  {
>         __asm__("fninit");
> -       if ( cpu_has_xmm )
> +       if (cpu_has_mmx) {
> +               asm volatile("pxor %mm0, %mm0\n\t"
> +                            "movq %mm0, %mm1\n\t"
> +                            "movq %mm0, %mm2\n\t"
> +                            "movq %mm0, %mm3\n\t"
> +                            "movq %mm0, %mm4\n\t"
> +                            "movq %mm0, %mm5\n\t"
> +                            "movq %mm0, %mm6\n\t"
> +                            "movq %mm0, %mm7\n\t"
> +                            "emms\n");
> +       }
> +       if ( cpu_has_xmm ) {
> +               asm volatile("xorps %xmm0, %xmm0\n\t"
> +                            "xorps %xmm1, %xmm1\n\t"
> +                            "xorps %xmm2, %xmm2\n\t"
> +                            "xorps %xmm3, %xmm3\n\t"
> +                            "xorps %xmm4, %xmm4\n\t"
> +                            "xorps %xmm5, %xmm5\n\t"
> +                            "xorps %xmm6, %xmm6\n\t"
> +                            "xorps %xmm7, %xmm7\n");
>                 load_mxcsr(0x1f80);
> +       }
> 
>         current->used_math = 1;
>  }

Looks good; I just did the same thing ;)

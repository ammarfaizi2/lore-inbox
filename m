Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273784AbSISXWK>; Thu, 19 Sep 2002 19:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273787AbSISXWJ>; Thu, 19 Sep 2002 19:22:09 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:18417 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S273784AbSISXWI>;
	Thu, 19 Sep 2002 19:22:08 -0400
Message-ID: <3D8A5D4A.5D7A1442@mvista.com>
Date: Thu, 19 Sep 2002 16:27:06 -0700
From: Frank Rowand <frowand@mvista.com>
Reply-To: frowand@mvista.com
Organization: Montavista Software, Inc
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Karim Yaghmour <karim@opersys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>, frowand@mvista.com
Subject: Re: [ltt-dev] Re: [PATCH] LTT for 2.5.36 9/9: ARM trace support
References: <3D8A511A.B5F9044F@opersys.com> <20020920001500.E11763@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> You should probably explicitly CC the architecture maintainers with
> these patches.  Generally, there is no guarantee that they'll read
> lkml.
> 
> On Thu, Sep 19, 2002 at 06:35:06PM -0400, Karim Yaghmour wrote:
> > diff -urpN linux-2.5.36/arch/arm/kernel/entry-common.S linux-2.5.36-ltt/arch/arm/kernel/entry-common.S
> > --- linux-2.5.36/arch/arm/kernel/entry-common.S       Tue Sep 17 20:58:42 2002
> > +++ linux-2.5.36-ltt/arch/arm/kernel/entry-common.S   Thu Sep 19 16:29:55 2002
> > @@ -35,6 +35,11 @@ ENTRY(__do_softirq)
> >   * stack.
> >   */
> >  ret_fast_syscall:
> > +#if (CONFIG_TRACE || CONFIG_TRACE_MODULE)
> > +     mov     r7, r0                          @ save returned r0
> > +     bl      SYMBOL_NAME(trace_real_syscall_exit)
> > +     mov     r0, r7
> > +#endif
> 
> This misses the slow syscall exit path.

Thanks, I'll fix that.


> 
> > +#if (CONFIG_TRACE || CONFIG_TRACE_MODULE)
> > +asmlinkage void trace_real_syscall_entry(int scno,struct pt_regs * regs)
> > +{
> > +     int                     depth = 0;
> > +     unsigned long           end_code;
> > +     unsigned long           *fp;                    /* frame pointer */
> > +     unsigned long           lower_bound;
> > +     unsigned long           lr;                     /* link register */
> > +     unsigned long           *prev_fp;
> > +     int                     seek_depth;
> > +     unsigned long           start_code;
> > +     unsigned long           *start_stack;
> > +     trace_syscall_entry     trace_syscall_event;
> > +     unsigned long           upper_bound;
> > +     int                     use_bounds;
> > +     int                     use_depth;
> > +
> > +     trace_syscall_event.syscall_id = (uint8_t)scno;
> > +     trace_syscall_event.address    = instruction_pointer(regs);
> > +
> > +     if (! (user_mode(regs) ))
> > +             goto trace_syscall_end;
> > +
> > +     if (trace_get_config(&use_depth,
> > +                          &use_bounds,
> > +                          &seek_depth,
> > +                          (void*)&lower_bound,
> > +                          (void*)&upper_bound) < 0)
> > +             goto trace_syscall_end;
> > +
> > +     if ((use_depth == 1) || (use_bounds == 1)) {
> > +             fp          = (unsigned long *)regs->ARM_fp;
> 
> You can't rely on FP being set to anything real.  Although the "APCS"
> ABI defines that FP will be either zero or a pointer to a valid frame,
> this isn't always true; a binary built with -fomit-frame-pointer will
> use FP for its own purposes.  This means that there exists the possibility
> for a program without any frames on the stack (although we could be
> many functions deep within the program.)
> 
> Do you care about this?

Yes, but there isn't much we can to about it.  If a program doesn't have
valid frame pointers then we just won't be able to capture a valid
address of where the program made the syscall from.  There are
plenty of paranoia checks to limit the search through the frames (even
with non-existent frame pointers), so this won't be catastrophic.

It looks like I could add one more paranoia check for the initial
value of regs->ARM_fp.


> 
> --
> Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
>              http://www.arm.linux.org.uk/personal/aboutme.html
> 
> _______________________________________________
> ltt-dev mailing list
> ltt-dev@listserv.shafik.org
> http://www.listserv.shafik.org/listserv/listinfo/ltt-dev


Thanks for the comments!

-Frank
-- 
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129111AbRBCAcc>; Fri, 2 Feb 2001 19:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130450AbRBCAcW>; Fri, 2 Feb 2001 19:32:22 -0500
Received: from [62.172.234.2] ([62.172.234.2]:35766 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129439AbRBCAcH>; Fri, 2 Feb 2001 19:32:07 -0500
Date: Sat, 3 Feb 2001 00:31:06 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Richard Gooch <rgooch@atnf.csiro.au>, linux-kernel@vger.kernel.org
Subject: Re: CPU capabilities -- an update proposal
In-Reply-To: <3A7B1B31.1CCED9D9@transmeta.com>
Message-ID: <Pine.LNX.4.21.0102030007170.7970-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2001, H. Peter Anvin wrote:
> 
> > diff -up --recursive --new-file linux-2.4.0-ac12.macro/include/asm-i386/bugs.h linux-2.4.0-ac12/include/asm-i386/bugs.h
> > --- linux-2.4.0-ac12.macro/include/asm-i386/bugs.h      Sun Jan 28 09:41:20 2001
> > +++ linux-2.4.0-ac12/include/asm-i386/bugs.h    Wed Jan 31 22:18:40 2001
> > @@ -83,12 +83,12 @@ static void __init check_fpu(void)
> >                 extern void __buggy_fxsr_alignment(void);
> >                 __buggy_fxsr_alignment();
> >         }
> > -       if (cpu_has_fxsr) {
> > +       if (boot_has_fxsr) {
> >                 printk(KERN_INFO "Enabling fast FPU save and restore... ");
> >                 set_in_cr4(X86_CR4_OSFXSR);
> >                 printk("done.\n");
> >         }
> > -       if (cpu_has_xmm) {
> > +       if (boot_has_xmm) {
> >                 printk(KERN_INFO "Enabling unmasked SIMD FPU exception support... ");
> >                 set_in_cr4(X86_CR4_OSXMMEXCPT);
> >                 printk("done.\n");
> 
> Once you enable OSFXSR (therefore allowing user-space code to issue SSE
> instructions) you *have* to save using FXSAVE, which you can only do if
> *all* CPUs support FXSR.  Therefore, I would say this is a buggy
> change... it is not save to enable OSFXSR unless *all* the CPUs support
> FXSR (they don't have to all support SSE, however, although since you
> can't control which CPU you execute on, it's pretty useless if they
> don't.)

That's nothing new: all Maciej has done there is update the names
of the macros.  Of course you are right, it is in principle unsafe,
and it would be nice to know about all the CPUs before making such
decisions; but I think there are many other choices like that (TSC?
PSE? PGE? PAE?) made on the basis of that first CPU, before the
others have even been booted, and it's not been a serious problem
in practice.  I seem to recall that Intel only support mixed CPU
steppings if the earliest (presumably least capable) is the first
to boot.  It would be quite easy to add a second bugs.h check,
this time on common_x86_capability once all CPUs have booted;
but that may be too late, and I doubt it's worth trying harder.

Hugh

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

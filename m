Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129315AbRBBUlB>; Fri, 2 Feb 2001 15:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129549AbRBBUkv>; Fri, 2 Feb 2001 15:40:51 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:32775 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129315AbRBBUkp>; Fri, 2 Feb 2001 15:40:45 -0500
Message-ID: <3A7B1B31.1CCED9D9@transmeta.com>
Date: Fri, 02 Feb 2001 12:40:17 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Hugh Dickins <hugh@veritas.com>, Richard Gooch <rgooch@atnf.csiro.au>,
        linux-kernel@vger.kernel.org
Subject: Re: CPU capabilities -- an update proposal
In-Reply-To: <Pine.GSO.3.96.1010202161941.28509L-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I like what you have done here, but there are a few things...

> diff -up --recursive --new-file linux-2.4.0-ac12.macro/include/asm-i386/bugs.h linux-2.4.0-ac12/include/asm-i386/bugs.h
> --- linux-2.4.0-ac12.macro/include/asm-i386/bugs.h      Sun Jan 28 09:41:20 2001
> +++ linux-2.4.0-ac12/include/asm-i386/bugs.h    Wed Jan 31 22:18:40 2001
> @@ -83,12 +83,12 @@ static void __init check_fpu(void)
>                 extern void __buggy_fxsr_alignment(void);
>                 __buggy_fxsr_alignment();
>         }
> -       if (cpu_has_fxsr) {
> +       if (boot_has_fxsr) {
>                 printk(KERN_INFO "Enabling fast FPU save and restore... ");
>                 set_in_cr4(X86_CR4_OSFXSR);
>                 printk("done.\n");
>         }
> -       if (cpu_has_xmm) {
> +       if (boot_has_xmm) {
>                 printk(KERN_INFO "Enabling unmasked SIMD FPU exception support... ");
>                 set_in_cr4(X86_CR4_OSXMMEXCPT);
>                 printk("done.\n");

Once you enable OSFXSR (therefore allowing user-space code to issue SSE
instructions) you *have* to save using FXSAVE, which you can only do if
*all* CPUs support FXSR.  Therefore, I would say this is a buggy
change... it is not save to enable OSFXSR unless *all* the CPUs support
FXSR (they don't have to all support SSE, however, although since you
can't control which CPU you execute on, it's pretty useless if they
don't.)

This may mean the code needs to be restructured; I haven't looked at it
in detail.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

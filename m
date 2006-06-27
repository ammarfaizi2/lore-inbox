Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161122AbWF0Put@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161122AbWF0Put (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 11:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161124AbWF0Pus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 11:50:48 -0400
Received: from cantor2.suse.de ([195.135.220.15]:49891 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161122AbWF0Pus (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 11:50:48 -0400
From: Andi Kleen <ak@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [klibc 37/43] x86_64 support for klibc
Date: Tue, 27 Jun 2006 17:49:25 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <klibc.200606251757.37@tazenda.hos.anvin.org> <p73zmfzt2hx.fsf@verdi.suse.de> <44A14844.3010009@zytor.com>
In-Reply-To: <44A14844.3010009@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606271749.25922.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 June 2006 17:01, H. Peter Anvin wrote:
> Andi Kleen wrote:
> > "H. Peter Anvin" <hpa@zytor.com> writes:
> >> +
> >> +#include <asm/signal.h>
> >> +/* The x86-64 headers defines NSIG 32, but it's actually 64 */
> >> +#undef  _NSIG
> >> +#undef  NSIG
> >> +#define _NSIG 64
> >> +#define NSIG  _NSIG
> > 
> > If it's really wrong it should be fixed, not workarounded.
> > 
> 
> It is wrong... include/asm-x86_64/signal.h has cribbed a bit too much 
> from i386:
> 
> ifdef __KERNEL__
> /* Most things should be clean enough to redefine this at will, if care
>     is taken to make libc match.  */
> 
> #define _NSIG           64
> #define _NSIG_BPW       64
> #define _NSIG_WORDS     (_NSIG / _NSIG_BPW)
> 
> typedef unsigned long old_sigset_t;             /* at least 32 bits */
> 
> typedef struct {
>          unsigned long sig[_NSIG_WORDS];
> } sigset_t;
> 
> 
> struct pt_regs;
> asmlinkage int do_signal(struct pt_regs *regs, sigset_t *oldset);
> 
> 
> #else
> /* Here we must cater to libcs that poke about in kernel headers.  */
> 
> #define NSIG            32
> typedef unsigned long sigset_t;
> 
> #endif /* __KERNEL__ */
> #endif
> 
> 
> I can't remove the workaround just yet, since I have active users of the 
> out-of-tree version.  However, I will send you a patch for 
> include/asm-x86_64/signal.h.

Please do.

> >> +
> >> +/* The x86-64 syscall headers are needlessly inefficient */
> >> +
> >> +#undef _syscall0
> >> +#undef _syscall1
> >> +#undef _syscall2
> >> +#undef _syscall3
> >> +#undef _syscall4
> >> +#undef _syscall5
> >> +#undef _syscall6
> > 
> > What do you mean with that?
> > 
> 
> At one point klibc was using the _syscall() macros, and I observed that 
> the x86-64 ones generated extra instructions because of the "movq"s that 
> were hard-coded in the patterns (using register variables, one can make 
> gcc do any moves that may or may not be necessary.)

No you can't. We tried that first, but it generated incorrect code
on older gcc versions. gcc doesn't behave gratefully when an inline
statement takes nearly all register classes (x86-64 has less register
classes than real registers so it's a bit non obvious). I added the 
moves to hide some registers at the advice of gcc hackers.

Maybe you got lucky with newer gcc versions, but I would recommend
to use the standard versions to be backwards compatible.

-Andi

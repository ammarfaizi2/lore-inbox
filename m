Return-Path: <linux-kernel-owner+w=401wt.eu-S965128AbXASNZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128AbXASNZ2 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 08:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965129AbXASNZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 08:25:28 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:43548 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965128AbXASNZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 08:25:27 -0500
X-Originating-Ip: 74.109.98.130
Date: Fri, 19 Jan 2007 08:19:37 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: can someone explain "inline" once and for all?
In-Reply-To: <84144f020701190501x5d1efb49u87dc9537bfe1e791@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0701190805360.25200@CPE00045a9c397f-CM001225dbafb6>
References: <Pine.LNX.4.64.0701190645400.24224@CPE00045a9c397f-CM001225dbafb6>
 <84144f020701190501x5d1efb49u87dc9537bfe1e791@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jan 2007, Pekka Enberg wrote:

> On 1/19/07, Robert P. J. Day <rpjday@mindspring.com> wrote:
> > is there a simple explanation for how to *properly* define inline
> > routines in the kernel?  and maybe this can be added to the
> > CodingStyle guide (he mused, wistfully).
>
> AFAIK __always_inline is the only reliable way to force inlining
> where it matters for correctness (for example, when playing tricks
> with __builtin_return_address like we do in the slab).
>
> Anything else is just a hint to the compiler that might be ignored
> if the optimizer thinks it knows better.

  oh, *that* part i knew.  what i don't understand is the difference
between "inline", "__inline" and "__inline__".  you can see in
include/linux/compiler-gcc4.h:

#ifdef CONFIG_FORCED_INLINING
# undef inline
# undef __inline__
# undef __inline
# define inline                 inline          __attribute__((always_inline))
# define __inline__             __inline__      __attribute__((always_inline))
# define __inline               __inline        __attribute__((always_inline))
#endif

  so that header file certainly suggests that there's some sort of
difference.  after which it gets even more confusing as various macros
seem to mix and match:

  drivers/cdrom/sbpcd.c:#define INLINE inline
  arch/arm/nwfpe/ARM-gcc.h:#define INLINE extern __inline__
  arch/cris/arch-v10/kernel/fasttimer.c:#define __INLINE__ inline
  arch/alpha/mm/fault.c:#define __EXTERN_INLINE inline
  ... etc etc ...

  i mean, how many different kinds of inline *are* there?

rday

p.s.  apparently, some of the alpha people are less than thrilled with
the situation:

include/asm-alpha/compiler.h:
-----------------------------

#ifdef __KERNEL__
/* Some idiots over in <linux/compiler.h> thought inline should imply
   always_inline.  This breaks stuff.  We'll include this file whenever
   we run into such problems.  */

#include <linux/compiler.h>
#undef inline
#undef __inline__
#undef __inline
#undef __always_inline
#define __always_inline         inline __attribute__((always_inline))

#endif /* __KERNEL__ */





Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263182AbUC2Wrb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 17:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbUC2WqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 17:46:18 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:29623 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263171AbUC2Woy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 17:44:54 -0500
Subject: Re: [PATCH] Introduce mask ADT, rebuild cpumask_t and nodemask_t
	[0/22]
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20040329041140.77ce66d2.pj@sgi.com>
References: <20040329041140.77ce66d2.pj@sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1080600241.6742.20.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 29 Mar 2004 14:44:01 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-29 at 04:11, Paul Jackson wrote:
> The following sequence of 22 patches replaces cpumask_t and Matthew
> Dobson's recent nodemask_t with ones based on a new mask ADT.

Still reading through all the patches, but I decided it'd be easier to
reply as I'm reading through since there are so many! ;)  Looks good so
far.  I like the simplifications (reducing the number of 'empty' asm-*
include files that just include the asm-generic routine, added const's,
etc.).


> ==> This code is untested.  Never even booted yet.
>     Code review and testing requested.  I will test
>     on ia64.
> 
>     It has been built, for a default i386 arch only.
>     But it seems far enough along to me to be worth
>     seeking feedback from others.

I'll build & boot these on our NUMAQ (i386) & PPC hardware to try and
shake out any obvious buglets.


> The following patches apply against a 2.6.4 vanilla kernel,
> and result in nodemask code that is (with a couple of details)
> the same as Matthew's.
> 
> All the various include/asm-*/*mask.h files are gone.  The const
> macros are gone.  The promote and coerce macros are replaced
> with a single mask_raw() macro, that simply returns the address
> of the first unsigned long in the mask, to do with as you will.
> 
> There are now only 3 mask header files:
>   include/linux/mask.h - the underlying ADT
>   include/linux/cpumask.h - cpumasks, implemented using mask.h
>   include/linux/nodemask.h - nodemasks, implemented using mask.h

Awesome.  Simplicity makes me happy. :)


> Excluding block comments, the old cpumask code, with Matthew's
> nodemask patch, consumed (in files matching include/*/*mask*.h):
> 
> 	34 files, 683 lines of code
> 
> This new cpumask and nodemask code, and its common mask ADT base,
> consumes a comparable:
> 
> 	3 files, 418 lines of code

Yep.  20 of those are just include/asm-$ARCH/cpumask.h files that just
include include/asm-generic/cpumask.h.  Not a single arch overrides the
default.  I was planning on sending a patch to remove these eventually. 
They won't be missed. ;)  7 cpumask & 7 nodemask implementation files
round out the whopping 34 *mask*.h files.


> The *_complement macros were recoded to take separate source
> and dest arguments, following a suggestion of Bill Irwin.

Very nice.  Aligns the macro with the rest of the *mask_OP() macros
which is a Good Thing(tm).  It will also make my code a little less
wrong. ;)


> Bug fixes include:
>  1) *_complement macros don't leave unused high bits set
>  2) MASK_ALL for sizes > 1 word, but not exact word multiple,
>     doesn't have unused high bits set
>  3) Explicit, documented semantics for handling these unused high bits.

Nice.


>  4) Fixed a nodes_complement() call in Matthew's patches.

Heh...  Ooops.  I actually had a new version I meant to send out on
Friday, but got distracted.  Mostly fixing up the x86_64 & ppc64
versions.  I'll look at your x86_64 fix and send out new patches.


> Also, the assymetry that Matthew's nodemasks had with cpumasks,
> whereby the cpumasks had include/asm-<arch> specific redirecting
> headers for every arch, but nodemasks didn't, has been fixed.
> Now neither one has arch-specific redirect headers.  They aren't
> needed in my view.  Arch specific code belongs in the underlying
> bitops.h header files, and the individual mask macros can be
> elaborated as need be to take advantage of such.

I totally agree.  If no one is reimplementing the macros, all the
arch-specific redirection is useless.

-Matt


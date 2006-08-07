Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWHGGEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWHGGEc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 02:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWHGGEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 02:04:31 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:15583 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751103AbWHGGEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 02:04:31 -0400
Subject: Re: [PATCH 1/4] x86 paravirt_ops: create no_paravirt.h for native
	ops
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200608070730.17813.ak@muc.de>
References: <1154925835.21647.29.camel@localhost.localdomain>
	 <200608070730.17813.ak@muc.de>
Content-Type: text/plain
Date: Mon, 07 Aug 2006 16:04:28 +1000
Message-Id: <1154930669.7642.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-07 at 07:30 +0200, Andi Kleen wrote:
> > ===================================================================
> > --- /dev/null
> > +++ b/include/asm-i386/no_paravirt.h
> 
> I can't say I like the name. After all that should be the normal
> case for a long time now ... native? normal? bareiron?

Yeah, I don't like it much either.  native.h doesn't say what the
alternative is.  native_paravirt.h is kind of contradictory.

> Also I would prefer if you split this file up a bit - the old
> processor/system/irqflags split wasn't too bad.

In the paravirt case, they all come into one ops structure, which has to
be declared in one place.

Of course, those headers can do:

#ifdef CONFIG_PARAVIRT
#include <asm/paravirt.h>
#else
...
#endif

I'll try this and see what happens.  Playing with the x86 headers can be
extremely hairy 8(

> > +
> > +/*
> > + * Set IOPL bits in EFLAGS from given mask
> > + */
> > +static inline void set_iopl_mask(unsigned mask)
> 
> This function can be completely written in C using local_save_flags()/local_restore_flags()
> Please do that. I guess it's still a good idea to keep it separated
> though because it might allow other optimizations.
> 
> e.g. i've been thinking about special casing IF changes in save/restore flags 
> to optimize CPUs which have slow pushf/popf. If you already make sure
> all non IF manipulations of flags are separated that would help.
...
> > +
> > +/*
> > + * Clear and set 'TS' bit respectively
> > + */
> 
> The comment seems out of date (no set TS)
> 
> 
> > +#define clts() __asm__ __volatile__ ("clts")
> > +#define read_cr0() ({ \
> > +	unsigned int __dummy; \
> > +	__asm__ __volatile__( \
> 
> Maybe it's just me, but can't you just drop all these __s around
> asm and volatile? They are completely useless as far I know. 
> 
> Also the assembly will be easier readable if you just keep it on a single 
> line for the simple ones.

I'm just shuffling code here, and if the other approach works, I won't
even be doing that.

But I'm happy to submit a separate patch which cleans these...

Thanks!
Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law


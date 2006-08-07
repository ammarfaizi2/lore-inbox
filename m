Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbWHGFap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbWHGFap (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 01:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWHGFap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 01:30:45 -0400
Received: from cantor2.suse.de ([195.135.220.15]:11412 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751062AbWHGFao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 01:30:44 -0400
From: Andi Kleen <ak@muc.de>
To: virtualization@lists.osdl.org
Subject: Re: [PATCH 1/4] x86 paravirt_ops: create no_paravirt.h for native ops
Date: Mon, 7 Aug 2006 07:30:17 +0200
User-Agent: KMail/1.9.3
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1154925835.21647.29.camel@localhost.localdomain>
In-Reply-To: <1154925835.21647.29.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608070730.17813.ak@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ===================================================================
> --- /dev/null
> +++ b/include/asm-i386/no_paravirt.h

I can't say I like the name. After all that should be the normal
case for a long time now ... native? normal? bareiron?

Also I would prefer if you split this file up a bit - the old
processor/system/irqflags split wasn't too bad.



> +
> +/*
> + * Set IOPL bits in EFLAGS from given mask
> + */
> +static inline void set_iopl_mask(unsigned mask)

This function can be completely written in C using local_save_flags()/local_restore_flags()
Please do that. I guess it's still a good idea to keep it separated
though because it might allow other optimizations.

e.g. i've been thinking about special casing IF changes in save/restore flags 
to optimize CPUs which have slow pushf/popf. If you already make sure
all non IF manipulations of flags are separated that would help.



> +/* Stop speculative execution */
> +static inline void sync_core(void)
> +{
> +	unsigned int eax = 1, ebx, ecx, edx;
> +	__cpuid(&eax, &ebx, &ecx, &edx);
> +}

Actually I don't think this one should be para virtualized at all.
I don't see any reason at all why a hypervisor should trap it and it
is very time critical. I would recommend you move it back into the 
normal files without hooks.

> +
> +/*
> + * Clear and set 'TS' bit respectively
> + */

The comment seems out of date (no set TS)


> +#define clts() __asm__ __volatile__ ("clts")
> +#define read_cr0() ({ \
> +	unsigned int __dummy; \
> +	__asm__ __volatile__( \

Maybe it's just me, but can't you just drop all these __s around
asm and volatile? They are completely useless as far I know. 

Also the assembly will be easier readable if you just keep it on a single 
line for the simple ones.

-Andi

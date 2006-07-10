Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbWGJJgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWGJJgE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 05:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWGJJgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 05:36:04 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:48273 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP id S964848AbWGJJgC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 05:36:02 -0400
Date: Mon, 10 Jul 2006 11:28:52 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Jan Glauber <jan.glauber@de.ibm.com>, linux-kernel@vger.kernel.org,
       systemtap@sources.redhat.com, dwilder@us.ibm.com,
       Mike Grundy <grundym@us.ibm.com>
Subject: Re: [PATCH] kprobes for s390 architecture
Message-ID: <20060710092852.GC9440@osiris.boeblingen.de.ibm.com>
References: <20060623150344.GL9446@osiris.boeblingen.de.ibm.com> <OF44DB398C.F7A51098-ON88257196.007CD277-88257196.007DC8F0@us.ibm.com> <20060623222106.GA25410@osiris.ibm.com> <20060624113641.GB10403@osiris.ibm.com> <1151421789.5390.65.camel@localhost> <20060628055857.GA9452@osiris.boeblingen.de.ibm.com> <20060707172333.GA12068@localhost.localdomain> <20060707172555.GA10452@osiris.ibm.com> <20060708185428.GA26129@localhost.localdomain> <20060708195823.GA4112@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060708195823.GA4112@localhost.localdomain>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int __kprobes swap_instruction(void *aref)
> +{
> +	unsigned long addr, prev, tmp;
> +	int shift;
> +	struct ins_replace_args *args = aref;
> +
> +	addr = (unsigned long) args->ptr;
> +	shift = (2 ^ (addr & 2)) << 3;
> +	addr ^= addr & 2;
> +	asm volatile(
> +		"    l   %0,0(%4)\n"
> +		"    nr  %0,%5\n"
> +                "    lr  %1,%0\n"

Whitespace :)

> +		"    or  %0,%2\n"
> +		"    or  %1,%3\n"
> +		"0:  cs  %0,%1,0(%4)\n"
> +		"    jnl 1f\n"
> +		"    xr  %1,%0\n"
> +		"    nr  %1,%5\n"
> +		"    jnz 0b\n"
> +		"1:"
> +#ifndef __s390x__
> +		".section .fixup,\"ax\"\n"
> +		"2: lhi    %0,%6\n"
> +		"   bras   1,3f\n"
> +		"   .long  1b\n"
> +		"3: l      1,0(1)\n"
> +		"   br     1\n"
> +		".previous\n"
> +		".section __ex_table,\"a\"\n"
> +		"   .align 4\n"
> +		"   .long  0b,2b\n"
> +		".previous"
> +#else /* __s390x__ */
> +		".section .fixup,\"ax\"\n"
> +		"2: lghi   %0,%6\n"
> +		"   jg     1b\n"
> +		".previous\n"
> +		".section __ex_table,\"a\"\n"
> +		"   .align 8\n"
> +		"   .quad  0b,2b\n"
> +		".previous"
> +#endif /* __s390x__ */
> +		: "=&d" (prev), "=&d" (tmp)
> +		: "d" (args->old << shift), "d" (args->new << shift),
> +		  "a" (args->ptr), "d" (~(65535 << shift)), "K" (-EFAULT)
> +		: "memory", "cc" );
> +	return prev >> shift;

You need a label behind the cs instruction and put that into the __ex_table,
since the PSW will point to the instruction after cs if it fails.

Also, on failure this function seems to return -EFAULT >> shift, which
seems to be wrong.

> +EXPORT_SYMBOL(register_die_notifier);
> +EXPORT_SYMBOL(unregister_die_notifier);

_GPL?

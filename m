Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbVFJKfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbVFJKfi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 06:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbVFJKfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 06:35:23 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:41931 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262543AbVFJKdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 06:33:20 -0400
Message-ID: <42A96BA6.1070300@jp.fujitsu.com>
Date: Fri, 10 Jun 2005 19:29:58 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davidm@hpl.hp.com
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, Linas Vepstas <linas@austin.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH 07/10] IOCHK interface for I/O error handling/detecting
References: <42A8386F.2060100@jp.fujitsu.com>	<42A83CF2.90304@jp.fujitsu.com> <17064.32552.507932.62892@napali.hpl.hp.com>
In-Reply-To: <17064.32552.507932.62892@napali.hpl.hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

David Mosberger wrote:
>>>>>>On Thu, 09 Jun 2005 21:58:26 +0900, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com> said:
> 
>   Hidetoshi> +/*
>   Hidetoshi> + * Some I/O bridges may poison the data read, instead of
>   Hidetoshi> + * signaling a BERR.  The consummation of poisoned data
>   Hidetoshi> + * triggers a local, imprecise MCA.
>   Hidetoshi> + * Note that the read operation by itself does not consume
>   Hidetoshi> + * the bad data, you have to do something with it, e.g.:
>   Hidetoshi> + *
>   Hidetoshi> + *	ld.8	r9=[r10];;	// r10 == I/O address
>   Hidetoshi> + *	add.8	r8=r9,r9;;	// fake operation
>   Hidetoshi> + */
>   Hidetoshi> +#define ia64_poison_check(val)					\
>   Hidetoshi> +{	register unsigned long gr8 asm("r8");			\
>   Hidetoshi> +	asm volatile ("add %0=%1,r0" : "=r"(gr8) : "r"(val)); }
>   Hidetoshi> +
>   Hidetoshi> #endif /* CONFIG_IOMAP_CHECK  */
> 
> I have only looked that this briefly and I didn't see off hand where you get
> the "r9=[r10]" sequence from --- I hope you're not relying on the compiler
> happening to generate this sequence!

+static inline unsigned char
+___ia64_readb (const volatile void __iomem *addr)
+{
+    unsigned char val;
+
+    val = *(volatile unsigned char __force *)addr;
+    ia64_poison_check(val);
+
+    return val;
+}

Assigning value from addr to variable val stands for "ld", is it right?
What I want to do here is making sure that ld actually finishs loading data
from memory or mmaped register or far place to general register, and make
sure that the data is healthy enough to operate, not poisoned.

> More importantly: please avoid inline "asm" and use the intrinsics
> defined by gcc_intrin.h instead (if you need something new, we can add
> that), but I think ia64_getreg() will do much of what you want already.

Umm, I think I need something like ia64_setreg(ANYWHERE_DUMMY_REG, val).
How do you think?

Or don't you mind if I move the definition of ia64_poison_check above to
gcc_intrin.h?

Thanks,
H.Seto


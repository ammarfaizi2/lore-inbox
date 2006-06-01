Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030181AbWFAN2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbWFAN2G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 09:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbWFAN2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 09:28:05 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:26879 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S965109AbWFAN2E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 09:28:04 -0400
Subject: Re: 2.6.17-rc5-mm2 link issues on s390
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, arjan@infradead.org
In-Reply-To: <447EE5A4.7050201@fr.ibm.com>
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	 <447EE5A4.7050201@fr.ibm.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Thu, 01 Jun 2006 15:28:02 +0200
Message-Id: <1149168482.5279.34.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-01 at 15:03 +0200, Cedric Le Goater wrote:
> here are small link issues on s390.
> 
>   ...
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> init/built-in.o(.init.text+0x564): In function `start_kernel':
> : undefined reference to `early_init_irq_lock_type'
> lib/built-in.o(.text+0xaf6): In function `__iowrite64_copy':
> : undefined reference to `__raw_writeq'
> make: *** [.tmp_vmlinux1] Error 1

I will try.

> I think the early_init_irq_lock_type() undef is related to the
> lock-validator patch. Shall I just :
>
> --- 2.6.17-rc5-mm2.orig/init/main.c
> +++ 2.6.17-rc5-mm2/init/main.c
> @@ -473,7 +473,9 @@
> 
>         local_irq_disable();
>         early_boot_irqs_off();
> +#ifdef CONFIG_GENERIC_HARDIRQS
>         early_init_irq_lock_type();
> +#endif
> 
> 
> too easy ... the lock-validator should be ported to s390 I guess. What are
> the steps to follow ?

Can't comment on the port issues yet but we plan to add the s390 support
to the lock-validator. It is just a cool debugging tool.

> As for the `__iowrite64_copy', shall we :
> 
> #define writeq(b,addr) (*(volatile unsigned long *) __io_virt(addr) = (b))
> #define __raw_writeq writeq

Seems reasonable. __io_wirt() is a nop, so you are simply writing to the
specified address.

> For the moment, it boots but I'd like to make sure i'm in the right
> direction before sending patches. However, the following one is safe and
> fixes a very small compil issue on s390 in klibc.

Patches that fix compile problems are always fine with me. If it turns
out wrong for some obscure reason we can fix it up later.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.



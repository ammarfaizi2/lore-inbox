Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbUKCASc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbUKCASc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 19:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbUKBXtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 18:49:46 -0500
Received: from verein.lst.de ([213.95.11.210]:5585 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262754AbUKBXqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 18:46:20 -0500
Date: Wed, 3 Nov 2004 00:46:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: uClinux development list <uclinux-dev@uclinux.org>
Cc: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com,
       linux-kernel@vger.kernel.org
Subject: Re: [uClinux-dev] [PATCH 1/14] FRV: Fujitsu FR-V CPU arch implementation
Message-ID: <20041102234610.GB7040@lst.de>
References: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- /warthog/kernels/linux-2.6.10-rc1-bk10/arch/frv/boot/install.sh	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.10-rc1-bk10-frv/arch/frv/boot/install.sh	2004-11-01 11:47:04.635676524 +0000

please don't copy the horrible boot decompressor cludges to new arches.
Why can't your loader support vmlinux.gz files for a new port?

> diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/arch/frv/kernel/irq.c linux-2.6.10-rc1-bk10-frv/arch/frv/kernel/irq.c
> --- /warthog/kernels/linux-2.6.10-rc1-bk10/arch/frv/kernel/irq.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.10-rc1-bk10-frv/arch/frv/kernel/irq.c	2004-11-01 14:09:42.825602343 +0000
> @@ -0,0 +1,1062 @@
> +/* irq.c: FRV IRQ handling
> + *
> + * Copyright (C) 2003, 2004 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +/*
> + * (mostly architecture independent, will move to kernel/irq.c in 2.5.)
> + *
> + * IRQs are in fact implemented a bit like signal handlers for the kernel.
> + * Naturally it's not a 1:1 relation, but there are similarities.
> + */

Please use the generic kernel/irq/* code.

> +void __global_cli(void)
> +{
> +	unsigned int flags;
> +
> +	__save_flags(flags);
> +	if (flags & (1 << EFLAGS_IF_SHIFT)) {
> +		int cpu;
> +		__cli();
> +		cpu = smp_processor_id();
> +		if (!local_irq_count(cpu))
> +			get_irqlock(cpu);
> +	}
> +}

HTF did you managed to get this into a 2.6.x code submission?

> --- /warthog/kernels/linux-2.6.10-rc1-bk10/arch/frv/kernel/nmi.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.10-rc1-bk10-frv/arch/frv/kernel/nmi.c	2004-11-01 11:47:04.683672529 +0000
> @@ -0,0 +1,42 @@
> +/* nmi.c: FRV NMI handler (level 15 external interrupt)
> + *
> + * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/config.h>
> +#include <linux/ptrace.h>
> +#include <linux/errno.h>
> +#include <linux/signal.h>
> +#include <linux/sched.h>
> +#include <linux/ioport.h>
> +#include <linux/interrupt.h>
> +#include <linux/timex.h>
> +#include <linux/smp_lock.h>
> +#include <linux/init.h>
> +#include <linux/kernel_stat.h>
> +#include <linux/irq.h>
> +#include <linux/proc_fs.h>
> +
> +#include <asm/atomic.h>
> +#include <asm/io.h>
> +#include <asm/smp.h>
> +#include <asm/system.h>
> +#include <asm/bitops.h>
> +#include <asm/pgalloc.h>
> +#include <asm/delay.h>
> +#include <asm/irq.h>
> +#include <asm/gdb-stub.h>
> +
> +/*****************************************************************************/
> +/*
> + * deal with the NMI
> + */
> +asmlinkage void do_NMI(void)
> +{
> +} /* end do_IRQ() */

I can't see this beeing called from generic code ever, why do you
implement it?

> +#
> +# If you want the kernel build to build modules outside of the tree
> +# then define this and pass it to the main linux makefile
> +#
> +ifdef EXTRA_MODULE_DIRS
> +SUBDIRS += $(EXTRA_MODULE_DIRS)
> +endif

this is not something that belongs into arch code.

> +#ifdef CONFIG_MMU
> +
> +void *dma_alloc_coherent(struct device *hwdev, size_t size, dma_addr_t *dma_handle, int flag)
> +{
> +	void *ret;
> +	int gfp = GFP_ATOMIC;

the last argument is the gfp mask.

> +	if (hwdev == NULL || hwdev->coherent_dma_mask < 0xffffffff)
> +		gfp |= GFP_DMA;

does GFP_DMA really hae the same meaning as on i386 here?

> --- /warthog/kernels/linux-2.6.10-rc1-bk10/fs/proc/array.c	2004-10-27 17:32:31.000000000 +0100
> +++ linux-2.6.10-rc1-bk10-frv/fs/proc/array.c	2004-11-01 11:47:04.866657296 +0000
> @@ -289,6 +289,9 @@
>  	buffer = task_state(task, buffer);
>   
>  	if (mm) {
> +#if defined(CONFIG_FRV) && defined(CONFIG_MMU)
> +		buffer = proc_pid_status_frv_cxnr(mm, buffer);
> +#endif
>  		buffer = task_mem(mm, buffer);
>  		mmput(mm);

Don't mess with per-arch fields in common procfs files.  And don't ever
try to hide such a change again after an enormous patch otherwise only
adding new code.


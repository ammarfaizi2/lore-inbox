Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751918AbWAEElL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbWAEElL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 23:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbWAEElL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 23:41:11 -0500
Received: from thorn.pobox.com ([208.210.124.75]:37299 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S1751918AbWAEElK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 23:41:10 -0500
Date: Wed, 4 Jan 2006 22:42:27 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       Arnd Bergmann <arndb@de.ibm.com>, linux-kernel@vger.kernel.org,
       Mark Nutter <mnutter@us.ibm.com>, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH 13/13] spufs: set irq affinity for running threads
Message-ID: <20060105044227.GD16729@localhost.localdomain>
References: <20060104193120.050539000@localhost> <20060104194502.253418000@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060104194502.253418000@localhost>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> For far, all SPU triggered interrupts always end up on
> the first SMT thread, which is a bad solution.
> 
> This patch implements setting the affinity to the
> CPU that was running last when entering execution on
> an SPU. This should result in a significant reduction
> in IPI calls and better cache locality for SPE thread
> specific data.

...

> --- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spufs/sched.c
> +++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/sched.c
> @@ -357,6 +357,11 @@ int spu_activate(struct spu_context *ctx
>  	if (!spu)
>  		return (signal_pending(current)) ? -ERESTARTSYS : -EAGAIN;
>  	bind_context(spu, ctx);
> +	/*
> +	 * We're likely to wait for interrupts on the same
> +	 * CPU that we are now on, so send them here.
> +	 */
> +	spu_irq_setaffinity(spu, smp_processor_id());

With CONFIG_DEBUG_PREEMPT this will give a warning about using
smp_processor_id in pre-emptible context if I'm reading the code
correctly.

Maybe use raw_smp_processor_id, since setting the affinity to this cpu
isn't a hard requirement?


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbVKOD4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbVKOD4F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 22:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbVKOD4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 22:56:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23451 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932351AbVKOD4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 22:56:03 -0500
Date: Mon, 14 Nov 2005 19:55:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org, mikey@neuling.org
Subject: Re: [PATCH] Allow arch to veto PC speaker beeper initialization
Message-Id: <20051114195532.3500080b.akpm@osdl.org>
In-Reply-To: <17273.16792.850639.195427@cargo.ozlabs.ibm.com>
References: <17273.16792.850639.195427@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> wrote:
>
> Index: linux-2.6/drivers/input/misc/pcspkr.c
> ===================================================================
> --- linux-2.6.orig/drivers/input/misc/pcspkr.c	2005-10-31 15:16:39.000000000 +1100
> +++ linux-2.6/drivers/input/misc/pcspkr.c	2005-10-31 15:21:13.000000000 +1100
> @@ -66,6 +66,11 @@
>  
>  static int __init pcspkr_init(void)
>  {
> +#ifdef HAS_PCSPKR_ARCH_INIT
> +	int rc = pcspkr_arch_init();
> +	if (rc)
> +		return rc;
> +#endif
>  	pcspkr_dev = input_allocate_device();
>  	if (!pcspkr_dev)
>  		return -ENOMEM;
> Index: linux-2.6/include/asm-powerpc/8253pit.h
> ===================================================================
> --- linux-2.6.orig/include/asm-powerpc/8253pit.h	2005-10-31 15:02:18.000000000 +1100
> +++ linux-2.6/include/asm-powerpc/8253pit.h	2005-10-31 15:20:30.000000000 +1100
> @@ -5,6 +5,19 @@
>   * 8253/8254 Programmable Interval Timer
>   */
>  
> +#include <asm/prom.h>
> +
>  #define PIT_TICK_RATE	1193182UL
>  
> +#define HAS_PCSPKR_ARCH_INIT
> +
> +static inline int pcspkr_arch_init(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, NULL, "pnpPNP,100");
> +	of_node_put(np);
> +	return np ? 0 : -ENODEV;
> +}
> +
>  #endif	/* _ASM_POWERPC_8253PIT_H */

We can avoid all the ifdef nasties by adding

static int pcspkr_arch_init(void) __attribute__((weak))
{
	return 0;
}

in pcspkr.c.

It'll bloat the kernel by a few bytes.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWCVImd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWCVImd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 03:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWCVImd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 03:42:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44226 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751113AbWCVImc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 03:42:32 -0500
Subject: Re: [RFC PATCH 28/35] add support for Xen feature queries
From: Arjan van de Ven <arjan@infradead.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
       virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
In-Reply-To: <20060322063803.621530000@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org>
	 <20060322063803.621530000@sorel.sous-sol.org>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 09:42:29 +0100
Message-Id: <1143016950.2955.22.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 22:31 -0800, Chris Wright wrote:
> plain text document attachment (27-xen-features)
> Add support for parsing and interpreting hypervisor feature
> flags. These allow the kernel to determine what features are provided
> by the underlying hypervisor. For example, whether page tables need to
> be write protected explicitly by the kernel, and whether the kernel
> (appears to) run in ring 0 rather than ring 1. This information allows
> the kernel to improve performance by avoiding unnecessary actions.
> 
> Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
> Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> ---
>  arch/i386/mach-xen/Makefile                 |    2 -
>  arch/i386/mach-xen/features.c               |   29 ++++++++++++++++++++++++++++
>  include/asm-i386/mach-xen/setup_arch_post.h |    2 +
>  include/xen/features.h                      |   20 +++++++++++++++++++
>  4 files changed, 52 insertions(+), 1 deletion(-)
> 
> --- xen-subarch-2.6.orig/arch/i386/mach-xen/Makefile
> +++ xen-subarch-2.6/arch/i386/mach-xen/Makefile
> @@ -4,6 +4,6 @@
>  
>  extra-y				:= head.o
>  
> -obj-y				:= setup.o
> +obj-y				:= setup.o features.o
>   
>  setup-y				:= ../mach-default/setup.o
> --- xen-subarch-2.6.orig/include/asm-i386/mach-xen/setup_arch_post.h
> +++ xen-subarch-2.6/include/asm-i386/mach-xen/setup_arch_post.h
> @@ -40,6 +40,8 @@ static void __init machine_specific_arch
>  {
>  	struct physdev_op op;
>  
> +	setup_xen_features();
> +
>  	HYPERVISOR_shared_info =
>  		(struct shared_info *)__va(xen_start_info->shared_info);
>  	memset(empty_zero_page, 0, sizeof(empty_zero_page));
> --- /dev/null
> +++ xen-subarch-2.6/arch/i386/mach-xen/features.c
> @@ -0,0 +1,29 @@
> +/******************************************************************************
> + * features.c
> + *
> + * Xen feature flags.
> + *
> + * Copyright (c) 2006, Ian Campbell, XenSource Inc.
> + */
> +#include <linux/types.h>
> +#include <linux/cache.h>
> +#include <linux/module.h>
> +#include <asm/hypervisor.h>
> +#include <xen/features.h>
> +
> +u8 xen_features[XENFEAT_NR_SUBMAPS * 32] __read_mostly;
> +EXPORT_SYMBOL(xen_features);

EXPORT_SYMBOL_GPL please; this is very specific, low level functionality



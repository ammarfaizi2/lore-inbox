Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbWHGMFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWHGMFl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 08:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbWHGMFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 08:05:41 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:50119 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750881AbWHGMFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 08:05:40 -0400
Date: Mon, 7 Aug 2006 17:36:58 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Kprobes: Make kprobe modules more portable
Message-ID: <20060807120658.GF15253@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20060807115537.GA15253@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807115537.GA15253@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 05:25:37PM +0530, Ananth N Mavinakayanahalli wrote:
> From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> 
> This patch introduces KPROBE_ADDR, a macro that abstracts out the
> architecture-specific artefacts of getting the correct text address
> given a symbol. While we are at it, also introduce the symbol_name field
> in struct kprobe to allow for users to just specify the address to be
> probed in terms of the kernel symbol. In-kernel kprobes infrastructure
> decodes the actual text address to probe. The symbol resolution happens
> only if the kprobe.addr isn't explicitly specified.

This change was first mooted by Dave Boutcher during his kprobes
tutorial @ OLS. Thanks Dave! (He had also signed off on the patch)

> 
> ---
> Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> Signed-off-by: Prasanna S.P <prasanna@in.ibm.com>

Acked-by: Dave Boutcher <sleddog@us.ibm.com>

> 
> 
> ---
>  include/asm-powerpc/kprobes.h |    2 ++
>  include/linux/kprobes.h       |    8 ++++++++
>  kernel/kprobes.c              |    4 ++++
>  3 files changed, 14 insertions(+)
> 
> Index: linux-2.6.18-rc3/include/asm-powerpc/kprobes.h
> ===================================================================
> --- linux-2.6.18-rc3.orig/include/asm-powerpc/kprobes.h
> +++ linux-2.6.18-rc3/include/asm-powerpc/kprobes.h
> @@ -44,6 +44,8 @@ typedef unsigned int kprobe_opcode_t;
>  #define IS_TDI(instr)		(((instr) & 0xfc000000) == 0x08000000)
>  #define IS_TWI(instr)		(((instr) & 0xfc000000) == 0x0c000000)
>  
> +#define KPROBE_ADDR(name) *((kprobe_opcode_t **)(kallsyms_lookup_name(name)))
> +
>  #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)((func_descr_t *)pentry)
>  
>  #define is_trap(instr)	(IS_TW(instr) || IS_TD(instr) || \
> Index: linux-2.6.18-rc3/include/linux/kprobes.h
> ===================================================================
> --- linux-2.6.18-rc3.orig/include/linux/kprobes.h
> +++ linux-2.6.18-rc3/include/linux/kprobes.h
> @@ -36,6 +36,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/rcupdate.h>
>  #include <linux/mutex.h>
> +#include <linux/kallsyms.h>
>  
>  #ifdef CONFIG_KPROBES
>  #include <asm/kprobes.h>
> @@ -49,6 +50,10 @@
>  /* Attach to insert probes on any functions which should be ignored*/
>  #define __kprobes	__attribute__((__section__(".kprobes.text")))
>  
> +#ifndef KPROBE_ADDR	/* powerpc has its own definition */
> +#define KPROBE_ADDR(name) (kprobe_opcode_t *)(kallsyms_lookup_name(name))
> +#endif	/* KPROBE_ADDR */
> +
>  struct kprobe;
>  struct pt_regs;
>  struct kretprobe;
> @@ -77,6 +82,9 @@ struct kprobe {
>  	/* location of the probe point */
>  	kprobe_opcode_t *addr;
>  
> +	/* Allow user to indicate symbol name of the probe point */
> +	char *symbol_name;
> +
>  	/* Called before addr is executed. */
>  	kprobe_pre_handler_t pre_handler;
>  
> Index: linux-2.6.18-rc3/kernel/kprobes.c
> ===================================================================
> --- linux-2.6.18-rc3.orig/kernel/kprobes.c
> +++ linux-2.6.18-rc3/kernel/kprobes.c
> @@ -446,6 +446,10 @@ static int __kprobes __register_kprobe(s
>  	struct kprobe *old_p;
>  	struct module *probed_mod;
>  
> +	/* Do the kallsyms lookup only if p->addr == NULL */
> +	if (!p->addr && (p->symbol_name))
> +		p->addr = KPROBE_ADDR(p->symbol_name);
> +
>  	if ((!kernel_text_address((unsigned long) p->addr)) ||
>  		in_kprobes_functions((unsigned long) p->addr))
>  		return -EINVAL;

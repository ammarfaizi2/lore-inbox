Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966599AbWK2Jal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966599AbWK2Jal (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 04:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966602AbWK2Jal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 04:30:41 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:11649 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S966599AbWK2Jak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 04:30:40 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] i386-pda UP optimization
Date: Wed, 29 Nov 2006 10:30:56 +0100
User-Agent: KMail/1.9.5
Cc: akpm@osdl.org, Arjan van de Ven <arjan@infradead.org>, ak@suse.de,
       mingo@elte.hu, linux-kernel@vger.kernel.org
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <200611151227.04777.dada1@cosmosbay.com> <456CC25C.6070005@goop.org>
In-Reply-To: <456CC25C.6070005@goop.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611291030.56670.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 November 2006 00:12, Jeremy Fitzhardinge wrote:

> Hi Eric,
>
> Could you try this patch out and see if it makes much performance
> difference for you.  You should apply this on top of the %fs patch I
> posted earlier (and use the %fs patch as the baseline for your
> comparisons).

Hi Jeremy

I will try this as soon as possible, thank you.

However I have some remarks browsing your patch.


> +#ifdef CONFIG_SMP
> +#define LOAD_PDA_SEG(reg)	\
> +	movl $(__KERNEL_PDA), reg; \
> +	movl reg, %fs
> +#define CUR_CPU(reg)	movl %fs:PDA_cpu, reg
> +#else
> +#define LOAD_PDA_SEG(reg)
> +#define CUR_CPU(reg)	movl boot_pda+PDA_cpu, reg

if !CONFIG_SMP, why even dereferencing boot_pda+PDA_cpu to get 0 ?
and as PER_CPU(cpu_gdt_descr, %ebx) in !CONFIG_SMP doesnt need the a value in 
ebx, you can just do :

#define CUR_CPU(reg) /* nothing */


> --- a/include/asm-i386/pda.h	Tue Nov 21 18:54:56 2006 -0800
> +++ b/include/asm-i386/pda.h	Wed Nov 22 02:35:24 2006 -0800
> @@ -22,6 +22,16 @@ extern struct i386_pda *_cpu_pda[];
>

My patch was better IMHO : we dont need to force asm () instructions to 
perform regular C variable reading/writing in !CONFIG_SMP case.

Using plain C allows compiler to generate a better code.

Eric

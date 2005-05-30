Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVE3SqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVE3SqS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 14:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVE3SqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 14:46:18 -0400
Received: from mail.dvmed.net ([216.237.124.58]:38891 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261676AbVE3SpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 14:45:17 -0400
Message-ID: <429B5F2D.9010804@pobox.com>
Date: Mon, 30 May 2005 14:45:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@kvack.org>
CC: ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86-64: Use SSE for copy_page and clear_page
References: <20050530181626.GA10212@kvack.org>
In-Reply-To: <20050530181626.GA10212@kvack.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> Hello Andi,
> 
> Below is a patch that uses 128 bit SSE instructions for copy_page and 
> clear_page.  This is an improvement on P4 systems as can be seen by 
> running the test program at http://www.kvack.org/~bcrl/xmm64.c to get 
> results like:
> 
> SSE test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ buffer = 0x2aaaaaad6000
> clear_page() tests 
> clear_page function 'warm up run'        took 25444 cycles per page
> clear_page function 'kernel clear'       took 6595 cycles per page
> clear_page function '2.4 non MMX'        took 7827 cycles per page
> clear_page function '2.4 MMX fallback'   took 7741 cycles per page
> clear_page function '2.4 MMX version'    took 6454 cycles per page
> clear_page function 'faster_clear_page'  took 4344 cycles per page
> clear_page function 'even_faster_clear'  took 4151 cycles per page
> clear_page function 'xmm_clear '         took 3204 cycles per page
> clear_page function 'xmma_clear '        took 6080 cycles per page
> clear_page function 'xmm2_clear '        took 3370 cycles per page
> clear_page function 'xmma2_clear '       took 6115 cycles per page
> clear_page function 'kernel clear'       took 6583 cycles per page
> 
> copy_page() tests 
> copy_page function 'warm up run'         took 9770 cycles per page
> copy_page function '2.4 non MMX'         took 9758 cycles per page
> copy_page function '2.4 MMX fallback'    took 9572 cycles per page
> copy_page function '2.4 MMX version'     took 9405 cycles per page
> copy_page function 'faster_copy'         took 7407 cycles per page
> copy_page function 'even_faster'         took 7158 cycles per page
> copy_page function 'xmm_copy_page_no'    took 6110 cycles per page
> copy_page function 'xmm_copy_page'       took 5914 cycles per page
> copy_page function 'xmma_copy_page'      took 5913 cycles per page
> copy_page function 'v26_copy_page'       took 9168 cycles per page
> 
> The SSE clear page fuction is almost twice as fast as the kernel's 
> current clear_page, while the copy_page implementation is roughly a 
> third faster.  This is likely due to the fact that SSE instructions 
> can keep the 256 bit wide L2 cache bus at a higher utilisation than 
> 64 bit movs are able to.  Comments?

Sounds pretty darn cool to me.  I can give it a test on athlon64 and 
em64t here.

I have some codingstyle whining to do though...


> :r public_html/patches/v2.6.12-rc4-xmm-2.diff
> diff -purN v2.6.12-rc4/arch/x86_64/lib/c_clear_page.c xmm-rc4/arch/x86_64/lib/c_clear_page.c
> --- v2.6.12-rc4/arch/x86_64/lib/c_clear_page.c	1969-12-31 19:00:00.000000000 -0500
> +++ xmm-rc4/arch/x86_64/lib/c_clear_page.c	2005-05-26 11:16:09.000000000 -0400
> @@ -0,0 +1,45 @@
> +#include <linux/config.h>
> +#include <linux/preempt.h>
> +#include <asm/page.h>
> +#include <linux/kernel.h>
> +#include <asm/string.h>

preferred ordering:

linux/config
linux/kernel
linux/preempt
asm/*


> +typedef struct { unsigned long a,b; } __attribute__((aligned(16))) xmm_store_t;

space between "a,b"


> +void c_clear_page_xmm(void *page)
> +{
> +	/* Note! gcc doesn't seem to align stack variables properly, so we 
> +	 * need to make use of unaligned loads and stores.
> +	 */
> +	xmm_store_t xmm_save[1];
> +	unsigned long cr0;
> +	int i;
> +
> +	preempt_disable();
> +	__asm__ __volatile__ (
> +		" mov %%cr0,%0\n"
> +		" clts\n"
> +		" movdqu %%xmm0,(%1)\n"
> +		" pxor %%xmm0, %%xmm0\n"
> +		: "=&r" (cr0): "r" (xmm_save) : "memory"
> +	);
> +
> +	for(i=0;i<PAGE_SIZE/64;i++)

exercise that spacebar :)


> +	{
> +		__asm__ __volatile__ (
> +		" movntdq %%xmm0, (%0)\n"
> +		" movntdq %%xmm0, 16(%0)\n"
> +		" movntdq %%xmm0, 32(%0)\n"
> +		" movntdq %%xmm0, 48(%0)\n"
> +		: : "r" (page) : "memory");
> +		page+=64;
> +	}
> +
> +	__asm__ __volatile__ (
> +		" sfence \n "
> +		" movdqu (%0),%%xmm0\n"
> +		" mov %1,%%cr0\n"
> +		:: "r" (xmm_save), "r" (cr0)
> +	);
> +	preempt_enable();
> +}
> diff -purN v2.6.12-rc4/arch/x86_64/lib/c_copy_page.c xmm-rc4/arch/x86_64/lib/c_copy_page.c
> --- v2.6.12-rc4/arch/x86_64/lib/c_copy_page.c	1969-12-31 19:00:00.000000000 -0500
> +++ xmm-rc4/arch/x86_64/lib/c_copy_page.c	2005-05-30 14:07:28.000000000 -0400
> @@ -0,0 +1,52 @@
> +#include <linux/config.h>
> +#include <linux/preempt.h>
> +#include <asm/page.h>
> +#include <linux/kernel.h>
> +#include <asm/string.h>
> +
> +typedef struct { unsigned long a,b; } __attribute__((aligned(16))) xmm_store_t;

ditto

> +void c_copy_page_xmm(void *to, void *from)
> +{
> +	/* Note! gcc doesn't seem to align stack variables properly, so we 
> +	 * need to make use of unaligned loads and stores.
> +	 */
> +	xmm_store_t xmm_save[2];
> +	unsigned long cr0;
> +	int i;
> +
> +	preempt_disable();
> +	__asm__ __volatile__ (
> +                " prefetchnta    (%1)\n"
> +                " prefetchnta  64(%1)\n"
> +                " prefetchnta 128(%1)\n"
> +                " prefetchnta 192(%1)\n"
> +                " prefetchnta 256(%1)\n"
> +		" mov %%cr0,%0\n"
> +		" clts\n"
> +		" movdqu %%xmm0,  (%1)\n"
> +		" movdqu %%xmm1,16(%1)\n"
> +		: "=&r" (cr0): "r" (xmm_save) : "memory"
> +	);
> +
> +	for(i=0;i<PAGE_SIZE/32;i++) {

ditto


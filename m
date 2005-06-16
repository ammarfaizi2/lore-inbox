Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbVFPUv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVFPUv2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 16:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbVFPUv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 16:51:28 -0400
Received: from alog0475.analogic.com ([208.224.222.251]:46025 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261805AbVFPUuq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 16:50:46 -0400
Date: Thu, 16 Jun 2005 16:45:42 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: Andrew Morton <akpm@osdl.org>, Walt Drummond <drummond@valinux.com>,
       David Mosberger-Tang <davidm@hpl.hp.com>,
       Stephane Eranian <eranian@hpl.hp.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [resend][PATCH] avoid signed vs unsigned comparison in
 efi_range_is_wc()
In-Reply-To: <Pine.LNX.4.62.0506162219040.2477@dragon.hyggekrogen.localhost>
Message-ID: <Pine.LNX.4.61.0506161629220.3712@chaos.analogic.com>
References: <Pine.LNX.4.62.0506162219040.2477@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well long and int are the same size on ix86. What you really need
is 'size_t' for counters. That's the largest unsigned integer that
will fit in a register on the target platform. It is platform-
specific, therefore defined in stddef.h. No index or return-value
is supposed to be larger than what can be represented in size_t,
therefore it is a good type to use.

Note that on 64-bit platforms, size_t will be larger than an unsigned
int. This is good.

On Thu, 16 Jun 2005, Jesper Juhl wrote:

> I send in the patch below a while back but never recieved any response.
> Now I'm resending it in the hope that it might be added to -mm.
> The patch still applies cleanly to 2.6.12-rc6-mm1
>
> -- 
> Jesper Juhl
>
>
> ---------- Forwarded message ----------
> Date: Fri, 18 Mar 2005 00:43:33 +0100 (CET)
> From: Jesper Juhl <juhl-lkml@dif.dk>
> To: linux-kernel <linux-kernel@vger.kernel.org>
> Cc: Walt Drummond <drummond@valinux.com>,
>    David Mosberger-Tang <davidm@hpl.hp.com>,
>    Stephane Eranian <eranian@hpl.hp.com>
> Subject: [PATCH] avoid signed vs unsigned comparison in efi_range_is_wc()
>
>
> This little function in include/linux/efi.h :
>
> static inline int efi_range_is_wc(unsigned long start, unsigned long len)
> {
>        int i;
>
>        for (i = 0; i < len; i += (1UL << EFI_PAGE_SHIFT)) {
>                unsigned long paddr = __pa(start + i);
>                if (!(efi_mem_attributes(paddr) & EFI_MEMORY_WC))
>                        return 0;
>        }
>        /* The range checked out */
>        return 1;
> }
>
> generates this warning when building with gcc -W :
>
> include/linux/efi.h: In function `efi_range_is_wc':
> include/linux/efi.h:320: warning: comparison between signed and unsigned
>
> It looks to me like a significantly large 'len' passed in could cause the
> loop to never end. Isn't it safer to make 'i' an unsigned long as well?
> Like this little patch below (which of course also kills the warning) :
>
>
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
>
> diff -up linux-2.6.11-mm4-orig/include/linux/efi.h linux-2.6.11-mm4/include/linux/efi.h
> --- linux-2.6.11-mm4-orig/include/linux/efi.h	2005-03-16 15:45:35.000000000 +0100
> +++ linux-2.6.11-mm4/include/linux/efi.h	2005-03-18 00:34:36.000000000 +0100
> @@ -315,7 +315,7 @@ extern struct efi_memory_map memmap;
>  */
> static inline int efi_range_is_wc(unsigned long start, unsigned long len)
> {
> -	int i;
> +	unsigned long i;
>
> 	for (i = 0; i < len; i += (1UL << EFI_PAGE_SHIFT)) {
> 		unsigned long paddr = __pa(start + i);
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262419AbVAZQmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbVAZQmn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 11:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVAZQkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 11:40:18 -0500
Received: from alog0652.analogic.com ([208.224.223.189]:36480 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262351AbVAZQjB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 11:39:01 -0500
Date: Wed, 26 Jan 2005 11:38:15 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Rik van Riel <riel@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       James Antill <james.antill@redhat.com>,
       Bryn Reeves <breeves@redhat.com>
Subject: Re: don't let mmap allocate down to zero
In-Reply-To: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.61.0501261130130.17993@chaos.analogic.com>
References: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2005, Rik van Riel wrote:

> With some programs the 2.6 kernel can end up allocating memory
> at address zero, for a non-MAP_FIXED mmap call!  This causes
> problems with some programs and is generally rude to do. This
> simple patch fixes the problem in my tests.

Does this mean that we can't mmap the screen regen buffer at
0x000b8000 anymore?

How do I look at the real-mode interrupt table starting at
offset 0? You know that the return value of mmap is to be
checked for MAP_FAILED, not for NULL, don't you?

What 'C' standard do you refer to? Seg-faults on null pointers
have nothing to do with the 'C' standard and everything to
do with the platform.

I don't think you should apply this patch. It puts "your"
policy in the kernel. Now, your policy might be "good" for
you, but the kernel is not supposed to have such policy
inside.

>
> Make sure that we don't allocate memory all the way down to zero,
> so the NULL pointer never gets covered up with anonymous memory
> and we don't end up violating the C standard.
>
> Signed-off-by: Rik van Riel <riel@redhat.com>
>
> --- linux-2.6.9/mm/mmap.c.nullmmap	2005-01-25 18:00:26.000000000 -0500
> +++ linux-2.6.9/mm/mmap.c	2005-01-26 08:48:03.438701673 -0500
> @@ -1114,6 +1114,8 @@ void arch_unmap_area(struct vm_area_stru
> 		area->vm_mm->free_area_cache = area->vm_start;
> }
>
> +#define SHLIB_BASE             0x00111000
> +
> /*
>  * This mmap-allocator allocates new areas top-down from below the
>  * stack's low limit (the base):
> @@ -1162,6 +1164,13 @@ try_again:
> 			return addr;
>
> 		/*
> +		 * Make sure we don't allocate all the way down to
> +		 * zero, which would break NULL pointer detection.
> +		 */
> +		if (addr < SHLIB_BASE)
> +			goto fail;
> +
> +		/*
> 		 * new region fits between prev_vma->vm_end and
> 		 * vma->vm_start, use it:
> 		 */
> @@ -1258,8 +1267,6 @@ get_unmapped_area_prot(struct file *file
> EXPORT_SYMBOL(get_unmapped_area_prot);
>
>
> -#define SHLIB_BASE             0x00111000
> -
> unsigned long arch_get_unmapped_exec_area(struct file *filp, unsigned long 
> addr0,
> 		unsigned long len0, unsigned long pgoff, unsigned long flags)
> {
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.

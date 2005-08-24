Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbVHXMMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbVHXMMt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 08:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbVHXMMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 08:12:49 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.17]:42768 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750923AbVHXMMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 08:12:49 -0400
Date: Wed, 24 Aug 2005 14:12:46 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: 2.6.13-rc7 compile failures (was: Re: Fix up mmap of /dev/kmem)
In-Reply-To: <200508132201.j7DM1TAN031499@hera.kernel.org>
Message-ID: <Pine.LNX.4.63.0508241410530.4356@anakin>
References: <200508132201.j7DM1TAN031499@hera.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Aug 2005, Linux Kernel Mailing List wrote:
> Fix up mmap of /dev/kmem
> 
> This leaves the issue of whether we should deprecate the whole thing (or
> if we should check the whole mmap range, for that matter) open. Just do
> the minimal fix for now.
> 
>  drivers/char/mem.c |   12 ++++++++----
>  1 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -261,7 +261,11 @@ static int mmap_mem(struct file * file, 
>  
>  static int mmap_kmem(struct file * file, struct vm_area_struct * vma)
>  {
> -        unsigned long long val;
> +	unsigned long pfn;
> +
> +	/* Turn a kernel-virtual address into a physical page frame */
> +	pfn = __pa((u64)vma->vm_pgoff << PAGE_SHIFT) >> PAGE_SHIFT;
> +
>  	/*
>  	 * RED-PEN: on some architectures there is more mapped memory
>  	 * than available in mem_map which pfn_valid checks

Some (not all!) of my m68k test builds are now failing with:

| linux-m68k-2.6.13-rc7/drivers/char/mem.c: In function `mmap_kmem':
| linux-m68k-2.6.13-rc7/drivers/char/mem.c:267: warning: cast to pointer from integer of different size
| linux-m68k-2.6.13-rc7/drivers/char/mem.c:267: invalid operands to binary <<

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

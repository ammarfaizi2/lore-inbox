Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbVHONEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbVHONEW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 09:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbVHONEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 09:04:22 -0400
Received: from cantor.suse.de ([195.135.220.2]:59819 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751092AbVHONEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 09:04:21 -0400
Date: Mon, 15 Aug 2005 15:04:20 +0200
From: Olaf Hering <olh@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix up mmap of /dev/kmem
Message-ID: <20050815130420.GA521@suse.de>
References: <200508132201.j7DM1TAN031499@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200508132201.j7DM1TAN031499@hera.kernel.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Aug 13, Linux Kernel Mailing List wrote:

> tree e52389322e063c5b784ead6ec314503f7646c765
> parent 2da5bf80f754e28cc153362e5ed1edaa9740897a
> author Linus Torvalds <torvalds@g5.osdl.org> Sun, 14 Aug 2005 04:22:59 -0700
> committer Linus Torvalds <torvalds@g5.osdl.org> Sun, 14 Aug 2005 04:22:59 -0700
> 
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

make all ARCH=um SUBARCH=i386 V=1

This gives 

drivers/char/mem.c: In function 'mmap_kmem':
drivers/char/mem.c:267: error: invalid operands to binary <<



static int mmap_kmem(struct file * file, struct vm_area_struct * vma)
{
 unsigned long pfn;


 pfn = to_phys((void *) (unsigned long) (u64)vma->vm_pgoff << 12) >> 12;
# 276 "drivers/char/mem.c"
 if (!((pfn) < max_mapnr))
  return -5;


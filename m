Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287254AbSA3AQe>; Tue, 29 Jan 2002 19:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287145AbSA3AOs>; Tue, 29 Jan 2002 19:14:48 -0500
Received: from www.transvirtual.com ([206.14.214.140]:26639 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S287163AbSA3ANs>; Tue, 29 Jan 2002 19:13:48 -0500
Date: Tue, 29 Jan 2002 16:13:31 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Daniel Jacobowitz <dan@debian.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <andrea@suse.de>,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH?] Crash in 2.4.17/ptrace
In-Reply-To: <3C572A20.F55DED87@zip.com.au>
Message-ID: <Pine.LNX.4.10.10201291608490.29648-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ah, thanks.  Also I missed sbusfb.c (not that it was fatal - the driver
> got it right anyway).

Great.
 
> Here's the current patch.  After some discussion with Ben
> Herrenschmidt, it now sets VM_IO against the vma *before*
> calling the subdriver's mmap method, just in case the
> driver really does want to clear that flag (presumably, a shadow
> buffer in main memory).

I also thought about it as well. Never thought about the issue with shadow
buffers. Is it safe to move it before if (fb->fb_mmap)? 

> --- linux-2.4.18-pre7/drivers/video/fbmem.c	Fri Dec 21 11:19:14 2001
> +++ linux-akpm/drivers/video/fbmem.c	Tue Jan 29 14:57:00 2002
> @@ -541,6 +541,16 @@ fb_mmap(struct file *file, struct vm_are
>  	if (fb->fb_mmap) {
>  		int res;
>  		lock_kernel();
> +		/*
> +		 * This is an IO map - tell maydump to skip this VMA.
> +		 * If, for some reason, the sub-driver wishes to allow the
> +		 * mapping to be dumpable and accessible via ptrace then
> +		 * it may clear VM_IO later.
> +		 * (This only makes sense if the buffer is actually
> +		 * in main memory, and is described by a page struct in
> +		 * mem_map[])
> +		 */
> +		vma->vm_flags |= VM_IO;
>  		res = fb->fb_mmap(info, file, vma);
>  		unlock_kernel();
>  		return res;


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265826AbUBBWP5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 17:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265830AbUBBWP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 17:15:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:37353 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265826AbUBBWPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 17:15:55 -0500
Date: Mon, 2 Feb 2004 14:17:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix memory leak while coredumping
Message-Id: <20040202141718.48f32dc4.akpm@osdl.org>
In-Reply-To: <20040202105335.DFE88700A2@sv1.valinux.co.jp>
References: <20040202105335.DFE88700A2@sv1.valinux.co.jp>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IWAMOTO Toshihiro <iwamoto@valinux.co.jp> wrote:
>
> Hi,
> 
> with some help of coworker, I found a bug in binfmt_elf.c.
> The bug exists in linux-2.6.1 and linux-2.6.2-rc2-mm2.
> 
> This patch fixes a memory leak that happens when a core file hits the
> process's resource limit.
> I've tested the DUMP_WRITE case only a little, and the DUMP_SEEK case
> is only compile tested.
> 
> --- old/fs/binfmt_elf.c	Fri Jan 16 12:12:24 2004
> +++ new/fs/binfmt_elf.c	Mon Feb  2 19:31:42 2004
> @@ -1441,12 +1441,22 @@
>  				DUMP_SEEK (file->f_pos + PAGE_SIZE);
>  			} else {
>  				if (page == ZERO_PAGE(addr)) {
> -					DUMP_SEEK (file->f_pos + PAGE_SIZE);
> +					if (!dump_seek(file,
> +					    file->f_pos + PAGE_SIZE)) {
> +						page_cache_release(page);
> +						goto end_coredump;
> +					}

There's no point in doing page_cache_release() of the zero page.

>  				} else {
>  					void *kaddr;
>  					flush_cache_page(vma, addr);
>  					kaddr = kmap(page);
> -					DUMP_WRITE(kaddr, PAGE_SIZE);
> +					if ((size += PAGE_SIZE) > limit ||
> +					    !dump_write(file, kaddr,
> +					    PAGE_SIZE)) {
> +						kunmap(page);
> +						page_cache_release(page);
> +						goto end_coredump;
> +					}
>  					kunmap(page);
>  				}
>  				page_cache_release(page);

This chunk is good, thanks.

Those macros are foul.


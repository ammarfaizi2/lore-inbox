Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbTH2RiV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 13:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbTH2RiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 13:38:21 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:54788 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261717AbTH2RiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 13:38:18 -0400
Date: Fri, 29 Aug 2003 19:36:03 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] M68k cache
In-Reply-To: <200308291451.h7TEpE8k005932@callisto.of.borg>
Message-ID: <Pine.LNX.4.44.0308291743280.8124-100000@serv>
References: <200308291451.h7TEpE8k005932@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 29 Aug 2003, Geert Uytterhoeven wrote:

> M68k icache flush fixes from Roman Zippel:
>   - uninline flush_icache_range() and rename it to flush_icache_user_range()
>   - add virt_to_phys_slow() which handles vmalloc()ed space
>   - add flush_icache_range and flush_icache_user_page
> 
> [...]
> 
> --- linux-2.4.23-pre1/kernel/ptrace.c	Wed May 28 13:11:52 2003
> +++ linux-m68k-2.4.23-pre1/kernel/ptrace.c	Fri Jul 25 20:02:39 2003
> @@ -165,7 +165,7 @@
>  		if (write) {
>  			memcpy(maddr + offset, buf, bytes);
>  			flush_page_to_ram(page);
> -			flush_icache_user_range(vma, page, addr, len);
> +			flush_icache_user_page(vma, page, addr, len);
>  			set_page_dirty(page);
>  		} else {
>  			memcpy(buf, maddr + offset, bytes);

Geert, did you intend to include this part?
This part needs an update of all archs includes (to define 
flush_icache_user_page at least as flush_icache_user_range) and the 
changes to binfmt_{elf,aout}.c are part of this patch.
Maybe I should explain the reason behind this patch:
The actual problem is the usage of flush_icache_range(). In 
kernel/module.c it's used to flush data from the kernel cache, in 
binfmt_{elf,aout}.c it's used to flush data from the user cache and in 
both situations it's called with a user space context, so that 
flush_icache_range() doesn't know which cache to flush and I'd really 
like to avoid having to flush both caches.
So the full patch renames flush_icache_range() in binfmt_{elf,aout}.c into 
flush_icache_user_range(), but which already exists, so I renamed this 
into flush_icache_user_page().

bye, Roman


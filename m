Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265098AbSKJTMf>; Sun, 10 Nov 2002 14:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265101AbSKJTMf>; Sun, 10 Nov 2002 14:12:35 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4104 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265098AbSKJTMd>; Sun, 10 Nov 2002 14:12:33 -0500
Date: Sun, 10 Nov 2002 11:18:42 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@suse.cz>
cc: kernel list <linux-kernel@vger.kernel.org>, <ak@suse.de>
Subject: Re: swsusp critical code rewritten to assembly
In-Reply-To: <20021110132122.GA364@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0211101117190.9581-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 10 Nov 2002, Pavel Machek wrote:
> 
> do_magic was really too fragile to be written in C. This patch
> rewrites it into assembly, to make sure C compiler does not generate
> stack access and corrupt memory that way. Plus it cleans up suspend.c
> a bit, makes it really free memory it needs, an no longer calls
> drivers from atomic context.

But this still has stuff in C:

> +	asm volatile ("movl %0, %%esp" :: "m" (saved_context_esp));
> +	asm volatile ("movl %0, %%ebp" :: "m" (saved_context_ebp));
> +	asm volatile ("movl %0, %%eax" :: "m" (saved_context_eax));
> +	asm volatile ("movl %0, %%ebx" :: "m" (saved_context_ebx));
> +	asm volatile ("movl %0, %%ecx" :: "m" (saved_context_ecx));
> +	asm volatile ("movl %0, %%edx" :: "m" (saved_context_edx));
> +	asm volatile ("movl %0, %%esi" :: "m" (saved_context_esi));
> +	asm volatile ("movl %0, %%edi" :: "m" (saved_context_edi));
>  
> -	fix_processor_context();
> +	restore_processor_state();

What's up with that? There's no way you can safely restore regular 
registers and _especially_ %%esp from C code, since the compiler may be 
using them for other things.

		Linus


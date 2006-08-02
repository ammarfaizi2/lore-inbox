Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWHBOnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWHBOnP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 10:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbWHBOnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 10:43:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29360 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750960AbWHBOnP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 10:43:15 -0400
Date: Wed, 2 Aug 2006 07:43:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Blunck <jblunck@suse.de>
Cc: linux-kernel@vger.kernel.org, paulus@samba.org
Subject: Re: [PATCH] fix vmstat per cpu usage
Message-Id: <20060802074308.babd264e.akpm@osdl.org>
In-Reply-To: <20060802133006.GP4995@hasse.suse.de>
References: <20060801173620.GM4995@hasse.suse.de>
	<20060801140707.a55a0513.akpm@osdl.org>
	<20060802133006.GP4995@hasse.suse.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2006 15:30:06 +0200
Jan Blunck <jblunck@suse.de> wrote:

> Here comes another idea. To find further wrong usage of percpu variables I
> wrote the following patch. It still needs some work for the other archs but
> I'm interested in your feedback about that.
> 
> ...
> 
> Index: linux-2.6/include/asm-generic/percpu.h
> ===================================================================
> --- linux-2.6.orig/include/asm-generic/percpu.h
> +++ linux-2.6/include/asm-generic/percpu.h
> @@ -14,7 +14,9 @@ extern unsigned long __per_cpu_offset[NR
>      __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name
>  
>  /* var is in discarded region: offset to particular copy we want */
> -#define per_cpu(var, cpu) (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]))
> +#define per_cpu(var, cpu) (*({				\
> +	int user_error_##var __attribute__ ((unused));	\
> +	RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]); }))

What's it do?  Forces a syntax error if `var' isn't a simple identifier?

Seems sane, although I'd check that the compiler doesn't accidentally
waste a stack slot for that local.  Perhaps it's be safer to make
it a non-existing function:

	extern int user_error#var(void);


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbVLLXog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbVLLXog (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 18:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbVLLXog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 18:44:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22216 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932237AbVLLXof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 18:44:35 -0500
Date: Mon, 12 Dec 2005 15:42:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, bunk@stusta.de
Subject: Re: [PATCH] Introduce atomic_long_t and asm-generic/atomic.h
Message-Id: <20051212154224.10a8c5e4.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0512121028410.14769@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0512121028410.14769@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> +#ifdef ATOMIC64_INIT
> +
> +#define ATOMIC_LONG_INIT(i)	ATOMIC64_INIT(i)
> +#define atomic_long_t		atomic64_t
> +#define atomic_long_read(v)	atomic64_read(v)
> +#define atomic_long_set(v,i)	atomic64_set(v,i)
> +#define atomic_long_inc(v)	atomic64_inc(v)
> +#define atomic_long_dec(v)	atomic64_dec(v)
> +#define atomic_long_add(i,v)	atomic64_add(i,v)
> +#define atomic_long_sub(i,v)	atomic64_sub(i,v)
> +
> +#else
> +
> +#define ATOMIC_LONG_INIT(i)	ATOMIC_INIT(i)
> +#define atomic_long_t		atomic_t
> +#define atomic_long_read(v)	atomic_read(v)
> +#define atomic_long_set(v,i)	atomic_set(v,i)
> +#define atomic_long_inc(v)	atomic_inc(v)
> +#define atomic_long_dec(v)	atomic_dec(v)
> +#define atomic_long_add(i,v)	atomic_add(i,v)
> +#define atomic_long_sub(i,v)	atomic_sub(i,v)
> +
> +#endif

It's sneaky, but it's not really good enough, IMO.

It assumes that sizeof(long) = sizeof(int) ifndef ATOMIC64_INIT.  Which is
true, but there are still problems.  For example, I'd reasonably expect this:

	printk("%ld", atomic_long_read(v));

to not produce a warning.  It may also lead to long*/int* warnings or build
errors.

Also, it kind-of assumes that each 64-bit arch uses `long' for its 64-bit
value.  sh64, for example, appears to use `long long'.


Perhaps all this can be fixed by filling the above macros with typecasts. 
Remember that typecasted lvals are illegal with gcc-4.x.

Or we bite the bullet and implement these guys in each arch...

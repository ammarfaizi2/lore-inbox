Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262341AbVATQfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbVATQfX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 11:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbVATQfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 11:35:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:30674 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262270AbVATQbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 11:31:20 -0500
Date: Thu, 20 Jan 2005 08:31:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Peter Chubb <peterc@gelato.unsw.edu.au>, Chris Wedgwood <cw@f00f.org>,
       Andrew Morton <akpm@osdl.org>, paulus@samba.org,
       linux-kernel@vger.kernel.org, tony.luck@intel.com,
       dsw@gelato.unsw.edu.au, benh@kernel.crashing.org,
       linux-ia64@vger.kernel.org, hch@infradead.org, wli@holomorphy.com,
       jbarnes@sgi.com
Subject: Re: [patch 1/3] spinlock fix #1, *_can_lock() primitives
In-Reply-To: <20050120160839.GA13067@elte.hu>
Message-ID: <Pine.LNX.4.58.0501200823010.8178@ppc970.osdl.org>
References: <16877.42598.336096.561224@wombat.chubb.wattle.id.au>
 <20050119080403.GB29037@elte.hu> <16878.9678.73202.771962@wombat.chubb.wattle.id.au>
 <20050119092013.GA2045@elte.hu> <16878.54402.344079.528038@cargo.ozlabs.ibm.com>
 <20050120023445.GA3475@taniwha.stupidest.org> <20050119190104.71f0a76f.akpm@osdl.org>
 <20050120031854.GA8538@taniwha.stupidest.org> <16879.29449.734172.893834@wombat.chubb.wattle.id.au>
 <Pine.LNX.4.58.0501200747230.8178@ppc970.osdl.org> <20050120160839.GA13067@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Jan 2005, Ingo Molnar wrote:
> 
> anyway, here's my first patch again, with s/trylock_test/can_lock/.

I don't want to break all the other architectures. Or at least not most of 
them. Especially since I was hoping to do a -pre2 soon (well, like today, 
but I guess that's out..) and make the 2.6.11 cycle shorter than 2.6.10.

So I'd like to now _first_ get

>   spin_can_lock(lock)
>   read_can_lock(lock)
>   write_can_lock(lock)

for at least most architectures (ie for me at a minimum that is x86,
x86-64, ia64 and ppc64 - and obviously the "always true" cases for the 
UP version).

Ok?

Also, I've already made sure that I can't apply any half-measures by 
mistake by undoing the mess that it was before, and making sure that any 
patches I get have to be "clean slate".

That said, I like how just the _renaming_ of the thing (and making them 
all consistent) made your BUILD_LOCK_OPS() helper macro much simpler. So 
I'm convinced that this is the right solution - I just want to not screw 
up other architectures.

I can do ppc64 myself, can others fix the other architectures (Ingo, 
shouldn't the UP case have the read/write_can_lock() cases too? And 
wouldn't you agree that it makes more sense to have the rwlock test 
variants in asm/rwlock.h?):

		Linus

> --- linux/include/linux/spinlock.h.orig
> +++ linux/include/linux/spinlock.h
> @@ -584,4 +584,10 @@ static inline int bit_spin_is_locked(int
>  #define DEFINE_SPINLOCK(x) spinlock_t x = SPIN_LOCK_UNLOCKED
>  #define DEFINE_RWLOCK(x) rwlock_t x = RW_LOCK_UNLOCKED
>  
> +/**
> + * spin_can_lock - would spin_trylock() succeed?
> + * @lock: the spinlock in question.
> + */
> +#define spin_can_lock(lock)		(!spin_is_locked(lock))
> +
>  #endif /* __LINUX_SPINLOCK_H */
> --- linux/include/asm-i386/spinlock.h.orig
> +++ linux/include/asm-i386/spinlock.h
> @@ -188,6 +188,18 @@ typedef struct {
>  
>  #define rwlock_is_locked(x) ((x)->lock != RW_LOCK_BIAS)
>  
> +/**
> + * read_can_lock - would read_trylock() succeed?
> + * @lock: the rwlock in question.
> + */
> +#define read_can_lock(x) (atomic_read((atomic_t *)&(x)->lock) > 0)
> +
> +/**
> + * write_can_lock - would write_trylock() succeed?
> + * @lock: the rwlock in question.
> + */
> +#define write_can_lock(x) ((x)->lock == RW_LOCK_BIAS)
> +
>  /*
>   * On x86, we implement read-write locks as a 32-bit counter
>   * with the high bit (sign) being the "contended" bit.
> 

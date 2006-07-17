Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWGQBXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWGQBXV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 21:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWGQBXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 21:23:21 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:16097
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932109AbWGQBXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 21:23:20 -0400
Date: Sun, 16 Jul 2006 18:23:34 -0700 (PDT)
Message-Id: <20060716.182334.30182563.davem@davemloft.net>
To: mrmacman_g4@mac.com
Cc: acahalan@gmail.com, dwmw2@infradead.org, arjan@infradead.org,
       maillist@jg555.com, ralf@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 Headers - Long
From: David Miller <davem@davemloft.net>
In-Reply-To: <6C943713-549B-453C-A0B2-1286764FFE13@mac.com>
References: <787b0d920607151409q4d0dfcc1wc787d9dfe7b0a897@mail.gmail.com>
	<6C943713-549B-453C-A0B2-1286764FFE13@mac.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kyle Moffett <mrmacman_g4@mac.com>
Date: Sun, 16 Jul 2006 08:34:53 -0400

> Both of which may be easily cut and pasted into your GPL programs  
> with little or no effort (Hint: I do this all the time).  Those are  
> so stable you don't even have to maintain it!  IMHO, what you really  
> want, though, is for GCC to export a library of ASM intrinsics (like  
> memory barriers, atomic ops, etc), that are available on your current  
> architecture.  If there is no __gcc_atomic_inc then it wouldn't  
> #define it and you can just go back to pthread_mutex_lock/unlock for  
> protecting an atomic variable.  Such a library layer certainly  
> doesn't belong in the kernel, although if GCC got such a library  
> right the kernel might start to use it (although only the most recent  
> GCC would support it so it wouldn't be very useful).

I agree with your assertions that the stuff in asm/atomic.h should be
steered away from, since they generally are not expected to work in
userspace.  In fact, if you try to use the 32-bit sparc or parisc
ones, it simply won't link because the implementations are external
and use a hash table spinlock scheme which is in the kernel image.

However, the pthread based locking is bad if you want to recover
from arbitrary signals correctly.  I ran into this problem while
trying to get Linux/Sparc Mono working well.

When people want atomic cmpxchg or atomic increment/decrement, they
want a true atomic.  This means either finish the whole thing, or
leave no trace of the atomic having started in the first place.
Spinlock based atomic implementations, which is what a lot of
platforms lacking true atomic use, absolutely cannot reasonably
provide this semantic.

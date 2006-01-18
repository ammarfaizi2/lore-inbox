Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbWARRLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWARRLz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 12:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWARRLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 12:11:55 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:43400 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751386AbWARRLy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 12:11:54 -0500
Message-ID: <43CE76B8.1000905@austin.ibm.com>
Date: Wed, 18 Jan 2006 11:11:20 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <npiggin@suse.de>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/2] powerpc: native atomic_add_unless
References: <20060118063636.GA14608@wotan.suse.de> <20060118063921.GB14608@wotan.suse.de>
In-Reply-To: <20060118063921.GB14608@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I didn't convert LL/SC architectures so as to "encourage" them
> to do atomic_add_unless natively. Here is my probably-wrong attempt
> for powerpc.
> 
> Should I bring this up on the arch list? (IIRC cross posting 
> between there and lkml is discouraged)
> 

You should bring this up on the arch list or it is likely to be missed by people 
who would give you useful feedback.

> +static __inline__ int atomic_add_unless(atomic_t *v, int a, int u)
> +{
> +	int t;
> +	int dummy;
> +
> +	__asm__ __volatile__ (
> +	LWSYNC_ON_SMP

I realize to preserve the behavior you currently get with the cmpxchg currently 
used to implement atomic_add_unless that you feel the need to put in an lwsync & 
isync.  But I would point out that neither is necessary to actually atomic add 
unless.  They are simply so cmpxchg can be overloaded to be used as both a lock 
and unlock primitive.  If atomic_add_unless isn't being used as a locking 
primitive somewhere I would love for these to be dropped.

> +"1:	lwarx	%0,0,%2		# atomic_add_unless\n\
> +	cmpw	0,%0,%4 \n\

This is just personal preference, but I find it more readable to use the 
simplified mnemonic:
cmpw %0, %4

> +	beq-	2f \n\
> +	add	%1,%3,%0 \n"

Why use a separate register here? Why not reuse %0 instead of using %1? 
Registers are valuable.

> +	PPC405_ERR77(0,%2)
> +"	stwcx.	%1,0,%2 \n\
> +	bne-	1b \n"
> +	ISYNC_ON_SMP
> +	"\n\
> +2:"
> +	: "=&r" (t), "=&r" (dummy)
> +	: "r" (&v->counter), "r" (a), "r" (u)
> +	: "cc", "memory");
> +
> +	return likely(t != u);
> +}
> +
>  #define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)


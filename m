Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWARR2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWARR2Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 12:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWARR2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 12:28:25 -0500
Received: from ns1.suse.de ([195.135.220.2]:16076 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751399AbWARR2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 12:28:25 -0500
Date: Wed, 18 Jan 2006 18:28:23 +0100
From: Nick Piggin <npiggin@suse.de>
To: Joel Schopp <jschopp@austin.ibm.com>
Cc: Nick Piggin <npiggin@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/2] powerpc: native atomic_add_unless
Message-ID: <20060118172822.GG28418@wotan.suse.de>
References: <20060118063636.GA14608@wotan.suse.de> <20060118063921.GB14608@wotan.suse.de> <43CE76B8.1000905@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CE76B8.1000905@austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 11:11:20AM -0600, Joel Schopp wrote:
> >I didn't convert LL/SC architectures so as to "encourage" them
> >to do atomic_add_unless natively. Here is my probably-wrong attempt
> >for powerpc.
> >
> >Should I bring this up on the arch list? (IIRC cross posting 
> >between there and lkml is discouraged)
> >
> 
> You should bring this up on the arch list or it is likely to be missed by 
> people who would give you useful feedback.
> 

OK I will if we don't get much discussion going here.

> >+static __inline__ int atomic_add_unless(atomic_t *v, int a, int u)
> >+{
> >+	int t;
> >+	int dummy;
> >+
> >+	__asm__ __volatile__ (
> >+	LWSYNC_ON_SMP
> 
> I realize to preserve the behavior you currently get with the cmpxchg 
> currently used to implement atomic_add_unless that you feel the need to put 
> in an lwsync & isync.  But I would point out that neither is necessary to 
> actually atomic add unless.  They are simply so cmpxchg can be overloaded 
> to be used as both a lock and unlock primitive.  If atomic_add_unless isn't 
> being used as a locking primitive somewhere I would love for these to be 
> dropped.
> 

Well my aim is more to fit in with Documentation/atomic_ops.txt which
basically defines every atomic_xxx function which both modifies the
value and returns something as having a memory barrier either side of it.

I do agree that this is probably overkill (though simple). For example
the dec_and_test common to most refcounting tends not to be a barrier.

> >+"1:	lwarx	%0,0,%2		# atomic_add_unless\n\
> >+	cmpw	0,%0,%4 \n\
> 
> This is just personal preference, but I find it more readable to use the 
> simplified mnemonic:
> cmpw %0, %4
> 

OK. The former appears to be common in atomic.h for some reason... but
I'd be happy to defer that to the maintainers.

> >+	beq-	2f \n\
> >+	add	%1,%3,%0 \n"
> 
> Why use a separate register here? Why not reuse %0 instead of using %1? 
> Registers are valuable.
> 

You still need to get the output (t) because you need to return
whether the operation met with the "unless" case or not. If there is
a better way to do this then I'd like to know.

I couldn't even get it to assign a general register without the dummy
variable - my gcc inline asm is pretty rusty.

Thanks for the feedback,
Nick


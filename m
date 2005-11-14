Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbVKNQaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbVKNQaA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 11:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbVKNQaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 11:30:00 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:34258 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750981AbVKNQ37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 11:29:59 -0500
Date: Mon, 14 Nov 2005 08:29:56 -0800
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 3/5] atomic: atomic_inc_not_zero
Message-Id: <20051114082956.609ff5cd.pj@sgi.com>
In-Reply-To: <4364178E.8040502@yahoo.com.au>
References: <436416AD.3050709@yahoo.com.au>
	<4364171C.7020103@yahoo.com.au>
	<43641755.5010004@yahoo.com.au>
	<4364178E.8040502@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 30, and again on Nov 4, Nick wrote:

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    Index: linux-2.6/arch/sparc/lib/atomic32.c
    ===================================================================
    --- linux-2.6.orig/arch/sparc/lib/atomic32.c
    +++ linux-2.6/arch/sparc/lib/atomic32.c
    @@ -52,6 +52,20 @@ int atomic_cmpxchg(atomic_t *v, int old,
	    return ret;
     }

    +int atomic_add_unless(atomic_t *v, int a, int u)
    +{
    +	int ret;
    +	unsigned long flags;
    +	spin_lock_irqsave(ATOMIC_HASH(v), flags);
    +	ret = v->counter;
    +	if (ret != u)
    +		v->counter += a;
    +	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
    +	return ret != u;
    +}
    +
    +static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
    +/* Atomic operations are already serializing */
     void atomic_set(atomic_t *v, int i)
     {
	    unsigned long flags;
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


Whatever is the meaning of that "static inline ..." line, and
is this the cause of my crosstool sparc compile failure:

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      CC      arch/sparc/lib/atomic32.o
    arch/sparc/lib/atomic32.c: In function `atomic_clear_mask':
    arch/sparc/lib/atomic32.c:72: error: parse error before '{' token
    arch/sparc/lib/atomic32.c:71: error: parm types given both in parmlist and separately
    arch/sparc/lib/atomic32.c:75: error: `flags' undeclared (first use in this function)
    arch/sparc/lib/atomic32.c:75: error: (Each undeclared identifier is reported only once
    arch/sparc/lib/atomic32.c:75: error: for each function it appears in.)
    arch/sparc/lib/atomic32.c: At top level:
    arch/sparc/lib/atomic32.c:75: error: parse error before "while"
    make[1]: *** [arch/sparc/lib/atomic32.o] Error 1
    make: *** [arch/sparc/lib] Error 2
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

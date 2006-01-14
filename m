Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751743AbWANJxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbWANJxu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 04:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbWANJxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 04:53:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51420 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751218AbWANJxu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 04:53:50 -0500
Date: Sat, 14 Jan 2006 01:53:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/17] fuse: add number of waiting requests attribute
Message-Id: <20060114015331.6c4a7618.akpm@osdl.org>
In-Reply-To: <E1ExhxA-0004Bz-00@dorka.pomaz.szeredi.hu>
References: <20060114003948.793910000@dorka.pomaz.szeredi.hu>
	<20060114004114.241169000@dorka.pomaz.szeredi.hu>
	<20060113172846.3ea49670.akpm@osdl.org>
	<E1ExhxA-0004Bz-00@dorka.pomaz.szeredi.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > This doesn't get initialised anywhere.
> > 
> > Presumably you're relying on a memset somewhere.  That might work on all
> > architectures, AFAIK.  But in theory it's wrong.  If, for example, the
> > architecture implements atomic_t via a spinlock-plus-integer, and that
> > spinlock's unlocked state is not all-bits-zero, we're dead.
> > 
> > So we should initialise it with
> > 
> > 	foo->num_waiting = ATOMIC_INIT(0);
> > 
> 
> Is it correct to use a structure initializer this way?

Yes, if it's typecast to the right type.

ATOMIC_INIT is not.  I had a brainfart.

> > nb: it is not correct to initialise an atomic_t with
> > 
> > 	atomic_set(a, 0);
> > 
> > because in the above theoretical case case where the arch uses a spinlock
> > in the atomic_t, that spinlock doesn't get initialised.  I bet we've got code
> > in there which does this.
> 
> According to Documentation/atomic_ops.txt, this is the correct usage
> of atomic_set():
> 
> |           The first operations to implement for atomic_t's are the
> |   initializers and plain reads.
> |   
> |           #define ATOMIC_INIT(i)          { (i) }
> |           #define atomic_set(v, i)        ((v)->counter = (i))
> |   
> |   The first macro is used in definitions, such as:
> |   
> |   static atomic_t my_counter = ATOMIC_INIT(1);
> |   
> |   The second interface can be used at runtime, as in:
> |   
> |           struct foo { atomic_t counter; };
> |           ...
> |   
> |           struct foo *k;
> |   
> |           k = kmalloc(sizeof(*k), GFP_KERNEL);
> |           if (!k)
> |                   return -ENOMEM;
> |           atomic_set(&k->counter, 0);
> 
> So in fact atomic_set() is an initializer, and should be named
> atomic_init() accordingly.

Yes, we're screwed.  I don't think it's possible to implement atomic_t as
spinlock+int due to this.

>  Is atomic_set() ever used as an atomic
> operation rather than an initializer?
> 

Sure, lots of places.  Lots of places where you _don't_ want your
atomic_t's spinlock to be reinitialised.

hmm.

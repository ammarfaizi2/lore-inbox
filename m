Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751670AbWANJoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbWANJoc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 04:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbWANJoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 04:44:32 -0500
Received: from adsl-510.mirage.euroweb.hu ([193.226.239.254]:57772 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751677AbWANJob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 04:44:31 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <20060113172846.3ea49670.akpm@osdl.org> (message from Andrew
	Morton on Fri, 13 Jan 2006 17:28:46 -0800)
Subject: Re: [PATCH 11/17] fuse: add number of waiting requests attribute
References: <20060114003948.793910000@dorka.pomaz.szeredi.hu>
	<20060114004114.241169000@dorka.pomaz.szeredi.hu> <20060113172846.3ea49670.akpm@osdl.org>
Message-Id: <E1ExhxA-0004Bz-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 14 Jan 2006 10:44:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This doesn't get initialised anywhere.
> 
> Presumably you're relying on a memset somewhere.  That might work on all
> architectures, AFAIK.  But in theory it's wrong.  If, for example, the
> architecture implements atomic_t via a spinlock-plus-integer, and that
> spinlock's unlocked state is not all-bits-zero, we're dead.
> 
> So we should initialise it with
> 
> 	foo->num_waiting = ATOMIC_INIT(0);
> 

Is it correct to use a structure initializer this way?

> nb: it is not correct to initialise an atomic_t with
> 
> 	atomic_set(a, 0);
> 
> because in the above theoretical case case where the arch uses a spinlock
> in the atomic_t, that spinlock doesn't get initialised.  I bet we've got code
> in there which does this.

According to Documentation/atomic_ops.txt, this is the correct usage
of atomic_set():

|           The first operations to implement for atomic_t's are the
|   initializers and plain reads.
|   
|           #define ATOMIC_INIT(i)          { (i) }
|           #define atomic_set(v, i)        ((v)->counter = (i))
|   
|   The first macro is used in definitions, such as:
|   
|   static atomic_t my_counter = ATOMIC_INIT(1);
|   
|   The second interface can be used at runtime, as in:
|   
|           struct foo { atomic_t counter; };
|           ...
|   
|           struct foo *k;
|   
|           k = kmalloc(sizeof(*k), GFP_KERNEL);
|           if (!k)
|                   return -ENOMEM;
|           atomic_set(&k->counter, 0);

So in fact atomic_set() is an initializer, and should be named
atomic_init() accordingly.  Is atomic_set() ever used as an atomic
operation rather than an initializer?

Miklos

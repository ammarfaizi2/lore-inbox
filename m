Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265764AbUGMTxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265764AbUGMTxo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 15:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265766AbUGMTxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 15:53:44 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:50679 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S265764AbUGMTxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 15:53:42 -0400
Date: Tue, 13 Jul 2004 20:53:29 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Manfred Spraul <manfred@colorfullife.com>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rmaplock 2/6 SLAB_DESTROY_BY_RCU
In-Reply-To: <40F40F86.5030201@colorfullife.com>
Message-ID: <Pine.LNX.4.44.0407132029540.8535-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jul 2004, Manfred Spraul wrote:
> An interesting idea:
> The slab caches are object caches. If a rcu user only needs a valid 
> object but doesn't care which one then there is no need to wait for a 
> quiescent cycle after free - the quiescent cycle can be delayed until 
> the destructor is called.

Sorry, to be honest, I've not understood you there at all.
I wonder if you're seeing some other use than I intended.

> But there are two flaws in your patch:
> - you must disable poisoning and unmapping if SLAB_DESTROY_BY_RCU is set.

How right you are!  Thank you.  Does the further patch below suit?

> - either delay the dtor calls a well or fail if an object has a non-NULL 
> dtor and SLAB_DESTROY_BY_RCU is set.

Doesn't that rather depend on what the dtor does?  I'm not used to how
destructors are commonly used, but I can easily imagine a destructor
which, say, frees up some attached objects, but still leaves this cache
object recognizably itself, good enough for the reference-after-free
which SLAB_DESTROY_BY_RCU is allowing - all we need to avoid is the
page being freed (or poisoned or unmapped) and reused.  I don't see a
need to prohibit or delay dtor necessarily - but there's no question,
those who make use of this SLAB_DESTROY_BY_RCU technique do still
need to take great care when referencing after free.

Hugh

--- rmaplock6/mm/slab.c	2004-07-12 18:20:35.277828256 +0100
+++ rmaplock7/mm/slab.c	2004-07-13 20:24:27.193884264 +0100
@@ -1196,8 +1196,11 @@ kmem_cache_create (const char *name, siz
 	 */
 	if ((size < 4096 || fls(size-1) == fls(size-1+3*BYTES_PER_WORD)))
 		flags |= SLAB_RED_ZONE|SLAB_STORE_USER;
-	flags |= SLAB_POISON;
+	if (!(flags & SLAB_DESTROY_BY_RCU))
+		flags |= SLAB_POISON;
 #endif
+	if (flags & SLAB_DESTROY_BY_RCU)
+		BUG_ON(flags & SLAB_POISON);
 #endif
 	/*
 	 * Always checks flags, a caller might be expecting debug


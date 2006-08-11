Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWHKVDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWHKVDV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 17:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWHKVDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 17:03:21 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:18835 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751227AbWHKVDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 17:03:20 -0400
Date: Fri, 11 Aug 2006 14:02:54 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, mpm@selenic.com,
       npiggin@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Simple Slab: A slab allocator with minimal meta information
In-Reply-To: <44DCE994.4060102@colorfullife.com>
Message-ID: <Pine.LNX.4.64.0608111355120.19072@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0608091744290.4966@schroedinger.engr.sgi.com>
 <20060810140153.e5932e76.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0608092211320.5806@schroedinger.engr.sgi.com>
 <20060810144451.13591e4b.kamezawa.hiroyu@jp.fujitsu.com>
 <20060810151305.bc4602e0.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0608100823580.8368@schroedinger.engr.sgi.com>
 <44DB7F29.3060901@colorfullife.com> <Pine.LNX.4.64.0608111014470.17885@schroedinger.engr.sgi.com>
 <44DCE994.4060102@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2006, Manfred Spraul wrote:

> Christoph Lameter wrote:
> 
> > I still do not get the role of the shared cache though.
> > 
> The shared cache is just for efficient object transfers:
> Think about two nics, both cpu bound, one does rx, the other does tx.
> Result: a few 100k kmalloc, kmem_cache_alloc(skb_head_cache) calls each second
> on cpu1.
> the same number of kfree, kmem_cache_free(skb_head_cache) calls each second on
> cpu 2.

Hmmm. In that case a faster free/alloc would help since cachelines are not 
shared.

> Initially, the slab allocator just had the cpu cache. Thus an object transfer
> was a free_block call: add the freed object to the bufctl linked list. Move
> the slab to the tail of the partial list. Probably the list_del()/list_add()
> calls caused cache line trashing, but I don't remember the details. IIRC
> Robert Olsson did the test. Pentium III Xeon system?
> Anyway: The solution was the shared array. It allows to move objects around
> with a simple memmove of the pointers, without the list_del()/list_add()
> calls.

But the shared array still needs the list_lock for access. So this is 
avoiding the list operations?

In the case of the simple slab we would have one task continually 
allocating from its slab until its full. If the other task is freeing 
objects in the same slab at the same time then there is lock contention on 
the per cpu slab.

If however there would be sufficient distance between the free and the 
alloc then one task would complete a slab put it back to the full list and 
get it back from the partial list.
The other task would be removing objects from the full slab and move it 
back to the partial list.

In an ideal case we would have two slab continually trading roles with 
separate slab locks. The list lock would only be taken if they switch 
roles.If we can get that going then its the same effect as the shared 
cache.

Hmmm... Hmmm...

Essentially if we discover that a process frees in the cpuslab of another 
then the cpuslab must be detached and the other process must be forced to 
pick another slab for allocation.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262303AbVC3P40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbVC3P40 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 10:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbVC3P4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 10:56:25 -0500
Received: from graphe.net ([209.204.138.32]:22024 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262303AbVC3Pz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 10:55:58 -0500
Date: Wed, 30 Mar 2005 07:55:29 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: Manfred Spraul <manfred@colorfullife.com>
cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, shai@scalex86.org
Subject: Re: API changes to the slab allocator for NUMA memory allocation
In-Reply-To: <424A3FA0.9030403@colorfullife.com>
Message-ID: <Pine.LNX.4.58.0503300748320.12816@server.graphe.net>
References: <20050315204110.6664771d.akpm@osdl.org> <42387C2E.4040106@colorfullife.com>
 <273220000.1110999247@[10.10.2.4]> <4238845E.5060304@colorfullife.com>
 <Pine.LNX.4.58.0503292126050.32140@server.graphe.net> <424A3FA0.9030403@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2005, Manfred Spraul wrote:

> >The patch makes the following function calls available to allocate memory on
> >a specific node without changing the basic operation of the slab
> >allocator:
> >
> > kmem_cache_alloc_node(kmem_cache_t *cachep, unsigned int flags, int node);
> > kmalloc_node(size_t size, unsigned int flags, int node);

> I intentionally didn't add a kmalloc_node() function:
> kmalloc is just a wrapper around
> kmem_find_general_cachep+kmem_cache_alloc. It exists only for
> efficiency. The _node functions are slow, thus a wrapper is IMHO not
> required. kmalloc_node(size,flags,node) is identical to
> kmem_cache_alloc(kmem_find_general_cachep(size,flags),flags,node). What
> about making kmem_find_general_cachep() public again and removing
> kmalloc_node()?

kmalloc is the function in use by most kernel code. kmalloc_node makes the
use of node specific allocations easy. Yes node functions are slow at
this point but we will submit additional patches that will address those
issues. The patch makes it easy for a variety of kernel modules to use
node specific memory allocations. With this patch we will be able to
submit patches that enhance the speed of the slab allocator as well as
patches that make subsystems use node specific memory at the same time.

> And I don't know if it's a good idea to make kmalloc() a special case of
> kmalloc_node(): It adds one parameter to every kmalloc call and
> kmem_cache_alloc call, virtually everyone passes -1. Does it increase
> the .text size?

The -1 is optimized away for the non NUMA case. In the NUMA case its an
additional parameter that is passed to kmem_cache_alloc. So its one
additional register load that allows us to not have an additional function
for the case non node specific allocations.


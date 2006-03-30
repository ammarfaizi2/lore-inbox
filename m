Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWC3JvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWC3JvF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 04:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWC3JvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 04:51:04 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:51373 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751333AbWC3JvD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 04:51:03 -0500
Date: Thu, 30 Mar 2006 10:50:48 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, bharata@in.ibm.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: dcache leak in 2.6.16-git8 II
Message-ID: <20060330095048.GW27946@ftp.linux.org.uk>
References: <200603270750.28174.ak@suse.de> <200603271822.28043.ak@suse.de> <20060327190027.24498e3a.akpm@osdl.org> <200603300026.59131.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603300026.59131.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 12:26:58AM +0200, Andi Kleen wrote:
> dentry_cache      999168 1024594    208   19    1 : tunables  120   60    8 : slabdata  53926  53926      0 : shrinker stat 18522624 8871000
> 
> Hrm interesting is this one:
> 
> sock_inode_cache  996784 996805    704    5    1 : tunables   54   27    8 : slabdata 199361 199361      0
> 
> Most of the leaked dentries seem to be sockets. I didn't notice this earlier.

ITYM "all".  You've got 2384 non-socket dentries, which is about what I'd
expect on severely pressured busy system...
 
> This was with the debugging patches applied btw. 
> 
> So maybe we have a socket leak?

Looks like that.  Note: /proc/slab_allocators won't help here; all allocations
into that cache are done from sock_alloc_inode(), which is what will be shown.
Not useful...  Moreover, call chain is predictable several steps deeper than
that: sock_alloc_inode() (as ->alloc_inode()) from alloc_inode() from
new_inode() from sock_alloc().

FWIW...  One thing that might be useful here:

a) slab_set_creator(objp, cachep, address): no-op unless DEBUG_SLAB_LEAK set,
void slab_set_creator(void *objp, struct kmem_cache *cachep, void *address)
{
        if (cachep->flags & SLAB_STORE_USER)
                *dbg_userword(cachep, objp) = address;
}
otherwise (has to be function in mm/slab.c; exported).

b)
void slab_charge_here(void *objp, struct kmem_cache *cachep, void *address)
{
	slab_set_creator(objp, cachep, __builtin_return_address(0));
}
in mm/slab.c (exported)

c) #define slab_charge_caller(objp, cachep) \
	slab_set_creator((objp), (cachep), __builtin_return_address(0))


Then we can do the following: in sock_alloc() have
	slab_charge_caller(container_of(inode, struct socket_alloc, vfs_inode),
			   sock_inode_cachep);

and _then_ /proc/slab_allocators will charge these guys to callers of
sock_alloc(); if you'll need to pursue it further, you can always slap
more slab_charge_...() where needed.

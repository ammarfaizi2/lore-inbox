Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265809AbUFIP6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265809AbUFIP6U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 11:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266166AbUFIP6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 11:58:20 -0400
Received: from cantor.suse.de ([195.135.220.2]:49616 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265809AbUFIP6J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 11:58:09 -0400
Date: Wed, 9 Jun 2004 17:56:13 +0200
From: Andi Kleen <ak@suse.de>
To: Anton Blanchard <anton@samba.org>
Cc: manfred@colorfullife.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use numa policy API for boot time policy
Message-Id: <20040609175613.487903b5.ak@suse.de>
In-Reply-To: <20040609154429.GA6152@krispykreme>
References: <20040605034356.1037d299.ak@suse.de>
	<40C12865.9050803@colorfullife.com>
	<20040605041813.75e2d22d.ak@suse.de>
	<20040605023211.GA16084@krispykreme>
	<20040605122239.4a73f5e8.ak@suse.de>
	<20040609154429.GA6152@krispykreme>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2004 01:44:29 +1000
Anton Blanchard <anton@samba.org> wrote:

>  
> > It would be a one liner change to allow process policy interleaving 
> > for orders > 0 in mempolicy. But I'm not sure how useful it is, since
> > the granuality would be really bad.
> 
> OK. Id like to take a quick look at order > 0 allocations during boot
> to see if its worth it. The ppc64 page size is small and we might be
> doing a significant number of order 1 allocations.

For what? 

> > Have you ever tried to switch to implement a vmalloc_interleave() for these
> > tables instead? My bet is that it will perform better.
> 
> Im warming to this idea. We would need a per arch override, since there
> is a trade off here between interleaving and TLB usage.

Actually just standard vmalloc is enough. The interleave policy in alloc_pages
will transparently interleave the order 0 pages allocated by vmalloc.

When I find some time I will try that on Opteron too.

> 
> We also have a problem in 2.6 on our bigger machines where our dcache
> hash and inode hash cache are limited to MAX_ORDER (16MB on ppc64). By
> using vmalloc would allow us to interleave the memory and allocate more
> than 16MB for those hashes.

IMHO 16MB hash table for a kernel structure is madness. A different data
structure is probably needed if it's really a problem
(is your dcache that big?). Or maybe just limit the dcache more aggressively
to keep the max number of entries smaller.

-Andi

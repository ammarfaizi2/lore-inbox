Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263657AbTETJxF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 05:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263658AbTETJxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 05:53:05 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:59451 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263657AbTETJxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 05:53:04 -0400
Date: Tue, 20 May 2003 03:08:24 -0700
From: Andrew Morton <akpm@digeo.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dentry/inode accounting for vm_enough_mem()
Message-Id: <20030520030824.39235b00.akpm@digeo.com>
In-Reply-To: <1053391863.12309.2.camel@nighthawk>
References: <1053391863.12309.2.camel@nighthawk>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 May 2003 10:05:59.0505 (UTC) FILETIME=[698AAC10:01C31EB7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> wrote:
>
> +void inode_dtor(void * objp, struct kmem_cache_s *cachep, unsigned long dflags)
>  +{
>  +	atomic_dec(&inodes_stat.nr_alloced);
>   }

This isn't called anywhere.

inodes are a problem, because their sizes differ, and because each
filesystem uses its own slab cache for them.

I'm wondering if it would not be better to modify slab to do this.  For all
the inode caches and the dentry cache and the mb cache and that new
shrinkable cache which just got added to XFS, we can pass a new flag into
kmem_cache_create() which tells slab.c to account for this cache.

So then, in slab.c, it's just a matter of incrementing or decrementing a
global counter each time slab allocates or frees a page on behalf of a
thus-tagged cache.  And simply read that counter in vm_enough_memory().




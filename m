Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbTKPUGj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 15:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbTKPUGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 15:06:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:42681 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262762AbTKPUGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 15:06:38 -0500
Date: Sun, 16 Nov 2003 12:11:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Jesse Barnes <jbarnes@sgi.com>
Subject: Re: Bootmem broke ARM
Message-Id: <20031116121131.0796cf01.akpm@osdl.org>
In-Reply-To: <20031116101535.A592@flint.arm.linux.org.uk>
References: <20031116101535.A592@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> Andrew & others,
> 
> 2.6 contains a change to init_bootmem_core() which now sorts the nodes
> according to their start pfn.  This change occurred in revision 1.20 of
> bootmem.c.  Unfortunately, this active sorting broke ARM discontig memory
> support.
> 
> With previous kernels, the nodes are added to the list in reverse order,
> so architecture code knew we had to add the highest PFN first and the
> lowest PFN node last.
> 
> However, we now sort the nodes using node_start_pfn, which, at this point,
> will be uninitialised - the responsibility for initialising this field
> is with the generic code - in free_area_init_node() which occurs well
> after bootmem has been initialised.
> 
> The result of this change is that we now add nodes to the tail of the
> pgdat list, which is the opposite way to 2.4.
> 
> This causes problems for ARM because we need to use bootmem to initialise
> the kernels page tables, and we can only allocate these from node 0 - none
> of the other nodes are mapped into memory at this point.
> 
> I, therefore, believe this change is bogus.  Can it be reverted please?
> 

It looks to be bogus on ia64 as well, for which the patch was written.

Or maybe ia64 _does_ arrange for the node_start_pfn to be initialised
before init_bootmem_core(), but I cannot see where.  So the attempt to sort
the pgdat list in there doesn't actually sort it at all - it simply
reverses it by accident.

Jesse, it looks like this needs to be revisited please.

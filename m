Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbUDDBnY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 20:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbUDDBnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 20:43:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:50624 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262103AbUDDBnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 20:43:22 -0500
Date: Sat, 3 Apr 2004 17:43:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: hugh@veritas.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: anon-vma (and now filebacked-mappings too) mprotect vma merging
 [Re:    2.6.5-rc2-aa vma merging]
Message-Id: <20040403174312.16e4537d.akpm@osdl.org>
In-Reply-To: <20040404013245.GT2307@dualathlon.random>
References: <20040403184639.GN2307@dualathlon.random>
	<Pine.LNX.4.44.0404031954250.10509-100000@localhost.localdomain>
	<20040404010147.GS2307@dualathlon.random>
	<20040403171358.5dec3987.akpm@osdl.org>
	<20040404013245.GT2307@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Sat, Apr 03, 2004 at 05:13:58PM -0800, Andrew Morton wrote:
> > That change was made for scheduling latency reasons, mainly due to huge
> > pagetable walks in zap_page_range():
> > 
> >     i_shared_lock is held for a very long time during vmtruncate() and
> >     causes high scheduling latencies when truncating a file which is
> >     mmapped.  I've seen 100 milliseconds.
> > 
> >     So turn it into a semaphore.  It nests inside mmap_sem.  This
> >     change is also needed by the shared pagetable patch, which needs to
> >     unshare pte's on the vmtruncate path - lots of pagetable pages need to
> >     be allocated and they are using __GFP_WAIT.
> > 
> > If we no longer hold that lock during pte takedown then sure, it would
> > be better if we had a spinlock in there.
> 
> agreed, vmtruncate may still be very costly due the pte scan, so
> I was probably wrong about not needing the semaphore anymore with
> prio-tree (I was too objrmap centric, and after all objrmap with the
> trylocks threats it like a spinlock anyways), though the semaphore
> cannot help the latency of the non-contention case (I mean with preempt
> disabled), that seem to have room for improvements with a cond_sched()
> before returning from invalidate_mmap_range_list not present yet.

<looks>

Actually I was a bit harsh to the !CONFIG_PREEMPT case in unmap_vmas():

/* No preempt: go for the best straight-line efficiency */
#if !defined(CONFIG_PREEMPT)
#define ZAP_BLOCK_SIZE	(~(0UL))
#endif

We should probably make that 1024*PAGE_SIZE or something like that.

truncate_inode_pages() does a cond_resched() every 16 pages irrespective of
CONFIG_PREEMPT.


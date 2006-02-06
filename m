Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWBFW2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWBFW2Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 17:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWBFW2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 17:28:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37511 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932398AbWBFW2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 17:28:23 -0500
Date: Mon, 6 Feb 2006 14:30:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: ak@suse.de, pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: OOM behavior in constrained memory situations
Message-Id: <20060206143022.37d1781e.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0602061415560.18919@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602061253020.18594@schroedinger.engr.sgi.com>
	<20060206131026.53dbd8d5.akpm@osdl.org>
	<200602062222.28630.ak@suse.de>
	<Pine.LNX.4.62.0602061415560.18919@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> On Mon, 6 Feb 2006, Andi Kleen wrote:
> 
> > At least remnants from my old 80% hack to avoid this (huge_page_needed)
> > seem to be still there in mainline:
> > 
> > fs/hugetlbfs/inode.c:hugetlbfs_file_mmap
> > 
> >    bytes = huge_pages_needed(mapping, vma);
> >    if (!is_hugepage_mem_enough(bytes))
> >           return -ENOMEM;
> > 
> > 
> > So something must be broken if this doesn't work. Or did you allocate
> > the pages in some other way? 
> 
> huge pages are now allocated in the huge fault handler. If it would be 
> returning an OOM then the OOM killer may be activated.

?

The oom-killer is invoked from the page allocator.  A hugetlb pagefault
won't use the page allocator.  So there shouldn't be an oom-killing on
hugepage exhaustion.

I think this comment is just wrong:

		/* Logically this is OOM, not a SIGBUS, but an OOM
		 * could cause the kernel to go killing other
		 * processes which won't help the hugepage situation
		 * at all (?) */

A VM_FAULT_OOM from there won't cause the oom-killer to do anything.  We
should return VM_FAULT_OOM and let do_page_fault() commit suicide with
SIGKILL.

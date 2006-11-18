Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754617AbWKRNze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617AbWKRNze (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 08:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754621AbWKRNze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 08:55:34 -0500
Received: from excu-mxob-2.symantec.com ([198.6.49.23]:162 "EHLO
	excu-mxob-2.symantec.com") by vger.kernel.org with ESMTP
	id S1754617AbWKRNze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 08:55:34 -0500
X-AuditID: c6063117-a07e5bb00000257a-46-455f10d55439 
Date: Sat, 18 Nov 2006 13:55:54 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Francis Moreau <francis.moro@gmail.com>
cc: a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org
Subject: Re: Re : vm: weird behaviour when munmapping
In-Reply-To: <38b2ab8a0611171301pe16229ch441ec24c538b1998@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0611181340220.7193@blonde.wat.veritas.com>
References: <38b2ab8a0611171301pe16229ch441ec24c538b1998@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 18 Nov 2006 13:55:33.0288 (UTC) FILETIME=[3747AA80:01C70B19]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2006, Francis Moreau wrote:
> On Fri, 2006-11-17 at 14:12 +0000, moreau francis wrote:
> > Peter Zijlstra wrote:
> >
> > The new object is the one allocated using:
> > new = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
> 
> Of course but at this point the choice of the new VMA is already made
> by the caller. So in our case do_munmap() decided that B is the new
> one as you said. But I still don't see why...

split_vma decides which address range will use the newly allocated
vm_area_struct in such a way as to suit its own convenience, and
that of mremap's move_vma.  "new" is the name of a variable in
split_vma, you should stop agonizing over it.

> 
> And as I said previously it will end up by calling consecutively:
> 
>        vma->vm_ops->open(B)
>        vma->vm_ops->close(B)

You are attaching too much significance to the current address
of the vma which is passed to your driver in open and close.
As mmap.c splits and merges vmas, in response to system calls
unmapping and mapping, those addresses will change.

The important thing is the info contained within the vma: perhaps
your underlying complaint is that your driver is not getting as
much info as it wants about what's happening?

I think (haven't searched) most drivers, if they care at all,
only care about the total number of their vmas: can free
resources when that count goes down to 0.

Hugh

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267310AbUHPAOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267310AbUHPAOu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 20:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267303AbUHPANW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 20:13:22 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:23256 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267298AbUHPAMr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 20:12:47 -0400
Date: Sun, 15 Aug 2004 17:11:53 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: "David S. Miller" <davem@redhat.com>
cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault fastpath: Increasing SMP scalability by introducing
 pte locks?
In-Reply-To: <20040815165827.0c0c8844.davem@redhat.com>
Message-ID: <Pine.LNX.4.58.0408151703580.3751@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
 <20040815130919.44769735.davem@redhat.com> <Pine.LNX.4.58.0408151552280.3370@schroedinger.engr.sgi.com>
 <20040815165827.0c0c8844.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 15 Aug 2004, David S. Miller wrote:
> > On Sun, 15 Aug 2004, David S. Miller wrote:
> > > Is the read lock in the VMA semaphore enough to let you do
> > > the pgd/pmd walking without the page_table_lock?
> > > I think it is, but just checking.
> >
> > That would be great.... May I change the page_table lock to
> > be a read write spinlock instead?
>
> No, I means "is the read long _ON_ the VMA semaphore".
> The VMA semaphore is a read/write semaphore, and we grab
> it for reading in the code path you're modifying.
>
> Please don't change page_table_lock to a rwlock, it's
> only needed for write accesses.

pgd/pmd walking should be possible always even without the vma semaphore
since the CPU can potentially walk the chain at anytime.

The modification of the pte is not without issue since there are other
code paths that may modify pte's and rely on the page_table_lock to
exclude others from modifying ptes. One known problem is the swap
code which sets the page to the pte_not_present condition to insure that
nothing else touches the page while it is figuring out where to put it. A
page fault during that time (skipping the checking of the
page_table_lock) will cause the fastpath to be taken which will then
assign new memory to it.

We need to have some kind of system how finer granularity locks could be
realized.

One possibility is to abuse the rw spinlock to not only allow exclusive
access to the page tables(as done right now with the spinlock) but also
allow shared access with pte locking after a read lock.

Is there any other way to realize this?



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbTE2FoZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 01:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbTE2FoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 01:44:25 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:13030 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S261916AbTE2FoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 01:44:16 -0400
Date: Thu, 29 May 2003 06:59:47 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
cc: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Inline vm_acct_memory
In-Reply-To: <20030529044312.GG5604@in.ibm.com>
Message-ID: <Pine.LNX.4.44.0305290656010.1317-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 May 2003, Ravikiran G Thirumalai wrote:
> 
> Yeah I kinda overlooked vm_unacct_memory 'til I wondered why I had put
> the inlines in the header file earlier :).  But I do have the profiles
> and checking on all calls to vm_unacct_memory, I find there is no 
> regression at significant callsites.  
> I can provide the detailed profile if required,
> but here is the summary for 4 runs of kernbench -- nos against routines
> are profile ticks (oprofile) for 4 runs.
> 
> Vanilla
> -------
> vm_enough_memory 786 778 780 735
> vm_acct_memory	870 952 884 898
> -----------------------------------
> tot of above    1656 1730 1664 1633
> 
> do_mmap_pgoff 	3559 3673 3669 3807
> expand_stack	27 34 33 42
> unmap_region	236 267 280 280
> do_brk		594 596 615 615
> exit_mmap	51 52 44 52	
> mprotect_fixup	47 55 55 57
> do_mremap	0 2 1 1
> poll_idle	101553 108687 89281 86251
> 
> Inline
> ------
> vm_enough_memory 1539 1488 1488 1472
> do_mmap_pgoff 	3510 3523 3436 3475
> expand_stack	27 33 32 27
> unmap_region	295 340 311 349
> do_brk		641 583 659 640
> exit_mmap	33 52 44 42
> mprotect_fixup	54 65 73 64
> do_mremap	2 0 0 0
> poll_idle	98733 85659 104994 103096

There does look to be a regression in unmap_region.

Though I'd be reluctant to assign much general significance
to any of these numbers (suspect it might all come out quite
differently on another machine, another config, another run).

But the probable best course is just to inline vm_acct_memory
as you did, but also uninline vm_unacct_memory: placing the
static inline vm_acct_memory and then vm_unacct_memory just
before vm_enough_memory in mm/mmap.c.

Hugh



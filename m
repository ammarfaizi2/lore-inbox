Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbTE2J2P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 05:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbTE2J2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 05:28:14 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:15517 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262028AbTE2J2N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 05:28:13 -0400
Date: Thu, 29 May 2003 15:22:20 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Inline vm_acct_memory
Message-ID: <20030529095220.GA21263@in.ibm.com>
References: <20030529044312.GG5604@in.ibm.com> <Pine.LNX.4.44.0305290656010.1317-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305290656010.1317-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 06:59:47AM +0100, Hugh Dickins wrote:
> On Thu, 29 May 2003, Ravikiran G Thirumalai wrote:
> > ...
> > Vanilla
> > -------
> > vm_enough_memory 786 778 780 735
> > vm_acct_memory	870 952 884 898
> > -----------------------------------
> > tot of above    1656 1730 1664 1633
> > 
> > do_mmap_pgoff 	3559 3673 3669 3807
> > expand_stack	27 34 33 42
> > unmap_region	236 267 280 280
> > do_brk		594 596 615 615
> > exit_mmap	51 52 44 52	
> > mprotect_fixup	47 55 55 57
> > do_mremap	0 2 1 1
> > poll_idle	101553 108687 89281 86251
> > 
> > Inline
> > ------
> > vm_enough_memory 1539 1488 1488 1472
> > do_mmap_pgoff 	3510 3523 3436 3475
> > expand_stack	27 33 32 27
> > unmap_region	295 340 311 349
> > do_brk		641 583 659 640
> > exit_mmap	33 52 44 42
> > mprotect_fixup	54 65 73 64
> > do_mremap	2 0 0 0
> > poll_idle	98733 85659 104994 103096
> 
> There does look to be a regression in unmap_region.

Yeah, but there is an improvement of a greater magnitude in do_mmap_pgoff
...by about 190 ticks. There is a regression of about 60 ticks in 
unmap_region (taking standard deviation into consideration).  Change
in ticks for do_brk is not statistically significant.

> 
> Though I'd be reluctant to assign much general significance
> to any of these numbers (suspect it might all come out quite
> differently on another machine, another config, another run).
>

I agree with this for vm_unacct_memory, since it is called from many
places.  Based on the workload, nos could be different (if all the
callsites are called with comparable frequency).   
However, if the workload is such that one particular caller is
stressed much more than other callers, then, maybe inlining  helps 
as in this case where do_mmap_pgoff is stresed more?  

> But the probable best course is just to inline vm_acct_memory
> as you did, but also uninline vm_unacct_memory: placing the
> static inline vm_acct_memory and then vm_unacct_memory just
> before vm_enough_memory in mm/mmap.c.

Sounds reasonable.  I'll give this a run and see how the profiles look.

Thanks,
Kiran

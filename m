Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267619AbUHJUm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267619AbUHJUm7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 16:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267724AbUHJUm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 16:42:59 -0400
Received: from lists.us.dell.com ([143.166.224.162]:50049 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S267619AbUHJUmn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 16:42:43 -0400
Date: Tue, 10 Aug 2004 15:42:32 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       Ernie Petrides <petrides@redhat.com>
Subject: Re: [PATCH] reserved buffers only for PF_MEMALLOC
Message-ID: <20040810204232.GA2528@lists.us.dell.com>
References: <Pine.LNX.4.44.0408101310580.7156-100000@dhcp83-102.boston.redhat.com> <20040810190455.GA13349@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810190455.GA13349@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 04:04:55PM -0300, Marcelo Tosatti wrote:
> On Tue, Aug 10, 2004 at 01:20:24PM -0400, Rik van Riel wrote:
> > 
> > The buffer allocation path in 2.4 has a long standing bug,
> > where non-PF_MEMALLOC tasks can dig into the reserved pool
> > in get_unused_buffer_head().  The following patch makes the
> > reserved pool only accessible to PF_MEMALLOC tasks.
> 
> Out of curiosity: Do you actually seen any practical problem due to 
> get_unused_buffer_head() calls eating into the reserved pool?
> 
> Or have any testcase which would trigger a problem (OOM) due to it? 

My team has seen an application which mallocs as much memory as
possible, up to 95% of system RAM, using multiple processes as
necessary, and then has threads which touch all the malloc'd bytes and
threads which touch all the malloc'd pages.  It keeps kswapd pretty
busy, such that you can get down to zero free and inactive clean
ZONE_NORMAL pages from which to allocate additional buffer_heads for
swapout, deadlocking the system.

We believe that by limiting the use of the reserved buffer_head pool
to PF_MEMALLOC tasks like kswapd, kswapd can make forward progress
even in extremely low memory situations.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

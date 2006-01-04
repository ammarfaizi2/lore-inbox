Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751694AbWADLPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbWADLPn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 06:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbWADLPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 06:15:43 -0500
Received: from ns2.suse.de ([195.135.220.15]:29158 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750819AbWADLPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 06:15:42 -0500
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH] Shrinks sizeof(files_struct) and better layout
Date: Wed, 4 Jan 2006 12:15:36 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20051108185349.6e86cec3.akpm@osdl.org> <p733bk4z2z0.fsf@verdi.suse.de> <43BBADD5.3070706@cosmosbay.com>
In-Reply-To: <43BBADD5.3070706@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200601041215.36627.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 January 2006 12:13, Eric Dumazet wrote:
> Andi Kleen a écrit :
> > Eric Dumazet <dada1@cosmosbay.com> writes:
> >> 1) Reduces the size of (struct fdtable) to exactly 64 bytes on 32bits
> >> platforms, lowering kmalloc() allocated space by 50%.
> > 
> > It should be probably a kmem_cache_alloc() instead of a kmalloc
> > in the first place anyways. This would reduce fragmentation.
> 
> Well in theory yes, if you really expect thousand of tasks running...
> But for most machines, number of concurrent tasks is < 200, and using a 
> special cache for this is not a win.

It is because it avoids fragmentation because objects with similar livetimes
are clustered together. In general caches are a win
if the data is nearly a page or more.

> 
> > 
> >> +   * read mostly part
> >> +   */
> >>  	atomic_t count;
> >>  	struct fdtable *fdt;
> >>  	struct fdtable fdtab;
> >> -	fd_set close_on_exec_init;
> >> -	fd_set open_fds_init;
> >> +  /*
> >> +   * written part on a separate cache line in SMP
> >> +   */
> >> +	spinlock_t file_lock ____cacheline_aligned_in_smp;
> >> +	int next_fd;
> >> +	embedded_fd_set close_on_exec_init;
> >> +	embedded_fd_set open_fds_init;
> > 
> > You didn't describe that change, but unless it's clear the separate cache lines
> > are a win I would not do it and save memory again. Was this split based on
> > actual measurements or more theoretical considerations? 
> 
> As it is a refinement on a previous patch (that was integrated in 2.6.15) that 
> put spin_lock after the array[] (so cleary using a separate cache line), I 
> omited to describe it.

Ok, perhaps you should describe that too then

-Andi

 

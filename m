Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751668AbWADKpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbWADKpL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 05:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbWADKpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 05:45:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:7394 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751668AbWADKpJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 05:45:09 -0500
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Shrinks sizeof(files_struct) and better layout
References: <20051108185349.6e86cec3.akpm@osdl.org>
	<437226B1.4040901@cosmosbay.com>
	<20051109220742.067c5f3a.akpm@osdl.org>
	<4373698F.9010608@cosmosbay.com> <43BB1178.7020409@cosmosbay.com>
From: Andi Kleen <ak@suse.de>
Date: 04 Jan 2006 11:45:07 +0100
In-Reply-To: <43BB1178.7020409@cosmosbay.com>
Message-ID: <p733bk4z2z0.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <dada1@cosmosbay.com> writes:
> 
> 1) Reduces the size of (struct fdtable) to exactly 64 bytes on 32bits
> platforms, lowering kmalloc() allocated space by 50%.

It should be probably a kmem_cache_alloc() instead of a kmalloc
in the first place anyways. This would reduce fragmentation.

> 2) Reduces the size of (files_struct), using a special 32 bits (or
> 64bits) embedded_fd_set, instead of a 1024 bits fd_set for the
> close_on_exec_init and open_fds_init fields. This save some ram (248
> bytes per task) as most tasks dont open more than 32 files. D-Cache
> footprint for such tasks is also reduced to the minimum.
> 
> 3) Reduces size of allocated fdset. Currently two full pages are
> allocated, that is 32768 bits on x86 for example, and way too
> much. The minimum is now L1_CACHE_BYTES.
> 
> UP and SMP should benefit from this patch, because most tasks will
> touch only one cache line when open()/close() stdin/stdout/stderr
> (0/1/2), (next_fd, close_on_exec_init, open_fds_init, fd_array[0 .. 2]
> being in the same cache line)

Looks mostly good to me.

> +   * read mostly part
> +   */
>  	atomic_t count;
>  	struct fdtable *fdt;
>  	struct fdtable fdtab;
> -	fd_set close_on_exec_init;
> -	fd_set open_fds_init;
> +  /*
> +   * written part on a separate cache line in SMP
> +   */
> +	spinlock_t file_lock ____cacheline_aligned_in_smp;
> +	int next_fd;
> +	embedded_fd_set close_on_exec_init;
> +	embedded_fd_set open_fds_init;

You didn't describe that change, but unless it's clear the separate cache lines
are a win I would not do it and save memory again. Was this split based on
actual measurements or more theoretical considerations? 

-Andi

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135985AbREJBjR>; Wed, 9 May 2001 21:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135997AbREJBi6>; Wed, 9 May 2001 21:38:58 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:57606 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135985AbREJBiw>; Wed, 9 May 2001 21:38:52 -0400
Date: Wed, 9 May 2001 21:00:26 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Kurt Garloff <garloff@suse.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs MAP_SHARED corruption fix
In-Reply-To: <20010510031652.G2506@athlon.random>
Message-ID: <Pine.LNX.4.21.0105092045410.15984-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 10 May 2001, Andrea Arcangeli wrote:

> If some page wasn't yet visible in the dirty_pages list by the time
> __sync_one started, we'll find I_DIRTY_PAGES set. This is enforced by
> the locking order (sync_one first clears the I_DIRTY_PAGES and then
> it starts browsing the dirty_pages list while set_page_dirty first make the
> page visible and then marks the inode dirty).
> 
> So the I_DIRTY_PAGES check guarantees that those dirty pages cannot be
> lost in iput, that was the _only_ object of the patch and that is
> certainly enough to fix the nfs fs data corruption reported.
> 
> Now if you claim that munmap needs to be synchronous for nfs that's a
> completly different matter. I didn't even tried to make it synchronous.
> It is possible it has to be synchronous, even write(2) (in theory ;) has
> to behave like O_SYNC with nfs, but I'm not sure.

I suggested the removal of I_DIRTY_PAGES check because the current
behaviour of munmap seems to be synchronous (1), so I guess you _always_
want it to be synchronous.

1) nfs_wb_file() flushes the dirty data and then waits for completion. 

Trond? 

> Another thing (completly unrelated to the above issues) that I noticed
> while looking over this nfs code is that the __sync_one() for example
> called by generic_file_write(O_SYNC) will recall fdatasync but no nfs_wb_all
> is put before the fdatawait, and I'm not sure that the nfs_sync_page
> called by the fdatawait is enough to rapidly flush the writepaged stuff
> to the nfs server. nfs_sync_page apparently only cares about speculative
> reads, not at all about committing writebacks. It would look much saner
> to me if nfs_sync_page also does a nfs_wb_all() on the inode, so that
> the ->sync_page callback gets the same semantics it has for the real
> filesystems.

Looks sane and will probably makes things faster.

Again, Trond? :)


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265385AbRF0TiL>; Wed, 27 Jun 2001 15:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265388AbRF0TiC>; Wed, 27 Jun 2001 15:38:02 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:47886
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S265385AbRF0Ths>; Wed, 27 Jun 2001 15:37:48 -0400
Date: Wed, 27 Jun 2001 15:36:49 -0400
From: Chris Mason <mason@suse.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Xuan Baldauf <xuan--lkml@baldauf.org>, linux-kernel@vger.kernel.org,
        andrea@suse.de,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: VM deadlock
Message-ID: <910160000.993670608@tiny>
In-Reply-To: <Pine.LNX.4.21.0106271440150.1745-100000@freak.distro.conectiva>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, June 27, 2001 02:43:57 PM -0300 Marcelo Tosatti
<marcelo@conectiva.com.br> wrote:
> 
> Looking at http://lists.omnipotent.net/reiserfs/200106/msg00214.html:

Also from Xuan ;-)

> 
>>> EIP; c0128228 <page_launder+b8/90c>   <=====
> Trace; c01303df <refill_freelist+1f/54>
> Trace; c01307e2 <getblk+f2/108>
> Trace; c5141308 <END_OF_CODE+4e978b8/????>
> Trace; c0176c4b <do_journal_end+63f/ac0>
> Trace; c5160848 <END_OF_CODE+4eb6df8/????>
> Trace; c01759e6 <journal_end_sync+16/1c>
> Trace; c015e23a <reiserfs_write_inode+56/64>
> Trace; c0141055 <try_to_sync_unused_inodes+101/1a8>
> Trace; c01416dd <prune_icache+105/114>
> Trace; c014170d <shrink_icache_memory+21/30>
> Trace; c0128d67 <do_try_to_free_pages+2b/58>
> Trace; c0128deb <kswapd+57/e4>
> Trace; c0105434 <kernel_thread+28/38>
> 
> 
> 
> refill_freelist() calls page_launder(GFP_BUFFER). Now GFP_BUFFER _will_
> block writting out buffers with try_to_free_buffers().

Grrr, how did I miss this before?  I thought Xuan's hang went away after
pre3, so I didn't look into this trace hard enough.  

Reiserfs expects write_inode() calls initiated by kswapd to always have
sync==0.  Otherwise, kswapd ends up waiting on the log, which isn't what we
want at all.

The dirty inode callback ensures there are no dirty inodes that haven't
been logged.  I took the sync parameter to mean it is initiated by fsync or
O_SYNC, so I trigger a full commit when sync == 1.

So, my choices are to ignore sync == 1 write_inode calls when kswapd is
doing it, or make a private inode dirty list.

> 
> Maybe thats the reason for the deadlock we're seeing here at this specific
> trace ? 
> 

The trace above is caused by the dirty inode problem, the I think the more
recent trace is something different.

-chris


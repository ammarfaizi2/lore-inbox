Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292739AbSCEXhz>; Tue, 5 Mar 2002 18:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292876AbSCEXhp>; Tue, 5 Mar 2002 18:37:45 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:12856 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S292739AbSCEXh0>; Tue, 5 Mar 2002 18:37:26 -0500
Date: Wed, 6 Mar 2002 00:37:50 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Arjan van de Ven <arjan@fenrus.demon.nl>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <20020306003750.Q20606@dualathlon.random>
In-Reply-To: <20020305161032.F20606@dualathlon.random> <Pine.LNX.4.44L.0203051354590.1413-100000@duckman.distro.conectiva> <20020305192604.J20606@dualathlon.random>, <20020305192604.J20606@dualathlon.random>; <20020305183053.A27064@fenrus.demon.nl> <3C8518AE.B44AF2D5@zip.com.au> <20020306000314.M20606@dualathlon.random>, <20020306000314.M20606@dualathlon.random> <20020306000532.N20606@dualathlon.random> <3C8553C1.5E296978@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C8553C1.5E296978@zip.com.au>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 03:24:49PM -0800, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > BTW, I noticed one of my last my email was a private reply so I'll
> > answer here too for the buffer_head pagecache I/O part:
> 
> Heh.  Me too.
>  
> > Having persistence on the physical I/O information is a good thing, so
> > you don't need to resolve logical to physical block at every I/O and bio
> > has a cost to setup too. The information we carry on the bh isn't
> > superflous, it's needed for the I/O so even if you don't use the
> > buffer_head you will still need some other memory to hold such
> > information, or alternatively you need to call get_block (and serialize
> > in the fs) at every I/O even if you've plenty of ram free. So I don't
> > think the current setup is that stupid, current bh only sucks for the
> > rawio and that's fixed by bio.
> 
> The small benefit of caching the get_block result in the buffers
> just isn't worth it.
> 
> At present, a one-megabyte write to disk requires the allocation
> and freeing and manipulation and locking of 256 buffer_heads and
> 256 BIOs.  lru_list_lock, hash_table_lock, icache/dcache
> thrashing, etc, etc.   It's an *enormous* amount of work.
> 
> I'm doing the same amount of work with as few as two (yes, 2) BIOs.
> 
> This is not something theoretical.  I have numbers, and code.
> 20% speedup on a 2-way with a workload which is dominated
> by copy_*_user.  It'll be more significant on larger machines,
> on machines with higher core/main memory speed ratios, on
> machines with higher I/O bandwidth. (OK, that bit was theoretical).

then let's cut and paste this part as well :)

depends what you're doing, if you do `cp /dev/zero .` and the fs is
lucky enough to have free contigous space I definitely can see the
improvement of highlevel merging, but that's not always what you're
doing with the fs, for example that's not the case for kernel compiles
and small files where you'll be always fragmented and where the bio will
at max hold 4k and you keep rewriting into cache. The times you enter
get_block you enter in a fs lock, rather than staying at the per-page
lock, it's not additional locking, the bh on the pagecahce doesn't need
any additional locking. So for a kernel compile the current situation is
an obvious advantage in performance and scalability (fs code definitely
doesn't scale at the moment).

But ok, globally it will be probably better to drop the bh since we have
to work on the bio anyways somehow and so at the very least we don't
want to be slowed down from the bio logic in the physically contigous
pagecache flood case.

I just meant the bh isn't totally pointless and it could be shrunk as
Arjan said in a private email.

Andrea

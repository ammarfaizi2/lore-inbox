Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293163AbSCEX0y>; Tue, 5 Mar 2002 18:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293243AbSCEX0p>; Tue, 5 Mar 2002 18:26:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9486 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293163AbSCEX03>;
	Tue, 5 Mar 2002 18:26:29 -0500
Message-ID: <3C8553C1.5E296978@zip.com.au>
Date: Tue, 05 Mar 2002 15:24:49 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Arjan van de Ven <arjan@fenrus.demon.nl>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
In-Reply-To: <20020305161032.F20606@dualathlon.random> <Pine.LNX.4.44L.0203051354590.1413-100000@duckman.distro.conectiva> <20020305192604.J20606@dualathlon.random>, <20020305192604.J20606@dualathlon.random>; <20020305183053.A27064@fenrus.demon.nl> <3C8518AE.B44AF2D5@zip.com.au> <20020306000314.M20606@dualathlon.random>,
		<20020306000314.M20606@dualathlon.random> <20020306000532.N20606@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> BTW, I noticed one of my last my email was a private reply so I'll
> answer here too for the buffer_head pagecache I/O part:

Heh.  Me too.
 
> Having persistence on the physical I/O information is a good thing, so
> you don't need to resolve logical to physical block at every I/O and bio
> has a cost to setup too. The information we carry on the bh isn't
> superflous, it's needed for the I/O so even if you don't use the
> buffer_head you will still need some other memory to hold such
> information, or alternatively you need to call get_block (and serialize
> in the fs) at every I/O even if you've plenty of ram free. So I don't
> think the current setup is that stupid, current bh only sucks for the
> rawio and that's fixed by bio.

The small benefit of caching the get_block result in the buffers
just isn't worth it.

At present, a one-megabyte write to disk requires the allocation
and freeing and manipulation and locking of 256 buffer_heads and
256 BIOs.  lru_list_lock, hash_table_lock, icache/dcache
thrashing, etc, etc.   It's an *enormous* amount of work.

I'm doing the same amount of work with as few as two (yes, 2) BIOs.

This is not something theoretical.  I have numbers, and code.
20% speedup on a 2-way with a workload which is dominated
by copy_*_user.  It'll be more significant on larger machines,
on machines with higher core/main memory speed ratios, on
machines with higher I/O bandwidth. (OK, that bit was theoretical).

-

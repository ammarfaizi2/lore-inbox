Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293662AbSCEXxg>; Tue, 5 Mar 2002 18:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293656AbSCEXxd>; Tue, 5 Mar 2002 18:53:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28174 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293676AbSCEXxR>;
	Tue, 5 Mar 2002 18:53:17 -0500
Message-ID: <3C855A09.CF2510B6@zip.com.au>
Date: Tue, 05 Mar 2002 15:51:37 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Arjan van de Ven <arjan@fenrus.demon.nl>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
In-Reply-To: <20020305161032.F20606@dualathlon.random> <Pine.LNX.4.44L.0203051354590.1413-100000@duckman.distro.conectiva> <20020305192604.J20606@dualathlon.random>, <20020305192604.J20606@dualathlon.random>; <20020305183053.A27064@fenrus.demon.nl> <3C8518AE.B44AF2D5@zip.com.au> <20020306000314.M20606@dualathlon.random>, <20020306000314.M20606@dualathlon.random> <20020306000532.N20606@dualathlon.random> <3C8553C1.5E296978@zip.com.au>,
		<3C8553C1.5E296978@zip.com.au> <20020306003750.Q20606@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
>
> depends what you're doing, if you do `cp /dev/zero .` and the fs is
> lucky enough to have free contigous space I definitely can see the
> improvement of highlevel merging, but that's not always what you're
> doing with the fs, for example that's not the case for kernel compiles
> and small files where you'll be always fragmented and where the bio will
> at max hold 4k and you keep rewriting into cache.

Cache effects.  We touch the buffers at prepare_write.  We touch them
again at commit_write().  And at writeout time.  And at page reclaim
time.  I think it's this general white-noise cost which is causing
the funny profiles which I'm seeing.  (For example, with no-buffers,
the cost of the IDE driver setup and interrupt handler has nosedived).

> The times you enter
> get_block you enter in a fs lock, rather than staying at the per-page
> lock, it's not additional locking, the bh on the pagecahce doesn't need
> any additional locking.

For writes, we have the lru list insertion, and the hashtable lock (twice).

> So for a kernel compile the current situation is
> an obvious advantage in performance and scalability (fs code definitely
> doesn't scale at the moment).

mm..  Delayed allocation means that the short-lived files never get
a disk mapping at all.

And yes, if all files are 100% fragmented then the BIO aggregation
doesn't help as much.

> But ok, globally it will be probably better to drop the bh since we have
> to work on the bio anyways somehow and so at the very least we don't
> want to be slowed down from the bio logic in the physically contigous
> pagecache flood case.
> 
> I just meant the bh isn't totally pointless and it could be shrunk as
> Arjan said in a private email.

bh represents a disk block.  It's a wrapper around a section of the
block device's pagecache pages.  We'll always need a representation
of disk blocks.  For filesystem metadata.

-

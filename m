Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267029AbTBTXGA>; Thu, 20 Feb 2003 18:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265687AbTBTXGA>; Thu, 20 Feb 2003 18:06:00 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:12277 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S267029AbTBTXF7>; Thu, 20 Feb 2003 18:05:59 -0500
Date: Thu, 20 Feb 2003 16:15:36 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>, t.baetzler@bringe.com,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: xdr nfs highmem deadlock fix [Re: filesystem access slowing system to a crawl]
Message-ID: <20030220161536.F1723@schatzie.adilger.int>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	Andrew Morton <akpm@digeo.com>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	t.baetzler@bringe.com, linux-kernel@vger.kernel.org,
	marcelo@conectiva.com.br
References: <A1FE021ABD24D411BE2D0050DA450B925EEA6C@MERKUR> <200302191742.02275.m.c.p@wolk-project.de> <20030219174940.GJ14633@x30.suse.de> <200302201629.51374.m.c.p@wolk-project.de> <20030220103543.7c2d250c.akpm@digeo.com> <20030220215457.GV31480@x30.school.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030220215457.GV31480@x30.school.suse.de>; from andrea@suse.de on Thu, Feb 20, 2003 at 10:54:58PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 20, 2003  22:54 +0100, Andrea Arcangeli wrote:
> Explanation is very simple: you _can't_ kmap two times in the context of
> a single task (especially if more than one task can run the same code at
> the same time). I don't yet have the confirmation that this fixes the
> deadlock though (it takes days to reproduce so it will take weeks to
> confirm), but I can't see anything else wrong at the moment, and this
> remains a genuine highmem deadlock that has to be fixed.  The fix is
> optimal, no change unless you run out of kmaps and in turn you can
> deadlock, i.e. all the light workloads won't be affected at all.

We had a similar problem in Lustre, where we have to kmap multiple pages
at once and hold them over a network RPC (which is doing zero-copy DMA
into multiple pages at once), and there is possibly a very heavy load
of kmaps because the client and the server can be on the same system.

What we did was set up a "kmap reservation", which used an atomic_dec()
+ wait_event() to reschedule the task until it could get enough kmaps
to satisfy the request without deadlocking (i.e. exceeding the kmap cap
which we conservitavely set at 3/4 of all kmap space).

A single "server" task could exceed the kmap cap by enough to satisfy the
maximum possible request size, so that a single system with both clients
and servers can always make forward progress even in the face of clients
trying to kmap more than the total amount of kmap space.

This works for us because we are the only consumer of huge amounts of kmaps
on our systems, but it would be nice to have a generic interface to do that
so that multiple apps don't deadlock against each other (e.g. NFS + Lustre).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/


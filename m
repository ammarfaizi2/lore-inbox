Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267804AbRGQJFX>; Tue, 17 Jul 2001 05:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267803AbRGQJFM>; Tue, 17 Jul 2001 05:05:12 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:56518 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267801AbRGQJFD>; Tue, 17 Jul 2001 05:05:03 -0400
Date: Mon, 16 Jul 2001 23:03:49 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Cc: Andrew Morton <andrewm@uow.edu.au>, Lance Larsh <llarsh@oracle.com>,
        Brian Strand <bstrand@switchmanagement.com>,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: 2x Oracle slowdown from 2.2.16 to 2.4.4
Message-ID: <20010716230349.A31172@redhat.com>
In-Reply-To: <3B4E7666.EFD7CC89@uow.edu.au> <Pine.LNX.4.33.0107130834080.313-100000@desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0107130834080.313-100000@desktop>; from jwbaker@acm.org on Fri, Jul 13, 2001 at 08:36:01AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 13, 2001 at 08:36:01AM -0700, Jeffrey W. Baker wrote:

> > files O_SYNC.  Journal size was 400 megs, mount options `data=journal'
> >
> > ext2: Throughput 2.71849 MB/sec (NB=3.39812 MB/sec  27.1849 MBit/sec)
> > ext3: Throughput 12.3623 MB/sec (NB=15.4529 MB/sec  123.623 MBit/sec)
> >
> > The difference will be less dramatic with large, individual writes.
> 
> This is a totally transient effect, right?  The journal acts as a faster
> buffer, but if programs are writing a lot of data to the disk for a very
> long time, the throughput will eventually be throttled by writing the
> journal back into the filesystem.

Not for O_SYNC.  For ext2, *every* O_SYNC append to a file involves
seeking between inodes and indirect blocks and data blocks.  With ext3
with data journaling enabled, the synchronous part of the IO is a
single sequential write to the journal.  The async writeback will
affect throughput, yes, but since it is done in the background, it can
do tons of optimisations: if you extend a file a hundred times with
O_SYNC, then you are forced to journal the inode update a hundred
times but the writeback which occurs later need only be done once.

For async traffic, you're quite correct.  For synchronous traffic, the
writeback later on is still async, and the synchronous costs really do
often dominate, so the net effect over time is still a big win.

Cheers,
 Stephen

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278805AbRJZR7y>; Fri, 26 Oct 2001 13:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278810AbRJZR7l>; Fri, 26 Oct 2001 13:59:41 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:38947 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S278805AbRJZR7a>; Fri, 26 Oct 2001 13:59:30 -0400
Date: Fri, 26 Oct 2001 20:00:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Christopher S. Swingley" <cswingle@iarc.uaf.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.13-ac1
Message-ID: <20011026200002.N30905@athlon.random>
In-Reply-To: <20011026194301.M30905@athlon.random> <E15xBBA-0000pp-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E15xBBA-0000pp-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Oct 26, 2001 at 06:54:00PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2001 at 06:54:00PM +0100, Alan Cox wrote:
> > simply because the <2.4.10 buffer cache layer wasn't able to do proper
> > readahead on the blkdev. Now we do readahead properly and so in turn
> > the the lack of media-change trust of the vfs shows up. So as far I can
> > tell the right fix have no influence on the blkdev in pagecache, but it
> > only consists in resurrecting the media-change detection with a
> > per-device bitflag whitelist. I cannot see other source of stalls across
> > a close/open cycle.
> 
> I'm not currently sure if the impact is from the cost of the page cache
> flushing or the invalidate/re-read it triggers. There probably are two or
> three seeks on the DVD if the data is invalidated so that would make sense.

plus we also need to wait completion of the readahead synchronously in
the cache flushing at close, the larger the readahead, the larger the
stall.

I doubt the cpu cost of truncate_inode_pages as originally suspected
is the culprit, more likely the fact we have to wait for a larger I/O to
complete plus the disk seek due the fact we throw away the readahead,
infact invalidate_buffers in-cpu-core cost in -ac could be lot worse
considering it has to walk a list that contains all kind of buffers not
only belonging to the interesting device to flush.

But anyways the media change detection will avoid to throw away the
readahead and in turn it will avoid the seek, it will avoid the
synchronous I/O completion wait in truncate_inode_pages, and it will
avoid the truncate_inode_pages in-cpu-core cost cost as well, so it
should most certainly fix the problem.

Andrea

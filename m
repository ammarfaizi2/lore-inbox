Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261513AbREYSpE>; Fri, 25 May 2001 14:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261519AbREYSoy>; Fri, 25 May 2001 14:44:54 -0400
Received: from inet-mail3.oracle.com ([148.87.2.203]:1930 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S261513AbREYSon>; Fri, 25 May 2001 14:44:43 -0400
Date: Fri, 25 May 2001 11:52:27 -0700 (PDT)
From: Lance Larsh <llarsh@oracle.com>
To: Heikki Tuuri <Heikki.Tuuri@innobase.inet.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: Why O_SYNC and fsync are slow in Linux?
In-Reply-To: <20010516183630.FZOA13813.fep07.tmt.tele.fi@omnibook>
Message-ID: <Pine.LNX.4.21.0105251058060.1395-100000@llarsh-pc3.us.oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 May 2001, Heikki Tuuri wrote:

> On Red Hat 6.2 and 7.? Intel big block writes are very slow if
> I open the file with O_SYNC. I call pwrite to write 1 MB chunks to
> the file, and I get only 1 MB/s write speed. If I open without O_SYNC
> and call fsync only after writing the whole 100 MB file,
> I get 5 MB/s. I got the same adequate speed 5 MB/s with 16 MB writes
> after which I called fdatasync.

When you open with O_SYNC, the data must go all the way to disk on
every write call.  This means you get at least one disk access for
every write, and possibly more if the writes are large (>64k).

When you don't use O_SYNC and only flush after all writes have been
submitted by the application, then the kernel is able to combine writes
in the cache and at the blk dev layer.  Therefore you end up with fewer
accesses to the physical disk, which makes it much faster.

> On a Linux-Compaq Alpha I measured the following: if I open with O_SYNC,
> I can flush the end of my file (it is a log file) to
> disk 170 times / second. If I do not open with O_SYNC,
> but call fsync or fdatasync after each write, I get only 50
> writes/second.

This is generally the case.  If you need to sync every write, O_SYNC
is usually faster than fsync.  If you don't need to sync
every individual write, then a single fsync after the last
write is the fastest to get all the data to disk.

> 
> On the Red Hat 7.? I get 500 writes per second if I open with O_SYNC.
> That is too much because the disk does not rotate
> 500 rotations/second. Does the disk fool the operating
> system to believe a write has ended while it has not?

Are you using an IDE disk?  If so, it probably has a huge cache.

-Lance


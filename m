Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261556AbSIZWAH>; Thu, 26 Sep 2002 18:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261558AbSIZWAH>; Thu, 26 Sep 2002 18:00:07 -0400
Received: from thunk.org ([140.239.227.29]:53408 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S261556AbSIZWAG>;
	Thu, 26 Sep 2002 18:00:06 -0400
Date: Thu, 26 Sep 2002 18:04:32 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ryan Cumming <ryan@completely.kicks-ass.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Message-ID: <20020926220432.GB10551@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Ryan Cumming <ryan@completely.kicks-ass.org>,
	linux-kernel@vger.kernel.org
References: <E17uINs-0003bG-00@think.thunk.org> <200209260041.59855.ryan@completely.kicks-ass.org> <20020926154217.GA10551@think.thunk.org> <200209261208.59020.ryan@completely.kicks-ass.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209261208.59020.ryan@completely.kicks-ass.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 12:08:54PM -0700, Ryan Cumming wrote:
> On September 26, 2002 08:42, Theodore Ts'o wrote:
> > Hmm... I just tried biult 2.4.19 with the ext3 patch on my UP P3
> > machine, using GCC 3.2, and I wasn't able to replicate your problem.
> > (This was using Debian's gcc 3.2.1-0pre2 release from testing.)
> The whole GCC 3.2 thing was a red herring. Although it ran stable for a few 
> hours last night (cvs up, compiled a kernel, etc), the filesystem was once 
> again read-only when I came to check my mail this morning.

Was there anything in the logs at all?  There should be, if the
filesystem was remounted read-only.

> The interesting fsck errors this time were:
> 245782 was part of the orphaned inode list FIXED
> 245792 was part of the orphaned inode list FIXED
> 245797...
> 
> 245782,245792 don't exist according to ncheck.

That's not surprising. What this means is that those inodes were
deleted, but since some process still had a file descriptor open for
that inode, it was placed on the orphaned inode list.  But the
directory entry would have already been removed, which is why ncheck
couldn't find an associated pathname.  The e2fsck error message simply
states that these inodes had a dtime which was small enough that it
was probably the next entry on the orphaned inode linked list, these
inodes weren't actually on the list.  At a guess, this probably
happened when an error was noted in the filesystem, and the filesystem
was forcibly put into the read-only state.  That probably arrested
some transactions which were not fully completed, and would explain
these sorts of fsck errors.

The real question is what was the original error that caused the ext3
filesystme to decide it needed to remount the filesystem read-only.
That should be in your logs, since calls to ext3_error should always
cause printk's explaining what the error was to be sent to the logs.

The filesystem wouldn't happen to be running close to full either on
the number of blocks or the number of inodes, would it?  There's a bug
in ext3 (for which Stephen has already posted bug fixes to be applied
to the 2.4.20-preX kernels) where an running out of blocks or inodes
is being erroneously flagged as a filesystem corruption error, which
would mount the filesystem read-only.

						- Ted

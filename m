Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270152AbRHGNYA>; Tue, 7 Aug 2001 09:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270161AbRHGNXu>; Tue, 7 Aug 2001 09:23:50 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:61702 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S270152AbRHGNXk>; Tue, 7 Aug 2001 09:23:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Anton Altaparmakov <aia21@cam.ac.uk>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [RFC] using writepage to start io
Date: Tue, 7 Aug 2001 15:29:26 +0200
X-Mailer: KMail [version 1.2]
Cc: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
In-Reply-To: <01080623182601.01864@starship> <5.1.0.14.2.20010807123805.027f19a0@pop.cus.cam.ac.uk>
In-Reply-To: <5.1.0.14.2.20010807123805.027f19a0@pop.cus.cam.ac.uk>
MIME-Version: 1.0
Message-Id: <01080715292606.02365@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 August 2001 14:02, Anton Altaparmakov wrote:
> At 12:02 07/08/01, Stephen C. Tweedie wrote:
> >On Mon, Aug 06, 2001 at 11:18:26PM +0200, Daniel Phillips wrote:
> >FWIW, we've seen big performance degradations in the past when
> > testing different ext3 checkpointing modes.  You can't reuse a disk
> > block in the journal without making sure that the data in it has
> > been flushed to disk, so ext3 does regular checkpointing to flush
> > journaled blocks out.  That can interact very badly with normal VM
> > writeback if you're not careful: having two threads doing the same
> > thing at the same time can just thrash the disk.
> >
> >Parallel sync() calls from multiple processes has shown up the same
> >behaviour on ext2 in the past.  I'd definitely like to see at most
> > one thread of writeback per disk to avoid that.
>
> Why not have a facility with which each fs can register their own
> writeback functions with a time interval? The daemon would be doing
> the writing to the device and would be invoking the fs registered
> writers every <time interval> seconds. That would avoid the problem of
> having two fs trying to write in parallel but that ignores the problem
> of having two parallel writers on separate partitions of the same disk
> but that could be solved at the fs writeback function level.
>
> At least for NTFS TNG I was thinking of having a daemon running every
> 5 seconds and committing dirty data to disk but it would be iterating
> over all mounted ntfs volumes in sequence and flushing all dirty data
> for each, thus avoiding concurrent writing to the same disk, which I
> had thought might cause a problem and you just confirmed it...[1]

Let me see:

  Ext3 has its own writeback daemon
  ReiserFS has its own writeback daemon
  NTFS quite possibly will have its own writeback daemon
  Tux2 has its own writeback daemon
  xfs... does it?
  jfs?

And then there is kupdate, which is a writeback daemon for all those
filesystems too dumb to have their own.

I think I see a pattern here.  We must come up with a model for
efficient interaction between these writeback daemons, or better yet,
provide a generic mechanism that provides the scheduling for all fs
writeback, and knows about the fs->device topology.

> [1] I am aware this probably doesn't scale too well but considering a
> volume can span several disk partitions on the same disk or across
> several disks I don't see how to parallelize at the fs level.

One thread per block device; flushes across mounts on the same device
are serialized.  This model works well for fs->device graphs that are
strict trees.  For a non-strict tree (acyclic graph) its not clear
what to do, but you could argue that such a configuration is stupid,
so any kind of punt would do.

--
Daniel

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751599AbWHXPyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbWHXPyZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 11:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbWHXPyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 11:54:25 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:64689 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751606AbWHXPyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 11:54:24 -0400
Date: Thu, 24 Aug 2006 17:54:34 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] LogFS
Message-ID: <20060824155434.GA31877@wohnheim.fh-wedel.de>
References: <20060824134430.GB17132@wohnheim.fh-wedel.de> <p73wt8ydu1v.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <p73wt8ydu1v.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 August 2006 17:37:00 +0200, Andi Kleen wrote:
> Jörn Engel <joern@wohnheim.fh-wedel.de> writes:
> 
> > For the last 16 month, I've been hacking on a small filesystem.  It
> > has progress far enough that it shouldn't be a total embarrassment to
> > show the code, but still needs quite a bit of work.
> > 
> > Anyhow, in case people are interested to have a look... comments are
> > very welcome.
> 
> ... some more description/rationale missing ...

Most people that are interested in this already know about it, but you
are absolutely right.

> Is it only intended for (small) flash like jffs2 or also for larger disks?

It is only intended for medium to large flash.  On disks with the
rotational latency, I would expect performance to be very poor.
Writes should be relatively good, reads absolutely horrible.


The missing rationale:

Linux needs a decent flash filesystem.  So far, jffs2 filled the gap,
but it is increasingly showing its age.  Both mount time and memory
consumption scale linearly with flash size, so there is a soft limit
of jffs2 usefulness somewhere between 128MiB and 4GiB, depending on
system design and whether the summary extension is used.

Then there is a hard limit at 4GiB, because jffs2 uses 32bit byte
offsets to locate data.

In the opinion of many people, including me, the only solution to fix
jffs2 is to completely redesign it from scratch.  Voila logfs.

The first idea of logfs was to store data in a tree, similar to ffs
style filesystems.  Flash behaves a little different to hard disks, so
free block bitmaps are a bad idea.  Instead, blocks are annotated with
the inode and fpos they belong to.  By walking the filesystem tree, it
is possible to decide whether a block is still used or free.

Updates are done by a wandering tree.  In-place updates is basically
verboten on flash.  Wandering trees cause quite a bit of overhead,
which will be reduced later.  -ENOTIME so far.

There is a small journal necessary for several purposes:
1. Store the root of the filesystem tree.  Inodes are stored in an
inode file.  The ifile's inode is stored in the journal.
2. Perform atomic directory operations (create, rename, ...).
3. Reduce the overhead of wandering trees.  Jffs2 has quite an
efficient layout wrt. write performance.  Pushing writes through a
jffs2-style journal before adding it to the tree will help a lot.

Jörn

-- 
Mundie uses a textbook tactic of manipulation: start with some
reasonable talk, and lead the audience to an unreasonable conclusion.
-- Bruce Perens

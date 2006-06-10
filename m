Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbWFJFY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWFJFY6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 01:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWFJFY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 01:24:58 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:48006 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932192AbWFJFY5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 01:24:57 -0400
Date: Fri, 9 Jun 2006 23:25:02 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Valerie Henson <val_henson@linux.intel.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Alex Tomas <alex@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: Continuation Inodes Explained! (was Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3)
Message-ID: <20060610052502.GY5964@schatzie.adilger.int>
Mail-Followup-To: Valerie Henson <val_henson@linux.intel.com>,
	Matthew Wilcox <matthew@wil.cx>, Alex Tomas <alex@clusterfs.com>,
	Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
	Arjan van de Ven <arjan@linux.intel.com>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <m3r71ycprd.fsf@bzzz.home.net> <20060609153116.GM1651@parisc-linux.org> <20060610032623.GG10524@goober>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060610032623.GG10524@goober>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 09, 2006  20:26 -0700, Valerie Henson wrote:
> To be honest, continuation inodes and these ext3 patches are
> addressing different problems.  ext3 48-bit extents are an advanced
> solution to a complex problem - growing ext3 beyond 8TB while keeping
> as much of the existing on-disk format and associated stable code as
> possible.

The 48-bit support was acutally only a small of the originalreason for
extents, while it seems to be the most popular right now.  The other
issues that are being addressed are:
- performance issues like avoiding 0.1%+ indirect block metadata overhead
  for each file which is bad for the cache, and also hurts unlinks)
- the extent index blocks are also more robust than indirect blocks (they
  have a magic and internally verifiable structure, and the possibility
  to easily add metadata checksums and extent->inode backpointers to
  allow improved filesystem checking).  With large ext3 filesystems the
  {d,t,}indirect blocks can have random garbage in them and there is no
  way for the kernel to know unless it overlaps with other fixed metadata
- the ability to do things like preallocation of files efficiently (via
  uninitialized extents), instead of zero-filling the whole file.

> Continuation inodes/chunkfs are an idea Arjan and I came up with,
> inspired loosely by the ext2 dirty bit code.  The problem we were
> trying to solve is how to isolate the effects of file system
> corruption (from crash, bug, or I/O error) so that we didn't have to
> run fsck over the entire file system in order to repair it.

I think this is a great idea, and one that is very similar to what
we are doing with ext3 filesystems in Lustre.  There is definitely
a desire to harden the ext3 code in many ways against such failures,
and being able to check independent parts of the filesystem is a
very desirable part of this.

> The solution we came up with is to create a "continuation inode" in
> every file system chunk which contains data for a particular file or
> directory.  For example, if file "foo" has its inode in chunk A, and
> some file data in chunk B, we would create a continuation inode in
> chunk B.  The continuation inode has a back pointer to the parent
> inode.

This needs some extra data in the directory entry, which I've already
been thinking about for ext3, so if you are looking at implementing
this for ext3 I'd be happy to share some ideas.

> One interesting possibility would be to combine this with the ext2
> dirty bit patches.

Put on your asbestos vest before suggesting any changes to ext2 :-).

> If we implement chunkfs on top of this, we could get away with fsck'ing
> only a few of the file systems each time, getting ext2-style performance
> with ext3-style fast recovery.

While fast recovery is one aspect of ext3 journaling, the other one
is that this allows multiple filesystem changes to be made atomically
and they are rolled back as a set if the system crashes in the middle.

> We'll talk about it more next week, I hope.

I look forward to it.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWFJD17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWFJD17 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 23:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWFJD17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 23:27:59 -0400
Received: from fmr18.intel.com ([134.134.136.17]:51679 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932192AbWFJD16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 23:27:58 -0400
Date: Fri, 9 Jun 2006 20:26:24 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       Andreas Dilger <adilger@clusterfs.com>,
       Arjan van de Ven <arjan@linux.intel.com>
Subject: Continuation Inodes Explained! (was Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3)
Message-ID: <20060610032623.GG10524@goober>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <m3r71ycprd.fsf@bzzz.home.net> <20060609153116.GM1651@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060609153116.GM1651@parisc-linux.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 09:31:16AM -0600, Matthew Wilcox wrote:
> 
> I want extents, but I'm still unconvinced that ext3 needs to grow beyond
> 32-bit blocks.  The scheme posted by Val and Arjan (with the
> continuation inodes) seems much neater.

Well, thanks!  Arjan and I like our idea too, but at this point it's
just an idea.  We'll be hashing it out some more at the file system
workshop next week.

To be honest, continuation inodes and these ext3 patches are
addressing different problems.  ext3 48-bit extents are an advanced
solution to a complex problem - growing ext3 beyond 8TB while keeping
as much of the existing on-disk format and associated stable code as
possible.  It's hard work and the ext3 developers came up with some
good ideas.  Continuation inodes are an idea about how to limit error
propagation in large file systems - an idea which happens to allow
file systems larger than 8 TB with 32-bit block pointers.

So what the heck are continuation inodes?  Actually, we named this
"chunkfs" - not particularly descriptive, maybe continuation inodes is
a better term.

Continuation inodes/chunkfs are an idea Arjan and I came up with,
inspired loosely by the ext2 dirty bit code.  The problem we were
trying to solve is how to isolate the effects of file system
corruption (from crash, bug, or I/O error) so that we didn't have to
run fsck over the entire file system in order to repair it.  This is
important because disk bandwidth is not growing as fast as disk
capacity, so the absolute time to read the entire disk is growing.
The basic idea is to create a bunch of small file systems - chunks -
which look like one big file system to the administrator.  Major
problems to solve:

1. Files which span more than one chunk (file system).
2. Hard links from a directory in chunk A to a file in chunk B.

The solution we came up with is to create a "continuation inode" in
every file system chunk which contains data for a particular file or
directory.  For example, if file "foo" has its inode in chunk A, and
some file data in chunk B, we would create a continuation inode in
chunk B.  The continuation inode has a back pointer to the parent
inode.  Now imagine there is some kind of corruption in chunk B and we
need to check the file system.  We can determine the free or allocated
state of every block in chunk B without reading any metadata outside
of chunk B.

Similarly, if we create a hard link to file "foo" in chunk A from
directory "bar" in chunk B, we will allocate a continuation inode for
directory "bar" in chunk B, and then allocate a block to contain the
link to "foo" in chunk B.  Once again, to find the link count of every
inode in chunk B, we only have to look at directories inside of chunk
B.  There are still problems that require checking across chunks, but
we only need to read inodes and directory entries in those cases and
the checks are much simpler than in existing fsck.

One interesting possibility would be to combine this with the ext2
dirty bit patches.  They create a clean/dirty bit for an ext2 file
system.  If the system crashes while the file system is being written
to, the bit is set to dirty and we do a full fsck.  If the system
crashes while it's inactive, the bit is clean, and all we have to do
is a little bit of orphan inode cleanup before mounting.  If we
implement chunkfs on top of this, we could get away with fsck'ing only
a few of the file systems each time, getting ext2-style performance
with ext3-style fast recovery.

I measured the number of different block groups that were
simultaneously dirty on my laptop's file system as a proxy for how
many chunks would be dirty; it turns out that on average most block
groups were clean 98% of the time, and when I really pushed my
(admittedly dinky) disk I/O system with an artificial load, only a
maximum of 25% of the block groups were dirty during any one second
period.  So it's tempting... We'll talk about it more next week, I
hope.

-VAL

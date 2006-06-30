Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbWF3T1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWF3T1y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 15:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbWF3T1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 15:27:54 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:14230 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964829AbWF3T1x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 15:27:53 -0400
Subject: Re: Proposal and plan for ext2/3 future development work
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Jeff Garzik <jeff@garzik.org>, "Theodore Ts'o" <tytso@mit.edu>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060630182457.GH11640@ca-server1.us.oracle.com>
References: <E1Fvjsh-0008Uw-85@candygram.thunk.org>
	 <44A47B0D.7020308@garzik.org>
	 <20060630015903.GE11640@ca-server1.us.oracle.com>
	 <1151687586.339.5.camel@dyn9047017100.beaverton.ibm.com>
	 <20060630182457.GH11640@ca-server1.us.oracle.com>
Content-Type: text/plain
Date: Fri, 30 Jun 2006 12:29:52 -0700
Message-Id: <1151695792.339.19.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-30 at 11:24 -0700, Joel Becker wrote:
> On Fri, Jun 30, 2006 at 10:13:06AM -0700, Badari Pulavarty wrote:
> > I tried adding "delayed allocation" for ext3 earlier. Yes. VFS level
> > infrastructure would be nice. But, I haven't found much that we can
> > do at VFS - which is common across all the filesystems (except
> > mpage_writepage(s) handling). Most of the stuff is specific to 
> > filesystem implementation (even though it could be common) - coming
> > out with VFS level interfaces to suite all the different filesystem
> > delalloc would be *interesting* exercise.
> 
> 	Well, to be fair, I'm just going by what little I know about
> XFS.  They maintain a cache of all pages waiting on delayed allocation
> for writepack.  Why have this entire cache (hash, list, whatever) when
> we could create some state on in the pagecache?  We save a large chunk
> of memory and some complex writeback code.  I suspect you were thinking
> of this when you said "mpage_writepage(s) handling".  But this is a
> large complexity win if we can do it.
> 	The same with metadata/data ordering issues.  ie, data=ordered
> or even plain "creat(2); write(2)".  I don't know how generic the
> ordering is for each filesystem, but there is always room for play.
> 	On-disk, of course each filesystem is going to be different.
> I'm not sure we could fit a fully-generic aops->reserve_space() &
> aops->commit_space() API.  But I don't think we need to.

Unfortunately, I haven't looked at XFS delalloc implementation indetail
to understand what exact they would need from VFS (or could be pushed to
VFS). I purely tried to work with current ext3 code and current VFS
support. What I find is that -

1) Instead of allocating a block at prepare time, we need to be able to
"reserve" a block (so it won't file as part of writeback). And, as 
part of writeback - we need a way to figure out if a given page did
indeed really reserve the block. (we need to make sure the allocation
succeeds for those). We might need a pageflag for this (but I haven't
decided that its absolutely needed).

2) Needed a way to cluster bunch of (contig) pages and allocate disk
blocksfor those in a single shot - which is NOT a direct delalloc
requirement, but that is the whole reason for doing delalloc. 
(Suprana did few radix_tree interfaces for this).

Other than these general VFS level ones - I had to play with journal
lock ordering issues (very specific to ext3 stuff). To work around
the journalling issues, I had to do my own mpage_writepages() since 
the changes I need are specific to ext3 journalling - I am not sure
if they are going to be useful for other filesystems or not.

If you can think of general infrastructure you need for OCFS2, please
let me know - we can come with commonality.


Thanks,
Badari



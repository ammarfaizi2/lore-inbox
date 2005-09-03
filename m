Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161137AbVICFNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161137AbVICFNI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 01:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161135AbVICFNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 01:13:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50835 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161134AbVICFNG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 01:13:06 -0400
Date: Sat, 3 Sep 2005 13:18:41 +0800
From: David Teigland <teigland@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: GFS, what's remaining
Message-ID: <20050903051841.GA13211@redhat.com>
References: <20050901104620.GA22482@redhat.com> <20050901035939.435768f3.akpm@osdl.org> <1125586158.15768.42.camel@localhost.localdomain> <20050901132104.2d643ccd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050901132104.2d643ccd.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 01:21:04PM -0700, Andrew Morton wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > > - Why GFS is better than OCFS2, or has functionality which OCFS2 cannot
> > >   possibly gain (or vice versa)
> > > 
> > > - Relative merits of the two offerings
> > 
> > You missed the important one - people actively use it and have been for
> > some years. Same reason with have NTFS, HPFS, and all the others. On
> > that alone it makes sense to include.
> 
> Again, that's not a technical reason.  It's _a_ reason, sure.  But what are
> the technical reasons for merging gfs[2], ocfs2, both or neither?
> 
> If one can be grown to encompass the capabilities of the other then we're
> left with a bunch of legacy code and wasted effort.

GFS is an established fs, it's not going away, you'd be hard pressed to
find a more widely used cluster fs on Linux.  GFS is about 10 years old
and has been in use by customers in production environments for about 5
years.  It is a mature, stable file system with many features that have
been technically refined over years of experience and customer/user
feedback.  The latest development cycle (GFS2) has focussed on improving
performance, it's not a new file system -- the "2" indicates that it's not
ondisk compatible with earlier versions.

OCFS2 is a new file system.  I expect they'll want to optimize for their
own unique goals.  When OCFS appeared everyone I know accepted it would
coexist with GFS, each in their niche like every other fs.  That's good,
OCFS and GFS help each other technically even though they may eventually
compete in some areas (which can also be good.)

Dave

Here's a random summary of technical features:

- cluster infrastructure: a lot of work, perhaps as much as gfs itself,
  has gone into the infrastructure surrounding and supporting gfs
- cluster infrastructure allows for easy cooperation with CLVM
- interchangable lock/cluster modules:  gfs interacts with the external
  infrastructure, including lock manager, through an interchangable
  module allowing the fs to be adapted to different environments.
- a "nolock" module can be plugged in to use gfs as a local fs
  (can be selected at mount time, so any fs can be mounted locally)
- quotas, acls, cluster flocks, direct io, data journaling,
  ordered/writeback journaling modes -- all supported
- gfs transparently switches to a different locking scheme for direct io
  allowing parallel non-allocating writes with no lock contention
- posix locks -- supported, although it's being reworked for better
  performance right now
- asynchronous locking, lock prefetching + read-ahead
- coherent shared-writeable memory mappings across the cluster
- nfs3 support (multiple nfs servers exporting one gfs is very common)
- extend fs online, add journals online
- full fs quiesce to allow for block level snapshot below gfs
- read-only mount
- "specatator" mount (like ro but no journal allocated for the mount,
  no fencing needed for failed node that was mounted as specatator)
- infrastructure in place for live ondisk inode migration, fs shrink
- stuffed dinodes, small files are stored in the disk inode block
- tunable (fuzzy) atime updates
- fast, nondisruptive stat on files during non-allocating direct-io
- fast, nondisruptive statfs (df) even during heavy fs usage
- friendly handling of io errors: shut down fs and withdraw from cluster
- largest GFS cluster deployed was around 200 nodes, most are much smaller
- use many GFS file systems at once on a node and in a cluster
- customers use GFS for: scientific apps, HA, NFS serving, database,
  others I'm sure
- graphical management tools for gfs, clvm, and the cluster infrastruture
  exist and are improving quickly


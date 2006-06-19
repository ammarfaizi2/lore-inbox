Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWFSRUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWFSRUN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 13:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWFSRUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 13:20:13 -0400
Received: from thunk.org ([69.25.196.29]:22417 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S964810AbWFSRUL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 13:20:11 -0400
Date: Mon, 19 Jun 2006 13:20:14 -0400
From: Theodore Tso <tytso@mit.edu>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 5/8] inode-diet: Eliminate i_blksize and use a per-superblock default
Message-ID: <20060619172014.GD15216@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
References: <20060619152003.830437000@candygram.thunk.org> <20060619153109.817554000@candygram.thunk.org> <20060619155821.GA27867@infradead.org> <20060619161651.GS29684@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619161651.GS29684@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 09:16:51AM -0700, Joel Becker wrote:
> On Mon, Jun 19, 2006 at 04:58:21PM +0100, Christoph Hellwig wrote:
> > Blease don't add a field to the superblock for the optimal I/O size.
> > Any filesystem that wants to override it can do so directly in ->getattr.
> 
> 	I don't disagree with you, but the idea of everyone implementing
> ->getattr where they just let it work before scares me.  It's a ton of
> cut-n-paste error waiting to happen.  Especially if we make something
> stale.
> 	Perhaps add generic_fillattr_blksize()?

Well, as far as I know the only filesystems today that would need to
do something different are xfs, ocfs2, and reiserfs, and IMHO only the
first two have any kind of justification for doing it.  Part of the
problem is what st_blksize actually means was never well-defined; it
was never in POSIX, and in SuSv3 all that is stated is, "A file
system-specific preferred I/O block size for this object."  This is
why Reiserfs got away with specifying 128 megs (I assume it helped on
some benchmark), and why being ill-defined, using such a large value
might cause some applications (like /bin/cp) to core dump.   

Given that most filesystems use the generic page cache read/write
functions, using PAGE_CACHE_SIZE as the default seems to make a huge
amount of sense.  I really wonder how useful setting st_blksize really
is, actually, at least in the real-world, as opposed to just for
benchmarks.

						- Ted

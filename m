Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030335AbWFJGWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbWFJGWJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 02:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030322AbWFJGWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 02:22:09 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:48048 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1030306AbWFJGWH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 02:22:07 -0400
Date: Sat, 10 Jun 2006 00:22:13 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Valerie Henson <val_henson@linux.intel.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Alex Tomas <alex@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [Ext2-devel] Continuation Inodes Explained! (was Re: [RFC 0/13] extents and 48bit ext3)
Message-ID: <20060610062213.GZ5964@schatzie.adilger.int>
Mail-Followup-To: Valerie Henson <val_henson@linux.intel.com>,
	Matthew Wilcox <matthew@wil.cx>, Alex Tomas <alex@clusterfs.com>,
	Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
	Arjan van de Ven <arjan@linux.intel.com>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <m3r71ycprd.fsf@bzzz.home.net> <20060609153116.GM1651@parisc-linux.org> <20060610032623.GG10524@goober> <20060610052502.GY5964@schatzie.adilger.int> <20060610054111.GN10524@goober>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060610054111.GN10524@goober>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 09, 2006  22:41 -0700, Valerie Henson wrote:
> On Fri, Jun 09, 2006 at 11:25:02PM -0600, Andreas Dilger wrote:
> > This needs some extra data in the directory entry, which I've already
> > been thinking about for ext3, so if you are looking at implementing
> > this for ext3 I'd be happy to share some ideas.
> 
> Actually, it seems vaguely possible this could be implemented as a
> layer on top of any normal file system - just use files to store
> continuation inodes and the like.  Then you could use the file system
> that best suits your workload underneath.

That is basically Lustre.  One filesystem (the metadata filesystem, MDS)
holds just the pathnames and some EA data that points to other files
(these are essentially "file continuation inodes").  The data filesystems
(object storage filesystems, OST) have the file data RAID0 striped over
multipe OST "objects".  The objects are just regular files stored in
ext3 filesystems.

In clustered metadata Lustre (CMD) there are also continuation inodes for
files in a single directory, but currently a 2TB MDS filesystem is plenty
big for holding just filenames and inodes.

The same problems exist with Lustre that you have to face with the
continuation inode scheme - files that grow too large for a single
chunk, cross-chunk namespace links, etc.

Of course we'd be thrilled if there was a desire to implement Lustre
at a completely local-filesystem level (removing a lot of the networking
and required recovery mechanism), though it would also be desirable to
have the ability to move a filesystem from a local box to a distributed
filesystem (ala X11) without any changes.

> (Suparna has a paper in the next OLS talking about something related
> but not identical, check it out.)

Interesting, I'll have to take a look.

> forking might get rid of some constraints - e.g., an XFS fork could
> get rid of a lot of crufty compat code.

It continually amazes me that XFS even made it into the kernel as it
currently stands, because of the normally vehement objections to any
kind of abstraction of code.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.


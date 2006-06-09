Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030492AbWFIUQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030492AbWFIUQj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030487AbWFIUQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:16:39 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:13014 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1030489AbWFIUQi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:16:38 -0400
Date: Fri, 9 Jun 2006 14:16:44 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alex Tomas <alex@clusterfs.com>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609201643.GG5964@schatzie.adilger.int>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Alex Tomas <alex@clusterfs.com>, Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@osdl.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, cmm@us.ibm.com,
	linux-fsdevel@vger.kernel.org
References: <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org> <20060609181020.GB5964@schatzie.adilger.int> <Pine.LNX.4.64.0606091114270.5498@g5.osdl.org> <m31wty9o77.fsf@bzzz.home.net> <Pine.LNX.4.64.0606091137340.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606091137340.5498@g5.osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 09, 2006  11:38 -0700, Linus Torvalds wrote:
> On Fri, 9 Jun 2006, Alex Tomas wrote:
> > would "#if CONFIG_EXT3_EXTENTS" be a good solution then?
> 
> Let's put it this way:
>  - have you had _any_ valid argument at all against "ext4"?
> 
> Think about it. Honestly. Tell me anything that doesn't work?

It's funny that everyone is arguing to fork ext3 into ext4, for a feature
that will primarily allow it to work with large disks (that are already
here, not some wacky pipe dream of featuritis as Jeff thinks).  Yet the
same people that are advocating code duplication on a massive scale in
ext4 are against 5 lines of duplication between the VFS and a filesystem,
or in a couple of drivers here and there.

Having two copies of ext3 means we immediately get 2x the bugs, and
no guarantee that they will ever be fixed in ext3 (all of the ext3
maintainers will be solidly on the ext4 bandwagon if it comes to that).
It also means that two virtually identical copies of the same code
will be in memory at the same time (one for ext3 and another for ext4)
polluting the cache, even though some developers complain that a single
EXPORT_SYMBOL is "bloating" the kernel.  This also means two inode slabs
causing memory fragmentation, etc.

The other issue is that adding a new "ext4" filesystem type will cause
userspace tools to break that assume they know something about the
filesystem type.  They will all detect the filesystem as "ext3" and try
to mount it as such, when the required kernel filesystem is ext4.  Or
we will need to have "mkfs.ext4", "fsck.ext4", etc, for no particular
reason.

Either a system upgrades totally to ext4 to avoid the duplication of code
in memory (and breaks ALL backward compatibility, for no good reason), or
it lives with "only mount filesystems as 'ext4' when they need it" and the
code will rarely be used.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.


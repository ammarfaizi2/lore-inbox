Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbWFIWz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWFIWz7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 18:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbWFIWz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 18:55:59 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:709 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932293AbWFIWz6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 18:55:58 -0400
Date: Fri, 9 Jun 2006 16:56:04 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Dave Jones <davej@redhat.com>, Theodore Tso <tytso@mit.edu>,
       Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609225604.GK5964@schatzie.adilger.int>
Mail-Followup-To: Jeff Garzik <jeff@garzik.org>,
	Dave Jones <davej@redhat.com>, Theodore Tso <tytso@mit.edu>,
	Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	cmm@us.ibm.com, linux-fsdevel@vger.kernel.org
References: <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <m3k67qb7hr.fsf@bzzz.home.net> <4489A7ED.8070007@garzik.org> <20060609195750.GD10524@thunk.org> <20060609203803.GF3574@ca-server1.us.oracle.com> <20060609205036.GI7420@redhat.com> <4489E8EF.5020508@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4489E8EF.5020508@garzik.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 09, 2006  17:32 -0400, Jeff Garzik wrote:
> Dave Jones wrote:
> >Am I missing something fundamental that precludes the use of both
> >extent-based and current existing filesystems from the same code
> >simultaneously ?
> 
> Nothing precludes it.  The point is that introducing major format 
> changes inline in this manner just complicates the code progressively to 
> the point where your directory walking, inode block walking, and other 
> code winds up being
> 
> 	if (new)
> 		...
> 	else
> 		...
> 
> _anyway_, at which point it is essentially multiple independent 
> filesystems.  I guarantee this won't be the last fundamental fs metadata 
> design change people will want to make...

Umm, and how is this fundamentally different from similar code paths in
the VFS (e.g. O_DIRECT vs regular writes)?  Should we make a copy of the
whole write path for each of O_DIRECT, AIO, pwrite, etc writes, or should
we instead add in a small change to the write path than leverages the
majority of the existing code?

What is better, using the 95% of the VFS that is common and change 5% to
work with the filesystem, or duplicate the whole VFS just because 5%
needs to be different?


In the extents case, the large majority of the ext3 code is the same
(directory, inode handling, superblock, etc) and only the on-disk format
for indirect blocks has changed.  Yes, we also want to change the block
allocator next in order to improve the performance in conjunction with
extents, but that is purely an in-memory change that has no direct
relation to on-disk layout.  The major motivations for the extents format:
(a) more compact on-disk representation for large files (improves unlink
    performance, reduces memory usage for metadata)
(b) support for larger filesystems (which will affect everyone soon enough).
(c) integrate well with improved allocation support

For most of the ext3 developers (b) is the primary motivation here, and
given that so many people are vocal about ext3 changes that must mean
that there are a lot of ext3 users here.  Does that mean that in the next
few years all of the objectors will abandon ext3 in favour of ext4 or XFS
or JFS or reiserfs or reiser4 when you get a new system with a single 12TB
disk?  And we can delete ext3 then, or will you be happy then that ext3
supports these large disks without any effort on your part?

Maybe we should start by deleting ext2 because it is old and obsolete?
The reality is that we will never merge the forks back once they are made.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.


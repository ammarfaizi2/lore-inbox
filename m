Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbWFIIfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWFIIfU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 04:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWFIIfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 04:35:20 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:12683 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751446AbWFIIfR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 04:35:17 -0400
Date: Fri, 9 Jun 2006 02:35:23 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: cmm@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609083523.GQ5964@schatzie.adilger.int>
Mail-Followup-To: Jeff Garzik <jeff@garzik.org>, cmm@us.ibm.com,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-fsdevel@vger.kernel.org
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <4488E1A4.20305@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4488E1A4.20305@garzik.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 08, 2006  22:49 -0400, Jeff Garzik wrote:
> One of my common complaints about massive ext3 updates such as this is 
> the ever-growing "which ext3 filesystem am I mounting?" problem.
> 
> I really think extents and 48bit-ness should imply
> 	cp -a fs/ext3 fs/ext4
> and go from there.

The problem with this approach (as seen with ext2 and ext3) is that one
tree or the other gets stale w.r.t. bug fixes and now we have the case
where ext2 has a noticably different implementation in some areas and
bug fixes are no longer trivial to apply to both trees.

I think all of the ext3 maintainers think this split was a bad idea in
hindsight, and having an ext3 mode where it can mount without a journal
would be much more desirable.

> IMHO the ext3 back-compat situation is already really hairy, with all 
> the features added since the original ext3 release.

While partially true, ext2/ext3 has a very good history w.r.t. compatibility
(with one exception being the EAs on symlinks problem that slipped through
with selinux).

Yes, the extents format will be incompatible with older ext3, but it isn't
enabled by default so it will be completely up to the sysadmin when they
make their filesystem incompatible.  They also won't impact any existing
files.  The earlier extents support gets into a kernel.org kernel the
more systems will be able to mount a filesystem with the changes when
they becomes widely used.

All of the other features that are going to be introduced will only going
to be applicable for format time (filesystems larger than 16TB), or if
exceeding limits of the current ext3 support (e.g. files larger than 2TB
in size).

> People (including me) still switch back and forth between ext2 and ext3 
> mounts of the same filesystem on occasion.  I think creating an "ext4" 
> would allow for greater developer flexibility in implementing new 
> features and ditching old ones -- while also emphasizing to the user 
> that switching back and forth between ext4 and ext[23] is a bad idea.

While this is partly true, one of the big benefits is that you can
transparently upgrade your system to use the new features and improve
performance without a long outage window.  Having a completely separate
ext4 filesystem doesn't improve the compatibility story at all.  There
has been renewed discussion on implementing "mounting ext3 without a
journal", just for a recovery mode, because ext2 will not be modified
to get all of these features (running e2fsck on a huge filesystem each
reboot would be insane).


> Overall, after applying extent (and 48bit) patches, I think it is wrong 
> to keep calling it ext3.  That will break some existing user 
> assumptions, and continue to restrict developers' freedom to implement 
> nifty new features.

Just FYI, all of the ext3 developers are on board with this patch series
and it has been discussed and reviewed for many weeks already, it isn't
just being pushed by one party.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.


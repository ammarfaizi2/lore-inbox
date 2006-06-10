Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbWFJCqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbWFJCqB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 22:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWFJCqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 22:46:00 -0400
Received: from sccrmhc11.comcast.net ([63.240.77.81]:19090 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932283AbWFJCp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 22:45:59 -0400
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
From: Nicholas Miell <nmiell@comcast.net>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Valdis.Kletnieks@vt.edu, Alex Tomas <alex@clusterfs.com>,
       Jeff Garzik <jeff@garzik.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Mingming Cao <cmm@us.ibm.com>, linux-fsdevel@vger.kernel.org
In-Reply-To: <20060610020900.GU5964@schatzie.adilger.int>
References: <44898476.80401@garzik.org> <m33beee6tc.fsf@bzzz.home.net>
	 <4489874C.1020108@garzik.org> <m3y7w6cr7d.fsf@bzzz.home.net>
	 <44899113.3070509@garzik.org>
	 <170fa0d20606090921x71719ad3m7f9387ba15413b8f@mail.gmail.com>
	 <m3odx2b86p.fsf@bzzz.home.net>
	 <200606092252.k59Mqc2Q018613@turing-police.cc.vt.edu>
	 <20060609232108.GM5964@schatzie.adilger.int>
	 <200606100121.k5A1LDjR004186@turing-police.cc.vt.edu>
	 <20060610020900.GU5964@schatzie.adilger.int>
Content-Type: text/plain
Date: Fri, 09 Jun 2006 19:45:55 -0700
Message-Id: <1149907555.2340.7.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-09 at 20:09 -0600, Andreas Dilger wrote:
> On Jun 09, 2006  21:21 -0400, Valdis.Kletnieks@vt.edu wrote:
> > On Fri, 09 Jun 2006 17:21:08 MDT, Andreas Dilger said:
> > > You mount with the new kernel without "-o extents", and find files with
> > > extents "lsattr -R /mnt/tmp | awk '/----e / print { $2 }'", copy those
> > > files, mv over old files, unmount.
> > 
> > How do you "copy those files" when you don't have extent support at that
> > point?  Remember - the whole problem here is that if you don't have
> > extent support, you can't read the file, it's backward-incompatible.
> > (If you *are* able to read the file even without extents, then this whole
> > thread is total BS).
> 
> The "-o extents" mount option only affects new files that are created
> while that option is enabled.  It doesn't affect existing files (even if
> they are modified while "-o extents" is set).  It also doesn't affect any
> new files after "-o extents" is removed.  Also, directories will not
> be extent-mapped, because their allocation pattern doesn't mix well with
> extent-mapped files (i.e. they are mostly single-block allocations).
> 
> Files that are created with "-o extents" are of course only readable with
> a kernel that supports it.  To be safe, the whole filesystem is marked
> with an EXT3_FEATURE_INCOMPAT_EXTENTS flag when the first extent file
> is created so that users don't inadvertently get strange errors while
> accessing the inodes marked with EXT3_EXTENT_FL with an old kernel.
> New kernels that understand INCOMPAT_EXTENTS of course can access extent
> and non-extent files equally well.
> 
> In an emergency it would also be possible to remove the INCOMPAT_EXTENTS
> filesystem flag and access all of the non-extent files, but this would
> risk filesystem corruption if any of the extent files were modified or
> unlinked, as that is the only indication older kernels have of this change.
> 
> So, to answer your question, if you _really_ want to get rid of extents
> on a filesystem, you mount the filesystem with INCOMPAT_EXTENTS on a new
> kernel that supports extents, but without -o extents so new files will
> use the old block-map layout, so if "orig-file" is an extent-mapped file:
> 
> 	cp /mnt/tmp/orig-file /mnt/tmp/temp-block-mapped-file
> 	mv /mnt/tmp/temp-block-mapped-file /mnt/tmp/orig-file
> 
> and now /mnt/tmp/orig-file is no longer extent-mapped.  Do this for all
> the extent-mapped files, unmount, use "debugfs -w -R 'feature ^extents' {dev}"
> and your filesystem is mountable with any old kernel.
> 
> No, it's not quite as easy as ext3 journal recovery->ext2 mounting,
> but then again "-o extents" isn't something that happens automatically
> (at least not for a couple of years, and hopefully distros will be smart
> enough never to do this for filesystems like /boot or / that are critical
> for mounting on a wide variety of kernels.  Besides which, we don't want
> to have to teach GRUB about extent-mapped files.  Concievably, if this
> becomes an issue then it should be possible to add a flag to inodes and
> parent directories to add a "no extents" flag that is inherited by new
> files that should never be extent mapped.
> 
> Cheers, Andreas
> --
> Andreas Dilger
> Principal Software Engineer
> Cluster File Systems, Inc.


I think changing all of this mess to:

[root@localhost root]# tune2fs -O extents /dev/whatever
WARNING: Enabling extents on /dev/whatever will make this filesystem
unreadable in Linux kernels versions before 2.6.19!
Are you sure you want to do this? <y/n>

[root@localhost root]# tune2fs -O ^extents /dev/whatever
WARNING: Disabling extents on /dev/whatever requires you to run e2fsck
on this filesystem before it can be used again!
Are you sure you want to do this? <y/n>

might assuage many of the fears presented in this thread.
-- 
Nicholas Miell <nmiell@comcast.net>


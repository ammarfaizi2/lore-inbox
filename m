Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265791AbSKFQdj>; Wed, 6 Nov 2002 11:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265807AbSKFQdi>; Wed, 6 Nov 2002 11:33:38 -0500
Received: from thunk.org ([140.239.227.29]:13218 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S265791AbSKFQdh>;
	Wed, 6 Nov 2002 11:33:37 -0500
Date: Wed, 6 Nov 2002 11:39:15 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Keith Owens <kaos@ocs.com.au>
Cc: Andreas Dilger <adilger@clusterfs.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-rc1 dirty ext2 mount error
Message-ID: <20021106163915.GA8072@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Keith Owens <kaos@ocs.com.au>,
	Andreas Dilger <adilger@clusterfs.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20021106084143.GN588@clusterfs.com> <24197.1036579429@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24197.1036579429@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 09:43:49PM +1100, Keith Owens wrote:
> VFS said that / was ext2, init ran fsck.ext2 against /, fstab says /
> whoudl be ext2 and mount claims that it is ext2.  Lies!  It is still
> ext3, the only indication is that lsmod shows a use count of 1 against
> ext3.  Crashing out of this kernel and into 2.4.20-rc1 which has no
> initrd gets the error.  And I thought I had got rid of ext3 ...

Not a kernel bug.  Let's break this down....

(BTW this is why I'm not all that fond of initrd at all.  In fact, I
have a very strong distatse for initrd....)

> Linux version 2.4.18-14smp (bhcompile@stripples.devel.redhat.com) (gcc
> version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #1 SMP Wed Sep 4
> 12:34:47 EDT 2002
> has ext2 built in but it boots with initrd containing ext3 as a module.
> VFS: Mounted root (ext2 filesystem)

The kernel mounted the initrd filesystem here, which was ext2 based.

> ...
> Loading jbd module
> Journalled Block Device driver loaded 
> Loading ext3 module
> Mounting root filsystem
> EXT3-fs: mounted filesystem with ordered data mode

This is where the initrd system mounted the (real) root filesystem as
ext3, and then did the pivotroot to switch the root filesystem from
the initrd ramdisk to the real root filesystem.

> init starts ...
> [/sbin/fsck.ext2 (1) -- /] fsck.ext2 -a /dev/sda1 [PASSED]

init doesn't actually run fsck.ext2.  Instead, init runs /etc/rc, and
that in turn runs fsck, and fsck consults /etc/fstab to determine
which fsck to run.  (So does mount when it creates /etc/mtab file
after the root filesystem is remount read-write.)

The reason why I haven't had fsck consult /proc/mounts is that it
would be a special-case thing that only makes sense for the root
filesystem, since that's the only filesystem which should be mounted
at the time fsck runs.  Since fsck.ext2 and fsck.ext3 are identical,
changing fsck so that it uses /proc/mounts is a rather moot change,
aside from the cosmetic details of what fsck prints out.

							- Ted

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131733AbRCXRoK>; Sat, 24 Mar 2001 12:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131732AbRCXRoB>; Sat, 24 Mar 2001 12:44:01 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:55216 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131729AbRCXRnv>;
	Sat, 24 Mar 2001 12:43:51 -0500
Date: Sat, 24 Mar 2001 12:43:06 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jorgen Cederlof <jorgen.cederlof@cendio.se>
cc: torvalds@transmeta.com, alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bug in do_mount()
In-Reply-To: <20010324182853.A4090@ondska>
Message-ID: <Pine.GSO.4.21.0103241230110.11914-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Mar 2001, Jorgen Cederlof wrote:

> > kill_super() releases the reference stored in ->s_type (created
> > by get_sb_...()). If superblock stays alive you should not release it.
> 
> get_sb_...() will do get_filesystem() even if superblock stays alive.

Sigh... I see what happens, and yes, it's a bug, but fix is wrong.
The real problem is with get_sb_single(), not with do_mount().
get_sb_bdev() and get_sb_nodev() are actually fine and your fix will
break them.

The problem is in the way we keep count for FS_SINGLE - in my current
tree I switched to cleaner variant, but doing the same in 2.4 may be tricky.

_Probably_ the right way to deal with that (for the time being) is add
	if (fstype->fs_flags & FS_SINGLE)
		put_filesystem(fstype);
before the if (list_empty(...))

IOW, 
--- fs/super.c.old Sat Mar 24 12:39:23 2001
+++ fs/super.c     Sat Mar 24 12:39:56 2001
@@ -1412,6 +1412,8 @@
        return retval;
 
 fail:
+       if (fstype->fs_flags & FS_SINGLE)
+               put_filesystem(fstype);
        if (list_empty(&sb->s_mounts))
                kill_super(sb, 0);
        goto unlock_out;

should be OK for now. Once we get clean refcounting for struct super_block
we will be able to get rid of the kludges in that area completely.
								Al


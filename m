Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129691AbQKUBSc>; Mon, 20 Nov 2000 20:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129681AbQKUBSX>; Mon, 20 Nov 2000 20:18:23 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:61166 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129428AbQKUBSL>; Mon, 20 Nov 2000 20:18:11 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200011210047.eAL0lrt13257@webber.adilger.net>
Subject: [PATCH] ext2 COMPAT flag fixup
To: torvalds@transmeta.com
Date: Mon, 20 Nov 2000 17:47:53 -0700 (MST)
CC: Ext2 development mailing list <ext2-devel@lists.sourceforge.net>,
        Linux FS development list <linux-fsdevel@vger.kernel.org>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
this is the 2.4-test11-pre7 version of the ext2 COMPAT flag cleanup.  A
series of issues during ext3 testing brought this out, but it is equally
a bug under 2.2 and 2.4 kernels.  Basically, the ext2 COMPAT flags should
prevent a kernel from mounting a filesystem for which it doesn't understand
any INCOMPAT flags, and read-only mount a filesystem for which it doesn't
understand any RO_COMPAT flags.

On 2.2 and 2.4 kernels this isn't really true because we always set the
flags (e.g. LARGE_FILE or for ext3 RECOVERY) in the ext2 code, but these
flags are only checked at mount time if we have a rev 1 filesystem, and
are not checked at all on a remount read-write.

The patch does a few things:
- always check the compat flags, even if we have a rev 0 filesystem,
  because we previously set these flags on rev 0 filesystems (BUGFIX)
- when setting a flag on a rev 0 filesystem, update it to be a rev 1
  filesystem (fill in a few fields in the superblock) (BUGFIX)
- check the RO_COMPAT flags at remount time to ensure we don't read-write
  mount a filesystem we don't understand (BUGFIX)
- print a warning at mount time if flags are already set on a rev 0
  filesystem (e2fsck will verify if the flags are valid separately)
- removed duplicate s_compat fields from ext2_sb_info, to avoid problems
  with keeping on-disk and in-memory flags in sync (this was the original
  cause of the ext3 bug that started this)
- moves the SPARSE_SUPER flag checking into a helper routine that also
  tells you if the group has a superblock (cleaner code)
- move s_num_db_per_group handling to its own helper routine because of
  general cleanup, and future changes (per Ted and Stephen) that will
  happen with group descriptor layout

The patch has been OK'd by Stephen for ext3, and no complaints at least
from Ted (he is aware of the issues).

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

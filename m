Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265280AbSKEElR>; Mon, 4 Nov 2002 23:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265282AbSKEElQ>; Mon, 4 Nov 2002 23:41:16 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:37640
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S265280AbSKEElP>; Mon, 4 Nov 2002 23:41:15 -0500
Subject: bug in ext3 htree rename: doesn't delete old name, leaves ino with
	bad nlink
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Ext2 devel <ext2-devel@lists.sourceforge.net>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 04 Nov 2002 20:47:50 -0800
Message-Id: <1036471670.21855.15.camel@ixodes.goop.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've isolated the problem to rename not removing the old name under some
circumstances, leaving two names for a file with an nlink of 1.  This
will reliably reproduce the problem for me, under 2.4.19-ac4 and 2.4.19
(stock) w/ patch-ext3-dxdir-2.4.19-4.

Generate a new filesystem: this will create htree-bug.fs
$ sh genfs

# mkdir m
# mount -o loop htree-bug.fs m

$ gcc -o tickle tickle.c
$ ./tickle m/test
*** rename("drivers/scsi/psi240i.h", "drivers/scsi/psi240i.h.orig") failure:
stating drivers/scsi/psi240i.h
  ino=294
  nlink=1
stating drivers/scsi/psi240i.h.orig
  ino=294
  nlink=1
*** rename("drivers/scsi/sun3_scsi.h", "drivers/scsi/sun3_scsi.h.orig") failure:
stating drivers/scsi/sun3_scsi.h
  ino=350
  nlink=1
stating drivers/scsi/sun3_scsi.h.orig
  ino=350
  nlink=1

# umount m

$ e2fsck -f htree-bug.fs
e2fsck 1.30-WIP (30-Sep-2002)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Inode 294 ref count is 1, should be 2.  Fix<y>? yes

Inode 350 ref count is 1, should be 2.  Fix<y>? yes

Pass 5: Checking group summary information

htree-bug.fs: ***** FILE SYSTEM WAS MODIFIED *****
htree-bug.fs: 541/10240 files (0.2% non-contiguous), 1369/10240 blocks
exit status 1
$ debugfs htree-bug.fs 
debugfs 1.30-WIP (30-Sep-2002)
debugfs:  ncheck 294
Inode   Pathname
294     /test/drivers/scsi/psi240i.h
debugfs:  ncheck 350
Inode   Pathname
350     /test/drivers/scsi/sun3_scsi.h


I've put all the bits needed to reproduce the bug (genfs, tickle) at
http://www.goop.org/~jeremy/htree/


        J


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266043AbSKFTvc>; Wed, 6 Nov 2002 14:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266064AbSKFTvc>; Wed, 6 Nov 2002 14:51:32 -0500
Received: from relaydude.reardensteel.com ([64.160.169.119]:65289 "HELO
	relaydude.digeo.com") by vger.kernel.org with SMTP
	id <S266043AbSKFTv3>; Wed, 6 Nov 2002 14:51:29 -0500
Subject: bug in htree rename: doesn't delete old name, leaves ino with bad
	nlink
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Ext2 devel <ext2-devel@lists.sourceforge.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-XXosG75PINjsoUZ1dXam"
X-Mailer: Ximian Evolution 1.0.8 
Date: 04 Nov 2002 14:32:43 -0800
Message-Id: <1036449163.21006.9.camel@sherkaner.pao.digeo.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XXosG75PINjsoUZ1dXam
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I've isolated the problem to rename not removing the old name under some
circumstances, leaving two names for a file with an nlink of 1.  This
will reliably reproduce the problem for me, under 2.4.19-ac4 w/
patch-ext3-dxdir-2.4.19-4.

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
Inode	Pathname
294	/test/drivers/scsi/psi240i.h
debugfs:  ncheck 350
Inode	Pathname
350	/test/drivers/scsi/sun3_scsi.h

	J

--=-XXosG75PINjsoUZ1dXam
Content-Disposition: attachment; filename=genfs
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=genfs; charset=ISO-8859-1

# script to generate a filesystem

FS=3D${1:-htree-bug.fs}

dd 'count=3D40k' 'bs=3D1k' < /dev/zero > $FS
mke2fs -F -b4096 -j -J size=3D4 $FS
echo 'set_super_value hash_seed ac791939-995d-4962-bb03-86a0f8626a0c' | deb=
ugfs -w $FS

e2fsck -f $FS

--=-XXosG75PINjsoUZ1dXam
Content-Disposition: attachment; filename=tickle.c.gz
Content-Type: application/x-gzip; name=tickle.c.gz
Content-Transfer-Encoding: base64

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

--=-XXosG75PINjsoUZ1dXam--


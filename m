Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290728AbSA3XMA>; Wed, 30 Jan 2002 18:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290735AbSA3XLv>; Wed, 30 Jan 2002 18:11:51 -0500
Received: from mail.littlefeet-inc.com ([63.215.255.3]:16147 "EHLO
	ltfsd01.little-ft.com") by vger.kernel.org with ESMTP
	id <S290725AbSA3XLh>; Wed, 30 Jan 2002 18:11:37 -0500
Message-ID: <B9F49C7F90DF6C4B82991BFA8E9D547B1256F4@BUFORD.littlefeet-inc.com>
From: Kris Urquhart <kurquhart@littlefeet-inc.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: PROBLEM: ext2/mount - multiple mounts corrupts inodes
Date: Wed, 30 Jan 2002 15:07:19 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have investigated this problem to the best of my resources.  If someone
would
please direct me down some more avenues of discovery, I would greatly
appreciate 
it.  If someone would take the time and effort to duplicate this problem in
a 
different environment, I would be even more grateful.  Thanks.  -Kris

[1.] One line summary of the problem: 
A mount of an already mounted ext2 partition corrupts inodes if there have
been 
recent writes without an intervening sync.

[2.] Full description of the problem/report: 
I have a script that is not sure if an ext2 partition will already be
mounted, so 
it tries the mount and is happy if the exit status is 0 or 32 (already
mounted).  
This worked fine with the 2.2.17 kernel, but I started getting corrupted
inodes 
when I migrated to 2.4.

I see this problem only when I compile my own kernel, but not when I use a
stock
RedHat kernel.  I have searched the web, the RedHat kernel source rpm
patches, 
and the RedHat Bugzilla database, but I can't find anything useful.
 
My .config is very stripped down (see end of email).

I can easily recreate this problem on two very different hardware setups,
with 
two different compilers, and with multiple versions of the 2.4 kernel.

[3.] Keywords (i.e., modules, networking, kernel): 
ext2, mount, file systems, kernel

[4.] Kernel version (from /proc/version): 
Linux version 2.4.10 (kurquhart@bay.sw.littlefeet-inc.com) (gcc version
egcs-2.91.66 
19990314/Linux (egcs-1.1.2 release)) #1 Wed Jan 30 09:46:52 PST 2002

- I have also tried kernel versions 2.4.7 and 2.4.17, as well as gcc 2.96,
but no 
change.

[6.] A small shell script or example program which triggers the problem (if
possible) 
#!/bin/bash
DEVICE=./loopdev
MOUNT=/mnt/hd
umount $MOUNT
dd if=/dev/zero of=$DEVICE bs=1k count=5000
mke2fs -F $DEVICE
rm -rf $MOUNT
mkdir -p $MOUNT
mount -t ext2 -o loop $DEVICE $MOUNT
cp -r /bin/tar $MOUNT
cp -r /bin/zcat $MOUNT
#sleep 5
#sync
mount -t ext2 -o loop $DEVICE $MOUNT
find $MOUNT -ls
umount $MOUNT
umount $MOUNT

- A real block device can be used in place of the loop device, but is
obviously 
destructive.  I have tried local IDE drives (both solid state and magnetic),
as
well as NFS mounted SCSI drives.

- If either the sleep or the sync line is uncommented, then all is fine.

- Here is the output:
umount: /mnt/hd: not mounted
5000+0 records in
5000+0 records out
mke2fs 1.23, 15-Aug-2001 for EXT2 FS 0.5b, 95/08/09
Filesystem label=
OS type: Linux
Block size=1024 (log=0)
Fragment size=1024 (log=0)
1256 inodes, 5000 blocks
250 blocks (5.00%) reserved for the super user
First data block=1
1 block group
8192 blocks per group, 8192 fragments per group
1256 inodes per group

Writing inode tables: done
Writing superblocks and filesystem accounting information: done

This filesystem will be automatically checked every 31 mounts or
180 days, whichever comes first.  Use tune2fs -c or -i to override.
     2    1 drwxr-xr-x   3 root     root         1024 Jan  1 01:11 /mnt/hd
    11   12 drwxr-xr-x   2 root     root        12288 Jan  1 01:11
/mnt/hd/lost+found
find: /mnt/hd/tar: Input/output error
find: /mnt/hd/zcat: Input/output error

- When a loop device is used, e2fsck finds nothing wrong after the two
umount commands, 
but does find problems if the second umount is commented out.  
- If a real block device is used, e2fsck finds problems in either case:
% e2fsck -f /dev/hda3
e2fsck 1.23, 15-Aug-2001 for EXT2 FS 0.5b, 95/08/09
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Entry 'tar' in / (2) has deleted/unused inode 12.  Clear<y>? yes

Entry 'zcat' in / (2) has deleted/unused inode 13.  Clear<y>? yes

Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Block bitmap differences:  -230 -231 -232 -233 -234 -235 -236 -237 -238 -239
-240 
-241 -242 -243 -244 -245 -246 -247 -248 -249 -250 -251 -252 -253 -254 -255
-256 
-257 -258 -259 -260 -261 -262 -263 -264 -265 -266 -267 -268 -269 -270 -271
-272 
-273 -274 -275 -276 -277 -278 -279 -280 -281 -282 -283 -284 -285 -286 -287
-288 
-289 -290 -291 -292 -293 -294 -295 -296 -297 -298 -299 -300 -301 -302 -303
-304 
-305 -306 -307 -308 -309 -310 -311 -312 -313 -314 -315 -316 -317 -318 -319
-320 
-321 -322 -323 -324 -325 -326 -327 -328 -329 -330 -331 -332 -333 -334 -335
-336 
-337 -338 -339 -340 -341 -342 -343 -344 -345 -346 -347 -348 -349 -350 -351
-352 
-353 -354 -355 -356 -357 -358 -359 -360 -361 -362 -363 -364 -365 -366 -367
-368 
-369 -370 -371 -372 -373 -374 -375 -376 -377 -378 -379 -380 -381 -382 -383
-384 
-385 -386 -387 -388 -389 -390 -391 -392 -393 -394 -395 -396 -397 -398 -399
-400 
-401 -402 -403 -404 -405 -406 -407 -408 -409 -410 -411 -412 -413 -414 -415
-416 
-417 -418 -419 -420 -421 -422 -423 -424 -425 -426 -427 -428 -429 -430
Fix<y>? yes

Free blocks count wrong for group #0 (7762, counted=7963).
Fix<y>? yes

Free blocks count wrong (12919, counted=13120).
Fix<y>? yes

Inode bitmap differences:  -12 -13
Fix<y>? yes

Free inodes count wrong for group #0 (1683, counted=1685).
Fix<y>? yes

Free inodes count wrong (3379, counted=3381).
Fix<y>? yes


/dev/hda3: ***** FILE SYSTEM WAS MODIFIED *****
/dev/hda3: 11/3392 files (0.0% non-contiguous), 446/13566 blocks

[7.] Environment 
I have this problem on two very different systems: an AMD 586 133MHz 32Mb 
RAM with a 16Mb flash drive, and an Intel Celeron 600MHz 128Mb RAM with
large 
IDE drives.  I can provide more details if desired.

[X.] Other notes, patches, fixes, workarounds: 
Non-comment lines of .config for 2.4.10:
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_MODULES=y
CONFIG_M486=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=4
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_NOHIGHMEM=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=20000
CONFIG_BLK_DEV_INITRD=y
CONFIG_PACKET=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK_DEV=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_CS89x0=y
CONFIG_PPP=y
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_BSDCOMP=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=2048
CONFIG_RTC=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_MSDOS_PARTITION=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y

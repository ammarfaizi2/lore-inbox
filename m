Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268792AbRHWPrc>; Thu, 23 Aug 2001 11:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268957AbRHWPrN>; Thu, 23 Aug 2001 11:47:13 -0400
Received: from mhub-c2.tc.umn.edu ([160.94.128.45]:54209 "EHLO
	mhub-c2.tc.umn.edu") by vger.kernel.org with ESMTP
	id <S268792AbRHWPrK>; Thu, 23 Aug 2001 11:47:10 -0400
Date: Thu, 23 Aug 2001 10:47:24 -0500 (CDT)
From: Grant Erickson <erick205@umn.edu>
To: linux-kernel@vger.kernel.org, linuxppc-embedded@lists.linuxppc.org
cc: linux-xfs@oss.sgi.com
Subject: Root Aliases & Lock-ups on Mount w/ Initrd (was Re: initrd: couldn'tumount)
Message-Id: <Pine.SOL.4.20.0108230957440.4132-100000@garnet.tc.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been following the thread between Andreas Haumer, Daniel Wagner, and
Alan Cox about not being able to unmount an initrd volume for the past
week or so as I've recently run into two, somewhat related problems, which
I am unable to explain.

1) The 'chroot' command fails with a message on the console about busy
   inodes and d_count=9:

	cardmgr[13]: executing: './ide start hda'
	cardmgr[13]: exiting
	 hda: hda1 hda2
	Start mounting filesystem: ide0(3,1)
	Starting XFS recovery on filesystem: ide0(3,1) (dev: 3/1)
	Ending XFS recovery on filesystem: ide0(3,1) (dev: 3/1)  
	VFS: busy inodes on changed media.
	VFS: Mounted root (xfs filesystem).
	change_root: old root has d_count=9
	Freeing unused kernel memory: 60k init 4k openfirmware
	...

   Later, when I try to force unmount the initrd and call 'blockdev
   --flushbufs /dev/ram0' in rc.sysinit, it fails with a message about
   busy buffers:

	...
	umount'ing initrd
	BLKFLSBUF: Device or resource busy
	INIT: Entering runlevel: 3
	The system is coming up.
	...

   When the system is finally "up" I end up with two /initrd mount points,
   one on top the other:

	# cat /proc/mounts
	/dev/root /initrd/initrd ext2 rw 0 0
	/dev/root.old /initrd xfs rw,noatime 0 0
	proc /initrd/proc proc rw 0 0
	/dev/root / xfs rw,noatime 0 0
	/proc /proc proc rw 0 0
	none /dev/pts devpts rw 0 0

   The mount /initrd is the same as / (ls -i bears this out) and
   /initrd/initrd is the initial RAM disk.

   When I get the d_count=9 message and run fuser, the only processes
   running are those I'd expect--kernel threads and linuxrc (which should
   be disassociated with any files):

	fuser -mv /initrd
	                     USER        PID ACCESS COMMAND
	/initrd              0             1 .rc..  swapper
	                     0             2 .rc..  keventd
	                     0             3 .rc..  kswapd
	                     0             4 .rc..  kreclaimd
	                     0             5 .rc..  bdflush
	                     0             6 .rc..  kupdate
	                     0             7 .rc..  pagebuf_daemon
	                     0             8 fr.e.  linuxrc
	                     0            24 fr.e.  sh
	                     0        kernel mount  /proc

   This behavior happens regardless of whether or not the file system
   on the SANDisk is xfs or ext2. I suspect there must be something
   wrong in either the way I've written linuxrc or there's something
   awry in fs/super.c or fs/block_dev.c.

   Has anyone else tried this configuration successfully? Any insight?

2) The second issue I notice is that when the root file system is
   XFS, 1 time out of 20, the sytem freezes shortly after mounting:

	...
	Ending XFS recovery on filesystem: ide0(3,1) (dev: 3/1)
	[ Hang ]

   It hangs regardless of whether or not it does recovery.

   When I run ext2 as the root file system, 9 times out of 10, the system
   freezes shortly after mounting.

   Problem here might well be pivot_root rather than mount. Anyone seen
   similar such hangs?

The goal:

   - Launch an initrd to allow switching the root file system over to an
     XFS volume on the SanDisk device

The setup:
   
   - TI PCI 1420 CardBus controller   
   - SanDisk SDCFB-128, ATA DISK drive
   - Monta Vista Linux 2.4.2-mvista_010329
     * XFS 1.0.1 patches (yes, I realize that these should have been
       applied to 2.4.5; however, save a few files, they merged well onto
       2.4.2)
   - PowerPC 405GP Revision E
   - pcmcia-cs 3.1.27

The linuxrc:

PATH=/bin:/usr/bin:/sbin:/usr/sbin

mount -t proc /proc /proc
if [ -f /etc/pcmcia.conf ] ; then
    . /etc/pcmcia.conf
fi
PC=/lib/modules/default/pcmcia
insmod $PC/pcmcia_core.o $CORE_OPTS
insmod $PC/$PCIC.o $PCIC_OPTS
insmod $PC/ds.o
cardmgr $V -q -o -s /var/run/stab -p /tmp/cardmgr.pid
umount /proc
mount -t xfs -o noatime dev/hda1 mnt
cd mnt
pivot_root . initrd
exec chroot . sh -c 'bin/mount -t proc proc proc; echo "0x03010000" > \
proc/sys/kernel/real-root-dev' < dev/console > dev/console 2>&1

Any nudges in the right direction to a root cause would be greatly
appreciated.

Regards,

Grant 


-- 
 Grant Erickson                       University of Minnesota Alumni
  o mail:erick205@umn.edu                                 1996 BSEE
  o http://www.umn.edu/~erick205                          1998 MSEE


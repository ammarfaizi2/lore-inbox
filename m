Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271821AbTG2XUZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 19:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272216AbTG2XUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 19:20:25 -0400
Received: from pdp1.sys.toronto.edu ([128.100.2.234]:4480 "EHLO
	pdp1.sys.toronto.edu") by vger.kernel.org with ESMTP
	id S271821AbTG2XUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 19:20:14 -0400
Date: Tue, 29 Jul 2003 19:20:13 -0400
From: Dave Wortman <dw@pdp1.sys.toronto.edu>
Message-Id: <200307292320.h6TNKD406132@pdp1.sys.toronto.edu>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Fault in init/do_mounts.c/change_floppy{} ramdisk file system read failure
Cc: dw@pdp1.sys.toronto.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] Fault in init/do_mounts.c/change_floppy{} causes ramdisk file system 
     reads from floppy disks to fail

[2.] Full description of the problem/report:

     I an trying to build a standalone Linux system using the process described 
     in the Bootdisk-HOWTO.  HOWEVER I am using an *uncompressed* root file 
     system since I was unable to configure a compressed one that is small 
     enough to fit on a single floppy.  I built:
     - a boot floppy containing a bzImage Linux kernel and minimal 
       infrastructure that gets me to the point of being able to load a file 
       system from floppy onto ramdisk.  This is the same kernel that I
       use on my desktop every day.
     - an ext2 root file system (4000 blocks) that holds a minimal set of 
       files/programs
     - a set of 3 floppy disks that contains an uncompressed  copy of the 
       ext2 root file system
     
    When I try to boot the standalone system the following sequence of
    events occurs:
    - I load the boot floppy, and the kernel appears to load and
      initialize correctly.
    - The kernel prompts me to insert a floppy so it can load a file
      system onto ramdisk.
    - The code in init correctly determines that my floppy disk 
      contains an uncompressed ext2 file system.
    - in init/do_mounts.c  rd_load_image is called with argument "/dev/root"
    - the for loop in this function starts reading from the first
      floppy disk.  Cachunk, cachunk.
    - When 1440 1k block have been read, the function change_floppy is 
      called to move to the next floppy disk.
    - change_floppy does something BROKEN.  See below.
    - The for loop in rd_load_image continues to try and read in more
      uncompressed file system from the floppy, BUT THE READ DOES NOT
      ACCESS the floppy drive.  The reads in the for loop appear to
      succeed, but nothing is actually transfered from the floppy
      disk to the ramdisk.
    - The same read failure  happens for the third floppy disk.
    - The end result is that I have a partial root file system on
      ramdisk so nothing works after that.

   The problem appears to be caused by this code 
   in  init/do_mount.c/change_floppy{}

        fd = open("/dev/root", O_RDWR | O_NDELAY, 0);
        if (fd >= 0) {
                sys_ioctl(fd, FDEJECT, 0);
                close(fd);
        }

   When I comment this code out, init reads through the sequence of floppy 
   disks and correctly loads the uncompressed file system into a ramdisk.

[3.] Keywords: init do_mounts.c ramdisk "uncompressed ext2 file system"

[4.] Kernel version (from /proc/version):
     Linux version 2.4.20 (root@pdp1) (gcc version 2.95.2 19991024 (release)) 
     #14 Fri May 16 10:53:23 EDT 2003

[5.] Output of Oops: Not applicable

[6.] The problem can be reproduced by using dd to copy part of an existing root
     ext2 file system onto 2 floppies as follows:
	dd  if=<ROOT_DEV> of=/dev/fd0 bs=1k count=1440
        <CHANGE FLOPPY>
        dd  if=<ROOT_DEV> of=/dev/fd0 bs=1k count=1440 skip=1440
     (it doesn't matter that you haven't copied the whole file system,
      the read in init will fail on the second floppy).
     Then build a boot kernel on a floppy with append parameters
        load_ramdisk=1 prompt_ramdisk=1
     Boot from the floppy, the kernel will prompt for the first file system
     disk and correctly read it into a ramdisk.  It will prompt
     for the second floppy disk but the reads will fail, i.e. the
     kernel will never read from the floppy drive.

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)
       (This is from my running system which uses the same kernel as
        the boot floppy that failed)
Linux pdp1 2.4.20 #14 Fri May 16 10:53:23 EDT 2003 i686 unknown
Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.10.0.33
util-linux             2.10q
mount                  2.10q
modutils               2.4.1
e2fsprogs              1.27
pcmcia-cs              3.1.22
Linux C Library        x    1 root     root      1382179 Jan 19  2001 /lib/libc.so.6
Dynamic linker (ldd)   2.2
Procps                 2.0.7
Net-tools              1.57
Kbd                    1.02
Sh-utils               2.0
Modules Loaded         snd-seq-midi snd-seq-midi-event snd-seq snd-ens1370 snd-pcm snd-timer snd-rawmidi snd-seq-device snd-ak4531-codec snd soundcore

[7.2.] Processor information (from /proc/cpuinfo):
model name      : AMD Athlon(TM) XP 2000+

[7.3.] Module information (from /proc/modules):
       The system that fails never gets as far as loading modules.

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
       The system that fails never gets this far

[7.5.] PCI information ('lspci -vvv' as root)
       Not relevant to this problem

[7.6.] SCSI information (from /proc/scsi/scsi)
       Not relevant to this problem

[7.7.] Other information that might be relevant to the problem

The lilo configuration file on my boot floppy looks like this:

	boot	=/dev/fd0
	install =/boot/boot.b
	map     =/boot/map
	read-write
	backup	=/dev/null
	compact
	image	=/boot/vmlinuz
	append  ="prompt_ramdisk=1 load_ramdisk=1"
	label	=Standalone
	root	=/dev/fd0

The kernel thinks my floppy disk is:

	<6>Floppy drive(s): fd0 is 1.44M
	<6>FDC 0 is a post-1991 82077

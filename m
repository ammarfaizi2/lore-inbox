Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279708AbRKIIHz>; Fri, 9 Nov 2001 03:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279704AbRKIIHq>; Fri, 9 Nov 2001 03:07:46 -0500
Received: from [62.58.73.254] ([62.58.73.254]:50162 "EHLO
	ats-core-0.atos-group.nl") by vger.kernel.org with ESMTP
	id <S279684AbRKIIHi>; Fri, 9 Nov 2001 03:07:38 -0500
Date: Fri, 9 Nov 2001 09:01:49 +0100 (CET)
From: Ryan Sweet <rsweet@atos-group.nl>
To: <linux-kernel@vger.kernel.org>
Subject: some progress and questions: eepro100 on diskless smp servers (fwd)
Message-ID: <Pine.LNX.4.30.0111090901260.16932-100000@core-0>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I posted some of this before, but with less detail, so here it is again,
with feeling:

In the long and protracted saga of trouble-shooting my now 32 box dual cpu
diskless cluster, [1] I think I have managed to track the bug that causes
the random reboots (or at least some of them) down to the built-in
eepro100 driver.

I ran the boxes for several days with kdb on and though several times they
either locked up invoking kdb, or simply triple-faulted and reset again, I
did get at least one that dropped into kdb and allowed me to get some
info.  I didn't catch the first oops - for whatever reason the screen
output was blank, but I could see that I was in kdb by the flashing
keyboard lights, so I just told it to "go", whereupon I caught the second
oops, in syslogd, which was trying to log a message regarding the eepro100
being "out of resources".  [2] The kernel backtrace was not on the stack
(this is where it would help to know more about using kdb), but
looking at the btp info for all the other processes (in kernel and out) it
seems consistent with the network having gone away.

After finally seeing some people on lkml report symptoms similar in nature
to mine with on-board eepro100 systems back in Oct. I had been focusing my
suspicion on the eepro100 anyway, so this all makes some amount of sense.
Most of those folks all said the problem was better if they switched to
the intel e100 driver or the latest donald becker (scyld) version of
eepro100.c.  Trouble is, each of those is only available as a module,
normally built outside the kernel source tree.  Now it gets really
annoying:

	1) since I am using nfsroot, I need to use IP autoconfig in the
kernel (or do I?  I can't get it to work without this - is there a way
someone can point to to configure the network from an initrd _before_
mounting the root filesystem?
	2) ip autoconfig cannot be built as a module
	3) thus if the network card driver is a module, ip autoconfig
loads first, says "can't find a nic, go away" (not literal) and then the
kernel happily loads the nic driver module from the initrd, and since the
network is not configured it can't mount the root fs.
	4) so I concluded that I either need to a)not use nfsroot (on
diskless servers this means using a ramdisk root), or b)I need to build
one of the two aforementioned drivers into the kernel.

approach a) - root fs on a ramdisk:  This is the one I like the most,
because we have plenty of RAM to spare, it possibly offers a decent
speedup (at least we got a very noticeable speedup when we switched /tmp to
a ramdisk), and simplifies the design of the whole cluster.  So I took my
nfsroot filesystem, dumped it onto a ramdisk, zipped it up into an initrd
image (the 32MB on a 64MB ramdisk zips up to just 10MB!) and put it on the
server.  I setup etc/fstab on the ramdisk to use "/dev/ram0 / ext2
defaults 0 0", and set "root=/dev/ram0 initrd=ramdisk.img" in the kernel
command line params (passed with pxelinux).  The kernel is compiled with
64MB ramdisks by default.  The pxe loader grabs the kernel and the
ramdisk, boots, loads the ramdisk as the initrd, decompresses it, frees
the initrd space, allegedly mounts the initrd as root, and starts init,
but then does _nothing_ at all (sits there, still on the network, still
running init, but not doing the normal things that init does).  I
double-checked that all the devices were there, that the kernel ramdisk
support was there,  I made a /linuxrc on the ramdisk (it had been a
symlink to init) that was supposed to format /dev/ram0 as ext2 and mount
it under /mnt, copy the system to it and exit, but that also didn't work.
I tried using "init=bash" so I could have a look around, but I get the
same behavior - bash starts up (according to kdb), but doesn't do anything
at all.  /sbin/init is linked with libc6 and ld-linux both of which are
available on the ramdisk in /lib.

Can anyone give any hints on how to get a ramdisk root working?  The
bootdisk howto was helpful, but I think I've done everything it suggests.

approach b) - build e100 or the scyld eepro100 into the kernel: since
neither of these is distributed as a patch, I had two choices, try and
integrate their sources into the kernel build, or build it out side the
kernel, but without -DMODULE (as their default makefiles use) and link the
resulting object file into the kernel during the kernel linking.  I tried
both ways with the e100 driver, and in the end it was the same:
drivers/net/net.o builds and links against it fine, but when the next to
last stage of the build happens (linking everything into .tmp.vmlinux
something or other), the linker complains about undefined references in
net.o to stuff that belongs to e100.  I tried adding the e100 object files
to the top-level makefile as well as to the drivers/net makefile (I'm
using 2.4.13 for testing, though I also tried it with 2.4.7), but of
course that didn't help either.

When I tried the same thing with the scyld eepro100 driver (broken
instructions at http://www.scyld.com/network/updates.html), I got it to
build a kernel, but the eepro100 driver never loads, as though it wasn't
really compiled in (even though all the linker messages say it was
linked).

Anyone have any pointers on integrating foreign sources into the kernel?

Is there a better way?  Can I get ip autoconfig to build as a module?  can
I configure the module nic driver for teh network before loading the
rootfs?

I will be eternally grateful for any advice or suggestions.

thanks,
-Ryan


[1] for a summary of my pain and suffering on this issue, search lkml for
my posts going back to June.  No, I haven't been working on just this all
that time.

[2] i can post the hand-transcribed kdb output if necessary

-- 
Ryan Sweet
ryan@end.org




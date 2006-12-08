Return-Path: <linux-kernel-owner+w=401wt.eu-S1425531AbWLHO7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425531AbWLHO7j (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 09:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938069AbWLHO7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 09:59:39 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:60635 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S938063AbWLHO7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 09:59:39 -0500
Message-ID: <45797DD8.6060301@ccr.jussieu.fr>
Date: Fri, 08 Dec 2006 15:59:36 +0100
From: Bernard Pidoux <pidoux@ccr.jussieu.fr>
Organization: Universite Pierre & Marie Curie - Paris 6
User-Agent: Thunderbird 1.5.0.8 (X11/20061109)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: dm_mirror and dm_mod modules incorrectly named and not found
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In kernel 2.6.19 and 2.6.18.5 I am facing a problem with two modules not
found : dm_mirror and dm_mod. (See my previous posting, for I am not
able to suppress these dependencies even if I unselect the option in
xconfig menu !).

These two modules are part of

Multiple devices driver support (RAID and LVM)
    Device mapper support
        Mirror target (EXPERIMENTAL)

which I validated.

Compile process built dm-mirror.ko and dm-mod.ko

make install complained that dm_mirror and dm_mod where not found.
Thus I guessed that the modules where incorrectly named.

I only patched Makefile for dm_mirror module name to verify my hypothesis.

--- linux/drivers/md/Makefile.old     2006-12-03 15:38:24.000000000 +0100
+++ linux/drivers/md/Makefile 2006-12-03 15:39:21.000000000 +0100
@@ -6,7 +6,7 @@
                   dm-ioctl.o dm-io.o kcopyd.o
 dm-multipath-objs := dm-hw-handler.o dm-path-selector.o dm-mpath.o
 dm-snapshot-objs := dm-snap.o dm-exception-store.o
-dm-mirror-objs := dm-log.o dm-raid1.o
+dm_mirror-objs := dm-log.o dm-raid1.o
 md-mod-objs     := md.o bitmap.o
 raid456-objs   := raid5.o raid6algos.o raid6recov.o raid6tables.o \
                   raid6int1.o raid6int2.o raid6int4.o \
@@ -34,7 +34,7 @@
 obj-$(CONFIG_DM_MULTIPATH)     += dm-multipath.o dm-round-robin.o
 obj-$(CONFIG_DM_MULTIPATH_EMC) += dm-emc.o
 obj-$(CONFIG_DM_SNAPSHOT)      += dm-snapshot.o
-obj-$(CONFIG_DM_MIRROR)                += dm-mirror.o
+obj-$(CONFIG_DM_MIRROR)                += dm_mirror.o
 obj-$(CONFIG_DM_ZERO)          += dm-zero.o

 quiet_cmd_unroll = UNROLL  $@
-

Then make modules

.....
  CC [M]  drivers/md/bitmap.o
  LD [M]  drivers/md/md-mod.o
  LD [M]  drivers/md/dm-mod.o
  LD [M]  drivers/md/dm_mirror.o
  Building modules, stage 2.
  MODPOST 546 modules
WARNING: Can't handle masks in drivers/ide/pci/atiixp:FFFF05
  CC      drivers/md/dm-mod.mod.o
  LD [M]  drivers/md/dm-mod.ko
  CC      drivers/md/dm_mirror.mod.o
  LD [M]  drivers/md/dm_mirror.ko
  CC      drivers/md/linear.mod.o
  LD [M]  drivers/md/linear.ko
  CC      drivers/md/md-mod.mod.o
  LD [M]  drivers/md/md-mod.ko
.....

make install_modules

  INSTALL drivers/md/dm-mod.ko
  INSTALL drivers/md/dm_mirror.ko
  INSTALL drivers/md/linear.ko
  INSTALL drivers/md/md-mod.ko

make install

sh /usr/src/linux-2.6.19/arch/i386/boot/install.sh 2.6.19
arch/i386/boot/bzImage System.map "/boot"
FATAL: Module dm_mirror not found.
FATAL: Module dm_mirror not found.
FATAL: Module dm_mod not found.
FATAL: Module dm_mod not found.

However, I checked that modules where in
/lib/modules/2.6.1.9.kernel/drivers/md/

ll /lib/modules/2.6.19/kernel/drivers/md/
total 169
-rw-r--r-- 1 root root 21879 déc  8 15:12 dm_mirror.ko
-rw-r--r-- 1 root root 58701 déc  8 15:12 dm-mod.ko
-rw-r--r-- 1 root root  6727 déc  8 15:12 linear.ko
-rw-r--r-- 1 root root 80744 déc  8 15:12 md-mod.ko

Thus, Makefile script is probably looking into the wrong directory to
find modules dm_mirror and dm_mod

Due to a lack of knowledge, I was not able to determine the actual
directory where make was looking nor to find out in which script part I
could change this.

Any idea ?


Bernard Pidoux


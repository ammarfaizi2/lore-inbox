Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWHIMYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWHIMYT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 08:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWHIMYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 08:24:19 -0400
Received: from natblert.rzone.de ([81.169.145.181]:29352 "EHLO
	natblert.rzone.de") by vger.kernel.org with ESMTP id S1750704AbWHIMYS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 08:24:18 -0400
Date: Wed, 9 Aug 2006 14:24:09 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: dependency errors in scripts/ and arch/powerpc/boot
Message-ID: <20060809122409.GA4596@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sam,

this script results in build errors because stuff in scripts/ and boot/
doesnt get rebuilt if the source dir changes. I was under the impression
that the absolute path of the source dir is part of the build dependency.
Even going from 2.6.18 to 2.6.17 fails.
This used to work with older kernels, I think.

#!/bin/bash
set -ex
mydir=/dev/shm/$PPID
numcpus=`grep -Ec '^cpu[0-9]' /proc/stat || echo 1`

rm -rf $mydir
mkdir -p $mydir
cd $mydir
mkdir O

tar xfz /mounts/mirror/kernel/v2.6/linux-2.6.17.8.tar.gz
tar xfz /mounts/mirror/kernel/v2.6/testing/linux-2.6.18-rc4.tar.gz
cd linux-2.6.18-rc4
cp arch/powerpc/configs/pseries_defconfig ../O/.config
yes '' | make -j$numcpus O=../O oldconfig > /dev/null
make -j$numcpus O=../O zImage > /dev/null
cd ../linux-2.6.17.8
make -j$numcpus O=../O zImage


...

+ cd ../linux-2.6.17.8
+ make -j14 O=../O zImage
  GEN     /dev/shm/13410/O/Makefile
  CHK     include/linux/version.h
  UPD     include/linux/version.h
  Using /dev/shm/13410/linux-2.6.17.8 as source for kernel
  GEN     /dev/shm/13410/O/Makefile
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/split-include
  HOSTCC  scripts/basic/docproc
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/kxgettext.o
  HOSTCC  scripts/kconfig/mconf.o
  HOSTCC  scripts/kconfig/zconf.tab.o
In file included from scripts/kconfig/zconf.tab.c:158:
scripts/kconfig/zconf.hash.c: In function ‘kconf_id_lookup’:
scripts/kconfig/zconf.hash.c:190: error: ‘T_OPT_DEFCONFIG_LIST’ undeclared (first use in this function)
scripts/kconfig/zconf.hash.c:190: error: (Each undeclared identifier is reported only once
scripts/kconfig/zconf.hash.c:190: error: for each function it appears in.)
scripts/kconfig/zconf.hash.c:190: error: ‘TF_OPTION’ undeclared (first use in this function)
scripts/kconfig/zconf.hash.c:203: error: ‘T_OPT_MODULES’ undeclared (first use in this function)
scripts/kconfig/zconf.tab.c: In function ‘zconfparse’:
scripts/kconfig/zconf.tab.c:1557: error: ‘TF_OPTION’ undeclared (first use in this function)
scripts/kconfig/zconf.tab.c:1557: error: invalid operands to binary &
scripts/kconfig/zconf.tab.c:1558: warning: implicit declaration of function ‘menu_add_option’
make[3]: *** [scripts/kconfig/zconf.tab.o] Error 1
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [silentoldconfig] Error 2
make[1]: *** [include/linux/autoconf.h] Error 2
make: *** [zImage] Error 2


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273541AbRI3Og7>; Sun, 30 Sep 2001 10:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273542AbRI3Ogt>; Sun, 30 Sep 2001 10:36:49 -0400
Received: from quechua.inka.de ([212.227.14.2]:14688 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S273541AbRI3Ogk>;
	Sun, 30 Sep 2001 10:36:40 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Makefile gcc -o /dev/null: the dissapearing of /dev/null
In-Reply-To: <20010929114304.A21440@lug-owl.de> <Pine.LNX.4.33.0109290535390.25966-100000@cerberus.stardot-tech.com>
Organization: private Linux site, southern Germany
Date: Sun, 30 Sep 2001 16:24:00 +0200
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E15nhVx-00017F-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So then you can no longer 'make modules && make modules_install', or you
> have to cp or chown /usr/src/linux on a fresh install to compile your
> kernel?   Doesn't sound pleasant to me.

I just do "MakeDist -a" as user and untar the result as root. Script appended.

Olaf

#!/bin/sh
# MakeDist - build Linux kernel installation tarballs
# written by Olaf Titz, 1999-2000. Public domain.
#
# Call this as MakeDist [-a] [kernel-source-dir]
#
# This will create two tarballs in the kernel source dir:
# boot-x.y.z.v contains /boot and /lib/modules stuff
# inc-x.y.z.v  contains /usr/src/linux-x.y.z/include
# The "v" name component is the build number from .version.
#
# The "-a" argument does a "make dep bzImage modules" cycle
# before building tarballs.
#

set -e
#J=-j2
J=""
buildall=false
if [ "$1" = "-a" ]; then
    buildall=true
    shift
fi

[ "$1" -a -d "$1" ] && cd "$1"
[ -e kernel/panic.c -a -d include/linux ] || { echo "usage: $0 srcdir"; exit 1; }

if $buildall ; then
    make dep
    rm -f make.log.0
    [ -f make.log ] && mv make.log make.log.0
    time make $J bzImage modules 2>&1 | tee make.log
fi

mkdir tmp 2>/dev/null || true
rm -rf tmp/boot tmp/lib tmp/usr 2>/dev/null

va=`sed -n 's/^#define UTS_RELEASE "\(.*\)".*$/\1/p' include/linux/version.h`
vb=`cat .version`
vc="$va.$vb"

mkdir tmp/boot
cp -p arch/i386/boot/bzImage tmp/boot/vmlinuz-$va
cp -p System.map tmp/boot/System.map-$va
cp -p .config tmp/boot/config-$va
make modules_install INSTALL_MOD_PATH=`pwd`/tmp
rm -f tmp/lib/modules/$va/build || true

echo "Creating boot-$vc.tar.gz"
( cd tmp; tar chzf ../boot-$vc.tar.gz boot lib )

mkdir -p tmp/usr/src/linux-$va/include
ARCH=`uname -m | sed 's/i.86/i386/;s/sun4u/sparc64/;s/arm.*/arm/;s/sa110/arm/'`
GENINC=`find include -mindepth 1 -maxdepth 1 \! -name 'asm*'`

cp -pR $GENINC include/asm-$ARCH tmp/usr/src/linux-$va/include
( cd tmp/usr/src/linux-$va/include; ln -s asm-$ARCH asm )
echo "Creating inc-$vc.tar.gz"
( cd tmp; tar czf ../inc-$vc.tar.gz usr )

rm -rf tmp/boot tmp/lib tmp/usr


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266086AbSKFUsa>; Wed, 6 Nov 2002 15:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266088AbSKFUsa>; Wed, 6 Nov 2002 15:48:30 -0500
Received: from mailout.zma.compaq.com ([161.114.64.103]:57094 "EHLO
	zmamail03.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S266086AbSKFUs3>; Wed, 6 Nov 2002 15:48:29 -0500
Date: Wed, 6 Nov 2002 14:51:50 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.46 and make menuconfig weirdness
Message-ID: <20021106145150.A17824@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm, I'm seeing weird stuff with 2.5.46 and make menuconfig:

[root@zuul lx2546]# make menuconfig
make[1]: `scripts/kconfig/mconf' is up to date.
make -f scripts/Makefile.build obj=scripts lxdialog
make -f scripts/Makefile.build obj=scripts/lxdialog
./scripts/kconfig/mconf arch/i386/Kconfig
[root@zuul lx2546]# echo $?
0

Huh?  It just exits.  So, ok, run strace:

[root@zuul lx2546]# strace ./scripts/kconfig/mconf arch/i386/Kconfig

It seems to do TCGETS ioctl on every file it opens and gets ENOTTY,
although it doesn't seem that this is necessarily a problem for it.

Any ideas what's going on?
I'm running redhat's 2.4.7-10 kernel (redhat 7.1) with its tools.

It seems to read all of drivers/block/paride/Kconfig 
(8192 + 4959 bytes == whole file) then it just quits?

[...bunch of strace output deleted...]
open("drivers/block/paride/Kconfig", O_RDONLY) = 17
brk(0x8089000)                          = 0x8089000
ioctl(17, TCGETS, 0xbffff350)           = -1 ENOTTY (Inappropriate ioctl for device)
read(17, "#\n# PARIDE configuration\n#\n# PAR"..., 8192) = 8192
brk(0x808a000)                          = 0x808a000
read(17, "herwise you\n\t  should answer M t"..., 8192) = 4959
brk(0x808b000)                          = 0x808b000
brk(0x808c000)                          = 0x808c000
read(17, "", 8192)                      = 0
ioctl(17, TCGETS, 0xbffff340)           = -1 ENOTTY (Inappropriate ioctl for device)
_exit(0)                                = ?




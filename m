Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263016AbVCMGKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263016AbVCMGKY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 01:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbVCMGKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 01:10:23 -0500
Received: from mail.autoweb.net ([198.172.237.26]:26893 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S263016AbVCMGJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 01:09:45 -0500
Date: Sun, 13 Mar 2005 01:09:41 -0500
From: Ryan Anderson <ryan@michonline.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [KBUILD] Bug in make deb-pkg when using seperate source and object directories
Message-ID: <20050313060940.GB7828@mythryan2.michonline.com>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam,

When running "make O=something deb-pkg", I get a failure that claims I
haven't configured my kernel (I have).  Running it a second time tells
me to run "make mrproper"  (include/linux/version.h got built on the
first run)

I did some preliminary poking around, but kbuild is still, well, mostly
magic to me - I can't see where the object directory is getting lost.

Think you can take a look?  (Note, this failure shouldn't require
anything Debian specific on your system to trigger - it's failing, as
far as I can tell, on the $(MAKE) right before the call build the
builddeb script, so it should be easy to reproduce)

The log of when I run it follows:

ryan@mythryan2 ~/dev/linux/local-quilt$ blocal deb-pkg
make
make -C /home/ryan/dev/linux/local-quilt
O=/home/ryan/dev/linux/output/local
Makefile:487: .config: No such file or directory
  Using /home/ryan/dev/linux/local-quilt as source for kernel
  CHK     include/linux/version.h
  UPD     include/linux/version.h
  SYMLINK include/asm -> include/asm-i386
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/split-include
  HOSTCC  scripts/basic/docproc
  SHIPPED scripts/kconfig/zconf.tab.h
  SHIPPED scripts/kconfig/zconf.tab.c
  SHIPPED scripts/kconfig/lex.zconf.c
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/mconf.o
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf -s arch/i386/Kconfig
***
*** You have not yet configured your kernel!
***
*** Please run some configurator (e.g. "make oldconfig" or
*** "make menuconfig" or "make xconfig").
***
make[6]: *** [silentoldconfig] Error 1
make[5]: *** [silentoldconfig] Error 2
make[4]: *** [include/linux/autoconf.h] Error 2
make[3]: *** [all] Error 2
make[2]: *** [deb-pkg] Error 2
make[1]: *** [deb-pkg] Error 2
make: *** [deb-pkg] Error 2

"blocal" is a simple wrapper to cut down on retyping things, it's just
this:

ryan@mythryan2 ~/dev/linux/local-quilt$ cat /home/ryan/bin/blocal
#!/bin/bash -e

PWD=`pwd`

if [ "$PWD" != "/home/ryan/dev/linux/local-quilt" ]; then
        cd /home/ryan/dev/linux/local-quilt
fi

make O=../output/local/ -j4 CC="ccache distcc" $*



-- 

Ryan Anderson
  sometimes Pug Majere

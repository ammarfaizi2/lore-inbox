Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263487AbUJ2UAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263487AbUJ2UAy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 16:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263485AbUJ2T6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:58:47 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:20341 "EHLO
	falcon10.austin.ibm.com") by vger.kernel.org with ESMTP
	id S263508AbUJ2Tz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 15:55:56 -0400
Message-Id: <200410291955.i9TJtfaj014056@falcon10.austin.ibm.com>
X-Mailer: exmh version 2.7.1.1 10/09/2004 with nmh-1.1
In-reply-to: <20041029014930.21ed5b9a.akpm@osdl.org> 
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: Re: 2.6.10-rc1-mm2 
Date: Fri, 29 Oct 2004 14:55:41 -0500
From: Doug Maxey <dwm@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew, 

having some troubles on ppc64.  It looks like the changes in
the scripts/Makefile.{clean,build} are expecting include/asm to
exist in the source tree.  I don't see any related file except the
include/asm-$ARCH/Kbuild


Below is output from a hacked up attempt to add $(srctree) check to
fix scripts/Makefile.build.  It invokes an added $(warning) at the top
of the file:



=============================
cmd=={make -j4 O=/build/dwm/build/lk-2.6.10-rc1-mm2.edit/ppc64 zImage}
  Using /build/dwm/linux/lk-2.6.10-rc1-mm2.edit as source for kernel
  CHK     include/linux/version.h
  GEN    /build/dwm/build/lk-2.6.10-rc1-mm2.edit/ppc64/Makefile
/build/dwm/linux/lk-2.6.10-rc1-mm2.edit/scripts/Makefile.build:13: kbuild: obj=scripts/basic/Kbuild srctree=/build/dwm/linux/lk-2.6.10-rc1-mm2.edit/scripts/basic/Kbuild, make=scripts/basic/Makefile!
  GEN    /build/dwm/build/lk-2.6.10-rc1-mm2.edit/ppc64/Makefile
/build/dwm/linux/lk-2.6.10-rc1-mm2.edit/scripts/Makefile.build:13: kbuild: obj=scripts/kconfig/Kbuild srctree=/build/dwm/linux/lk-2.6.10-rc1-mm2.edit/scripts/kconfig/Kbuild, make=scripts/kconfig/Makefile!
scripts/kconfig/conf -s arch/ppc64/Kconfig
 #
 # using defaults found in .config
 #
  SPLIT   include/linux/autoconf.h -> include/config/*
/build/dwm/linux/lk-2.6.10-rc1-mm2.edit/scripts/Makefile.build:13: kbuild: obj=scripts/basic/Kbuild srctree=/build/dwm/linux/lk-2.6.10-rc1-mm2.edit/scripts/basic/Kbuild, make=scripts/basic/Makefile!
/build/dwm/linux/lk-2.6.10-rc1-mm2.edit/scripts/Makefile.build:13: kbuild: obj=/build/dwm/linux/lk-2.6.10-rc1-mm2.edit/include/asm/Kbuild srctree=/build/dwm/linux/lk-2.6.10-rc1-mm2.edit//build/dwm/linux/lk-2.6.10-rc1-mm2.edit/include/asm/Kbuild, make=/build/dwm/linux/lk-2.6.10-rc1-mm2.edit/include/asm/Makefile!
/build/dwm/linux/lk-2.6.10-rc1-mm2.edit/scripts/Makefile.build:14: /build/dwm/linux/lk-2.6.10-rc1-mm2.edit/include/asm/Makefile: No such file or directory
/build/dwm/linux/lk-2.6.10-rc1-mm2.edit/scripts/Makefile.build:13: kbuild: obj=scripts/Kbuild srctree=/build/dwm/linux/lk-2.6.10-rc1-mm2.edit/scripts/Kbuild, make=scripts/Makefile!
make[2]: *** No rule to make target `/build/dwm/linux/lk-2.6.10-rc1-mm2.edit/include/asm/Makefile'.  Stop.
make[1]: *** [prepare0] Error 2
make[1]: *** Waiting for unfinished jobs....
/build/dwm/linux/lk-2.6.10-rc1-mm2.edit/scripts/Makefile.build:13: kbuild: obj=scripts/genksyms/Kbuild srctree=/build/dwm/linux/lk-2.6.10-rc1-mm2.edit/scripts/genksyms/Kbuild, make=scripts/genksyms/Makefile!
/build/dwm/linux/lk-2.6.10-rc1-mm2.edit/scripts/Makefile.build:13: kbuild: obj=scripts/mod/Kbuild srctree=/build/dwm/linux/lk-2.6.10-rc1-mm2.edit/scripts/mod/Kbuild, make=scripts/mod/Makefile!
make: *** [zImage] Error 2

=============================

diff from vanilla scripts/Makefile.{build,clean}

=============================
diff -Nwupa libata-dev-2.6/scripts/Makefile.build lk-2.6.10-rc1-mm2.edit/scripts/Makefile.build
--- libata-dev-2.6/scripts/Makefile.build       2004-10-27 15:38:46.972904640 -0500
+++ lk-2.6.10-rc1-mm2.edit/scripts/Makefile.build       2004-10-29 12:50:35.766986000 -0500
@@ -10,7 +10,7 @@ __build:
 # Read .config if it exist, otherwise ignore
 -include .config
 
-include $(obj)/Makefile
+include $(if $(wildcard $(obj)/Kbuild), $(obj)/Kbuild, $(obj)/Makefile)
 
 include scripts/Makefile.lib
 
diff -Nwupa libata-dev-2.6/scripts/Makefile.clean lk-2.6.10-rc1-mm2.edit/scripts/Makefile.clean
--- libata-dev-2.6/scripts/Makefile.clean       2004-10-27 15:38:46.972904640 -0500
+++ lk-2.6.10-rc1-mm2.edit/scripts/Makefile.clean       2004-10-29 12:50:35.766986000 -0500
@@ -7,7 +7,7 @@ src := $(obj)
 .PHONY: __clean
 __clean:
 
-include $(obj)/Makefile
+include $(if $(wildcard $(obj)/Kbuild), $(obj)/Kbuild, $(obj)/Makefile)
 
 # Figure out what we need to build from the various variables



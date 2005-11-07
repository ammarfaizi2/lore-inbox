Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965062AbVKGV43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062AbVKGV43 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965220AbVKGV43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:56:29 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:54277 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S965062AbVKGV42
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:56:28 -0500
Date: Mon, 7 Nov 2005 13:56:26 -0800
Message-Id: <200511072156.jA7LuQKv009711@zach-dev.vmware.com>
Subject: [PATCH 1/1] My tools break here
From: Zachary Amsden <zach@vmware.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>, davej@redhat.com, thang@redhat.com,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 07 Nov 2005 21:56:27.0476 (UTC) FILETIME=[1A655940:01C5E3E6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have to revert the recent addition of -imacros to the Makefile to get my
tool chain to build.  Without the change, below, I get:

Note that this looks entirely like a toolchain bug.  Here is the offending command:

[pid 12163] execve("/usr/lib/gcc-lib/i386-redhat-linux/3.2.2/tradcpp0", ["/usr/lib/gcc-lib/i386-redhat-linux/3.2.2/tradcpp0", "-lang-asm", "-nostdinc", "-Iinclude", "-Iinclude/asm-i386/mach-default", "-D__GNUC__=3", "-D__GNUC_MINOR__=2", "-D__GNUC_PATCHLEVEL__=2", "-D__GXX_ABI_VERSION=102", "-D__ELF__", "-Dunix", "-D__gnu_linux__", "-Dlinux", "-D__ELF__", "-D__unix__", "-D__gnu_linux__", "-D__linux__", "-D__unix", "-D__linux", "-Asystem=posix", "-D__NO_INLINE__", "-D__STDC_HOSTED__=1", "-Acpu=i386", "-Amachine=i386", "-Di386", "-D__i386", "-D__i386__", "-D__tune_i386__", "-D__KERNEL__", "-D__ASSEMBLY__", "-isystem", "/usr/lib/gcc-lib/i386-redhat-linux/3.2.2/include", "-imacros", "include/linux/autoconf.h", "-MD", "arch/i386/kernel/.entry.o.d", "arch/i386/kernel/entry.S", "-o", "/tmp/ccOlsFJR.s"]

Which should execute properly, I think.  But it does not:

zach-dev:linux-2.6.14-zach-work $ make
  CHK     include/linux/version.h
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  AS      arch/i386/kernel/entry.o
/usr/lib/gcc-lib/i386-redhat-linux/3.2.2/tradcpp0: output filename specified twice
make[1]: *** [arch/i386/kernel/entry.o] Error 1
make: *** [arch/i386/kernel] Error 2

gcc (GCC) 3.2.2 20030222 (Red Hat Linux 3.2.2-5)

Deprecating the -imacros fixes the build for me.  It does not appear to be a
simple argument overflow problem in trapcpp0, since deprecating all the defines
reproduces the problem as well.  Also, switching -imacros to -include fixes the
problem.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.14-zach-work/Makefile
===================================================================
--- linux-2.6.14-zach-work.orig/Makefile	2005-11-07 09:41:09.000000000 -0800
+++ linux-2.6.14-zach-work/Makefile	2005-11-07 13:34:14.000000000 -0800
@@ -346,8 +346,7 @@ AFLAGS_KERNEL	=
 # Use LINUXINCLUDE when you must reference the include/ directory.
 # Needed to be compatible with the O= option
 LINUXINCLUDE    := -Iinclude \
-                   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include) \
-		   -imacros include/linux/autoconf.h
+                   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include)
 
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 

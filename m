Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbVKJVfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbVKJVfj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 16:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbVKJVfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 16:35:39 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:57937 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S932090AbVKJVfj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 16:35:39 -0500
Date: Thu, 10 Nov 2005 22:36:40 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Zachary Amsden <zach@vmware.com>,
       Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
       Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] Kbuild fixes
Message-ID: <20051110213640.GA19831@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

Two kbuild fixes.

    [PATCH] kbuild: build breaks after -imacros was introduced
    [PATCH] kbuild: make kernelrelease in unconfigured kernel prints an error


The use of -imacros is know to break for at least two distinct users.
akpm being one of them.

	Sam


    please pull from:
    
    master.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git

Patch'es included below.

 Makefile   |    2 +-
 b/Makefile |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Author: Zachary Amsden <zach@vmware.com>

    [PATCH] kbuild: build breaks after -imacros was introduced
    
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
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff --git a/Makefile b/Makefile
index 3152d63..83a3185 100644
--- a/Makefile
+++ b/Makefile
@@ -347,7 +347,7 @@ AFLAGS_KERNEL	=
 # Needed to be compatible with the O= option
 LINUXINCLUDE    := -Iinclude \
                    $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include) \
-		   -imacros include/linux/autoconf.h
+		   -include include/linux/autoconf.h
 
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 

Author: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>

    [PATCH] kbuild: make kernelrelease in unconfigured kernel prints an error
    
    Do not include .config for target kernelrelease
    
    Signed-off-by: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff --git a/Makefile b/Makefile
index 2dac801..3152d63 100644
--- a/Makefile
+++ b/Makefile
@@ -407,7 +407,7 @@ outputmakefile:
 # of make so .config is not included in this case either (for *config).
 
 no-dot-config-targets := clean mrproper distclean \
-			 cscope TAGS tags help %docs check%
+			 cscope TAGS tags help %docs check% kernelrelease
 
 config-targets := 0
 mixed-targets  := 0
    

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263217AbVCJWGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263217AbVCJWGb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 17:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbVCJWG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 17:06:26 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:16013 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S263259AbVCJV5R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 16:57:17 -0500
Date: Thu, 10 Mar 2005 22:58:04 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [BK PATCHES] kbuild updates
Message-ID: <20050310215803.GA18044@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

Please pull latest kbuild patches.
Full list below - the most important stuff:

o default value for INSTALL_PATH set to /boot
o Use -Wno-pointer-sign for gcc 4.0
o arch/i386: make install no longer check vmlinux
o Introdude KBUILD_NOCMDDEP

Except a few trivial things it has been in -mm for a while
with no comments.

	Sam

	

Please do a

	bk pull bk://linux-sam.bkbits.net/kbuild

This will update the following files:

 Makefile                              |   47 +++++++++++++++++++++++-----------
 arch/i386/Makefile                    |    5 ++-
 arch/i386/kernel/Makefile             |    2 -
 drivers/net/wireless/prism54/Makefile |    2 -
 drivers/video/console/Makefile        |    4 +-
 include/linux/module.h                |   13 +--------
 include/linux/moduleparam.h           |   19 +++++++++++--
 kernel/Makefile                       |    2 -
 kernel/kallsyms.c                     |    4 +-
 scripts/Makefile.lib                  |   28 ++++++++++++--------
 scripts/Makefile.modinst              |    5 ++-
 scripts/genksyms/genksyms.h           |   16 ++++++++---
 scripts/kconfig/Makefile              |    8 +++++
 scripts/mod/modpost.c                 |    5 +--
 scripts/mod/modpost.h                 |    4 +-
 scripts/namespace.pl                  |    5 +++
 16 files changed, 109 insertions(+), 60 deletions(-)

through these ChangeSets:

<sam@mars.ravnborg.org> (05/03/10 1.2007)
   kconfig: Add explicit depedencies
   
   Without these I could not do make menuconfig when using O=
   This is the shipped rule that plays tricks here.
   
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (05/03/10 1.2006)
   kbuild: Install external modules in a path relative to their own path
   
   When an external module is being built in down in a directory structure
   keep the relative directory when installing the module.
   
   Example:
   fs/ contains a Makefile used to build both modules:
   obj-y := myfs/ oldfs/
   Install directories
   fs/myfs/myfs.ko	  => Will be installed in /lib/modules/<version>/extra/fs/myfs/
   fs/oldfs/oldfs.o  => Will be installed in /lib/modules/<version>/extra/fs/oldfs/
   
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (05/03/10 1.2005)
   video/console: fix spurious rebuild
   
   kbuild does have troubles with assignmnets including '#'.
   The '#' is seen as a comment marker and this will in the end cause
   kbuild to think the commandline to build promcon_tbl.c has changed.
   This happens because the commandline is stored in the file: .promcon_tbl.c.cmd
   
   Although a bit complex the command to build promcon_tbl.c is unlikely
   to change so the workaround is to skip the check for a changed commandline.
   Now promcon_tbl.c is only rebuilt if the .uni file is newer than the .c file.
   
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (05/02/02 1.2004)
   prismtech: Avoid recompile when changing compile dir
   
   -I$(PWD) is superflous - and caused absolute path to be stored in build command - this
   casuses recompile when using symlink to kernel.
   Also deleted commented out -DCONFIG_PRISM_WDS. CONFIG_PRISM_WDS are not present in
   any of the source files.
   
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (05/02/02 1.2003)
   kbuild: Fix debugging leftover
   
   So now check for commandline options actually works again.
   
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<tero_niemela@yahoo.com> (05/01/31 1.2002)
   [PATCH] kbuild: skip depmod if not executable
   
   I've cross-compiled Linux on i386-netbsdelf2.0 for
   arm-linux for quite some time now and everything seems
   to be working perfectly except for one minor glitch in
   the build process that halts module installation
   (needlessly, IMHO). Specifically, if System.map exists
   $(DEPMOD) is run ("for convenience" as the comment
   says in the Makefile). However, on NetBSD I don't have
   $(DEPMOD) available so the command fails and make
   exits with non-zero exit status. Please consider the
   attached patch to add a check for $(DEPMOD) so that
   missing $(DEPMOD) won't halt the whole build process.
   
   From: Tero Niemela <tero_niemela@yahoo.com>
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<tony@atomide.com> (05/01/31 1.2001)
   [PATCH] kbuild: fix for i386 cross compile
   
   I used to be be able to cross compile for i386 on my x86_64 machine,
   but recently something (gcc/binutils?) changed, and it stopped working.
   
   Following patch makes cross compile work with:
   
   make ARCH=i386 CFLAGS_KERNEL="-m32" AFLAGS_KERNEL="-m32" bzImage
   
   Without the patch I'm getting the following error:
   
     SYSCALL arch/i386/kernel/vsyscall-syms.o
   /usr/lib/gcc/x86_64-pc-linux-gnu/3.4.3/../../../../x86_64-pc-linux-gnu/bin/ld:
   Relocatable linking with relocations from format elf32-i386
   (arch/i386/kernel/vsyscall-sysenter.o) to format elf64-x86-64
   (arch/i386/kernel/vsyscall-syms.o) is not supported
   collect2: ld returned 1 exit status
   
   Signed-off-by: Andrew Morton <akpm@osdl.org>
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<blaisorblade@yahoo.it> (05/01/31 1.2000)
   [PATCH] kbuild: no redundant srctree in tags file
   
   Avoid cluttering the tags/TAGS generated file with $(srctree) in the paths
   if this is not needed.
   
   This has two advantages:
   
   - Saving about 20M on the size of the resulting tags file (which are used
     currently to store the absolute path of the file names rather than the
     relative one) when KBUILD_OUTPUT is not set.
   
   - Keeping the tags file valid when the directory is renamed.
   
   No change is done for who does make tags O=..., if this is wanted (I would
   find that incommodous and non-typical for a developer, but anyway I've not
   ruined functionality in that case).
   
   Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
   Signed-off-by: Andrew Morton <akpm@osdl.org>
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<ak@muc.de> (05/01/31 1.1999)
   [PATCH] kbuild: Use -Wno-pointer-sign for gcc 4.0
   
   Compiling an allyesconfig kernel straight with a gcc 4.0 snapshot
   gives nearly 10k new warnings like:
   
   warning: pointer targets in passing argument 5 of `cpuid' differ in signedness
   
   Since the sheer number of these warnings was too much even for the
   most determined kernel janitors (I actually asked ;-) and I don't
   think it's a very serious issue to have these mismatches I submitted
   an new option to gcc to disable it. It was incorporated in gcc mainline
   now.
   
   This patch makes the kernel compilation use it. There are still
   quite a lot of new warnings with 4.0 (mostly about uninitialized variables),
   but the compile log looks much nicer nnow.
   
   Signed-off-by: Andi Kleen <ak@suse.de>
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<agruen@suse.de> (05/01/30 1.1998)
   The wrong version of the parmtype patch was merged, incompletely, and
   the part that got merged got broken on the way.  Here are the fixes:
   
   Move __MODULE_INFO to modparam.h: This macro is used in modparam.h;
   there are users who include this header but not module.h.  The latter
   includes modparam.h already.
   
   __MODULE_INFO(parmtype, name##type, #name ":" #type) does not evaluate
   to __MODULE_INFO(parmtype, footype, "foo:int") as was the idea, but to
   __MODULE_INFO(parmtype, fooint, "foo:int") when type is bound to int.
   In more complicated cases, we get syntax erros.  Re-introduce the
   __MODULE_PARM_TYPE macro; this is cleaner than renaming the type parameter.
   
   Add the parmtype definition which was dropped during the merge to to the
   obsolete but still heavily used MODULE_PARM macro.
   
   Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
   Signed-off-by: Sam Ravnborf <sam@ravnbrg.org>

<juhl-lkml@dif.dk> (05/01/30 1.1997)
   kbuild: make 'make help' show all *config targets and update descriptions slightly.
   
   "make help" doesn't show "make randconfig" nor "make config" as options
   and the description of oldconfig could be better (IMHO). Patch below adds
   the missing targets to the help and updates the description of oldconfig.
   
   Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<bunk@stusta.de> (05/01/30 1.1996)
   kbuild: update scripts/namespace.pl
   
   The patch below removes some false positives I've observed.
   
   Signed-off-by: Adrian Bunk <bunk@stusta.de>
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<bunk@stusta.de> (05/01/30 1.1995)
   kallsyms: kallsyms.c - make some code static
   
   This patch makes some needlessly global code static.
   
   Signed-off-by: Adrian Bunk <bunk@stusta.de>
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<bunk@stusta.de> (05/01/30 1.1994)
   kernel/configs.c: make a variable static
   
   This patch makes a needlessly global variable static.
   
   Signed-off-by: Adrian Bunk <bunk@stusta.de>
   Acked-by: Randy Dunlap <rddunlap@osdl.org>
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<agruen@suse.de> (05/01/30 1.1993)
   kbuild: Dont include absolute filenames in binaries
   
   The kbuild utilities are compiled with absolute patch names, so paths
   starting with $RPM_BUILD_ROOT would end up in the binaries.  To avoid
   this, remove all references to __FILE__ (directly and indirectly via
   assert()).
   
   Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (05/01/30 1.1992)
   kbuild: Nicer printout when Module.symvers is missing
   
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<agruen@suse.de> (05/01/30 1.1991)
   kbuild: Warn when building external modules without modversions
   
   This adds a warning when building external modules (M= or SUBDIRS=
   syntax) and there is no Module.symvers in the object tree. A missing
   Module.symvers is a clear sign that the kernel tree itself was never
   compiled. The resulting modules will work, but no symbol version
   information will be attached to kernel symbols the module uses (because
   that information comes from Module.symvers), and so the module will be
   more unsafe.
   Futhermore the external module will not record what other modules it is
   depended on.
   
   The test works with CONFIG_MODVERSIONS enabled or disabled.
   
   Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (05/01/30 1.1990)
   kbuild: add '--extra=+f' to ctags in Makefile in order to search for file names
   
   From: John Kacur <jkacur@rogers.com>
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<jkacur@rogers.com> (05/01/30 1.1989)
   kbuild: (trivial) spelling fix in comment in Makefile
   
   From: John Kacur <jkacur@rogers.com>
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (05/01/29 1.1987)
   kbuild: default value for INSTALL_PATH set to /boot
   
   Most architectures uses /boot for there kernel image, so let this be reflected
   by the kernel.
   If INSTALL_PATH shell variable is set then this will have effect.
   If INSTALL_PATH is set one the commanline to make like this:
   make INSTALL_PATH=/nfs/boot install
   then this will override both kbuild and shell variable.
   
   If an arch prefer another default this must be set in the arch Makefile
   
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (05/01/29 1.1986)
   kbuild arch/i386: make install no longer check vmlinux
   
   make install is often executed as root or on a different mechine via NFS
   To avoid updating vmlinux due to directory changes or similar the install target
   for i386 no longer has vmlinux as a prerequisite. 
   Now modules_install and install are aligned in this respect.
   
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (05/01/29 1.1985)
   kbuild: Introdude KBUILD_NOCMDDEP
   
   When tossing around with different gcc compilers there is no way to tell kbuild
   to ignore the new name of the compiler. The new option KBUILD_NOCMDDEP tell
   kbuild not to check the commandline for changes.
   This should be used with care because the resulting kernel may become inconsistent
   if one part is build with 2.96, and another part build with 3.3.4.
   So use only when you know what you are doing.
   
   Syntax:
   make KBUILD_NOCMDDEP=1
   
   Original request for this feature came from hpa.
   
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (05/01/29 1.1984)
   kbuild: Makefile.lib - small cleanup
   
   Combine duplicate code in two smaller 'functions'
   
   Signed-off-by: Sam Ravnborg

<kaos@ocs.com.au> (05/01/10 1.1966.36.1)
   kallsyms: gate page patch breaks module lookups
   
   >Your recent patch looks to break module kallsyms lookups....
   >It looks like if CONFIG_KALLSYMS_ALL is set then we never look up module
   >addresses.
   
   Separate lookups for kernel and modules when CONFIG_KALLSYMS_ALL=y.
   
   Signed-off-by: Keith Owens <kaos@ocs.com.au>
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>


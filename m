Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbUKGTja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbUKGTja (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 14:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbUKGTja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 14:39:30 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:64087 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261590AbUKGThZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 14:37:25 -0500
Date: Sun, 7 Nov 2004 20:37:34 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [BK patches] kbuild updates
Message-ID: <20041107193734.GA17604@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

A number of patches has accumulated in the kbuild tree.
This tree have no sign of the offsetts.h related patches - I did
a new clone to linux-sam.bkbits.net/kbuild to get rid of them.

It has been tested in latest -mm except for a few fixes

Plase pull:
bk pull bk://linux-sam.bkbits.net/kbuild

A quick summary is:

o fix xconfig and gconfig so they work againg
o Kbuild is now preferred name for kbuild files - but no global renaming.
o Allow architectures to set KBUILD_DEFCONFIG so arch/xxx/defconfig
  can be dropped. USed for arm only for now
o Updates to kernel-doc
o updates to sparc/Kconfig (acked by wli)
o ppc, make O= fix
o initramfs improvements (timestamp check)
o localversion improvements (ignore backup copies, do not rebuild so much)
o fixes for Solaris builds
o ppc64 install fix

Diffstat:

 arch/arm/defconfig                   |  510 -----------------------------------
 b/Documentation/kbuild/makefiles.txt |   23 -
 b/Makefile                           |    8 
 b/arch/arm/Makefile                  |    4 
 b/arch/i386/kernel/process.c         |    5 
 b/arch/i386/kernel/traps.c           |    4 
 b/arch/m32r/Makefile                 |    1 
 b/arch/m32r/boot/compressed/Makefile |    3 
 b/arch/ppc/boot/lib/Makefile         |   21 +
 b/arch/ppc64/boot/Makefile           |    2 
 b/arch/sparc/Kconfig                 |   28 -
 b/scripts/Makefile.build             |    2 
 b/scripts/Makefile.clean             |    2 
 b/scripts/basic/fixdep.c             |    8 
 b/scripts/gen_initramfs_list.sh      |   23 +
 b/scripts/kallsyms.c                 |   12 
 b/scripts/kconfig/Makefile           |   22 -
 b/scripts/kernel-doc                 |  186 +++++++++---
 b/scripts/lxdialog/Makefile          |    4 
 b/scripts/lxdialog/dialog.h          |    3 
 b/scripts/mod/modpost.c              |    2 
 b/sound/core/info.c                  |    7 
 22 files changed, 263 insertions(+), 617 deletions(-)

	Sam

 
ChangeSet@1.2454, 2004-11-06 21:18:02+01:00, sam@mars.ravnborg.org
  kconfig: fix xconfig and gconfig
  
  Patch that disabled use of loadable modules broke qconf and gconf.
  Fixed by disabling this also for these targets.
  
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 scripts/kconfig/Makefile |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)


ChangeSet@1.2453, 2004-11-06 00:14:15+01:00, adobriyan@mail.ru
  kernel-doc: Print preprocessor directives correctly.
  
  Print preprocessor directives (usually "#ifdef CONFIG_SOMETHING" and "#endif")
  in structs definitions correctly (-text, -html, sgmldocs, htmldocs, pdfdocs,
  mandocs).
  
  Correctly means:
   - on the separate line
   - starting from column 0
   - not glued to the type of the next member
   - not breeding if members are separated by comma
   - not imitating pointers to functions ("#if defined(CONFIG_X)...")
   - not giving bogus warnings because of this imitation
  
  Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 scripts/kernel-doc |   40 +++++++++++++++++++++++++++++++++++++---
 1 files changed, 37 insertions(+), 3 deletions(-)


ChangeSet@1.2452, 2004-11-06 00:07:44+01:00, blaisorblade_spam@yahoo.it
  Kbuild: avoid backup localversion files
  
  Avoid including as localversion-files the *~ files, i.e. backup files. If I
  have localversion-a and localversion-a~, I don't want both to be used. Nor I
  want to use localversion*~ anyway.
  
  Don't code that as $(wildcard localversion*[^~]) as that would exclude
  "localversion" from the wildcard expansion result, because it requires at
  least one character after localversion to exist in the name file. I.e.,
  
  Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>

 Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


ChangeSet@1.2451, 2004-11-06 00:05:44+01:00, akpm@osdl.org
  bk-kbuild utsname fix
  
  sound/core/info.c:31: sound/utsname.h: No such file or directory
  sound/core/info.c: In function `snd_info_version_read':
  sound/core/info.c:965: parse error before `CONFIG_SND_VERSION'
  sound/core/info.c:962: warning: unused variable `kernel_version'
  
  
  Signed-off-by: Andrew Morton <akpm@osdl.org>
  Signed-off-by Sam Ravnborg <sam@ravnborg.org>

 sound/core/info.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)


ChangeSet@1.2450, 2004-11-03 23:40:52+01:00, sam@mars.ravnborg.org
  Merge mars.ravnborg.org:/home/sam/bk/linux-2.6
  into mars.ravnborg.org:/home/sam/bk/to-akpm

 scripts/Makefile.build |    1 +
 1 files changed, 1 insertion(+)


ChangeSet@1.2346.2.20, 2004-11-03 21:52:01+01:00, azarah@nosferatu.za.org
  kbuild: check timestamps on files for initramfs
  
    Add a comment to gen_initramfs_list.sh output that contains the
    numeric mtime of the last modified file in the source directory,
    or the mtime of the source list.  This should cause the initramfs
    image to be rebuild if a file in the source directory changed, or
    the source list (if that was used rather than a directory as source).
  
  
  Signed-off-by: Martin Schlemmer <azarah@nosferatu.za.org>
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 scripts/gen_initramfs_list.sh |   23 +++++++++++++++++++----
 1 files changed, 19 insertions(+), 4 deletions(-)


ChangeSet@1.2346.2.19, 2004-11-03 21:51:06+01:00, adobriyan@mail.ru
  kernel-doc: don't print ... twice in variadic functions
  
  Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 scripts/kernel-doc |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


ChangeSet@1.2346.2.18, 2004-11-03 21:50:05+01:00, adobriyan@mail.ru
  kernel-doc: print arrays in declarations correctly
  
  Do not convert arrays into pointers while generating documentation for them.
  
  I.e, print
  
  struct sk_buff {
  	char cb[40];
  };
  
  as "char cb[40]", not "char * cb".
  
  Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 scripts/kernel-doc |  100 ++++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 73 insertions(+), 27 deletions(-)


ChangeSet@1.2346.2.17, 2004-11-03 21:49:24+01:00, adobriyan@mail.ru
  kernel-doc: support for comma-separated members in structs and unions
  
  Fix the following warnings
  
  $ make sgmldocs
  ...
  Warning(include/linux/skbuff.h:283): No description found for parameter 'len,data_len,mac_len,csum'
  Warning(include/linux/skbuff.h:283): No description found for parameter 'local_df,cloned,pkt_type,ip_summed'
  Warning(include/linux/skbuff.h:283): No description found for parameter 'protocol,security'
  ...
  Warning(include/linux/skbuff.h:283): No description found for
  parameter 'head,*data,*tail,*end'
  ...
  
  by adding support for comma-separated members in structs and unions.
  
  Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 scripts/kernel-doc |   46 ++++++++++++++++++++++++++++++----------------
 1 files changed, 30 insertions(+), 16 deletions(-)


ChangeSet@1.2346.2.16, 2004-11-03 21:48:44+01:00, sam@mars.ravnborg.org
  ppc: fix building arch/ppc/boot/lib/ with make O=
  
  arch/ppc/boot/lib/ reuses zlib_inflate from lib/zlib_inflate but kbuild
  does not support two different places utilising the same .o file. It results
  in recompile for each build because options to compiler changes etc.
  So the trick used here is to make a copy of the required .c files.
  
  Acked-by: Tom Rini <trini@kernel.crashing.org>
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 arch/ppc/boot/lib/Makefile |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)


ChangeSet@1.2346.2.15, 2004-11-03 21:47:44+01:00, sam@mars.ravnborg.org
  kconfig: drop usage of shared libraries
  
  Drop usage of shared libraries.
  It breaks on several non-i386 build environemnts - especially the ones popular for embedded development.
  This is a minimal version.
  Based on idea from Bertrand Marquis and patch from Dan Kegel.
  
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 scripts/kconfig/Makefile |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)


ChangeSet@1.2346.2.14, 2004-11-03 21:40:43+01:00, sam@mars.ravnborg.org
  kbuild: Prefer Kbuild as name of the kbuild files
  
  The kbuild syntax is unique and does only have very few things in common with
  usual Makefile syntax. So to avoid confusion make the filename 'Kbuild' be
  the preferred name as replacement for 'Makefile'.
  No global renaming planned to take place for now, but new stuff expected to use
  the new 'Kbuild' filename.
  
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 Documentation/kbuild/makefiles.txt |    7 +++++--
 scripts/Makefile.build             |    2 +-
 scripts/Makefile.clean             |    2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)


ChangeSet@1.2346.2.13, 2004-10-31 02:49:03+02:00, james4765@verizon.net
  Re: More patches to arch/sparc/Kconfig [2 of 5]
  
  Fixes typo in help in openpromfs.
  
  From: Jim Nelson <james4765@verizon.net>
  Acked-by: William Lee Irwin III <wli@holomorphy.com>
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 arch/sparc/Kconfig |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)


ChangeSet@1.2346.2.12, 2004-10-31 02:46:14+02:00, james4765@verizon.net
  More patches to arch/sparc/Kconfig [4 of 5]
  
  Makes sun4 default to "N" - most SPARC32 systems did not use these.
  
  From: Jim Nelson <james4765@verizon.net>
  Acked-by: William Lee Irwin III <wli@holomorphy.com>
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 arch/sparc/Kconfig |    1 +
 1 files changed, 1 insertion(+)


ChangeSet@1.2346.2.11, 2004-10-31 02:45:50+02:00, james4765@verizon.net
  More patches to arch/sparc/Kconfig [5 of 5]
  
  Fixes x86-specific bootloader help in printer config.
  
  From: Jim Nelson <james4765@verizon.net>
  Acked-by: William Lee Irwin III <wli@holomorphy.com>
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 arch/sparc/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


ChangeSet@1.2346.2.10, 2004-10-31 02:45:26+02:00, james4765@verizon.net
  More patches to arch/sparc/Kconfig [3 of 5]
  
  Fixes x86-specific bootloader help in serial console.
  
  From: Jim Nelson <james4765@verizon.net>
  Acked-by: William Lee Irwin III <wli@holomorphy.com>
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 arch/sparc/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


ChangeSet@1.2346.2.9, 2004-10-31 02:45:02+02:00, james4765@verizon.net
  Patch to arch/sparc/Kconfig [1 of 5]
  
  Fixes x86-specific help in SPARC32 SMP support help.
  
  From: Jim Nelson <james4765@verizon.net>
  Acked-by: William Lee Irwin III <wli@holomorphy.com>
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 arch/sparc/Kconfig |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)


ChangeSet@1.2346.2.8, 2004-10-31 02:23:45+02:00, sam@mars.ravnborg.org
  Do not recompile if localversion changes
  
  Changing localversion causes a few files to be recompiled, namely those who
  include <version.h>. Replace <version.h> with <utsname.h> in a few places.
  Long term solution is to split up <version.h> in two files.
  
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 arch/i386/kernel/process.c |    5 +++--
 arch/i386/kernel/traps.c   |    4 ++--
 sound/core/info.c          |    4 ++--
 3 files changed, 7 insertions(+), 6 deletions(-)


ChangeSet@1.2346.2.7, 2004-10-31 02:05:58+02:00, sam@mars.ravnborg.org
  kbuild: allow architectures to specify defconfig file with KBUILD_DEFCONFIG
  
  For some architectures is does not make sense to maintain a single default
  configuration - arm is a good example here.
  KBUILD_DEFCONFIG is introduced allowing relevant architectures to point out
  a configuration kept in arch/$(ARCH)/configs as the configuration
  to be used when executing 'make defconfig'.
  This patch selects versatile_defconfig as the default configuration for arm.
  
  The reason to keep defconfig is that is has proved valuable in many testing
  scenarios when one are doing a cross architecture build of the kernel to
  do a simple compile-time check of some changes.
  
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 arch/arm/defconfig       |  510 -----------------------------------------------
 Makefile                 |    6 
 arch/arm/Makefile        |    4 
 scripts/kconfig/Makefile |    5 
 4 files changed, 15 insertions(+), 510 deletions(-)


ChangeSet@1.2346.2.6, 2004-10-31 01:38:28+02:00, trini@kernel.crashing.org
  kbuild: additional warning fixes on Solaris 9
  
  A coworker of mine give them a look-over and spotted a few
  places where I missed changing some casts.
  
  Signed-off-by: Tom Rini <trini@kernel.crashing.org>
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 scripts/basic/fixdep.c |    8 ++++----
 scripts/mod/modpost.c  |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)


ChangeSet@1.2346.2.5, 2004-10-31 01:28:31+02:00, sam@mars.ravnborg.org
  m32r: misc kbuild cleanups
  
  o Remove unused LDFLAGS_BLOB assignement (from Brian Gerst)
  o Use implicit rule for vmlinux.lds (from Al viro)
  
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 arch/m32r/Makefile                 |    1 -
 arch/m32r/boot/compressed/Makefile |    3 ---
 2 files changed, 4 deletions(-)


ChangeSet@1.2346.2.4, 2004-10-31 01:14:43+02:00, kaos@sgi.com
  kbuild: Include useful absolute symbols in kallsyms
  
  Some absolute symbols are useful, they can even appear in back traces.
  Tweak kallsyms to retain the useful absolute symbols.
  
  This list is from ia64, add absolute symbols from other architectures
  as required.
  
  Signed-off-by: Keith Owens <kaos@sgi.com>
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 scripts/kallsyms.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletion(-)


ChangeSet@1.2346.2.3, 2004-10-31 00:18:21+02:00, bunk@stusta.de
  kbuild: Documentation/kbuild/makefiles.txt: check_gcc -> cc-option
  
  It's not good to show the obsolete check_gcc in an example.
  
  Signed-off-by: Adrian Bunk <bunk@stusta.de>
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 Documentation/kbuild/makefiles.txt |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)


ChangeSet@1.2346.2.2, 2004-10-31 00:16:03+02:00, trini@kernel.crashing.org
  kconfig: Fix menuconfig on Solaris
  
  The following two bits are needed to get it working (not as colorful as on
  Linux, but it functions) for me.  First, unless CURS_MACROS is defined,
  scroll(x) doesn't get expanded to wscrl(x, 1).  I did some quick
  grepping on Cygwin and Linux (debian/unstable) and didn't see
  CURS_MACROS show up anywhere else, but to be safe I put it inside of
  __sun__.  Next this uses libcurses instead of libncurses otherwise we
  get a bunch of undefined refs to w32attrset, w32addch, acs32map and few
  more.
  
  Signed-off-by: Tom Rini <trini@kernel.crashing.org>
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 scripts/lxdialog/Makefile |    4 ++++
 scripts/lxdialog/dialog.h |    3 +++
 2 files changed, 7 insertions(+)


ChangeSet@1.2346.2.1, 2004-10-31 00:12:39+02:00, dwm@austin.ibm.com
  ppc64: install outside of source tree
  
  Rationale:
  	When building outside source tree, install.sh is looked for in the
          obj side.
  
  Status:  tested on ppc64 builds
  
  Signed-off-by: Doug Maxey <dwm@austin.ibm.com>
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 arch/ppc64/boot/Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)



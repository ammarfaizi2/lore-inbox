Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269112AbUIHUo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269112AbUIHUo3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 16:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269127AbUIHUo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 16:44:29 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:37397 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S269112AbUIHUoK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 16:44:10 -0400
Date: Thu, 9 Sep 2004 00:44:26 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [BK] kbuild updates
Message-ID: <20040908224426.GA10514@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus - a few kbuild updates.

Most of this has been in -mm for a while now, and a few bugs
has been fixed.

One bug that annoyed me was that I introduced a two stage linking
in top-level Makefile of vmlinux
{vmlinux-main} -> built-in.o 
{vmlinux-init built-in.o} -> vmlinux

But Andrew reported that his x86_64 machine did not boot and I cannot
see why. For now I have reverted to the old one stage process and
I got confirmation that it works.

The two stage process would have been a nice speed up :-(
[Both booted on my i386]


Headlines (see details below):
o Support localversion
	One my have a string appended to KERNELRELEASE either by
		- Defining a CONFIG option
		- Using a file named localversion-foo in
		  root of src or output tree
	Usefull to identify different .configs for instance
	Especially now that EXTRAVERSION is used in released kernels
o Use -j N when doing make rpm
o Restructure build of vmlinux in top-level Makefile
	The result is to some degree readable now.
	Also added to possibility to override the final link command,
	um needs this for some reason. um bits not included
o Consistent use of KERNELRELEASE
	Needed for proper LOCALVERSION support
o Added "make namespacecheck"
	A nice tool form Keith Ownens to find global functions
	which are not used (in current configuration).
	As usual grepping the src is needed to get the full picture.
o Updated kbuild support files so they build on cygwin & Solaris
	This is by popular demand from the embedded crowd.
	I expect more patches to show up when the embedded users
	realise that attention is on this matter

	I really see a need to support building the kernel in
	non-linux environments.

Sam


Please do a

	bk pull bk://linux-sam.bkbits.net/kbuild


diffstat:

 Documentation/kbuild/makefiles.txt |    9 
 Makefile                           |  282 ++++++++++++++---------
 arch/arm/Makefile                  |    1 
 arch/arm26/Makefile                |    2 
 arch/arm26/boot/Makefile           |    4 
 arch/cris/Makefile                 |    2 
 arch/ppc/Makefile                  |    4 
 arch/ppc/boot/utils/mkbugboot.c    |   12 
 arch/ppc/boot/utils/mktree.c       |    4 
 arch/um/Makefile-i386              |    1 
 init/Kconfig                       |   10 
 scripts/Makefile.build             |    6 
 scripts/Makefile.modinst           |    2 
 scripts/Makefile.modpost           |    2 
 scripts/genksyms/genksyms.c        |   15 +
 scripts/kconfig/gconf.c            |    5 
 scripts/mod/sumversion.c           |    4 
 scripts/namespace.pl               |  449 +++++++++++++++++++++++++++++++++++++
 scripts/package/builddeb           |    2 
 scripts/package/mkspec             |   20 -
 scripts/ver_linux                  |    7 
 21 files changed, 687 insertions(+), 156 deletions(-)

ChangeSets:

<sam@mars.ravnborg.org> (04/09/09 1.1938)
   kbuild: Move localversion config option to top of menu
   
   Setting the local version is a typical action, and expected to be
   used more often than many other options in the "General" menu.
   So move it to the top.
   
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (04/09/08 1.1937)
   scripts: pass %{_smp_mflags} to make(1) in scripts/package/mkspec
   
   This patch passes %{_smp_mflags} to various build phases in
   scripts/package/mkspec so that -j$N is honored by make rpm.
   
   From: William Lee Irwin III <wli@holomorphy.com>
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (04/09/08 1.1936)
   kbuild: allow arch/$(ARCH)/Makefile to override cmd_vmlinux__
   
   The comments said so, so let the code refelct the comment.
   First user is um that needs a non-standard link rule.
   um patch will be submitted by the UML folks.
   
   Also dropped a bogus comment.
   
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<olh@suse.de> (04/09/08 1.1935)
   ppc: remove tmpfile for ppc binutils check
   
   make distclean does not remove the new tmp file .tmp_gas_check.
   
   Signed-off-by: Olaf Hering <olh@suse.de>
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (04/09/07 1.1934)
   kbuild: fix make -j N build
   
   Make did say:
   make[1]: warning: jobserver unavailable: using -j1.
   
   Added '+' flag in relevant places to supress this warning.
   Also removed some trailing tabs in same area spotted by Adrian Bunk <bunk@fs.tum.de>
   
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (04/09/06 1.1933)
   kbuild: Drop use of built-in.o in top level makefile
   
   built-in.o were introduced in top-level Makefile to saves us from
   linking the same .o files several times when kallsyms were enabled.
   Unfortunately this caused a hard lock-up on x86_64 - so this patch drops
   built-in.o again. Please note is was working on i386.
   
   This patch also fixes some wording/spellings noticed by: Horst von Brand <vonbrand@inf.utfsm.cl>
   
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (04/09/06 1.1932)
   kbuild: Enable compile after localversion change
   
   Last minute change to localversion patch were faulty.
   filechk needs a valid '$^' file. In this case unused but make sure to supply one.
   
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<elenstev@mesatop.com> (04/09/05 1.1931)
   scripts: Update ver_linux for recent reiserfsprogs
   
   The ver_linux script is fixed to report recent versions of
   reiserfsprogs.  (Older versions had "reiserfsprogs" in the
   line containing the version number, while recent versions
   report "reiserfsck" followed by version number).
   
   The ver_linux script is updated to report the reiser4progs
   version number.
   
   This was tested with reiserfsprogs 3.6.11, 3.6.18 and
   reiser4progs 1.0.0.
   
   Signed-off-by: Steven Cole <elenstev@mesatop.com>
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (04/09/05 1.1930)
   kbuild: Simplify generating vmlinux
   
   Generating vmlinux in top-level Makefile were getting a bit messy after kallsyms
   support were added. Also the full link of all the .o files were duplicaed a number of times.
   This patch does the following:
   - Introduce built-in.o which is a prelink of most .o files
   - Make the build process a bit more verbose telling when linking .tmpvmlinux*
   - Use less magic when determing when to generate a new version
   - Allow architectures to override the defineition of cmd_vmlinux__
   - Add more comments to the MAkefile and clean up soem other comments
   - Display more commends during V=1 builds
   
   The resulting kernel boots and rn here.
   
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<ianw@gelato.unsw.edu.au> (04/09/05 1.1929)
   kbuild: Support LOCALVERSION
   
   Add LOCALVERSION so we can append strings that show up in uname
   without having to fiddle with the Makefile and EXTRAVERSION, etc.
   
   * localversion* files are read first
   * config variable is appended last
   * LOCALVERSION from the command line overrides all of this
   * check is forced on build, since we can't really know when
     the config or environment options change.
   
   Signed-off-by: Ian Wienand <ianw@gelato.unsw.edu.au>
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<bgerst@quark.didntduck.org> (04/09/05 1.1928)
   kbuild: use KERNELRELEASE
   
   This patch changes several places where the kernel version string is put
   together from it's components with $KERNELRELEASE.
   
   From: Brian Gerst <bgerst@quark.didntduck.org>
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<blaisorblade_spam@yahoo.it> (04/09/01 1.1927)
   kbuild: Set cflags before including arch Makefile
   
   Please note that this patch, even if UML-related, should be immediately
   discussed for merging in mainline, if possible. The UML patch to handle
   this has therefore been separated.
   
   Patch purpose:
   If arch/$(ARCH)/Makefile is included before adding -O2 (and the rest) to
   CFLAGS, I must duplicate the addition of it to USER_CFLAGS for UML.
   So let's fix this.
   
   Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (04/09/01 1.1926)
   kbuild: Remove last signs of LDFLAGS_BLOB
   
   From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
   The LDFLAGS_BLOB var (which used to be defined in arch Makefiles) is now unused,as specified inside usr/initramfs_data.S. So this patch removes the remaining
   references.
   
   Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (04/08/31 1.1925)
   kbuild: Fix modules_install
   
   modules_install failed for modules with 'ko' in their name.
   Fixes this.
   
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (04/08/30 1.1924)
   kbuild: Add stactic analyser tools to make help
   
   Added the tools that seems to be maintained.
   There is a bunch that has not been touched for a while - ignore them for now.
   
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (04/08/30 1.1923)
   kbuild: Updates to namespacecheck.pl
   
   From: Keith Owens <kaos@ocs.com.au>
   
   This now supports the absolute symbols from modversions, handles
   recent binutils changes and supports O=.
   
   Signed-off-by: Keith Owens <kaos@ocs.com.au>
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (04/08/30 1.1922)
   bk: Ignore arch/i386/kernel/vsyscall.lds
   
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (04/08/30 1.1921)
   kbuild: fix stage 2 of module build
   
   When building allmodconfig the following error were seen:
   scripts/Makefile.modpost:86: target `fs/nls/nls_koi8-ru.ko' given more than once in the same rule.
   This happened for all modules with 'ko' inside their name.
   This bug were introduced when head ... were replaced by grep.
   
   Signed off by: Sam Ravnborg <sam@ravnborg.org>

<kaos@ocs.com.au> (04/08/29 1.1920)
   kbuild: Add 'make namespacecheck'
   
   make namespacecheck lists globally visible symbols that are not used
   outside the file that defines them.  These symbols are candidates for
   static declarations.  It also lists multiply defined symbols.
   namespace.pl knows about lots of special cases in the kernel code,
   including exported symbols and conglomerate objects.
   
   The patch also corrects the usage of scripts/reference*.pl, they need
   $(src).
   
   Signed-off-by: Keith Owens <kaos@ocs.com.au>
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
   
   Index: 2.6.9-rc1/Makefile
   ===================================================================

<trini@kernel.crashing.org> (04/08/29 1.1919)
   kbuild: Solaris fixes in various kbuild Makfiles's
   
   Additional Makefile fixes for Solaris 2.8
   
   On Solaris, 'head' doesn't take a -q argument.  But we can use 'grep -h'
   instead, so do that in Makefile.mod{inst,post}.  The built-in test to
   /bin/sh doesn't like 'if ! cmd' syntax, so when determining if we need
   to do modversion stuff, invert the if/else cases.  The built-in test
   also doesn't understand -ef, so invoke a real version of test which does.
   
   Signed-off-by: Tom Rini <trini@kernel.crashing.org>
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<trini@kernel.crashing.org> (04/08/29 1.1918)
   kbuild: Use getopt_long in genksyms only when available
   
   Use getopt_long() or getopt(), depending on the host
   
   From: Jean-Christophe Dubois <jdubois@mc.com>.
   
   We do not always have GNU getopt_long(), so when we don't, just use
   getopt() and the short options.  We do this based on __GNU_LIBRARY__
   being set, or not.  Originally from Jean-Christophe Dubois <jdubois@mc.com>.
   
   Signed-off-by: Tom Rini <trini@kernel.crashing.org>
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<trini@kernel.crashing.org> (04/08/29 1.1917)
   kbuild: Use inttypes.h when stdint.h are not available
   
   The following is from Jean-Christophe Dubois <jdubois@mc.com>.
   On Solaris 2.8, <stdint.h> does not exist, but <inttypes.h> does.
   However, on Cygwin (the other odd place that the kernel is compiled
   on) <inttypes.h> doesn't exist.  So we end up testing for __sun__ and
   using <inttypes.h> there, and <stdint.h> everywhere else.
   
   Signed-off-by: Tom Rini <trini@kernel.crashing.org>
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>


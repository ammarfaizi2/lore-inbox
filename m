Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWBGGet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWBGGet (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 01:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbWBGGet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 01:34:49 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:51214 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932238AbWBGGet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 01:34:49 -0500
Date: Tue, 7 Feb 2006 07:34:42 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH - resend 3] kbuild updates for -rc
Message-ID: <20060207063442.GA15079@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

The /dev/null issue trigger for several people.
Please apply or let me know if something troubles you to apply this.

   Sam
   
----- Forwarded message from Sam Ravnborg <sam@ravnborg.org> -----

Hi Linus.

Please pull following kbuild bug-fixes:
o kconfig: fix /dev/null breakage
o cris: asm-offsets related build failure
o kbuild: fix build with O=..

Purely bug-fixes that annoys a number of people. Should been in before
-rc2 but did not get around to mail a pull request.

Available at:
git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild-bugfix.git

All three patches included below for reference.

	Sam

diffstat:
 Makefile                                   |    2 +-
 arch/cris/Makefile                         |    2 +-
 scripts/kconfig/lxdialog/Makefile          |    7 +++++--
 scripts/kconfig/lxdialog/check-lxdialog.sh |   14 +++++++++-----
 4 files changed, 16 insertions(+), 9 deletions(-)

diff-tree 3835f82183eab8b67ddda6b32c127859a546c82d (from 3ee68c4af3fd7228c1be63254b9f884614f9ebb2)
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Sat Jan 21 12:03:09 2006 +0100

    kconfig: fix /dev/null breakage
    
    While running "make menuconfig" and "make mrproper"
    some people experienced that /dev/null suddenly changed
    permissions or suddenly became a regular file.
    The main reason was that /dev/null was used as output
    to gcc in the check-lxdialog.sh script and gcc did
    some strange things with the output file; in this
    case /dev/null when it errorred out.
    
    Following patch implements a suggestion
    from Bryan O'Sullivan <bos@serpentine.com> to
    use gcc -print-file-name=libxxx.so.
    
    Also the Makefile is adjusted to not resolve value of
    HOST_EXTRACFLAGS and HOST_LOADLIBES until they are actually used.
    This prevents us from calling gcc when running make *clean/mrproper
    
    Thanks to Eyal Lebedinsky <eyal@eyal.emu.id.au> and
    Jean Delvare <khali@linux-fr.org> for the first error reports.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
    ---

diff --git a/scripts/kconfig/lxdialog/Makefile b/scripts/kconfig/lxdialog/Makefile
index fae3e29..bbf4887 100644
--- a/scripts/kconfig/lxdialog/Makefile
+++ b/scripts/kconfig/lxdialog/Makefile
@@ -1,11 +1,14 @@
 # Makefile to build lxdialog package
 #
 
 check-lxdialog  := $(srctree)/$(src)/check-lxdialog.sh
-HOST_EXTRACFLAGS:= $(shell $(CONFIG_SHELL) $(check-lxdialog) -ccflags)
-HOST_LOADLIBES  := $(shell $(CONFIG_SHELL) $(check-lxdialog) -ldflags $(HOSTCC))
+
+# Use reursively expanded variables so we do not call gcc unless
+# we really need to do so. (Do not call gcc as part of make mrproper)
+HOST_EXTRACFLAGS = $(shell $(CONFIG_SHELL) $(check-lxdialog) -ccflags)
+HOST_LOADLIBES   = $(shell $(CONFIG_SHELL) $(check-lxdialog) -ldflags $(HOSTCC))
  
 HOST_EXTRACFLAGS += -DLOCALE 
 
 .PHONY: dochecklxdialog
 $(obj)/dochecklxdialog:
diff --git a/scripts/kconfig/lxdialog/check-lxdialog.sh b/scripts/kconfig/lxdialog/check-lxdialog.sh
index 448e353..120d624 100644
--- a/scripts/kconfig/lxdialog/check-lxdialog.sh
+++ b/scripts/kconfig/lxdialog/check-lxdialog.sh
@@ -2,21 +2,21 @@
 # Check ncurses compatibility
 
 # What library to link
 ldflags()
 {
-	echo "main() {}" | $cc -lncursesw -xc - -o /dev/null 2> /dev/null
+	$cc -print-file-name=libncursesw.so | grep -q /
 	if [ $? -eq 0 ]; then
 		echo '-lncursesw'
 		exit
 	fi
-	echo "main() {}" | $cc -lncurses -xc - -o /dev/null 2> /dev/null
+	$cc -print-file-name=libncurses.so | grep -q /
 	if [ $? -eq 0 ]; then
 		echo '-lncurses'
 		exit
 	fi
-	echo "main() {}" | $cc -lcurses -xc - -o /dev/null 2> /dev/null
+	$cc -print-file-name=libcurses.so | grep -q /
 	if [ $? -eq 0 ]; then
 		echo '-lcurses'
 		exit
 	fi
 	exit 1
@@ -34,14 +34,17 @@ ccflags()
 	else
 		echo '-DCURSES_LOC="<curses.h>"'
 	fi
 }
 
-compiler=""
+# Temp file, try to clean up after us
+tmp=.lxdialog.tmp
+trap "rm -f $tmp" 0 1 2 3 15
+
 # Check if we can link to ncurses
 check() {
-	echo "main() {}" | $cc -xc - -o /dev/null 2> /dev/null
+	echo "main() {}" | $cc -xc - -o $tmp 2> /dev/null
 	if [ $? != 0 ]; then
 		echo " *** Unable to find the ncurses libraries."          1>&2
 		echo " *** make menuconfig require the ncurses libraries"  1>&2
 		echo " *** "                                               1>&2
 		echo " *** Install ncurses (ncurses-devel) and try again"  1>&2
@@ -57,10 +60,11 @@ usage() {
 if [ $# == 0 ]; then
 	usage
 	exit 1
 fi
 
+cc=""
 case "$1" in
 	"-check")
 		shift
 		cc="$@"
 		check

diff-tree aa6ba2faec346a3f59bf4130060108e6433ad907 (from 3835f82183eab8b67ddda6b32c127859a546c82d)
Author: Al Viro <viro@ftp.linux.org.uk>
Date:   Thu Jan 19 19:03:15 2006 +0000

    cris: asm-offsets related build failure
    
    fallout from "kbuild: cris use generic asm-offsets.h support" - symlink
    target was wrong
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff --git a/arch/cris/Makefile b/arch/cris/Makefile
index ea65d58..ee11469 100644
--- a/arch/cris/Makefile
+++ b/arch/cris/Makefile
@@ -117,11 +117,11 @@ $(SRC_ARCH)/.links:
 	@ln -sfn $(SRC_ARCH)/$(SARCH)/boot $(SRC_ARCH)/boot
 	@rm -rf $(SRC_ARCH)/lib
 	@ln -sfn $(SRC_ARCH)/$(SARCH)/lib $(SRC_ARCH)/lib
 	@ln -sfn $(SRC_ARCH)/$(SARCH) $(SRC_ARCH)/arch
 	@ln -sfn $(SRC_ARCH)/$(SARCH)/vmlinux.lds.S $(SRC_ARCH)/kernel/vmlinux.lds.S
-	@ln -sfn $(SRC_ARCH)/$(SARCH)/asm-offsets.c $(SRC_ARCH)/kernel/asm-offsets.c
+	@ln -sfn $(SRC_ARCH)/$(SARCH)/kernel/asm-offsets.c $(SRC_ARCH)/kernel/asm-offsets.c
 	@touch $@
 
 # Create link to sub arch includes
 $(srctree)/include/asm-$(ARCH)/.arch: $(wildcard include/config/arch/*.h)
 	@echo '  Making $(srctree)/include/asm-$(ARCH)/arch -> $(srctree)/include/asm-$(ARCH)/$(SARCH) symlink'

diff-tree 8c7f75d3257fe466b34abf290c8b177c106c3769 (from aa6ba2faec346a3f59bf4130060108e6433ad907)
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Sat Jan 21 12:07:56 2006 +0100

    kbuild: fix build with O=..
    
    .kernelrelease was saved in same directory as kernel source also
    with make O=...
    Make sure we kick in the normal logic to shift to the output directory
    when we build .kernelrelease after executing *config.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
    ---

diff --git a/Makefile b/Makefile
index 252a659..31bbc6a 100644
--- a/Makefile
+++ b/Makefile
@@ -440,11 +440,11 @@ include $(srctree)/arch/$(ARCH)/Makefile
 export KBUILD_DEFCONFIG
 
 config %config: scripts_basic outputmakefile FORCE
 	$(Q)mkdir -p include/linux
 	$(Q)$(MAKE) $(build)=scripts/kconfig $@
-	$(Q)$(MAKE) .kernelrelease
+	$(Q)$(MAKE) -C $(srctree) KBUILD_SRC= .kernelrelease
 
 else
 # ===========================================================================
 # Build targets only - this includes vmlinux, arch specific targets, clean
 # targets and others. In general all targets except *config targets.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWDKMG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWDKMG0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 08:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWDKMG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 08:06:26 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:42258 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750787AbWDKMGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 08:06:25 -0400
Date: Tue, 11 Apr 2006 14:06:14 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Andreas Gruenbacher <agruen@suse.de>,
       Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
       Brian Gerst <bgerst@didntduck.org>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,
       Eric Sesterhenn <snakebyte@gmx.de>,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] kbuild fixes for 2.6.17-rc1
Message-ID: <20060411120613.GA17984@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus

Here follows kbuild fixes for 2.6.17-rc1 + a number of kconfig fixes.

Most noteworthy kbuild fixes:
o fix NULL dereference in modpost
o fix mips build after introducing -fasm-offsets gcc flag
o fix several make <single-target> bugs
o rebuild less when source-tree are moved
o rebuild initramfs if content of initramfs changes

For kconfig Roman Zippel wrote:
 The first four patches I'd like to see to go into 2.6.17 if possible.
 Although I'm quite confident about the remaining patches, a bit more testing
 can't hurt.
The mentioned first four kconfig patches are included in this set.

short-log, diffstat, log + full diff follows.
The 'rebuild initramfs if content of initramfs changes' counts for
the majority of the diff.

Please pull from:

	git pull git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git

	Sam


Alexey Dobriyan:
      ver_linux: don't print reiser4progs version if none found

Andreas Gruenbacher:
      kbuild: modules_install for external modules must not remove existing modules

Atsushi Nemoto:
      kbuild: mips: fix sed regexp to generate asm-offset.h

Brian Gerst:
      kbuild: fix garbled text in modules.txt

Carl-Daniel Hailfinger:
      kbuild: fix unneeded rebuilds in drivers/media/video after moving source tree
      kbuild: fix unneeded rebuilds in drivers/net/chelsio after moving source tree

Eric Sesterhenn:
      kbuild: fix NULL dereference in scripts/mod/modpost.c

Paolo 'Blaisorblade' Giarrusso:
      kbuild: fix mode of checkstack.pl and other files.

Roman Zippel:
      kconfig: fix default value for choice input
      kconfig: revert conf behaviour change
      kconfig: recenter menuconfig
      kconfig: fix typo in change count initialization

Sam Ravnborg:
      kbuild: use relative path to -I
      kbuild: fix building single targets with make O=.. single-target
      kbuild: fix make dir/
      kbuild: properly pass options to hostcc when doing make O=..
      kbuild: rebuild initramfs if content of initramfs changes

 Documentation/kbuild/modules.txt     |    2 
 Kbuild                               |    2 
 Makefile                             |   54 ++++----
 arch/ppc/boot/lib/Makefile           |    2 
 arch/sparc/math-emu/Makefile         |    2 
 drivers/media/video/Makefile         |    2 
 drivers/media/video/bt8xx/Makefile   |    2 
 drivers/media/video/cx25840/Makefile |    2 
 drivers/media/video/cx88/Makefile    |    6 
 drivers/media/video/em28xx/Makefile  |    2 
 drivers/media/video/saa7134/Makefile |    6 
 drivers/net/chelsio/Makefile         |    2 
 scripts/Kbuild.include               |    5 
 scripts/Makefile.lib                 |    5 
 scripts/gen_initramfs_list.sh        |  225 +++++++++++++++++++++++------------
 scripts/kconfig/conf.c               |   21 ---
 scripts/kconfig/confdata.c           |    2 
 scripts/kconfig/lxdialog/menubox.c   |   19 +-
 scripts/mod/modpost.c                |    2 
 scripts/ver_linux                    |    4 
 usr/Makefile                         |   91 +++++---------
 21 files changed, 254 insertions(+), 204 deletions(-)


commit b5ac4817de3032796c558b0a32062e7392b5ea60
Author: Roman Zippel <zippel@linux-m68k.org>
Date:   Sun Apr 9 17:27:28 2006 +0200

    kconfig: fix typo in change count initialization
    
    Configuration needs saving when either of these conditions is true.
    
    Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

commit 94f2505be3b6afaf50129e949b1840bc4dd0b3e8
Author: Roman Zippel <zippel@linux-m68k.org>
Date:   Sun Apr 9 17:27:14 2006 +0200

    kconfig: recenter menuconfig
    
    Move the menuconfig output more into the centre again, it's using a
    fixed position depending on the window width using the fact that the
    menu output has to work in a 80 chars terminal.
    
    Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

commit 59c6a3f4d745584f2f78cdf1f5e221a19518926c
Author: Roman Zippel <zippel@linux-m68k.org>
Date:   Sun Apr 9 17:26:50 2006 +0200

    kconfig: revert conf behaviour change
    
    After the last patch fixed the real problem, revert this needless behaviour
    change of conf, which only hid the real problem.
    
    Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

commit 40aee729b350672c2550640622416a855e27938f
Author: Roman Zippel <zippel@linux-m68k.org>
Date:   Sun Apr 9 17:26:39 2006 +0200

    kconfig: fix default value for choice input
    
    The wrong default value can cause conf to end up in endless loop for choice
    questions.
    
    Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

commit eaaae38c1ac4ccbec6d2de7255b0538f38fb29d6
Author: Eric Sesterhenn <snakebyte@gmx.de>
Date:   Tue Apr 11 00:54:16 2006 +0200

    kbuild: fix NULL dereference in scripts/mod/modpost.c
    
    before is NULL in this case, concluding from the surrounding code
    it seems that after is the right one to use.
    
    Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

commit 71378be91f5473e89c8be170c6e49edda3bdbb67
Author: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Date:   Fri Apr 7 16:16:40 2006 +0200

    kbuild: fix mode of checkstack.pl and other files.
    
    Make it executable like it should be. Do the same for other files intended to be
    executed by the user - the ones called by the build process needn't be
    executable as they already work (as argument to their interpreter).
    
    Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

commit d39a206bc35d46a3b2eb98cd4f34e340d5e56a50
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Tue Apr 11 13:24:32 2006 +0200

    kbuild: rebuild initramfs if content of initramfs changes
    
    initramfs.cpio.gz being build in usr/ and included in the
    kernel was not rebuild when the included files changed.
    
    To fix this the following was done:
    - let gen_initramfs.sh generate a list of files and directories included
      in the initramfs
    - gen_initramfs generate the gzipped cpio archive so we could simplify
      the kbuild file (Makefile)
    - utilising the kbuild infrastructure so when uid/gid root mapping changes
      the initramfs will be rebuild
    
    With this change we have a much more robust initramfs generation.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

commit d9df92e22aca939857c5bc9ecb130ef22307ccc1
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Fri Apr 7 08:36:49 2006 +0200

    kbuild: properly pass options to hostcc when doing make O=..
    
    This fix a longstanding bug where proper options was not
    passed to hostcc in case of a make O=.. build.
    This bug showed up in (not yet merged) klibc, and is not known
    to have any counterpart in-kernel.
    Fixed by moving the flags macro to Kbuild.include so it can be used
    by both Makefile.lib and Makefile.host.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

commit 7d2d8fe0cb88914d26219db51341d780a032b198
Author: Andreas Gruenbacher <agruen@suse.de>
Date:   Wed Apr 5 23:33:50 2006 +0200

    kbuild: modules_install for external modules must not remove existing modules
    
    When installing external modules with `make modules_install', the
    first thing that happens is a rm -rf of the target directory. This
    works only once, and breaks when installing more than one (set of)
    external module(s).
    With following fix we have the functionality:
    - for a in-kernel modules_install the $(MODLIB)/kernel directory will be
      deleted before module installation
    - for external modules the existing modules will be left as is assuming
      one may be building and installign several external modules
    
    Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

commit aa360879ed38fbe88057cc43f720881ab9e6a63a
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Thu Apr 6 08:25:31 2006 +0200

    kbuild: fix make dir/
    
    kbuild added an extra '/' after the directory - resulting in all
    files being rebuild in a subdirectory.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

commit ea88df9bf895720289331e41ed73cdcb04059900
Author: Alexey Dobriyan <adobriyan@gmail.com>
Date:   Wed Sep 21 21:37:24 2005 +0400

    ver_linux: don't print reiser4progs version if none found
    
    Sam: did the same for reiserprogs
    
    Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

commit 0947640f4388de50a39f762748b08e586a482527
Author: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Date:   Tue Mar 28 00:18:54 2006 +0900

    kbuild: mips: fix sed regexp to generate asm-offset.h
    
    Changes to Makefile.kbuild ("kbuild: add -fverbose-asm to i386
    Makefile") breaks asm-offset.h file on MIPS.  Other archs possibly
    suffer this change too but I'm not sure.
    
    Here is a fix just for MIPS.
    
    Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

commit bc2546a67975a7bddc72f8c48b0bb2081b56f853
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Wed Apr 5 12:57:21 2006 +0200

    kbuild: fix building single targets with make O=.. single-target
    
    This fixes single targets build so it now works relaiably in
    following cases:
    - build with mixed kernel source and output files (make single-target)
    - build with separate output directory (make O=.. single-target)
    - external module with mixed kernel source and output files
      (make M='pwd' single-target)
    - external module with separate kernel source and output files
      (make O=.. M='pwd' single-target)
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

commit b46da0567d3baa6783106e7463801292cdc79ddd
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Tue Apr 4 16:56:10 2006 +0200

    kbuild: use relative path to -I
    
    Using a relative path has the advantage that when the kernel source
    tree is moved the relevant .o files will not be rebuild just because
    the path to the kernel src has changed.
    This also got rid of a user of TOPDIR - which has been deprecated for a long time now.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

commit 1417ae0869472f4f3768779c51c3979faca20b2e
Author: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Date:   Tue Apr 4 01:02:30 2006 +0200

    kbuild: fix unneeded rebuilds in drivers/net/chelsio after moving source tree
    
    This fixes some uneeded rebuilds under drivers/net/chelsio after moving
    the source tree. The makefiles used $(TOPDIR) for include paths, which
    is unnecessary. Changed to use relative paths.
    
    Compile tested, produces byte-identical code to the previous makefiles.
    
    Signed-off-by: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

commit 8036dc6bdca0faa981be01377728678a6f6f3fde
Author: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Date:   Tue Apr 4 00:35:36 2006 +0200

    kbuild: fix unneeded rebuilds in drivers/media/video after moving source tree
    
    This fixes some uneeded rebuilds under drivers/media/video after moving
    the source tree. The makefiles used $(src) and $(srctree) for include
    paths, which is unnecessary. Changed to use relative paths.
    
    Compile tested, produces byte-identical code to the previous makefiles.
    
    Signed-off-by: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

commit a7d7cb3cd6c97cbbe21d528c014e5f592006457d
Author: Brian Gerst <bgerst@didntduck.org>
Date:   Sat Mar 25 14:48:37 2006 -0500

    kbuild: fix garbled text in modules.txt
    
    Signed-off-by: Brian Gerst <bgerst@didntduck.org>
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff --git a/Documentation/kbuild/modules.txt b/Documentation/kbuild/modules.txt
index fcccf24..61fc079 100644
--- a/Documentation/kbuild/modules.txt
+++ b/Documentation/kbuild/modules.txt
@@ -44,7 +44,7 @@ What is covered within this file is main
 of modules. The author of an external modules should supply
 a makefile that hides most of the complexity so one only has to type
 'make' to build the module. A complete example will be present in
-chapter ¤. Creating a kbuild file for an external module".
+chapter 4, "Creating a kbuild file for an external module".
 
 
 === 2. How to build external modules
diff --git a/Kbuild b/Kbuild
index 95d6a00..2d4f95e 100644
--- a/Kbuild
+++ b/Kbuild
@@ -18,7 +18,7 @@ define sed-y
 	"/^->/{s:^->\([^ ]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; s:->::; p;}"
 endef
 # Override default regexp for specific architectures
-sed-$(CONFIG_MIPS) := "/^@@@/s///p"
+sed-$(CONFIG_MIPS) := "/^@@@/{s/^@@@//; s/ \#.*\$$//; p;}"
 
 quiet_cmd_offsets = GEN     $@
 define cmd_offsets
diff --git a/Makefile b/Makefile
index b401942..fc8e08c 100644
--- a/Makefile
+++ b/Makefile
@@ -1112,7 +1112,6 @@ modules_install: _emodinst_ _emodinst_po
 install-dir := $(if $(INSTALL_MOD_DIR),$(INSTALL_MOD_DIR),extra)
 PHONY += _emodinst_
 _emodinst_:
-	$(Q)rm -rf $(MODLIB)/$(install-dir)
 	$(Q)mkdir -p $(MODLIB)/$(install-dir)
 	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modinst
 
@@ -1275,40 +1274,43 @@ kernelversion:
 
 # Single targets
 # ---------------------------------------------------------------------------
-# The directory part is taken from first prerequisite, so this
-# works even with external modules
+# Single targets are compatible with:
+# - build whith mixed source and output
+# - build with separate output dir 'make O=...'
+# - external modules
+#
+#  target-dir => where to store outputfile
+#  build-dir  => directory in kernel source tree to use
+
+ifeq ($(KBUILD_EXTMOD),)
+        build-dir  = $(patsubst %/,%,$(dir $@))
+        target-dir = $(dir $@)
+else
+        zap-slash=$(filter-out .,$(patsubst %/,%,$(dir $@)))
+        build-dir  = $(KBUILD_EXTMOD)$(if $(zap-slash),/$(zap-slash))
+        target-dir = $(if $(KBUILD_EXTMOD),$(dir $<),$(dir $@))
+endif
+
 %.s: %.c prepare scripts FORCE
-	$(Q)$(MAKE) $(build)=$(dir $<) $(dir $<)$(notdir $@)
+	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
 %.i: %.c prepare scripts FORCE
-	$(Q)$(MAKE) $(build)=$(dir $<) $(dir $<)$(notdir $@)
+	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
 %.o: %.c prepare scripts FORCE
-	$(Q)$(MAKE) $(build)=$(dir $<) $(dir $<)$(notdir $@)
+	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
 %.lst: %.c prepare scripts FORCE
-	$(Q)$(MAKE) $(build)=$(dir $<) $(dir $<)$(notdir $@)
+	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
 %.s: %.S prepare scripts FORCE
-	$(Q)$(MAKE) $(build)=$(dir $<) $(dir $<)$(notdir $@)
+	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
 %.o: %.S prepare scripts FORCE
-	$(Q)$(MAKE) $(build)=$(dir $<) $(dir $<)$(notdir $@)
-
-# For external modules we shall include any directory of the target,
-# but usual case there is no directory part.
-# make M=`pwd` module.o     => $(dir $@)=./
-# make M=`pwd` foo/module.o => $(dir $@)=foo/
-# make M=`pwd` /            => $(dir $@)=/
- 
-ifeq ($(KBUILD_EXTMOD),)
-        target-dir = $(@D)
-else
-        zap-slash=$(filter-out .,$(patsubst %/,%,$(dir $@)))
-        target-dir = $(KBUILD_EXTMOD)$(if $(zap-slash),/$(zap-slash))
-endif
+	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
 
-/ %/:      scripts prepare FORCE
+# Modules
+/ %/: prepare scripts FORCE
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) \
-	$(build)=$(target-dir)
-%.ko: scripts FORCE
+	$(build)=$(build-dir)
+%.ko: prepare scripts FORCE
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1)   \
-	$(build)=$(target-dir) $(@:.ko=.o)
+	$(build)=$(build-dir) $(@:.ko=.o)
 	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modpost
 
 # FIXME Should go into a make.lib or something 
diff --git a/arch/ppc/boot/lib/Makefile b/arch/ppc/boot/lib/Makefile
index d4077e6..80c84d5 100644
--- a/arch/ppc/boot/lib/Makefile
+++ b/arch/ppc/boot/lib/Makefile
@@ -3,7 +3,7 @@ # Makefile for some libs needed by zImag
 #
 
 CFLAGS_kbd.o	:= -Idrivers/char
-CFLAGS_vreset.o := -I$(srctree)/arch/ppc/boot/include
+CFLAGS_vreset.o := -Iarch/ppc/boot/include
 
 zlib  := infblock.c infcodes.c inffast.c inflate.c inftrees.c infutil.c
 	 
diff --git a/arch/sparc/math-emu/Makefile b/arch/sparc/math-emu/Makefile
index f84a9a6..8136987 100644
--- a/arch/sparc/math-emu/Makefile
+++ b/arch/sparc/math-emu/Makefile
@@ -5,4 +5,4 @@ #
 obj-y    := math.o
 
 EXTRA_AFLAGS := -ansi
-EXTRA_CFLAGS = -I. -I$(TOPDIR)/include/math-emu -w
+EXTRA_CFLAGS = -I. -Iinclude/math-emu -w
diff --git a/drivers/media/video/Makefile b/drivers/media/video/Makefile
index 4092a5e..b3ea2d6 100644
--- a/drivers/media/video/Makefile
+++ b/drivers/media/video/Makefile
@@ -84,4 +84,4 @@ obj-$(CONFIG_USB_IBMCAM)        += usbvi
 obj-$(CONFIG_USB_KONICAWC)      += usbvideo/
 obj-$(CONFIG_USB_VICAM)         += usbvideo/
 
-EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/dvb-core
+EXTRA_CFLAGS += -Idrivers/media/dvb/dvb-core
diff --git a/drivers/media/video/bt8xx/Makefile b/drivers/media/video/bt8xx/Makefile
index 94350f2..db641a3 100644
--- a/drivers/media/video/bt8xx/Makefile
+++ b/drivers/media/video/bt8xx/Makefile
@@ -9,4 +9,4 @@ bttv-objs      :=      bttv-driver.o btt
 obj-$(CONFIG_VIDEO_BT848) += bttv.o
 
 EXTRA_CFLAGS += -I$(src)/..
-EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/dvb-core
+EXTRA_CFLAGS += -Idrivers/media/dvb/dvb-core
diff --git a/drivers/media/video/cx25840/Makefile b/drivers/media/video/cx25840/Makefile
index 32a896c..6e8665b 100644
--- a/drivers/media/video/cx25840/Makefile
+++ b/drivers/media/video/cx25840/Makefile
@@ -3,4 +3,4 @@ cx25840-objs    := cx25840-core.o cx2584
 
 obj-$(CONFIG_VIDEO_CX25840) += cx25840.o
 
-EXTRA_CFLAGS += -I$(src)/..
+EXTRA_CFLAGS += -Idrivers/media/video
diff --git a/drivers/media/video/cx88/Makefile b/drivers/media/video/cx88/Makefile
index 6482b9a..0dcd09b 100644
--- a/drivers/media/video/cx88/Makefile
+++ b/drivers/media/video/cx88/Makefile
@@ -8,9 +8,9 @@ obj-$(CONFIG_VIDEO_CX88_DVB) += cx88-dvb
 obj-$(CONFIG_VIDEO_CX88_ALSA) += cx88-alsa.o
 obj-$(CONFIG_VIDEO_CX88_VP3054) += cx88-vp3054-i2c.o
 
-EXTRA_CFLAGS += -I$(src)/..
-EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/dvb-core
-EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/frontends
+EXTRA_CFLAGS += -Idrivers/media/video
+EXTRA_CFLAGS += -Idrivers/media/dvb/dvb-core
+EXTRA_CFLAGS += -Idrivers/media/dvb/frontends
 
 extra-cflags-$(CONFIG_VIDEO_BUF_DVB) += -DHAVE_VIDEO_BUF_DVB=1
 extra-cflags-$(CONFIG_DVB_CX22702)   += -DHAVE_CX22702=1
diff --git a/drivers/media/video/em28xx/Makefile b/drivers/media/video/em28xx/Makefile
index da457a0..826d0e3 100644
--- a/drivers/media/video/em28xx/Makefile
+++ b/drivers/media/video/em28xx/Makefile
@@ -3,4 +3,4 @@ em28xx-objs     := em28xx-video.o em28xx
 
 obj-$(CONFIG_VIDEO_EM28XX) += em28xx.o
 
-EXTRA_CFLAGS += -I$(src)/..
+EXTRA_CFLAGS += -Idrivers/media/video
diff --git a/drivers/media/video/saa7134/Makefile b/drivers/media/video/saa7134/Makefile
index 1ba9984..be7b9ee 100644
--- a/drivers/media/video/saa7134/Makefile
+++ b/drivers/media/video/saa7134/Makefile
@@ -11,9 +11,9 @@ obj-$(CONFIG_VIDEO_SAA7134_OSS) += saa71
 
 obj-$(CONFIG_VIDEO_SAA7134_DVB) += saa7134-dvb.o
 
-EXTRA_CFLAGS += -I$(src)/..
-EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/dvb-core
-EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/frontends
+EXTRA_CFLAGS += -Idrivers/media/video
+EXTRA_CFLAGS += -Idrivers/media/dvb/dvb-core
+EXTRA_CFLAGS += -Idrivers/media/dvb/frontends
 
 extra-cflags-$(CONFIG_VIDEO_BUF_DVB) += -DHAVE_VIDEO_BUF_DVB=1
 extra-cflags-$(CONFIG_DVB_MT352)     += -DHAVE_MT352=1
diff --git a/drivers/net/chelsio/Makefile b/drivers/net/chelsio/Makefile
index 91e9278..54c78d9 100644
--- a/drivers/net/chelsio/Makefile
+++ b/drivers/net/chelsio/Makefile
@@ -4,7 +4,7 @@ #
 
 obj-$(CONFIG_CHELSIO_T1) += cxgb.o
 
-EXTRA_CFLAGS += -I$(TOPDIR)/drivers/net/chelsio $(DEBUG_FLAGS)
+EXTRA_CFLAGS += -Idrivers/net/chelsio $(DEBUG_FLAGS)
 
 
 cxgb-objs := cxgb2.o espi.o pm3393.o sge.o subr.o mv88x201x.o
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 59620b1..b0d067b 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -87,6 +87,11 @@ # Usage:
 # $(Q)$(MAKE) $(build)=dir
 build := -f $(if $(KBUILD_SRC),$(srctree)/)scripts/Makefile.build obj
 
+# Prefix -I with $(srctree) if it is not an absolute path
+addtree = $(if $(filter-out -I/%,$(1)),$(patsubst -I%,-I$(srctree)/%,$(1))) $(1)
+# Find all -I options and call addtree
+flags = $(foreach o,$($(1)),$(if $(filter -I%,$(o)),$(call addtree,$(o)),$(o)))
+
 # If quiet is set, only print short version of command
 cmd = @$(echo-cmd) $(cmd_$(1))
 
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 550798f..2cb4935 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -99,11 +99,6 @@ __a_flags	= $(_a_flags)
 __cpp_flags     = $(_cpp_flags)
 else
 
-# Prefix -I with $(srctree) if it is not an absolute path
-addtree = $(if $(filter-out -I/%,$(1)),$(patsubst -I%,-I$(srctree)/%,$(1))) $(1)
-# Find all -I options and call addtree
-flags = $(foreach o,$($(1)),$(if $(filter -I%,$(o)),$(call addtree,$(o)),$(o)))
-
 # -I$(obj) locates generated .h files
 # $(call addtree,-I$(obj)) locates .h files in srctree, from generated .c files
 #   and locates generated .h files
diff --git a/scripts/bloat-o-meter b/scripts/bloat-o-meter
old mode 100644
new mode 100755
diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
old mode 100644
new mode 100755
diff --git a/scripts/gen_initramfs_list.sh b/scripts/gen_initramfs_list.sh
index 6d41116..56b3bed 100644
--- a/scripts/gen_initramfs_list.sh
+++ b/scripts/gen_initramfs_list.sh
@@ -1,22 +1,55 @@
 #!/bin/bash
 # Copyright (C) Martin Schlemmer <azarah@nosferatu.za.org>
-# Released under the terms of the GNU GPL
-#
-# Generate a newline separated list of entries from the file/directory
-# supplied as an argument.
-#
-# If a file/directory is not supplied then generate a small dummy file.
+# Copyright (c) 2006           Sam Ravnborg <sam@ravnborg.org>
 #
-# The output is suitable for gen_init_cpio built from usr/gen_init_cpio.c.
+# Released under the terms of the GNU GPL
 #
+# Generate a cpio packed initramfs. It uses gen_init_cpio to generate
+# the cpio archive, and gzip to pack it.
+# The script may also be used to generate the inputfile used for gen_init_cpio
+# This script assumes that gen_init_cpio is located in usr/ directory
+
+# error out on errors
+set -e
+
+usage() {
+cat << EOF
+Usage:
+$0 [-o <file>] [-u <uid>] [-g <gid>] {-d | <cpio_source>} ...
+	-o <file>      Create gzipped initramfs file named <file> using
+	               gen_init_cpio and gzip
+	-u <uid>       User ID to map to user ID 0 (root).
+	               <uid> is only meaningful if <cpio_source>
+	               is a directory.
+	-g <gid>       Group ID to map to group ID 0 (root).
+	               <gid> is only meaningful if <cpio_source>
+	               is a directory.
+	<cpio_source>  File list or directory for cpio archive.
+	               If <cpio_source> is a .cpio file it will be used
+		       as direct input to initramfs.
+	-d             Output the default cpio list.
+
+All options except -o and -l may be repeated and are interpreted
+sequentially and immediately.  -u and -g states are preserved across
+<cpio_source> options so an explicit "-u 0 -g 0" is required
+to reset the root/group mapping.
+EOF
+}
 
+list_default_initramfs() {
+	# echo usr/kinit/kinit
+	:
+}
+
 default_initramfs() {
-	cat <<-EOF
+	cat <<-EOF >> ${output}
 		# This is a very simple, default initramfs
 
 		dir /dev 0755 0 0
 		nod /dev/console 0600 0 0 c 5 1
 		dir /root 0700 0 0
+		# file /kinit usr/kinit/kinit 0755 0 0
+		# slink /init kinit 0755 0 0
 	EOF
 }
 
@@ -40,20 +73,30 @@ filetype() {
 		echo "invalid"
 	fi
 	return 0
+}
+
+list_print_mtime() {
+	:
 }
 
 print_mtime() {
-	local argv1="$1"
 	local my_mtime="0"
 
-	if [ -e "${argv1}" ]; then
-		my_mtime=$(find "${argv1}" -printf "%T@\n" | sort -r | head -n 1)
+	if [ -e "$1" ]; then
+		my_mtime=$(find "$1" -printf "%T@\n" | sort -r | head -n 1)
 	fi
-	
-	echo "# Last modified: ${my_mtime}"
-	echo
+
+	echo "# Last modified: ${my_mtime}" >> ${output}
+	echo "" >> ${output}
+}
+
+list_parse() {
+	echo "$1 \\"
 }
 
+# for each file print a line in following format
+# <filetype> <name> <path to file> <octal mode> <uid> <gid>
+# for links, devices etc the format differs. See gen_init_cpio for details
 parse() {
 	local location="$1"
 	local name="${location/${srcdir}//}"
@@ -99,80 +142,112 @@ parse() {
 			;;
 	esac
 
-	echo "${str}"
+	echo "${str}" >> ${output}
 
 	return 0
 }
 
-usage() {
-	printf    "Usage:\n"
-	printf    "$0 [ [-u <root_uid>] [-g <root_gid>] [-d | <cpio_source>] ] . . .\n"
-	printf    "\n"
-	printf -- "-u <root_uid>  User ID to map to user ID 0 (root).\n"
-	printf    "               <root_uid> is only meaningful if <cpio_source>\n"
-	printf    "               is a directory.\n"
-	printf -- "-g <root_gid>  Group ID to map to group ID 0 (root).\n"
-	printf    "               <root_gid> is only meaningful if <cpio_source>\n"
-	printf    "               is a directory.\n"
-	printf    "<cpio_source>  File list or directory for cpio archive.\n"
-	printf    "               If <cpio_source> is not provided then a\n"
-	printf    "               a default list will be output.\n"
-	printf -- "-d             Output the default cpio list.  If no <cpio_source>\n"
-	printf    "               is given then the default cpio list will be output.\n"
-	printf    "\n"
-	printf    "All options may be repeated and are interpreted sequentially\n"
-	printf    "and immediately.  -u and -g states are preserved across\n"
-	printf    "<cpio_source> options so an explicit \"-u 0 -g 0\" is required\n"
-	printf    "to reset the root/group mapping.\n"
+unknown_option() {
+	printf "ERROR: unknown option \"$arg\"\n" >&2
+	printf "If the filename validly begins with '-', " >&2
+	printf "then it must be prefixed\n" >&2
+	printf "by './' so that it won't be interpreted as an option." >&2
+	printf "\n" >&2
+	usage >&2
+	exit 1
+}
+
+list_header() {
+	echo "deps_initramfs := \\"
+}
+
+header() {
+	printf "\n#####################\n# $1\n" >> ${output}
+}
+
+# process one directory (incl sub-directories)
+dir_filelist() {
+	${dep_list}header "$1"
+
+	srcdir=$(echo "$1" | sed -e 's://*:/:g')
+	dirlist=$(find "${srcdir}" -printf "%p %m %U %G\n" 2>/dev/null)
+
+	# If $dirlist is only one line, then the directory is empty
+	if [  "$(echo "${dirlist}" | wc -l)" -gt 1 ]; then
+		${dep_list}print_mtime "$1"
+
+		echo "${dirlist}" | \
+		while read x; do
+			${dep_list}parse ${x}
+		done
+	fi
 }
 
-build_list() {
-	printf "\n#####################\n# $cpio_source\n"
-
-	if [ -f "$cpio_source" ]; then
-		print_mtime "$cpio_source"
-		cat "$cpio_source"
-	elif [ -d "$cpio_source" ]; then
-		srcdir=$(echo "$cpio_source" | sed -e 's://*:/:g')
-		dirlist=$(find "${srcdir}" -printf "%p %m %U %G\n" 2>/dev/null)
-
-		# If $dirlist is only one line, then the directory is empty
-		if [  "$(echo "${dirlist}" | wc -l)" -gt 1 ]; then
-			print_mtime "$cpio_source"
-		
-			echo "${dirlist}" | \
-			while read x; do
-				parse ${x}
-			done
+# if only one file is specified and it is .cpio file then use it direct as fs
+# if a directory is specified then add all files in given direcotry to fs
+# if a regular file is specified assume it is in gen_initramfs format
+input_file() {
+	source="$1"
+	if [ -f "$1" ]; then
+		${dep_list}header "$1"
+		is_cpio="$(echo "$1" | sed 's/^.*\.cpio/cpio/')"
+		if [ $2 -eq 0 -a ${is_cpio} == "cpio" ]; then
+			cpio_file=$1
+			[ ! -z ${dep_list} ] && echo "$1"
+			return 0
+		fi
+		if [ -z ${dep_list} ]; then
+			print_mtime "$1" >> ${output}
+			cat "$1"         >> ${output}
 		else
-			# Failsafe in case directory is empty
-			default_initramfs
+			grep ^file "$1" | cut -d ' ' -f 3
 		fi
+	elif [ -d "$1" ]; then
+		dir_filelist "$1"
 	else
-		echo "  $0: Cannot open '$cpio_source'" >&2
+		echo "  ${prog}: Cannot open '$1'" >&2
 		exit 1
 	fi
 }
 
-
+prog=$0
 root_uid=0
 root_gid=0
+dep_list=
+cpio_file=
+cpio_list=
+output="/dev/stdout"
+output_file=""
 
+arg="$1"
+case "$arg" in
+	"-l")	# files included in initramfs - used by kbuild
+		dep_list="list_"
+		shift
+		;;
+	"-o")	# generate gzipped cpio image named $1
+		shift
+		output_file="$1"
+		cpio_list="$(mktemp ${TMPDIR:-/tmp}/cpiolist.XXXXXX)"
+		output=${cpio_list}
+		shift
+		;;
+esac
 while [ $# -gt 0 ]; do
 	arg="$1"
 	shift
 	case "$arg" in
-		"-u")
+		"-u")	# map $1 to uid=0 (root)
 			root_uid="$1"
 			shift
 			;;
-		"-g")
+		"-g")	# map $1 to gid=0 (root)
 			root_gid="$1"
 			shift
 			;;
-		"-d")
+		"-d")	# display default initramfs list
 			default_list="$arg"
-			default_initramfs
+			${dep_list}default_initramfs
 			;;
 		"-h")
 			usage
@@ -181,23 +256,27 @@ while [ $# -gt 0 ]; do
 		*)
 			case "$arg" in
 				"-"*)
-					printf "ERROR: unknown option \"$arg\"\n" >&2
-					printf "If the filename validly begins with '-', then it must be prefixed\n" >&2
-					printf "by './' so that it won't be interpreted as an option." >&2
-					printf "\n" >&2
-					usage >&2
-					exit 1
+					unknown_option
 					;;
-				*)
-					cpio_source="$arg"
-					build_list
+				*)	# input file/dir - process it
+					input_file "$arg" "$#"
 					;;
 			esac
 			;;
 	esac
 done
-
-# spit out the default cpio list if a source hasn't been specified
-[ -z "$cpio_source" -a -z "$default_list" ] && default_initramfs
 
+# If output_file is set we will generate cpio archive and gzip it
+# we are carefull to delete tmp files
+if [ ! -z ${output_file} ]; then
+	if [ -z ${cpio_file} ]; then
+		cpio_tfile="$(mktemp ${TMPDIR:-/tmp}/cpiofile.XXXXXX)"
+		usr/gen_init_cpio ${cpio_list} > ${cpio_tfile}
+	else
+		cpio_tfile=${cpio_file}
+	fi
+	rm ${cpio_list}
+	cat ${cpio_tfile} | gzip -f -9 - > ${output_file}
+	[ -z ${cpio_file} ] && rm ${cpio_tfile}
+fi
 exit 0
diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 10eeae5..ae5ab98 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -63,20 +63,6 @@ static void check_stdin(void)
 	}
 }
 
-static char *fgets_check_stream(char *s, int size, FILE *stream)
-{
-	char *ret = fgets(s, size, stream);
-
-	if (ret == NULL && feof(stream)) {
-		printf(_("aborted!\n\n"));
-		printf(_("Console input is closed. "));
-		printf(_("Run 'make oldconfig' to update configuration.\n\n"));
-		exit(1);
-	}
-
-	return ret;
-}
-
 static void conf_askvalue(struct symbol *sym, const char *def)
 {
 	enum symbol_type type = sym_get_type(sym);
@@ -114,7 +100,7 @@ static void conf_askvalue(struct symbol 
 		check_stdin();
 	case ask_all:
 		fflush(stdout);
-		fgets_check_stream(line, 128, stdin);
+		fgets(line, 128, stdin);
 		return;
 	case set_default:
 		printf("%s\n", def);
@@ -328,8 +314,7 @@ static int conf_choice(struct menu *menu
 		printf("%*s%s\n", indent - 1, "", menu_get_prompt(menu));
 		def_sym = sym_get_choice_value(sym);
 		cnt = def = 0;
-		line[0] = '0';
-		line[1] = 0;
+		line[0] = 0;
 		for (child = menu->list; child; child = child->next) {
 			if (!menu_is_visible(child))
 				continue;
@@ -370,7 +355,7 @@ static int conf_choice(struct menu *menu
 			check_stdin();
 		case ask_all:
 			fflush(stdout);
-			fgets_check_stream(line, 128, stdin);
+			fgets(line, 128, stdin);
 			strip(line);
 			if (line[0] == '?') {
 				printf("\n%s\n", menu->sym->help ?
diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 1b8882d..1b5df58 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -325,7 +325,7 @@ int conf_read(const char *name)
 				sym->flags |= e->right.sym->flags & SYMBOL_NEW;
 	}
 
-	sym_change_count = conf_warnings && conf_unsaved;
+	sym_change_count = conf_warnings || conf_unsaved;
 
 	return 0;
 }
diff --git a/scripts/kconfig/lxdialog/menubox.c b/scripts/kconfig/lxdialog/menubox.c
index 09512b5..bf8052f 100644
--- a/scripts/kconfig/lxdialog/menubox.c
+++ b/scripts/kconfig/lxdialog/menubox.c
@@ -58,8 +58,7 @@
 
 #include "dialog.h"
 
-#define ITEM_IDENT 1   /* Indent of menu entries. Fixed for all menus */
-static int menu_width;
+static int menu_width, item_x;
 
 /*
  * Print menu item
@@ -70,7 +69,7 @@ static void do_print_item(WINDOW * win, 
 	int j;
 	char *menu_item = malloc(menu_width + 1);
 
-	strncpy(menu_item, item, menu_width - ITEM_IDENT);
+	strncpy(menu_item, item, menu_width - item_x);
 	menu_item[menu_width] = 0;
 	j = first_alpha(menu_item, "YyNnMmHh");
 
@@ -87,13 +86,13 @@ #else
 	wclrtoeol(win);
 #endif
 	wattrset(win, selected ? item_selected_attr : item_attr);
-	mvwaddstr(win, choice, ITEM_IDENT, menu_item);
+	mvwaddstr(win, choice, item_x, menu_item);
 	if (hotkey) {
 		wattrset(win, selected ? tag_key_selected_attr : tag_key_attr);
-		mvwaddch(win, choice, ITEM_IDENT + j, menu_item[j]);
+		mvwaddch(win, choice, item_x + j, menu_item[j]);
 	}
 	if (selected) {
-		wmove(win, choice, ITEM_IDENT + 1);
+		wmove(win, choice, item_x + 1);
 	}
 	free(menu_item);
 	wrefresh(win);
@@ -227,6 +226,8 @@ int dialog_menu(const char *title, const
 	draw_box(dialog, box_y, box_x, menu_height + 2, menu_width + 2,
 		 menubox_border_attr, menubox_attr);
 
+	item_x = (menu_width - 70) / 2;
+
 	/* Set choice to default item */
 	for (i = 0; i < item_no; i++)
 		if (strcmp(current, items[i * 2]) == 0)
@@ -263,10 +264,10 @@ int dialog_menu(const char *title, const
 	wnoutrefresh(menu);
 
 	print_arrows(dialog, item_no, scroll,
-		     box_y, box_x + ITEM_IDENT + 1, menu_height);
+		     box_y, box_x + item_x + 1, menu_height);
 
 	print_buttons(dialog, height, width, 0);
-	wmove(menu, choice, ITEM_IDENT + 1);
+	wmove(menu, choice, item_x + 1);
 	wrefresh(menu);
 
 	while (key != ESC) {
@@ -349,7 +350,7 @@ int dialog_menu(const char *title, const
 			print_item(scroll + choice, choice, TRUE);
 
 			print_arrows(dialog, item_no, scroll,
-				     box_y, box_x + ITEM_IDENT + 1, menu_height);
+				     box_y, box_x + item_x + 1, menu_height);
 
 			wnoutrefresh(dialog);
 			wrefresh(menu);
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 0b92ddf..7e8079a 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -658,7 +658,7 @@ static void warn_sec_mismatch(const char
 		warn("%s - Section mismatch: reference to %s:%s from %s "
 		     "before '%s' (at offset -0x%llx)\n",
 		     modname, secname, refsymname, fromsec,
-		     elf->strtab + before->st_name,
+		     elf->strtab + after->st_name,
 		     (long long)r.r_offset);
 	} else {
 		warn("%s - Section mismatch: reference to %s:%s from %s "
diff --git a/scripts/namespace.pl b/scripts/namespace.pl
old mode 100644
new mode 100755
diff --git a/scripts/show_delta b/scripts/show_delta
old mode 100644
new mode 100755
diff --git a/scripts/ver_linux b/scripts/ver_linux
index beb43ef..84999f6 100755
--- a/scripts/ver_linux
+++ b/scripts/ver_linux
@@ -39,10 +39,10 @@ tune2fs 2>&1 | grep "^tune2fs" | sed 's/
 fsck.jfs -V 2>&1 | grep version | sed 's/,//' |  awk \
 'NR==1 {print "jfsutils              ", $3}'
 
-reiserfsck -V 2>&1 | grep reiserfsck | awk \
+reiserfsck -V 2>&1 | grep ^reiserfsck | awk \
 'NR==1{print "reiserfsprogs         ", $2}'
 
-fsck.reiser4 -V 2>&1 | grep fsck.reiser4 | awk \
+fsck.reiser4 -V 2>&1 | grep ^fsck.reiser4 | awk \
 'NR==1{print "reiser4progs          ", $2}'
 
 xfs_db -V 2>&1 | grep version | awk \
diff --git a/usr/Makefile b/usr/Makefile
index e2129cb..19d74e6 100644
--- a/usr/Makefile
+++ b/usr/Makefile
@@ -1,65 +1,48 @@
+#
+# kbuild file for usr/ - including initramfs image
+#
 
-obj-y := initramfs_data.o
-
-hostprogs-y  := gen_init_cpio
+klibcdirs:;
 
-clean-files := initramfs_data.cpio.gz initramfs_list
+# Generate builtin.o based on initramfs_data.o
+obj-y := initramfs_data.o
 
 # initramfs_data.o contains the initramfs_data.cpio.gz image.
 # The image is included using .incbin, a dependency which is not
 # tracked automatically.
 $(obj)/initramfs_data.o: $(obj)/initramfs_data.cpio.gz FORCE
-
-ifdef CONFIG_INITRAMFS_ROOT_UID
-gen_initramfs_args += -u $(CONFIG_INITRAMFS_ROOT_UID)
-endif
-
-ifdef CONFIG_INITRAMFS_ROOT_GID
-gen_initramfs_args += -g $(CONFIG_INITRAMFS_ROOT_GID)
-endif
-
-# The $(shell echo $(CONFIG_INITRAMFS_SOURCE)) is to remove the
-# gratuitous begin and end quotes from the Kconfig string type.
-# Internal, escaped quotes in the Kconfig string will loose the
-# escape and become active quotes.
-quotefixed_initramfs_source := $(shell echo $(CONFIG_INITRAMFS_SOURCE))
-
-filechk_initramfs_list = $(CONFIG_SHELL) \
- $(srctree)/scripts/gen_initramfs_list.sh $(gen_initramfs_args) $(quotefixed_initramfs_source)
-
-$(obj)/initramfs_list: $(obj)/Makefile FORCE
-	$(call filechk,initramfs_list)
 
-quiet_cmd_cpio = CPIO    $@
-      cmd_cpio = ./$< $(obj)/initramfs_list > $@
-
-
-# Check if the INITRAMFS_SOURCE is a cpio archive
-ifneq (,$(findstring .cpio,$(quotefixed_initramfs_source)))
-
-# INITRAMFS_SOURCE has a cpio archive - verify that it's a single file
-ifneq (1,$(words $(quotefixed_initramfs_source)))
-$(error Only a single file may be specified in CONFIG_INITRAMFS_SOURCE (="$(quotefixed_initramfs_source)") when a cpio archive is directly specified.)
-endif
-# Now use the cpio archive directly
-initramfs_data_cpio = $(quotefixed_initramfs_source)
-targets += $(quotefixed_initramfs_source)
-
-else
-
-# INITRAMFS_SOURCE is not a cpio archive - create one
-$(obj)/initramfs_data.cpio: $(obj)/gen_init_cpio \
-                            $(initramfs-y) $(obj)/initramfs_list FORCE
-	$(call if_changed,cpio)
-
-targets += initramfs_data.cpio
-initramfs_data_cpio = $(obj)/initramfs_data.cpio
-
+#####
+# Generate the initramfs cpio archive
+
+hostprogs-y := gen_init_cpio
+initramfs   := $(CONFIG_SHELL) $(srctree)/scripts/gen_initramfs_list.sh
+ramfs-input := $(if $(filter-out "",$(CONFIG_INITRAMFS_SOURCE)), \
+                    $(CONFIG_INITRAMFS_SOURCE),-d)
+ramfs-args  := \
+        $(if $(CONFIG_INITRAMFS_ROOT_UID), -u $(CONFIG_INITRAMFS_ROOT_UID)) \
+        $(if $(CONFIG_INITRAMFS_ROOT_GID), -g $(CONFIG_INITRAMFS_ROOT_GID)) \
+        $(ramfs-input)
+
+# .initramfs_data.cpio.gz.d is used to identify all files included
+# in initramfs and to detect if any files are added/removed.
+# Removed files are identified by directory timestamp being updated
+# The dependency list is generated by gen_initramfs.sh -l
+ifneq ($(wildcard $(obj)/.initramfs_data.cpio.gz.d),)
+	include $(obj)/.initramfs_data.cpio.gz.d
 endif
-
-
-$(obj)/initramfs_data.cpio.gz: $(initramfs_data_cpio) FORCE
-	$(call if_changed,gzip)
 
-targets += initramfs_data.cpio.gz
+quiet_cmd_initfs = GEN     $@
+      cmd_initfs = $(initramfs) -o $@ $(ramfs-args) $(ramfs-input)
+
+targets := initramfs_data.cpio.gz
+$(deps_initramfs): klibcdirs
+# We rebuild initramfs_data.cpio.gz if:
+# 1) Any included file is newer then initramfs_data.cpio.gz
+# 2) There are changes in which files are included (added or deleted)
+# 3) If gen_init_cpio are newer than initramfs_data.cpio.gz
+# 4) arguments to gen_initramfs.sh changes
+$(obj)/initramfs_data.cpio.gz: $(obj)/gen_init_cpio $(deps_initramfs) klibcdirs
+	$(Q)$(initramfs) -l $(ramfs-input) > $(obj)/.initramfs_data.cpio.gz.d
+	$(call if_changed,initfs)
 

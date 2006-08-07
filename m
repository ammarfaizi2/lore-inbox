Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWHGT1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWHGT1a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 15:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWHGT1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 15:27:30 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:24718 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750836AbWHGT12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 15:27:28 -0400
Date: Mon, 7 Aug 2006 21:27:09 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PATCH] kbuild fixes for 2.6.18
Message-ID: <20060807192708.GA12937@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg.
Please apply to 2.6.18.

Pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild-2.6.18.git

Patches for both changes appended below.

	Sam

Shortlog:

Sam Ravnborg:
      kbuild: do not try to build content of initramfs
      kbuild: external modules shall not check config consistency

commit 9ee4e3365dd0dab4c1e02fe44dc08a223b826c72
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Mon Aug 7 21:01:36 2006 +0200

    kbuild: external modules shall not check config consistency
    
    external modules needs include/linux/autoconf.h and include/config/auto.conf
    but skip the integrity test of these. Even with a newer Kconfig file we
    shall just proceed since external modules simply uses the kernel source and
    shall not attempt to modify it.
    Error out if a config fiel is missing since they are mandatory.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

commit 58a2f7d85aaf4c41157f15c43a913b5c3c6b3adb
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Mon Aug 7 20:58:28 2006 +0200

    kbuild: do not try to build content of initramfs
    
    When a file supplied via CONFIG_INITRAMFS pointed to a file
    for which kbuild had a rule to compile it (foo.c => foo.o)
    then kbuild would compile the file before adding the
    file to the initramfs.
    
    Teach make that files included in initramfs shall not be updated by adding
    an 'empty command'. (See "Using Empty Commands" in info make).
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 Makefile     |   24 ++++++++++++++++++------
 usr/Makefile |    3 +++
 2 files changed, 21 insertions(+), 6 deletions(-)


diff --git a/Makefile b/Makefile
index 110db85..e71fefd 100644
--- a/Makefile
+++ b/Makefile
@@ -436,12 +436,13 @@ core-y		:= usr/
 endif # KBUILD_EXTMOD
 
 ifeq ($(dot-config),1)
-# In this section, we need .config
+# Read in config
+-include include/config/auto.conf
 
+ifeq ($(KBUILD_EXTMOD),)
 # Read in dependencies to all Kconfig* files, make sure to run
 # oldconfig if changes are detected.
 -include include/config/auto.conf.cmd
--include include/config/auto.conf
 
 # To avoid any implicit rule to kick in, define an empty command
 $(KCONFIG_CONFIG) include/config/auto.conf.cmd: ;
@@ -451,16 +452,27 @@ # with it and forgot to run make oldconf
 # if auto.conf.cmd is missing then we are probably in a cleaned tree so
 # we execute the config step to be sure to catch updated Kconfig files
 include/config/auto.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
-ifeq ($(KBUILD_EXTMOD),)
 	$(Q)$(MAKE) -f $(srctree)/Makefile silentoldconfig
 else
-	$(error kernel configuration not valid - run 'make prepare' in $(srctree) to update it)
-endif
+# external modules needs include/linux/autoconf.h and include/config/auto.conf
+# but do not care if they are up-to-date. Use auto.conf to trigger the test
+PHONY += include/config/auto.conf
+
+include/config/auto.conf:
+	$(Q)test -e include/linux/autoconf.h -a -e $@ || (		\
+	echo;								\
+	echo "  ERROR: Kernel configuration is invalid.";		\
+	echo "         include/linux/autoconf.h or $@ are missing.";	\
+	echo "         Run 'make oldconfig && make prepare' on kernel src to fix it.";	\
+	echo;								\
+	/bin/false)
+
+endif # KBUILD_EXTMOD
 
 else
 # Dummy target needed, because used as prerequisite
 include/config/auto.conf: ;
-endif
+endif # $(dot-config)
 
 # The all: target is the default when no target is given on the
 # command line.
diff --git a/usr/Makefile b/usr/Makefile
index e938242..5b31c0b 100644
--- a/usr/Makefile
+++ b/usr/Makefile
@@ -35,6 +35,9 @@ quiet_cmd_initfs = GEN     $@
       cmd_initfs = $(initramfs) -o $@ $(ramfs-args) $(ramfs-input)
 
 targets := initramfs_data.cpio.gz
+# do not try to update files included in initramfs
+$(deps_initramfs): ;
+
 $(deps_initramfs): klibcdirs
 # We rebuild initramfs_data.cpio.gz if:
 # 1) Any included file is newer then initramfs_data.cpio.gz

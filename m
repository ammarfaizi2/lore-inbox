Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267380AbUHMTxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267380AbUHMTxG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267354AbUHMTux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:50:53 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:34603 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S267356AbUHMTpx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 15:45:53 -0400
Date: Fri, 13 Aug 2004 21:48:16 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [6/12] kbuild: Accept absolute paths in clean-files and introduce clean-dirs
Message-ID: <20040813194816.GF10556@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20040813192804.GA10486@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040813192804.GA10486@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/09 20:01:02+02:00 sam@mars.ravnborg.org 
#   kbuild: Accept absolute paths in clean-files and introduce clean-dirs
#   
#   Teach kbuild to accept absolute paths in clean-files. This avoids using
#   clean-rules in several places.
#   Introduced clean-dirs to delete complete directories.
#   Kept clean-rule - but do not print anything when used.
#   Cleaned up a few places now the infrastructure are improved.
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# scripts/package/Makefile
#   2004/08/09 20:00:46+02:00 sam@mars.ravnborg.org +3 -3
#   Use the fact that kbuild now knows of absolute paths in clean-files, and also
#   know how to delete directories.
#   This killed use of clean-rule in this file - good.
# 
# scripts/Makefile.clean
#   2004/08/09 20:00:46+02:00 sam@mars.ravnborg.org +22 -8
#   Teach Makefile.clean about absolute pathnames in clean-files.
#   Introduce clean-dirs.
# 
# Documentation/kbuild/makefiles.txt
#   2004/08/09 20:00:46+02:00 sam@mars.ravnborg.org +11 -2
#   Document the new clean-dirs variable, and the changed behaviour of clean-files.
# 
# Documentation/DocBook/Makefile
#   2004/08/09 20:00:46+02:00 sam@mars.ravnborg.org +1 -3
#   Use clean-dirs to remove directories
# 
diff -Nru a/Documentation/DocBook/Makefile b/Documentation/DocBook/Makefile
--- a/Documentation/DocBook/Makefile	2004-08-13 21:08:35 +02:00
+++ b/Documentation/DocBook/Makefile	2004-08-13 21:08:35 +02:00
@@ -185,9 +185,7 @@
 	$(patsubst %.sgml, %.9,    $(DOCBOOKS)) \
 	$(C-procfs-example)
 
-ifneq ($(wildcard $(patsubst %.html,%,$(HTML))),)
-clean-rule := rm -rf $(wildcard $(patsubst %.html,%,$(HTML)))
-endif
+clean-dirs := $(patsubst %.sgml,%,$(DOCBOOKS))
 
 #man put files in man subdir - traverse down
 subdir- := man/
diff -Nru a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
--- a/Documentation/kbuild/makefiles.txt	2004-08-13 21:08:35 +02:00
+++ b/Documentation/kbuild/makefiles.txt	2004-08-13 21:08:35 +02:00
@@ -547,8 +547,17 @@
 		clean-files := devlist.h classlist.h
 
 When executing "make clean", the two files "devlist.h classlist.h" will
-be deleted. Kbuild knows that files specified by $(clean-files) are
-located in the same directory as the makefile.
+be deleted. Kbuild will assume files to be in same relative directory as the
+Makefile except if an absolute path is specified (path starting with '/').
+
+To delete a directory hirachy use:
+	Example:
+		#scripts/package/Makefile
+		clean-dirs := $(objtree)/debian/
+
+This will delete the directory debian, including all subdirectories.
+Kbuild will assume the directories to be in the same relative path as the
+Makefile if no absolute path is specified (path does not start with '/').
 
 Usually kbuild descends down in subdirectories due to "obj-* := dir/",
 but in the architecture makefiles where the kbuild infrastructure
diff -Nru a/scripts/Makefile.clean b/scripts/Makefile.clean
--- a/scripts/Makefile.clean	2004-08-13 21:08:35 +02:00
+++ b/scripts/Makefile.clean	2004-08-13 21:08:35 +02:00
@@ -29,21 +29,35 @@
 # Add subdir path
 
 subdir-ymn	:= $(addprefix $(obj)/,$(subdir-ymn))
-__clean-files	:= $(wildcard $(addprefix $(obj)/, \
-		   $(extra-y) $(EXTRA_TARGETS) $(always) $(host-progs) \
-		   $(targets) $(clean-files)))
+__clean-files	:= $(extra-y) $(EXTRA_TARGETS) $(always) $(host-progs) \
+		   $(targets) $(clean-files)
+__clean-files   := $(wildcard                                               \
+                   $(addprefix $(obj)/, $(filter-out /%, $(__clean-files))) \
+		   $(filter /%, $(__clean-files)))
+__clean-dirs    := $(wildcard                                               \
+                   $(addprefix $(obj)/, $(filter-out /%, $(clean-dirs)))    \
+		   $(filter /%, $(clean-dirs)))
 
 # ==========================================================================
 
-quiet_cmd_clean = CLEAN   $(obj)
-      cmd_clean = rm -f $(__clean-files); $(clean-rule)
+quiet_cmd_clean    = CLEAN   $(obj)
+      cmd_clean    = rm -f $(__clean-files)
+quiet_cmd_cleandir = CLEAN   $(__clean-dirs)
+      cmd_cleandir = rm -rf $(__clean-dirs)
+
 
 __clean: $(subdir-ymn)
-ifneq ($(strip $(__clean-files) $(clean-rule)),)
+ifneq ($(strip $(__clean-files)),)
 	+$(call cmd,clean)
-else
-	@:
 endif
+ifneq ($(strip $(__clean-dirs)),)
+	+$(call cmd,cleandir)
+endif
+ifneq ($(strip $(clean-rule)),)
+	+$(clean-rule)
+endif
+	@:
+
 
 # ===========================================================================
 # Generic stuff
diff -Nru a/scripts/package/Makefile b/scripts/package/Makefile
--- a/scripts/package/Makefile	2004-08-13 21:08:35 +02:00
+++ b/scripts/package/Makefile	2004-08-13 21:08:35 +02:00
@@ -51,7 +51,7 @@
 	$(RPM) --target $(UTS_MACHINE) -ta ../$(KERNELPATH).tar.gz
 	rm ../$(KERNELPATH).tar.gz
 
-clean-rule +=  rm -f $(objtree)/kernel.spec
+clean-files := $(objtree)/kernel.spec
 
 # binrpm-pkg
 .PHONY: binrpm-pkg
@@ -67,7 +67,7 @@
 
 	$(RPM) --define "_builddir $(srctree)" --target $(UTS_MACHINE) -bb $<
 
-clean-rule += rm -f $(objtree)/binkernel.spec
+clean-files += $(objtree)/binkernel.spec
 
 # Deb target
 # ---------------------------------------------------------------------------
@@ -77,7 +77,7 @@
 	$(MAKE)
 	$(CONFIG_SHELL) $(srctree)/scripts/package/builddeb
 
-clean-rule += && rm -rf $(objtree)/debian/
+clean-dirs += $(objtree)/debian/
 
 
 # Help text displayed when executing 'make help'

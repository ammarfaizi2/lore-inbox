Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315573AbSETALn>; Sun, 19 May 2002 20:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315599AbSETALm>; Sun, 19 May 2002 20:11:42 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:59552 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S315573AbSETALl>; Sun, 19 May 2002 20:11:41 -0400
Date: Sun, 19 May 2002 19:11:41 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: linux-kernel@vger.kernel.org
Subject: [RFC/PATCH] improve interaction with ccache
Message-ID: <Pine.LNX.4.44.0205191906310.30559-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As various people pointed out, ccache is a great win for people compiling 
a lot of kernels. (For info on ccache, see ccache.samba.org)

Unfortunately, when a kernel tree is moved around / cloned / symlinked, 
the compiler cache doesn't have many hits, since some header files use 
BUG(), which in turn uses __FILE__, which currently includes the absolute 
path to the header file.

The appended patch solves this problem by including the headers a relative 
path which will not change when the tree is moved.

I'd like to get comments if
o the patch breaks anything for someone and
o it's considered useful enough for inclusion

--Kai


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.553   -> 1.554  
#	          Rules.make	1.21    -> 1.22   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/19	kai@tp1.ruhr-uni-bochum.de	1.554
# kbuild: Improve interaction with ccache
# 
# Use relativ paths on the command line, thus __FILE__
# in an include file looks like "../../include/linux/foo.h" instead of
# "/home/kai/kernel/v2.5/linux-2.5.make-work/include/linux/foo.h".
# 
# The latter is unnecessarily long and in particular changes when
# you move your source tree around, thus causing cache misses with
# ccache.
# --------------------------------------------
#
diff -Nru a/Rules.make b/Rules.make
--- a/Rules.make	Sun May 19 18:50:41 2002
+++ b/Rules.make	Sun May 19 18:50:41 2002
@@ -49,13 +49,28 @@
 MOD_SUB_DIRS	:= $(sort $(subdir-m) $(both-m))
 ALL_SUB_DIRS	:= $(sort $(subdir-y) $(subdir-m) $(subdir-n) $(subdir-))
 
+empty :=
+space := $(empty) $(empty)
+
+ifeq ($(TOPDIR),$(CURDIR))
+  RELDIR := ./
+  TOPDIR_REL := ./
+else
+  RELDIR := $(subst $(TOPDIR)/,,$(CURDIR))
+  TOPDIR_REL := $(subst $(space),,$(foreach d,$(subst /, ,$(RELDIR)),../))
+endif
+
 #
 # Common rules
 #
 
 # export_flags will be set to -DEXPORT_SYMBOL for objects in $(export-objs)
 
-c_flags = $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o) -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) $(export_flags)
+c_flags = $(subst $(TOPDIR)/,$(TOPDIR_REL), \
+	          $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o) \
+	  	  -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) \
+	  	  $(export_flags) \
+	   )
 
 cmd_cc_s_c = $(CC) $(c_flags) -S $< -o $@
 
@@ -78,7 +93,9 @@
 # the Makefiles to these standard rules.  -- rmk, mec
 ifdef USE_STANDARD_AS_RULE
 
-a_flags = $(AFLAGS) $(EXTRA_AFLAGS) $(AFLAGS_$(*F).o)
+a_flags = $(subst $(TOPDIR)/,$(TOPDIR_REL), \
+	          $(AFLAGS) $(EXTRA_AFLAGS) $(AFLAGS_$(*F).o) \
+	   )
 
 cmd_as_s_S = $(CPP) $(a_flags) $< > $@
 
@@ -375,5 +392,5 @@
 if_changed = $(if $(strip $? \
 		          $(filter-out $($(1)),$(cmd_$@))\
 			  $(filter-out $(cmd_$@),$($(1)))),\
-	       @echo $($(1)); $($(1)); echo 'cmd_$@ := $($(1))' > .$@.cmd)
+	       @echo '$($(1))'; $($(1)); echo 'cmd_$@ := $($(1))' > .$@.cmd)
 


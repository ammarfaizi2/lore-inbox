Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275045AbSITFGI>; Fri, 20 Sep 2002 01:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275067AbSITFGI>; Fri, 20 Sep 2002 01:06:08 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:13839 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S275045AbSITFGF>;
	Fri, 20 Sep 2002 01:06:05 -0400
Date: Fri, 20 Sep 2002 07:10:55 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] linux kernel conf 0.6
Message-ID: <20020920071055.A1852@mars.ravnborg.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	kbuild-devel <kbuild-devel@lists.sourceforge.net>
References: <3D866667.1EBFDF31@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D866667.1EBFDF31@linux-m68k.org>; from zippel@linux-m68k.org on Tue, Sep 17, 2002 at 01:16:55AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman, sorry if you get this twice. first mail did not show up.

I have been working on integrating lkc with kbuild.
Here is the result.

Rules.make
- Added infrastructure to support host-ccprogs, in other words
  support tools written (partly) in c++.

scripts/lkc/Makefile*
- As kbuild does not distingush between individual objects,
  used for a given target, but (try to) build them all, I have
  found a solution where I create one Makefile for each executable.
  I could not see a clean way to integrate this in kbuild, and finally
  decided that in this special case a number of Makefiles did not
  hurt too much.

flex/bison
- Prepared for "_shipped" files.
  Rename lex.zconf.c to lex.zconf.c_shipped etc. in the version
  reday to go in the kernel.

	Sam

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.555   -> 1.556  
#	          Rules.make	1.70    -> 1.71   
#	               (new)	        -> 1.1     scripts/lkc/Makefile.qconf
#	               (new)	        -> 1.1     scripts/lkc/Makefile.conf
#	               (new)	        -> 1.1     scripts/lkc/Makefile.mconf
#	               (new)	        -> 1.1     scripts/lkc/lex.zconf.c_shipped
#	               (new)	        -> 1.1     scripts/lkc/Makefile
#	               (new)	        -> 1.1     scripts/lkc/zconf.tab.h_shipped
#	               (new)	        -> 1.1     scripts/lkc/zconf.tab.c_shipped
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/19	sam@mars.ravnborg.org	1.556
# [PATCH] Adaptions to make lkc kbuild compatible
# --------------------------------------------
#
diff -Nru a/Rules.make b/Rules.make
--- a/Rules.make	Thu Sep 19 21:32:14 2002
+++ b/Rules.make	Thu Sep 19 21:32:14 2002
@@ -391,19 +391,51 @@
 
 quiet_cmd_host_cc_o_c = HOSTCC  $(echo_target)
 cmd_host_cc_o_c       = $(HOSTCC) -Wp,-MD,$(depfile) \
-			$(HOSTCFLAGS) $(HOST_EXTRACFLAGS) -c -o $@ $<
+			$(HOSTCFLAGS) $(HOST_EXTRACFLAGS) \
+			$(HOSTCFLAGS_$(@F)) -c -o $@ $<
 
 $(host-progs-multi-objs): %.o: %.c FORCE
 	$(call if_changed_dep,host_cc_o_c)
 
 quiet_cmd_host_cc__o  = HOSTLD  $(echo_target)
-cmd_host_cc__o        = $(HOSTCC) $(HOSTLDFLAGS) -o $@ $($@-objs) \
+cmd_host_cc__o        = $(HOSTCC) $(HOSTLDFLAGS) -o $@ $($@-objs) $($@-ccobjs) \
 			$(HOST_LOADLIBES)
 
 $(host-progs-multi): %: $(host-progs-multi-objs) FORCE
 	$(call if_changed,host_cc__o)
 
 targets += $(host-progs-single) $(host-progs-multi-objs) $(host-progs-multi) 
+
+# Compile c++ programs on the host
+# ===========================================================================
+host-ccprogs-single  := $(foreach m,$(host-ccprogs),\
+$(if $($(m)-objs),,$(if $($(m)-ccobjs),,$(m))))
+
+host-ccprogs-multi := $(foreach m,$(host-ccprogs),$(if $($(m)-objs),$(m)))
+host-ccprogs-multi += $(foreach m,$(host-ccprogs),$(if $($(m)-ccobjs),$(m)))
+host-ccprogs-multi := $(sort $(host-ccprogs-multi))
+
+host-ccprogs-multi-objs   := $(foreach m,$(host-ccprogs-multi),$($(m)-objs))
+host-ccprogs-ccmulti-objs := $(foreach m,$(host-ccprogs-multi),$($(m)-ccobjs))
+
+$(host-ccprogs-single): %: %.cc FORCE
+        $(call if_changed_dep,host_cc__c)
+
+# .c -> .o
+$(host-ccprogs-multi-objs): %.o: %.c FORCE
+	$(call if_changed_dep,host_cc_o_c)
+
+# .cc -> .o
+$(host-ccprogs-ccmulti-objs): %.o: %.cc FORCE
+	@echo '? $?'
+	$(call if_changed_dep,host_cc_o_c)
+
+$(host-ccprogs-multi): %: $(host-ccprogs-multi-objs) \
+                          $(host-ccprogs-ccmulti-objs) FORCE
+	$(call if_changed,host_cc__o)
+
+targets += $(host-ccprogs-single)     $(host-ccprogs-multi) \
+	   $(host-ccprogs-multi-objs) $(host-ccprogs-ccmulti-objs) 
 
 endif # ! modules_install
 endif # ! fastdep
diff -Nru a/scripts/lkc/Makefile b/scripts/lkc/Makefile
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/scripts/lkc/Makefile	Thu Sep 19 21:32:14 2002
@@ -0,0 +1,51 @@
+#################
+#
+# Shared makefile for the various lkc executables:
+# conf:	  Used for defconfig, oldconfig and related targets
+# mconf:  Used for the mconfig target.
+#         Utilises the lxdialog package
+# qconf:  Used for the xconfig target
+#         Based on qt which needs to be installed to compile it
+#         Se instructions in Makefile.qconf
+#
+# kbuild are not well prepared for multiple targets that share the
+# same modules. To address this multiple makefiles are used, and the
+# common parts are located within this makefile.
+
+include $(TOPDIR)/Rules.make
+
+# objct files used by all lkc flavours
+sharedobjs := zconf.tab.o lex.zconf.o confdata.o expr.o symbol.o menu.o
+export sharedobjs
+
+parsersrc := zconf.tab.c zconf.tab.h lex.zconf.c
+export parsersrc
+.PHONY: conf mconf qconf
+
+conf: $(parsersrc)
+	$(MAKE) -f Makefile.$@
+mconf: $(parsersrc)  
+	$(MAKE) -f Makefile.$@
+qconf: $(parsersrc)
+	$(MAKE) -f Makefile.$@
+
+
+###
+# The following requires flex/bison
+# By defualt we use the _shipped versions, uncomment the following line if
+# you are modifying the flex/bison src.
+# LKC_GENPARSER := 1
+
+ifdef LKC_GENPARSER
+
+zconf.tab.c: zconf.y
+zconf.tab.h: zconf.tab.c
+
+%.tab.c %.tab.h: %.y
+	bison -t -d -v -b $* -p $* $<
+
+lex.%.c: %.l
+	flex -P$* $<
+
+endif
+
diff -Nru a/scripts/lkc/Makefile.conf b/scripts/lkc/Makefile.conf
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/scripts/lkc/Makefile.conf	Thu Sep 19 21:32:14 2002
@@ -0,0 +1,9 @@
+###
+# Makefile for the conf executable, part of the lkc suite of programs
+
+host-progs := conf
+conf-objs := conf.o $(sharedobjs)
+
+all: conf
+include $(TOPDIR)/Rules.make
+
diff -Nru a/scripts/lkc/Makefile.mconf b/scripts/lkc/Makefile.mconf
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/scripts/lkc/Makefile.mconf	Thu Sep 19 21:32:14 2002
@@ -0,0 +1,9 @@
+###
+# Makefile for the mconf executable, part of the lkc suite of programs.
+
+host-progs := mconf
+mconf-objs  := mconf.o $(sharedobjs)
+
+all: mconf
+include $(TOPDIR)/Rules.make
+
diff -Nru a/scripts/lkc/Makefile.qconf b/scripts/lkc/Makefile.qconf
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/scripts/lkc/Makefile.qconf	Thu Sep 19 21:32:14 2002
@@ -0,0 +1,43 @@
+###
+# Makefile for the qconf executable, part of the lkc suite of programs
+#
+# qconf is based on the qt library, which needs to be installed
+# 
+
+host-ccprogs := qconf
+qconf-ccobjs := qconf.o
+qconf-objs   := $(sharedobjs)
+
+# Assume default location of qt if QTDIR is unset
+# Use make QTDIR=/some/other/dir/qt xconfig
+# if qtdir is located elsewhere, and QTDIR is not defined.
+ifndef QTDIR
+QTDIR=/usr/share/qt
+endif
+
+#Executable to interpret the .moc file
+MOC=$(wildcard $(QTDIR)/bin/moc)
+
+HOSTLDFLAGS      := -L$(QTDIR)/lib
+HOST_LOADLIBES   := -lqt
+HOSTCFLAGS_qconf.o := -I$(QTDIR)/include 
+
+# Default target, we always want to build qconf
+.PHONY: qtcheck
+all: qtcheck qconf
+
+include $(TOPDIR)/Rules.make
+
+ifeq ($(MOC),)
+qtcheck:
+        @echo Unable to find the QT installation. Please make sure that the
+        @echo QT development package is correctly installed and the QTDIR
+        @echo environment variable is set to the correct location.
+        @false
+endif
+
+$(obj)/qconf.o: $(obj)/qconf.moc
+
+$(obj)/%.moc: $(src)/%.h
+	$(QTDIR)/bin/moc -i $< -o $@
+

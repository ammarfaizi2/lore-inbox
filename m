Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267062AbSKWWRy>; Sat, 23 Nov 2002 17:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267072AbSKWWRy>; Sat, 23 Nov 2002 17:17:54 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:36104 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267062AbSKWWRt>;
	Sat, 23 Nov 2002 17:17:49 -0500
Date: Sat, 23 Nov 2002 23:22:59 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: [CFT] Separate obj dir [2]
Message-ID: <20021123222259.GA10609@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here goes second version of separate obj dir patch.
I have modified kconfig so no need to copy kconfig
related files anymore. Patch is sent to Roman
already for review.

Usage as before:
cd to the directory where you want to compile
call kbuild located in the root of the kernel src.

kbuild passes all options to make.

As the last thread clearly showed there is interest
for this feature, but I do not plan to submit it for
inclusion before I get some more test-feedback.

Also I want to sort out the kconfig changes separate,
since I prefer the maintainer to send this to Linus.

Another related issue is that this patch touches
areas in the Makefiles that may interfere with
the module stuff, and thats more important to
get in right now.


If you try this out based on attached patch
make sure to uncomment LKC_GENPARSER in
scripts/kconfig/Makefile.

The diff of the three generated files were too big,
mainly becasue I do not have the same flex
and bison version as Roman.

Testing appreciated,

	Sam

Patch on top of 2.5.49.

Can be pulled from http://linux-sam.bkbits.net/sepobjdir

 Makefile                   |   22 ++++++++++++++++------
 scripts/Makefile.build     |   41 ++++++++++++++++++++---------------------
 scripts/Makefile.lib       |    8 +++++++-
 scripts/kconfig/Makefile   |    5 ++++-
 scripts/kconfig/confdata.c |   13 ++++++++++---
 scripts/kconfig/expr.h     |    2 ++
 scripts/kconfig/symbol.c   |    7 +++++++
 scripts/kconfig/zconf.l    |   27 +++++++++++++++++++++++++--
 8 files changed, 91 insertions(+), 34 deletions(-)


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.857   -> 1.858  
#	scripts/kconfig/symbol.c	1.2     -> 1.3    
#	scripts/kconfig/zconf.tab.c_shipped	1.2     -> 1.3    
#	scripts/kconfig/expr.h	1.2     -> 1.3    
#	scripts/kconfig/zconf.l	1.3     -> 1.4    
#	scripts/kconfig/lex.zconf.c_shipped	1.3     -> 1.4    
#	scripts/kconfig/zconf.tab.h_shipped	1.2     -> 1.3    
#	scripts/kconfig/confdata.c	1.3     -> 1.4    
#	scripts/kconfig/Makefile	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/11/23	sam@mars.ravnborg.org	1.858
# kconfig: Try to locate files in $srctree
# 
# In order to support separate src/obj dir, try locating
# files in tree pointed out by $srctree as second alternative
# --------------------------------------------
#
diff -Nru a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
--- a/scripts/kconfig/symbol.c	Sat Nov 23 22:53:43 2002
+++ b/scripts/kconfig/symbol.c	Sat Nov 23 22:53:43 2002
@@ -75,6 +75,13 @@
 	if (p)
 		sym_add_default(sym, p);
 
+	sym = sym_lookup(SRCTREE, 0);
+	sym->type = S_STRING;
+	sym->flags |= SYMBOL_AUTO;
+	p = getenv(SRCTREE);
+	if (p)
+		sym_add_default(sym, p);
+	
 	sym = sym_lookup("UNAME_RELEASE", 0);
 	sym->type = S_STRING;
 	sym->flags |= SYMBOL_AUTO;
diff -Nru a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
--- a/scripts/kconfig/zconf.l	Sat Nov 23 22:53:43 2002
+++ b/scripts/kconfig/zconf.l	Sat Nov 23 22:53:43 2002
@@ -249,9 +249,32 @@
 	BEGIN(INITIAL); 
 }
 
+/* 
+   Try to open specified file with following names:
+   ./name
+   $(srctree)/name
+   The latter is used when srctree is separate from objtree
+   when compiling the kernel.
+   Return NULL if file is not found.
+*/
+static FILE *zconf_fopen(const char *name)
+{
+	static char fullname[SYMBOL_MAXLENGTH];
+	static char *p;
+	FILE *f = fopen(name, "r");
+	if (f)
+		return f;
+	p = getenv(SRCTREE);
+	if (p) {
+		sprintf(fullname, "%s/%s", p, name);
+		return fopen(fullname, "r");
+	}
+	return NULL;
+}
+
 void zconf_initscan(const char *name)
 {
-	yyin = fopen(name, "r");
+	yyin = zconf_fopen(name);
 	if (!yyin) {
 		printf("can't find file %s\n", name);
 		exit(1);
@@ -272,7 +295,7 @@
 	memset(buf, 0, sizeof(*buf));
 
 	current_buf->state = YY_CURRENT_BUFFER;
-	yyin = fopen(name, "r");
+	yyin = zconf_fopen(name);
 	if (!yyin) {
 		printf("%s:%d: can't open file \"%s\"\n", zconf_curname(), zconf_lineno(), name);
 		exit(1);
diff -Nru a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
--- a/scripts/kconfig/Makefile	Sat Nov 23 22:53:43 2002
+++ b/scripts/kconfig/Makefile	Sat Nov 23 22:53:43 2002
@@ -77,12 +77,15 @@
 ifdef LKC_GENPARSER
 
 $(obj)/zconf.tab.c: $(obj)/zconf.y 
-$(obj)/zconf.tab.h: $(obj)/zconf.tab.c
+$(obj)/zconf.tab.h: $(obj)/zconf.y
 
 %.tab.c: %.y
 	bison -t -d -v -b $* -p $(notdir $*) $<
+	cp $@ $@_shipped
+	cp $(@:.c=.h) $(@:.c=.h)_shipped
 
 lex.%.c: %.l
 	flex -P$(notdir $*) -o$@ $<
+	cp $@ $@_shipped
 
 endif
diff -Nru a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
--- a/scripts/kconfig/confdata.c	Sat Nov 23 22:53:43 2002
+++ b/scripts/kconfig/confdata.c	Sat Nov 23 22:53:43 2002
@@ -7,6 +7,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/stat.h>
 #include <unistd.h>
 
 #define LKC_DIRECT_LINK
@@ -14,14 +15,16 @@
 
 const char conf_def_filename[] = ".config";
 
-const char conf_defname[] = "arch/$ARCH/defconfig";
+#define DEFNAME    4
+#define DEFALTNAME 5
 
 const char *conf_confnames[] = {
 	".config",
 	"/lib/modules/$UNAME_RELEASE/.config",
 	"/etc/kernel-config",
 	"/boot/config-$UNAME_RELEASE",
-	conf_defname,
+	"arch/$ARCH/defconfig",			/* index DEFNAME */
+	"$" SRCTREE "/arch/$ARCH/defconfig",	/* index DEFALTNAME */
 	NULL,
 };
 
@@ -53,7 +56,11 @@
 
 char *conf_get_default_confname(void)
 {
-	return conf_expand_value(conf_defname);
+	struct stat buf;
+	char * name = conf_expand_value(conf_confnames[DEFNAME]);
+	if (!stat(name, &buf))
+		return name;
+	return conf_expand_value(conf_confnames[DEFALTNAME]);
 }
 
 int conf_read(const char *name)
diff -Nru a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
--- a/scripts/kconfig/expr.h	Sat Nov 23 22:53:43 2002
+++ b/scripts/kconfig/expr.h	Sat Nov 23 22:53:43 2002
@@ -127,6 +127,8 @@
 #define SYMBOL_HASHSIZE		257
 #define SYMBOL_HASHMASK		0xff
 
+#define SRCTREE "srctree"
+
 enum prop_type {
 	P_UNKNOWN, P_PROMPT, P_COMMENT, P_MENU, P_ROOTMENU, P_DEFAULT, P_CHOICE
 };

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.858   -> 1.859  
#	            Makefile	1.350   -> 1.351  
#	scripts/Makefile.lib	1.4     -> 1.5    
#	scripts/Makefile.build	1.11    -> 1.12   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/11/23	sam@mars.ravnborg.org	1.859
# kbuild: Support for separate obj dir
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Sat Nov 23 23:10:07 2002
+++ b/Makefile	Sat Nov 23 23:10:07 2002
@@ -135,14 +135,20 @@
 
 export quiet Q KBUILD_VERBOSE
 
-#	Paths to obj / src tree
-
-src	:= .
-obj	:= .
+#       Paths to obj / src tree
+ifneq ($(wildcard .tmp_make_config),)
+include .tmp_make_config
+src     := $(srctree)
+obj     := .
+VPATH   := $(srctree)
+else
+src     := .
+obj     := .
 srctree := .
 objtree := .
+endif
 
-export srctree objtree
+export srctree objtree VPATH
 
 # 	Make variables (CC, etc...)
 
@@ -419,7 +425,11 @@
 
 include/asm:
 	@echo '  Making asm->asm-$(ARCH) symlink'
+ifeq ($(srctree),$(objtree))
 	@ln -s asm-$(ARCH) $@
+else
+	@ln -s $(src)/include/asm-$(ARCH) $@
+endif
 
 # 	Split autoconf.h into include/linux/config/*
 
@@ -598,7 +608,7 @@
 	tar -cvz $(RCS_TAR_IGNORE) -f $(KERNELPATH).tar.gz $(KERNELPATH)/. ; \
 	rm $(KERNELPATH) ; \
 	cd $(TOPDIR) ; \
-	. scripts/mkversion > .version ; \
+	$(CONFIG_SHELL) $(src)/scripts/mkversion > .version ; \
 	rpm -ta $(TOPDIR)/../$(KERNELPATH).tar.gz ; \
 	rm $(TOPDIR)/../$(KERNELPATH).tar.gz
 
diff -Nru a/scripts/Makefile.build b/scripts/Makefile.build
--- a/scripts/Makefile.build	Sat Nov 23 23:10:07 2002
+++ b/scripts/Makefile.build	Sat Nov 23 23:10:07 2002
@@ -84,26 +84,35 @@
 $(multi-objs-y:.o=.s)   : modname = $(modname-multi)
 $(multi-objs-y:.o=.lst) : modname = $(modname-multi)
 
+# Allow gcc to locate header files in srctree, if we use separate objtree
+ifeq ($(srctree),$(objtree))
+flags = $($(1))
+else
+flags = -I$(obj) -I$(srctree)/$(src) $($(1)) $(patsubst -I%,-I$(srctree)/%,$(filter -I%,$($(1))))
+endif
+
 quiet_cmd_cc_s_c = CC $(quiet_modtag)  $@
-cmd_cc_s_c       = $(CC) $(c_flags) -S -o $@ $< 
+cmd_cc_s_c       = $(CC) $(call flags,c_flags) -S -o $@ $< 
 
 %.s: %.c FORCE
 	$(call if_changed_dep,cc_s_c)
 
 quiet_cmd_cc_i_c = CPP $(quiet_modtag) $@
-cmd_cc_i_c       = $(CPP) $(c_flags)   -o $@ $<
+cmd_cc_i_c       = $(CPP) $(call flags,c_flags)   -o $@ $<
 
 %.i: %.c FORCE
 	$(call if_changed_dep,cc_i_c)
 
 quiet_cmd_cc_o_c = CC $(quiet_modtag)  $@
-cmd_cc_o_c       = $(CC) $(c_flags) -c -o $@ $<
+cmd_cc_o_c       = $(CC) $(call flags,c_flags) -c -o $@ $<
 
 %.o: %.c FORCE
 	$(call if_changed_dep,cc_o_c)
 
 quiet_cmd_cc_lst_c = MKLST   $@
-cmd_cc_lst_c       = $(CC) $(c_flags) -g -c -o $*.o $< && sh scripts/makelst $*.o System.map $(OBJDUMP) > $@
+      cmd_cc_lst_c = $(CC) $(call flags,c_flags) -g -c -o $*.o $< && \
+		     $(CONFIG_SHELL) $(src)/scripts/makelst $*.o \
+				     System.map $(OBJDUMP) > $@
 
 %.lst: %.c FORCE
 	$(call if_changed_dep,cc_lst_c)
@@ -116,17 +125,14 @@
 $(real-objs-m)      : modkern_aflags := $(AFLAGS_MODULE)
 $(real-objs-m:.o=.s): modkern_aflags := $(AFLAGS_MODULE)
 
-a_flags = -Wp,-MD,$(depfile) $(AFLAGS) $(NOSTDINC_FLAGS) \
-	  $(modkern_aflags) $(EXTRA_AFLAGS) $(AFLAGS_$(*F).o)
-
 quiet_cmd_as_s_S = CPP $(quiet_modtag) $@
-cmd_as_s_S       = $(CPP) $(a_flags)   -o $@ $< 
+cmd_as_s_S       = $(CPP) $(call flags,a_flags)   -o $@ $< 
 
 %.s: %.S FORCE
 	$(call if_changed_dep,as_s_S)
 
 quiet_cmd_as_o_S = AS $(quiet_modtag)  $@
-cmd_as_o_S       = $(CC) $(a_flags) -c -o $@ $<
+cmd_as_o_S       = $(CC) $(call flags,a_flags) -c -o $@ $<
 
 %.o: %.S FORCE
 	$(call if_changed_dep,as_o_S)
@@ -217,9 +223,8 @@
 # Create executable from a single .c file
 # host-csingle -> Executable
 quiet_cmd_host-csingle 	= HOSTCC  $@
-      cmd_host-csingle	= $(HOSTCC) -Wp,-MD,$(depfile) \
-			  $(HOSTCFLAGS) $(HOST_EXTRACFLAGS) \
-			  $(HOST_LOADLIBES) -o $@ $<
+      cmd_host-csingle	= $(HOSTCC) $(call flags,hostc_flags) \
+				    $(HOST_LOADLIBES) -o $@ $<
 $(host-csingle): %: %.c FORCE
 	$(call if_changed_dep,host-csingle)
 
@@ -235,9 +240,7 @@
 # Create .o file from a single .c file
 # host-cobjs -> .o
 quiet_cmd_host-cobjs	= HOSTCC  $@
-      cmd_host-cobjs	= $(HOSTCC) -Wp,-MD,$(depfile) \
-			  $(HOSTCFLAGS) $(HOST_EXTRACFLAGS) \
-			  $(HOSTCFLAGS_$(@F)) -c -o $@ $<
+      cmd_host-cobjs	= $(HOSTCC) $(call flags,hostc_flags) -c -o $@ $<
 $(host-cobjs): %.o: %.c FORCE
 	$(call if_changed_dep,host-cobjs)
 
@@ -253,18 +256,14 @@
 
 # Create .o file from a single .cc (C++) file
 quiet_cmd_host-cxxobjs	= HOSTCXX $@
-      cmd_host-cxxobjs	= $(HOSTCXX) -Wp,-MD,$(depfile) \
-			  $(HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
-			  $(HOSTCXXFLAGS_$(@F)) -c -o $@ $<
+      cmd_host-cxxobjs	= $(HOSTCXX) $(call flags,hostcxx_flags) -c -o $@ $<
 $(host-cxxobjs): %.o: %.cc FORCE
 	$(call if_changed_dep,host-cxxobjs)
 
 # Compile .c file, create position independent .o file
 # host-cshobjs -> .o
 quiet_cmd_host-cshobjs	= HOSTCC  -fPIC $@
-      cmd_host-cshobjs	= $(HOSTCC) -Wp,-MD,$(depfile) -fPIC\
-			  $(HOSTCFLAGS) $(HOST_EXTRACFLAGS) \
-			  $(HOSTCFLAGS_$(@F)) -c -o $@ $<
+      cmd_host-cshobjs	= $(HOSTCC) $(call flags,hostc_flags) -fPIC -c -o $@ $<
 $(host-cshobjs): %.o: %.c FORCE
 	$(call if_changed_dep,host-cshobjs)
 
diff -Nru a/scripts/Makefile.lib b/scripts/Makefile.lib
--- a/scripts/Makefile.lib	Sat Nov 23 23:10:07 2002
+++ b/scripts/Makefile.lib	Sat Nov 23 23:10:07 2002
@@ -128,6 +128,12 @@
 c_flags        = -Wp,-MD,$(depfile) $(CFLAGS) $(NOSTDINC_FLAGS) \
 	         $(modkern_cflags) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o) \
 	         $(basename_flags) $(modname_flags) $(export_flags) 
+a_flags        = -Wp,-MD,$(depfile) $(AFLAGS) $(NOSTDINC_FLAGS)\
+		 $(modkern_aflags) $(EXTRA_AFLAGS) $(AFLAGS_$(*F).o)
+hostc_flags    = -Wp,-MD,$(depfile) $(HOSTCFLAGS) $(HOST_EXTRACFLAGS)\
+		 $(HOSTCFLAGS_$(*F).o)
+hostcxx_flags  = -Wp,-MD,$(depfile) $(HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS)\
+		 $(HOSTCXXFLAGS_$(*F).o)
 
 # Finds the multi-part object the current object will be linked into
 modname-multi = $(subst $(space),_,$(sort $(foreach m,$(multi-used),\
@@ -139,7 +145,7 @@
 quiet_cmd_shipped = SHIPPED $@
 cmd_shipped = cat $< > $@
 
-%:: %_shipped
+$(obj)/%:: $(src)/%_shipped
 	$(call cmd,shipped)
 
 # Commands useful for building a boot image

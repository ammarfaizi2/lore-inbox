Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315297AbSDWSCP>; Tue, 23 Apr 2002 14:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315298AbSDWSCO>; Tue, 23 Apr 2002 14:02:14 -0400
Received: from [192.82.208.96] ([192.82.208.96]:44459 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S315297AbSDWSCL>;
	Tue, 23 Apr 2002 14:02:11 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.19-pre7 correct inter-directory .h dependencies
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 22 Apr 2002 18:40:42 +1000
Message-ID: <1099.1019464842@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are three long standing design problems in kbuild 2.4 when
handling timestamps on header files.  Originally they were not much of
an issue but recent source changes have made the problems severe enough
to require fixing.

Some background for those who do not live and breath kbuild code (I
need a life ;)

make dep builds a .depend file in each directory to describe the
dependencies between source files, headers and config options - in this
directory.  There is also a global .hdepend that covers all of the
include directories.  When make recurses into each directory, it reads
.hdepend plus the local .depend file.  The idea is to detect config
changes that affect headers and update their timestamps which in turn
will recompile the sources.

The problems are :-

(1) There is an undocumented assumption that local headers are only
    used by sources in the same directory.  .depend only changes the
    timestamps on local files, not on files read from other
    directories.  .hdepend is meant to catch global headers but more
    and more subsystems are defining local headers that are accessed
    from multiple directories.

    Particular examples are scsi.h (accessed from sub directories under
    drivers/scsi and even from directories completely outside the scsi
    subtree) and acpi headers (especially now that ia64 has backported
    the 2.5 acpi code into 2.4).  Any code with #include "../header" or
    -I ../somedir is being bitten by this problem.

    When a source depends on a header in another directory, you cannot
    guarantee cross directory timestamp integrity with the current
    code, especially with parallel make.  Sources are not being
    recompiled when they should be.  A second (third, fourth) build
    will usually pick up the files that were skipped the first time,
    but who does that?  The result is an inconsistent kernel, make
    mrproper will fix it but that is so Microsoft ...

(2) Nested local headers and local headers that depend on config
    options may not even be updated when the subordinate files change.
    make only looks at the targets if there is a chain from .o -> .c ->
    .h in the same directory as the local header.

    When a subsystem has its own include directory and no sources in
    that directory, there is nothing to trip the timestamp checks so
    changes to nested headers or configs are ignored.  2.5 acpi hits
    this.  Change drivers/acpi/acconfig.h and nothing gets recompiled.

(3) make does not recognise that ../../drivers/scsi/scsi.h and
    drivers/scsi/scsi.h are the same file (yes, we have source that
    does that).  This breaks the dependency graph, make does not notice
    changes until you run the build a second time.


This patch converts the unreliable per directory fiddling with header
timestamps into a single global header pass at the start of make
bzImage modules.  This gets all the header timestamps correct before
looking at any code.  As a bonus, it reduces the number of compiles on
the second build run.  mkdep output is standardized to overcome problem
3.

Even with this patch, 2.5 (and 2.4 ia64) acpi/include is still a
problem, changes to nested headers and config options are not detected
in acpi.  That is due to yet another bug which I will follow up with
the acpi developers.

Needless to say, none of this is a problem for kbuild 2.5, all of this
is a 2.4 problem.

Index: 19-pre7.1/scripts/mkdep.c
--- 19-pre7.1/scripts/mkdep.c Mon, 17 Sep 2001 11:13:57 +1000 kaos (linux-2.4/12_mkdep.c 1.1.2.2 644)
+++ 19-pre7.1(w)/scripts/mkdep.c Mon, 22 Apr 2002 15:25:53 +1000 kaos (linux-2.4/12_mkdep.c 1.1.2.2 644)
@@ -48,6 +48,8 @@
 char __depname[512] = "\n\t@touch ";
 #define depname (__depname+9)
 int hasdep;
+char cwd[PATH_MAX];
+int lcwd;
 
 struct path_struct {
 	int len;
@@ -202,8 +204,22 @@ void handle_include(int start, const cha
 		memcpy(path->buffer+path->len, name, len);
 		path->buffer[path->len+len] = '\0';
 		if (access(path->buffer, F_OK) == 0) {
+			int l = lcwd + strlen(path->buffer);
+			char name2[l+2], *p;
+			if (path->buffer[0] == '/') {
+				memcpy(name2, path->buffer, l+1);
+			}
+			else {
+				memcpy(name2, cwd, lcwd);
+				name2[lcwd] = '/';
+				memcpy(name2+lcwd+1, path->buffer, path->len+len+1);
+			}
+			while ((p = strstr(name2, "/../"))) {
+				*p = '\0';
+				strcpy(strrchr(name2, '/'), p+3);
+			}
 			do_depname();
-			printf(" \\\n   %s", path->buffer);
+			printf(" \\\n   %s", name2);
 			return;
 		}
 	}
@@ -585,6 +601,12 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
+	if (!getcwd(cwd, sizeof(cwd))) {
+		fprintf(stderr, "mkdep: getcwd() failed %m\n");
+		return 1;
+	}
+	lcwd = strlen(cwd);
+
 	add_path(".");		/* for #include "..." */
 
 	while (++argv, --argc > 0) {
Index: 19-pre7.1/Rules.make
--- 19-pre7.1/Rules.make Tue, 16 Apr 2002 15:54:34 +1000 kaos (linux-2.4/T/c/47_Rules.make 1.1.2.2.3.4 644)
+++ 19-pre7.1(w)/Rules.make Mon, 22 Apr 2002 12:05:39 +1000 kaos (linux-2.4/T/c/47_Rules.make 1.1.2.2.3.4 644)
@@ -291,10 +291,6 @@ ifneq ($(wildcard .depend),)
 include .depend
 endif
 
-ifneq ($(wildcard $(TOPDIR)/.hdepend),)
-include $(TOPDIR)/.hdepend
-endif
-
 #
 # Find files whose flags have changed and force recompilation.
 # For safety, this works in the converse direction:
Index: 19-pre7.1/Makefile
--- 19-pre7.1/Makefile Tue, 16 Apr 2002 15:54:34 +1000 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.25.2.2.1.17.1.4.1.29.1.40.1.21 644)
+++ 19-pre7.1(w)/Makefile Mon, 22 Apr 2002 17:20:00 +1000 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.25.2.2.1.17.1.4.1.29.1.40.1.21 644)
@@ -40,10 +40,11 @@ DEPMOD		= /sbin/depmod
 MODFLAGS	= -DMODULE
 CFLAGS_KERNEL	=
 PERL		= perl
+AWK		= awk
 
 export	VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION KERNELRELEASE ARCH \
 	CONFIG_SHELL TOPDIR HPATH HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC \
-	CPP AR NM STRIP OBJCOPY OBJDUMP MAKE MAKEFILES GENKSYMS MODFLAGS PERL
+	CPP AR NM STRIP OBJCOPY OBJDUMP MAKE MAKEFILES GENKSYMS MODFLAGS PERL AWK
 
 all:	do-it-all
 
@@ -314,7 +315,7 @@ include/config/MARKER: scripts/split-inc
 
 linuxsubdirs: $(patsubst %, _dir_%, $(SUBDIRS))
 
-$(patsubst %, _dir_%, $(SUBDIRS)) : dummy include/linux/version.h include/config/MARKER
+$(patsubst %, _dir_%, $(SUBDIRS)) : dummy include/linux/version.h .tmp_include_depends
 	$(MAKE) CFLAGS="$(CFLAGS) $(CFLAGS_KERNEL)" -C $(patsubst _dir_%, %, $@)
 
 $(TOPDIR)/include/linux/version.h: include/linux/version.h
@@ -350,13 +351,13 @@ include/linux/version.h: ./Makefile
 
 comma	:= ,
 
-init/version.o: init/version.c include/linux/compile.h include/config/MARKER
+init/version.o: init/version.c include/linux/compile.h .tmp_include_depends
 	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) -DUTS_MACHINE='"$(ARCH)"' -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) -c -o init/version.o init/version.c
 
-init/main.o: init/main.c include/config/MARKER
+init/main.o: init/main.c .tmp_include_depends
 	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) $(PROFILING) -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) -c -o $*.o $<
 
-init/do_mounts.o: init/do_mounts.c include/config/MARKER
+init/do_mounts.o: init/do_mounts.c .tmp_include_depends
 	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) $(PROFILING) -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) -c -o $*.o $<
 
 fs lib mm ipc kernel drivers net: dummy
@@ -383,7 +384,7 @@ endif
 modules: $(patsubst %, _mod_%, $(SUBDIRS))
 
 .PHONY: $(patsubst %, _mod_%, $(SUBDIRS))
-$(patsubst %, _mod_%, $(SUBDIRS)) : include/linux/version.h include/config/MARKER
+$(patsubst %, _mod_%, $(SUBDIRS)) : include/linux/version.h .tmp_include_depends
 	$(MAKE) -C $(patsubst _mod_%, %, $@) CFLAGS="$(CFLAGS) $(MODFLAGS)" MAKING_MODULES=1 modules
 
 .PHONY: modules_install
@@ -488,6 +489,13 @@ dep-files: scripts/mkdep archdep include
 ifdef CONFIG_MODVERSIONS
 	$(MAKE) update-modverfile
 endif
+	(find $(TOPDIR) \( -name .depend -o -name .hdepend \) -print | xargs $(AWK) -f scripts/include_deps) > .tmp_include_depends
+	sed -ne 's/^\([^ ].*\):.*/  \1 \\/p' .tmp_include_depends > .tmp_include_depends_1
+	(echo ""; echo "all: \\"; cat .tmp_include_depends_1; echo "") >> .tmp_include_depends
+	rm .tmp_include_depends_1
+
+.tmp_include_depends: include/config/MARKER dummy
+	$(MAKE) -r -f .tmp_include_depends all
 
 ifdef CONFIG_MODVERSIONS
 MODVERFILE := $(TOPDIR)/include/linux/modversions.h
Index: 19-pre7.1/scripts/include_deps
--- 19-pre7.1/scripts/include_deps Mon, 22 Apr 2002 17:51:33 +1000 kaos ()
+++ 19-pre7.1(w)/scripts/include_deps Mon, 22 Apr 2002 15:27:08 +1000 kaos (linux-2.4/s/g/34_include_de  644)
@@ -0,0 +1,15 @@
+# Read the .depend files, extract the dependencies for .h targets, convert
+# relative names to absolute and write the result to stdout.  It is part of
+# building the global .h dependency graph for kbuild 2.4.  KAO
+
+/^[^ 	]/		{ copy = 0; fn = "/error/"; }
+/^[^ 	][^ ]*\.h:/	{ copy = 1; fn = FILENAME; sub(/\.depend/, "", fn); }
+!copy			{ next; }
+			{
+			  indent = $0; sub(/[^ 	].*/, "", indent);
+			  if ($1 != "" && $1 !~ /^[@$\/\\]/) { $1 = fn $1 };
+			  if ($2 != "" && $2 !~ /^[@$\/\\]/) { $2 = fn $2 };
+			  $1 = $1;	# ensure $0 is rebuilt
+			  $0 = indent $0;
+			  print;
+			}


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBNDkX>; Tue, 13 Feb 2001 22:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129051AbRBNDkO>; Tue, 13 Feb 2001 22:40:14 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:12295 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129032AbRBNDj6>;
	Tue, 13 Feb 2001 22:39:58 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.2-pre3 mkdep -I support - take 2
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 14 Feb 2001 14:39:51 +1100
Message-ID: <12648.982121991@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of the special case in drivers/acpi/Makefile.  mkdep now uses
the same -I options in the same order as the compiler.  Against 2.4.2-pre3.
Please jump up and down on this patch before I send it to Linus.

Change from take 1 - make is too dumb to realise that /path/name/file.h
is the same as file.h when current directory is /path/name, so do not
use the full pathname to files in the current directory.


Index: 2-pre3.1/scripts/mkdep.c
--- 2-pre3.1/scripts/mkdep.c Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/12_mkdep.c 1.1 644)
+++ 2-pre3.4(w)/scripts/mkdep.c Wed, 14 Feb 2001 14:28:26 +1100 kaos (linux-2.4/12_mkdep.c 1.4 644)
@@ -2,7 +2,7 @@
  * Originally by Linus Torvalds.
  * Smart CONFIG_* processing by Werner Almesberger, Michael Chastain.
  *
- * Usage: mkdep file ...
+ * Usage: mkdep cflags -- file ...
  * 
  * Read source files and output makefile dependency lines for them.
  * I make simple dependency lines for #include <*.h> and #include "*.h".
@@ -22,10 +22,17 @@
  * 2.3.99-pre1, Andrew Morton <andrewm@uow.edu.au>
  * - Changed so that 'filename.o' depends upon 'filename.[cS]'.  This is so that
  *   missing source files are noticed, rather than silently ignored.
+ *
+ * 2.4.2-pre3, Keith Owens <kaos@ocs.com.au>
+ * - Accept cflags followed by '--' followed by filenames.  mkdep extracts -I
+ *   options from cflags and looks in the specified directories as well as the
+ *   defaults.   Only -I is supported, no attempt is made to handle -idirafter,
+ *   -isystem, -I- etc.
  */
 
 #include <ctype.h>
 #include <fcntl.h>
+#include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -44,11 +51,10 @@ int hasdep;
 
 struct path_struct {
 	int len;
-	char buffer[256-sizeof(int)];
-} path_array[2] = {
-	{  0, "" },
-	{  0, "" }
+	char *buffer;
 };
+struct path_struct *path_array;
+int paths;
 
 
 /* Current input file */
@@ -181,9 +187,10 @@ void define_precious(const char * filena
 /*
  * Handle an #include line.
  */
-void handle_include(int type, const char * name, int len)
+void handle_include(int start, const char * name, int len)
 {
-	struct path_struct *path = path_array+type;
+	struct path_struct *path;
+	int i;
 
 	if (len == 14 && !memcmp(name, "linux/config.h", len))
 		return;
@@ -191,13 +198,58 @@ void handle_include(int type, const char
 	if (len >= 7 && !memcmp(name, "config/", 7))
 		define_config(name+7, len-7-2);
 
-	memcpy(path->buffer+path->len, name, len);
-	path->buffer[path->len+len] = '\0';
-	if (access(path->buffer, F_OK) != 0)
-		return;
+	for (i = start, path = path_array+start; i < paths; ++i, ++path) {
+		memcpy(path->buffer+path->len, name, len);
+		path->buffer[path->len+len] = '\0';
+		if (access(path->buffer, F_OK) == 0) {
+			do_depname();
+			printf(" \\\n   %s", path->buffer);
+			return;
+		}
+	}
 
-	do_depname();
-	printf(" \\\n   %s", path->buffer);
+}
+
+
+
+/*
+ * Add a path to the list of include paths.
+ */
+void add_path(const char * name)
+{
+	struct path_struct *path;
+	char resolved_path[PATH_MAX+1];
+	const char *name2;
+
+	if (strcmp(name, ".")) {
+		name2 = realpath(name, resolved_path);
+		if (!name2) {
+			fprintf(stderr, "realpath(%s) failed, %m\n", name);
+			exit(1);
+		}
+	}
+	else {
+		name2 = "";
+	}
+
+	path_array = realloc(path_array, (++paths)*sizeof(*path_array));
+	if (!path_array) {
+		fprintf(stderr, "cannot expand path_arry\n");
+		exit(1);
+	}
+
+	path = path_array+paths-1;
+	path->len = strlen(name2);
+	path->buffer = malloc(path->len+1+256+1);
+	if (!path->buffer) {
+		fprintf(stderr, "cannot allocate path buffer\n");
+		exit(1);
+	}
+	strcpy(path->buffer, name2);
+	if (path->len && *(path->buffer+path->len-1) != '/') {
+		*(path->buffer+path->len) = '/';
+		*(path->buffer+(++(path->len))) = '\0';
+	}
 }
 
 
@@ -210,7 +262,7 @@ void use_config(const char * name, int l
 	char *pc;
 	int i;
 
-	pc = path_array[0].buffer + path_array[0].len;
+	pc = path_array[paths-1].buffer + path_array[paths-1].len;
 	memcpy(pc, "config/", 7);
 	pc += 7;
 
@@ -228,7 +280,7 @@ void use_config(const char * name, int l
 	define_config(pc, len);
 
 	do_depname();
-	printf(" \\\n   $(wildcard %s.h)", path_array[0].buffer);
+	printf(" \\\n   $(wildcard %s.h)", path_array[paths-1].buffer);
 }
 
 
@@ -387,7 +439,7 @@ pound_include_dquote:
 	GETNEXT
 	CASE('\n', start);
 	NOTCASE('"', pound_include_dquote);
-	handle_include(1, map_dot, next - map_dot - 1);
+	handle_include(0, map_dot, next - map_dot - 1);
 	goto start;
 
 /* #\s*include\s*<(.*)> */
@@ -395,7 +447,7 @@ pound_include_langle:
 	GETNEXT
 	CASE('\n', start);
 	NOTCASE('>', pound_include_langle);
-	handle_include(0, map_dot, next - map_dot - 1);
+	handle_include(1, map_dot, next - map_dot - 1);
 	goto start;
 
 /* #\s*d */
@@ -524,7 +576,7 @@ void do_depend(const char * filename, co
 int main(int argc, char **argv)
 {
 	int len;
-	char *hpath;
+	const char *hpath;
 
 	hpath = getenv("HPATH");
 	if (!hpath) {
@@ -532,12 +584,26 @@ int main(int argc, char **argv)
 		      "Don't bypass the top level Makefile.\n", stderr);
 		return 1;
 	}
-	len = strlen(hpath);
-	memcpy(path_array[0].buffer, hpath, len);
-	if (len && hpath[len-1] != '/')
-		path_array[0].buffer[len++] = '/';
-	path_array[0].buffer[len] = '\0';
-	path_array[0].len = len;
+
+	add_path(".");		/* for #include "..." */
+
+	while (++argv, --argc > 0) {
+		if (strncmp(*argv, "-I", 2) == 0) {
+			if (*((*argv)+2)) {
+				add_path((*argv)+2);
+			}
+			else {
+				++argv;
+				--argc;
+				add_path(*argv);
+			}
+		}
+		else if (strcmp(*argv, "--") == 0) {
+			break;
+		}
+	}
+
+	add_path(hpath);	/* must be last entry, for config files */
 
 	while (--argc > 0) {
 		const char * filename = *++argv;
Index: 2-pre3.1/drivers/acpi/Makefile
--- 2-pre3.1/drivers/acpi/Makefile Tue, 23 Jan 2001 13:26:27 +1100 kaos (linux-2.4/s/b/51_Makefile 1.2 644)
+++ 2-pre3.4(w)/drivers/acpi/Makefile Sun, 11 Feb 2001 14:27:42 +1100 kaos (linux-2.4/s/b/51_Makefile 1.3 644)
@@ -20,14 +20,6 @@ EXTRA_CFLAGS += -I./include
 
 EXTRA_CFLAGS += $(ACPI_CFLAGS)
 
-# genksyms only reads $(CFLAGS), it should really read $(EXTRA_CFLAGS) as well.
-# Without EXTRA_CFLAGS the gcc pass for genksyms fails, resulting in an empty
-# include/linux/modules/acpi_ksyms.ver.  Changing genkyms to use EXTRA_CFLAGS
-# will hit everything, too risky in 2.4.0-prerelease.  Bandaid by tweaking
-# CFLAGS only for .ver targets.  Review after 2.4.0 release.  KAO
-
-$(MODINCL)/%.ver: CFLAGS := -I./include $(CFLAGS)
-
 acpi-subdirs := common dispatcher events hardware \
 		interpreter namespace parser resources tables
 
Index: 2-pre3.1/Rules.make
--- 2-pre3.1/Rules.make Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/T/c/47_Rules.make 1.1 644)
+++ 2-pre3.4(w)/Rules.make Sun, 11 Feb 2001 14:27:19 +1100 kaos (linux-2.4/T/c/47_Rules.make 1.2 644)
@@ -123,7 +123,7 @@ endif
 # This make dependencies quickly
 #
 fastdep: dummy
-	$(TOPDIR)/scripts/mkdep $(wildcard *.[chS] local.h.master) > .depend
+	$(TOPDIR)/scripts/mkdep $(CFLAGS) $(EXTRA_CFLAGS) -- $(wildcard *.[chS]) > .depend
 ifdef ALL_SUB_DIRS
 	$(MAKE) $(patsubst %,_sfdep_%,$(ALL_SUB_DIRS)) _FASTDEP_ALL_SUB_DIRS="$(ALL_SUB_DIRS)"
 endif
@@ -222,9 +222,9 @@ endif
 
 $(MODINCL)/%.ver: %.c
 	@if [ ! -r $(MODINCL)/$*.stamp -o $(MODINCL)/$*.stamp -ot $< ]; then \
-		echo '$(CC) $(CFLAGS) -E -D__GENKSYMS__ $<'; \
+		echo '$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -E -D__GENKSYMS__ $<'; \
 		echo '| $(GENKSYMS) $(genksyms_smp_prefix) -k $(VERSION).$(PATCHLEVEL).$(SUBLEVEL) > $@.tmp'; \
-		$(CC) $(CFLAGS) -E -D__GENKSYMS__ $< \
+		$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -E -D__GENKSYMS__ $< \
 		| $(GENKSYMS) $(genksyms_smp_prefix) -k $(VERSION).$(PATCHLEVEL).$(SUBLEVEL) > $@.tmp; \
 		if [ -r $@ ] && cmp -s $@ $@.tmp; then echo $@ is unchanged; rm -f $@.tmp; \
 		else echo mv $@.tmp $@; mv -f $@.tmp $@; fi; \
Index: 2-pre3.1/Makefile
--- 2-pre3.1/Makefile Sat, 10 Feb 2001 13:20:52 +1100 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15 644)
+++ 2-pre3.4(w)/Makefile Sun, 11 Feb 2001 14:08:08 +1100 kaos (linux-2.4/T/c/50_Makefile 1.1.2.16 644)
@@ -440,8 +440,8 @@ sums:
 	find . -type f -print | sort | xargs sum > .SUMS
 
 dep-files: scripts/mkdep archdep include/linux/version.h
-	scripts/mkdep init/*.c > .depend
-	scripts/mkdep `find $(FINDHPATH) -name SCCS -prune -o -follow -name \*.h ! -name modversions.h -print` > .hdepend
+	scripts/mkdep -- init/*.c > .depend
+	scripts/mkdep -- `find $(FINDHPATH) -name SCCS -prune -o -follow -name \*.h ! -name modversions.h -print` > .hdepend
 	$(MAKE) $(patsubst %,_sfdep_%,$(SUBDIRS)) _FASTDEP_ALL_SUB_DIRS="$(SUBDIRS)"
 ifdef CONFIG_MODVERSIONS
 	$(MAKE) update-modverfile
@@ -492,7 +492,7 @@ include Rules.make
 #
 
 scripts/mkdep: scripts/mkdep.c
-	$(HOSTCC) $(HOSTCFLAGS) -o scripts/mkdep scripts/mkdep.c
+	$(HOSTCC) $(HOSTCFLAGS) -g -o scripts/mkdep scripts/mkdep.c
 
 scripts/split-include: scripts/split-include.c
 	$(HOSTCC) $(HOSTCFLAGS) -o scripts/split-include scripts/split-include.c


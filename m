Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWDIP3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWDIP3b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 11:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWDIP3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 11:29:04 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:32938 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750778AbWDIP2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 11:28:55 -0400
Date: Sun, 9 Apr 2006 17:28:53 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 10/19] kconfig: integrate split config into silentoldconfig
Message-ID: <Pine.LNX.4.64.0604091728410.23144@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now that kconfig can load multiple configurations, it becomes simple to
integrate the split config step, by simply comparing the new .config
file with the old auto.conf (and then saving the new auto.conf).
A nice side effect is that this saves a bit of disk space and cache, as
no data needs to be read from or saved into the splitted config files
anymore (e.g. include/config is now 648KB instead of 5.2MB).

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 Makefile                      |   11 --
 scripts/basic/Makefile        |    6 -
 scripts/basic/split-include.c |  226 ------------------------------------------
 scripts/kconfig/confdata.c    |  121 ++++++++++++++++++++++
 scripts/kconfig/expr.h        |    3 
 5 files changed, 125 insertions(+), 242 deletions(-)

Index: linux-2.6-git/Makefile
===================================================================
--- linux-2.6-git.orig/Makefile
+++ linux-2.6-git/Makefile
@@ -420,7 +420,7 @@ ifeq ($(KBUILD_EXTMOD),)
 # Carefully list dependencies so we do not try to build scripts twice
 # in parrallel
 PHONY += scripts
-scripts: scripts_basic include/config/MARKER
+scripts: scripts_basic include/config/auto.conf
 	$(Q)$(MAKE) $(build)=$(@)
 
 # Objects we will link into vmlinux / subdirs we need to visit
@@ -789,7 +789,7 @@ endif
 prepare2: prepare3 outputmakefile
 
 prepare1: prepare2 include/linux/version.h include/asm \
-                   include/config/MARKER
+                   include/config/auto.conf
 ifneq ($(KBUILD_MODULES),)
 	$(Q)rm -rf $(MODVERDIR)
 	$(Q)mkdir -p $(MODVERDIR)
@@ -817,13 +817,6 @@ include/asm:
 	$(Q)if [ ! -d include ]; then mkdir -p include; fi;
 	@ln -fsn asm-$(ARCH) $@
 
-# 	Split autoconf.h into include/linux/config/*
-
-include/config/MARKER: scripts/basic/split-include include/config/auto.conf
-	@echo '  SPLIT   include/linux/autoconf.h -> include/config/*'
-	@scripts/basic/split-include include/linux/autoconf.h include/config
-	@touch $@
-
 # Generate some files
 # ---------------------------------------------------------------------------
 
Index: linux-2.6-git/scripts/basic/Makefile
===================================================================
--- linux-2.6-git.orig/scripts/basic/Makefile
+++ linux-2.6-git/scripts/basic/Makefile
@@ -1,17 +1,15 @@
 ###
 # Makefile.basic list the most basic programs used during the build process.
 # The programs listed herein is what is needed to do the basic stuff,
-# such as splitting .config and fix dependency file.
+# such as fix dependency file.
 # This initial step is needed to avoid files to be recompiled
 # when kernel configuration changes (which is what happens when
 # .config is included by main Makefile.
 # ---------------------------------------------------------------------------
 # fixdep: 	 Used to generate dependency information during build process
-# split-include: Divide all config symbols up in a number of files in
-#                include/config/...
 # docproc:	 Used in Documentation/docbook
 
-hostprogs-y	:= fixdep split-include docproc
+hostprogs-y	:= fixdep docproc
 always		:= $(hostprogs-y)
 
 # fixdep is needed to compile other host programs
Index: linux-2.6-git/scripts/basic/split-include.c
===================================================================
--- linux-2.6-git.orig/scripts/basic/split-include.c
+++ /dev/null
@@ -1,226 +0,0 @@
-/*
- * split-include.c
- *
- * Copyright abandoned, Michael Chastain, <mailto:mec@shout.net>.
- * This is a C version of syncdep.pl by Werner Almesberger.
- *
- * This program takes autoconf.h as input and outputs a directory full
- * of one-line include files, merging onto the old values.
- *
- * Think of the configuration options as key-value pairs.  Then there
- * are five cases:
- *
- *    key      old value   new value   action
- *
- *    KEY-1    VALUE-1     VALUE-1     leave file alone
- *    KEY-2    VALUE-2A    VALUE-2B    write VALUE-2B into file
- *    KEY-3    -           VALUE-3     write VALUE-3  into file
- *    KEY-4    VALUE-4     -           write an empty file
- *    KEY-5    (empty)     -           leave old empty file alone
- */
-
-#include <sys/stat.h>
-#include <sys/types.h>
-
-#include <ctype.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-
-#define ERROR_EXIT(strExit)						\
-    {									\
-	const int errnoSave = errno;					\
-	fprintf(stderr, "%s: ", str_my_name);				\
-	errno = errnoSave;						\
-	perror((strExit));						\
-	exit(1);							\
-    }
-
-
-
-int main(int argc, const char * argv [])
-{
-    const char * str_my_name;
-    const char * str_file_autoconf;
-    const char * str_dir_config;
-
-    FILE * fp_config;
-    FILE * fp_target;
-    FILE * fp_find;
-
-    int buffer_size;
-
-    char * line;
-    char * old_line;
-    char * list_target;
-    char * ptarget;
-
-    struct stat stat_buf;
-
-    /* Check arg count. */
-    if (argc != 3)
-    {
-	fprintf(stderr, "%s: wrong number of arguments.\n", argv[0]);
-	exit(1);
-    }
-
-    str_my_name       = argv[0];
-    str_file_autoconf = argv[1];
-    str_dir_config    = argv[2];
-
-    /* Find a buffer size. */
-    if (stat(str_file_autoconf, &stat_buf) != 0)
-	ERROR_EXIT(str_file_autoconf);
-    buffer_size = 2 * stat_buf.st_size + 4096;
-
-    /* Allocate buffers. */
-    if ( (line        = malloc(buffer_size)) == NULL
-    ||   (old_line    = malloc(buffer_size)) == NULL
-    ||   (list_target = malloc(buffer_size)) == NULL )
-	ERROR_EXIT(str_file_autoconf);
-
-    /* Open autoconfig file. */
-    if ((fp_config = fopen(str_file_autoconf, "r")) == NULL)
-	ERROR_EXIT(str_file_autoconf);
-
-    /* Make output directory if needed. */
-    if (stat(str_dir_config, &stat_buf) != 0)
-    {
-	if (mkdir(str_dir_config, 0755) != 0)
-	    ERROR_EXIT(str_dir_config);
-    }
-
-    /* Change to output directory. */
-    if (chdir(str_dir_config) != 0)
-	ERROR_EXIT(str_dir_config);
-
-    /* Put initial separator into target list. */
-    ptarget = list_target;
-    *ptarget++ = '\n';
-
-    /* Read config lines. */
-    while (fgets(line, buffer_size, fp_config))
-    {
-	const char * str_config;
-	int is_same;
-	int itarget;
-
-	if (line[0] != '#')
-	    continue;
-	if ((str_config = strstr(line, "CONFIG_")) == NULL)
-	    continue;
-
-	/* Make the output file name. */
-	str_config += sizeof("CONFIG_") - 1;
-	for (itarget = 0; !isspace(str_config[itarget]); itarget++)
-	{
-	    int c = (unsigned char) str_config[itarget];
-	    if (isupper(c)) c = tolower(c);
-	    if (c == '_')   c = '/';
-	    ptarget[itarget] = c;
-	}
-	ptarget[itarget++] = '.';
-	ptarget[itarget++] = 'h';
-	ptarget[itarget++] = '\0';
-
-	/* Check for existing file. */
-	is_same = 0;
-	if ((fp_target = fopen(ptarget, "r")) != NULL)
-	{
-	    fgets(old_line, buffer_size, fp_target);
-	    if (fclose(fp_target) != 0)
-		ERROR_EXIT(ptarget);
-	    if (!strcmp(line, old_line))
-		is_same = 1;
-	}
-
-	if (!is_same)
-	{
-	    /* Auto-create directories. */
-	    int islash;
-	    for (islash = 0; islash < itarget; islash++)
-	    {
-		if (ptarget[islash] == '/')
-		{
-		    ptarget[islash] = '\0';
-		    if (stat(ptarget, &stat_buf) != 0
-		    &&  mkdir(ptarget, 0755)     != 0)
-			ERROR_EXIT( ptarget );
-		    ptarget[islash] = '/';
-		}
-	    }
-
-	    /* Write the file. */
-	    if ((fp_target = fopen(ptarget, "w" )) == NULL)
-		ERROR_EXIT(ptarget);
-	    fputs(line, fp_target);
-	    if (ferror(fp_target) || fclose(fp_target) != 0)
-		ERROR_EXIT(ptarget);
-	}
-
-	/* Update target list */
-	ptarget += itarget;
-	*(ptarget-1) = '\n';
-    }
-
-    /*
-     * Close autoconfig file.
-     * Terminate the target list.
-     */
-    if (fclose(fp_config) != 0)
-	ERROR_EXIT(str_file_autoconf);
-    *ptarget = '\0';
-
-    /*
-     * Fix up existing files which have no new value.
-     * This is Case 4 and Case 5.
-     *
-     * I re-read the tree and filter it against list_target.
-     * This is crude.  But it avoids data copies.  Also, list_target
-     * is compact and contiguous, so it easily fits into cache.
-     *
-     * Notice that list_target contains strings separated by \n,
-     * with a \n before the first string and after the last.
-     * fgets gives the incoming names a terminating \n.
-     * So by having an initial \n, strstr will find exact matches.
-     */
-
-    fp_find = popen("find * -type f -name \"*.h\" -print", "r");
-    if (fp_find == 0)
-	ERROR_EXIT( "find" );
-
-    line[0] = '\n';
-    while (fgets(line+1, buffer_size, fp_find))
-    {
-	if (strstr(list_target, line) == NULL)
-	{
-	    /*
-	     * This is an old file with no CONFIG_* flag in autoconf.h.
-	     */
-
-	    /* First strip the \n. */
-	    line[strlen(line)-1] = '\0';
-
-	    /* Grab size. */
-	    if (stat(line+1, &stat_buf) != 0)
-		ERROR_EXIT(line);
-
-	    /* If file is not empty, make it empty and give it a fresh date. */
-	    if (stat_buf.st_size != 0)
-	    {
-		if ((fp_target = fopen(line+1, "w")) == NULL)
-		    ERROR_EXIT(line);
-		if (fclose(fp_target) != 0)
-		    ERROR_EXIT(line);
-	    }
-	}
-    }
-
-    if (pclose(fp_find) != 0)
-	ERROR_EXIT("find");
-
-    return 0;
-}
Index: linux-2.6-git/scripts/kconfig/confdata.c
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/confdata.c
+++ linux-2.6-git/scripts/kconfig/confdata.c
@@ -5,6 +5,7 @@
 
 #include <sys/stat.h>
 #include <ctype.h>
+#include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -517,6 +518,119 @@ int conf_write(const char *name)
 	return 0;
 }
 
+int conf_split_config(void)
+{
+	char *name, path[128];
+	char *s, *d, c;
+	struct symbol *sym;
+	struct stat sb;
+	int res, i, fd;
+
+	name = getenv("KCONFIG_AUTOCONFIG");
+	if (!name)
+		name = "include/config/auto.conf";
+	conf_read_simple(name, S_DEF_AUTO);
+
+	if (chdir("include/config"))
+		return 1;
+
+	res = 0;
+	for_all_symbols(i, sym) {
+		sym_calc_value(sym);
+		if ((sym->flags & SYMBOL_AUTO) || !sym->name)
+			continue;
+		if (sym->flags & SYMBOL_WRITE) {
+			if (sym->flags & SYMBOL_DEF_AUTO) {
+				/*
+				 * symbol has old and new value,
+				 * so compare them...
+				 */
+				switch (sym->type) {
+				case S_BOOLEAN:
+				case S_TRISTATE:
+					if (sym_get_tristate_value(sym) ==
+					    sym->def[S_DEF_AUTO].tri)
+						continue;
+					break;
+				case S_STRING:
+				case S_HEX:
+				case S_INT:
+					if (!strcmp(sym_get_string_value(sym),
+						    sym->def[S_DEF_AUTO].val))
+						continue;
+					break;
+				default:
+					break;
+				}
+			} else {
+				/*
+				 * If there is no old value, only 'no' (unset)
+				 * is allowed as new value.
+				 */
+				switch (sym->type) {
+				case S_BOOLEAN:
+				case S_TRISTATE:
+					if (sym_get_tristate_value(sym) == no)
+						continue;
+					break;
+				default:
+					break;
+				}
+			}
+		} else if (!(sym->flags & SYMBOL_DEF_AUTO))
+			/* There is neither an old nor a new value. */
+			continue;
+		/* else
+		 *	There is an old value, but no new value ('no' (unset)
+		 *	isn't saved in auto.conf, so the old value is always
+		 *	different from 'no').
+		 */
+
+		/* Replace all '_' and append ".h" */
+		s = sym->name;
+		d = path;
+		while ((c = *s++)) {
+			c = tolower(c);
+			*d++ = (c == '_') ? '/' : c;
+		}
+		strcpy(d, ".h");
+
+		/* Assume directory path already exists. */
+		fd = open(path, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+		if (fd == -1) {
+			if (errno != ENOENT) {
+				res = 1;
+				break;
+			}
+			/*
+			 * Create directory components,
+			 * unless they exist already.
+			 */
+			d = path;
+			while ((d = strchr(d, '/'))) {
+				*d = 0;
+				if (stat(path, &sb) && mkdir(path, 0755)) {
+					res = 1;
+					goto out;
+				}
+				*d++ = '/';
+			}
+			/* Try it again. */
+			fd = open(path, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+			if (fd == -1) {
+				res = 1;
+				break;
+			}
+		}
+		close(fd);
+	}
+out:
+	if (chdir("../.."))
+		return 1;
+
+	return res;
+}
+
 int conf_write_autoconf(void)
 {
 	struct symbol *sym;
@@ -526,8 +640,13 @@ int conf_write_autoconf(void)
 	time_t now;
 	int i, l;
 
+	sym_clear_all_valid();
+
 	file_write_dep("include/config/auto.conf.cmd");
 
+	if (conf_split_config())
+		return 1;
+
 	out = fopen(".tmpconfig", "w");
 	if (!out)
 		return 1;
@@ -555,8 +674,6 @@ int conf_write_autoconf(void)
 		       "#define AUTOCONF_INCLUDED\n",
 		       sym_get_string_value(sym), ctime(&now));
 
-	sym_clear_all_valid();
-
 	for_all_symbols(i, sym) {
 		sym_calc_value(sym);
 		if (!(sym->flags & SYMBOL_WRITE) || !sym->name)
Index: linux-2.6-git/scripts/kconfig/expr.h
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/expr.h
+++ linux-2.6-git/scripts/kconfig/expr.h
@@ -65,6 +65,7 @@ enum symbol_type {
 
 enum {
 	S_DEF_USER,		/* main user value */
+	S_DEF_AUTO,
 };
 
 struct symbol {
@@ -97,7 +98,7 @@ struct symbol {
 #define SYMBOL_WARNED		0x8000
 #define SYMBOL_DEF		0x10000
 #define SYMBOL_DEF_USER		0x10000
-#define SYMBOL_DEF2		0x20000
+#define SYMBOL_DEF_AUTO		0x20000
 #define SYMBOL_DEF3		0x40000
 #define SYMBOL_DEF4		0x80000
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbUCOS5n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 13:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbUCOS5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 13:57:42 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:14735 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262674AbUCOSyw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 13:54:52 -0500
Date: Mon, 15 Mar 2004 19:54:58 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm2
Message-ID: <20040315185458.GA17332@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040314172809.31bd72f7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040314172809.31bd72f7.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> +kbuild-fix-early-dependencies.patch
> +kbuild-fix-early-dependencies-fix.patch
> 
>  Parallel build fix

Hi Andrew - here is an update, that includes the posted fixes.
It also fixes 'make sgmldocs', using correct path to docproc.

It replaces the above two patches, but description is still ok.

	Sam

diff -Nru a/Documentation/DocBook/Makefile b/Documentation/DocBook/Makefile
--- a/Documentation/DocBook/Makefile	Mon Mar 15 19:51:20 2004
+++ b/Documentation/DocBook/Makefile	Mon Mar 15 19:51:20 2004
@@ -47,7 +47,7 @@
 ###
 #External programs used
 KERNELDOC = scripts/kernel-doc
-DOCPROC   = scripts/docproc
+DOCPROC   = scripts/basic/docproc
 SPLITMAN  = $(PERL) $(srctree)/scripts/split-man
 MAKEMAN   = $(PERL) $(srctree)/scripts/makeman
 
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Mon Mar 15 19:51:20 2004
+++ b/Makefile	Mon Mar 15 19:51:20 2004
@@ -304,17 +304,10 @@
 # ===========================================================================
 # Rules shared between *config targets and build targets
 
-# Helpers built in scripts/
-
-scripts/docproc scripts/split-include : scripts ;
-
-.PHONY: scripts scripts/fixdep
-scripts:
-	$(Q)$(MAKE) $(build)=scripts
-
-scripts/fixdep:
-	$(Q)$(MAKE) $(build)=scripts $@
-
+# Basic helpers built in scripts/
+.PHONY: scripts_basic
+scripts_basic:
+	$(Q)$(MAKE) $(build)=scripts/basic
 
 # To make sure we do not include .config for any of the *config targets
 # catch them early, and hand them over to scripts/kconfig/Makefile
@@ -358,9 +351,9 @@
 # *config targets only - make sure prerequisites are updated, and descend
 # in scripts/kconfig to make the *config target
 
-%config: scripts/fixdep FORCE
+config: scripts_basic FORCE
 	$(Q)$(MAKE) $(build)=scripts/kconfig $@
-config : scripts/fixdep FORCE
+%config: scripts_basic FORCE
 	$(Q)$(MAKE) $(build)=scripts/kconfig $@
 
 else
@@ -368,6 +361,16 @@
 # Build targets only - this includes vmlinux, arch specific targets, clean
 # targets and others. In general all targets except *config targets.
 
+# Additional helpers built in scripts/
+# Carefully list dependencies so we do not try to build scripts twice
+# in parrallel
+.PHONY: scripts
+scripts: scripts_basic include/config/MARKER
+	$(Q)$(MAKE) $(build)=$(@)
+
+scripts_basic: include/linux/autoconf.h
+
+
 # That's our default target when none is given on the command line
 # Note that 'modules' will be added as a prerequisite as well, 
 # in the CONFIG_MODULES part below
@@ -400,7 +403,9 @@
 # with it and forgot to run make oldconfig
 include/linux/autoconf.h: .config
 	$(Q)$(MAKE) -f $(srctree)/Makefile silentoldconfig
-
+else
+# Dummy target needed, because used as prerequisite
+include/linux/autoconf.h: ;
 endif
 
 include $(srctree)/arch/$(ARCH)/Makefile
@@ -634,9 +639,9 @@
 
 # 	Split autoconf.h into include/linux/config/*
 
-include/config/MARKER: scripts/split-include include/linux/autoconf.h
+include/config/MARKER: include/linux/autoconf.h
 	@echo '  SPLIT   include/linux/autoconf.h -> include/config/*'
-	@scripts/split-include include/linux/autoconf.h include/config
+	@scripts/basic/split-include include/linux/autoconf.h include/config
 	@touch $@
 
 # Generate some files
@@ -930,7 +935,7 @@
 
 # Documentation targets
 # ---------------------------------------------------------------------------
-%docs: scripts/docproc FORCE
+%docs: scripts FORCE
 	$(Q)$(MAKE) $(build)=Documentation/DocBook $@
 
 # Scripts to check various things for consistency
@@ -983,7 +988,7 @@
 	@set -e; \
 	$(if $($(quiet)cmd_$(1)),echo '  $(subst ','\'',$($(quiet)cmd_$(1)))';) \
 	$(cmd_$(1)); \
-	scripts/fixdep $(depfile) $@ '$(subst $$,$$$$,$(subst ','\'',$(cmd_$(1))))' > $(@D)/.$(@F).tmp; \
+	scripts/basic/fixdep $(depfile) $@ '$(subst $$,$$$$,$(subst ','\'',$(cmd_$(1))))' > $(@D)/.$(@F).tmp; \
 	rm -f $(depfile); \
 	mv -f $(@D)/.$(@F).tmp $(@D)/.$(@F).cmd)
 
diff -Nru a/scripts/Makefile b/scripts/Makefile
--- a/scripts/Makefile	Mon Mar 15 19:51:20 2004
+++ b/scripts/Makefile	Mon Mar 15 19:51:20 2004
@@ -2,14 +2,10 @@
 # scripts contains sources for various helper programs used throughout
 # the kernel for the build process.
 # ---------------------------------------------------------------------------
-# fix-dep: 	 Used to generate dependency information during build process
-# split-include: Divide all config symbols up in a number of files in
-#                include/config/...
 # docproc: 	 Preprocess .tmpl file in order to generate .sgml docs
 # conmakehash:	 Create arrays for initializing the kernel console tables
 
-host-progs	:= fixdep split-include conmakehash docproc kallsyms modpost \
-		   mk_elfconfig pnmtologo bin2c
+host-progs	:= conmakehash kallsyms modpost mk_elfconfig pnmtologo bin2c
 always		:= $(host-progs) empty.o
 
 modpost-objs	:= modpost.o file2alias.o sumversion.o
@@ -17,10 +13,7 @@
 subdir-$(CONFIG_MODVERSIONS)	+= genksyms
 
 # Let clean descend into subdirs
-subdir-	+= lxdialog kconfig
-
-# fixdep is needed to compile other host programs
-$(addprefix $(obj)/,$(filter-out fixdep,$(always)) $(subdir-y)): $(obj)/fixdep
+subdir-	+= basic lxdialog kconfig
 
 # dependencies on generated files need to be listed explicitly
 
diff -Nru a/scripts/Makefile.build b/scripts/Makefile.build
--- a/scripts/Makefile.build	Mon Mar 15 19:51:20 2004
+++ b/scripts/Makefile.build	Mon Mar 15 19:51:20 2004
@@ -162,7 +162,7 @@
 	$(if $($(quiet)cmd_cc_o_c),echo '  $($(quiet)cmd_cc_o_c)';)	  \
 	$(cmd_cc_o_c);							  \
 	$(cmd_modversions)						  \
-	scripts/fixdep $(depfile) $@ '$(cmd_cc_o_c)' > $(@D)/.$(@F).tmp;  \
+	scripts/basic/fixdep $(depfile) $@ '$(cmd_cc_o_c)' > $(@D)/.$(@F).tmp;  \
 	rm -f $(depfile);						  \
 	mv -f $(@D)/.$(@F).tmp $(@D)/.$(@F).cmd
 endef
diff -Nru a/scripts/Makefile.lib b/scripts/Makefile.lib
--- a/scripts/Makefile.lib	Mon Mar 15 19:51:20 2004
+++ b/scripts/Makefile.lib	Mon Mar 15 19:51:20 2004
@@ -249,7 +249,7 @@
 	@set -e; \
 	$(if $($(quiet)cmd_$(1)),echo '  $(subst ','\'',$($(quiet)cmd_$(1)))';) \
 	$(cmd_$(1)); \
-	scripts/fixdep $(depfile) $@ '$(subst $$,$$$$,$(subst ','\'',$(cmd_$(1))))' > $(@D)/.$(@F).tmp; \
+	scripts/basic/fixdep $(depfile) $@ '$(subst $$,$$$$,$(subst ','\'',$(cmd_$(1))))' > $(@D)/.$(@F).tmp; \
 	rm -f $(depfile); \
 	mv -f $(@D)/.$(@F).tmp $(@D)/.$(@F).cmd)
 
diff -Nru a/scripts/basic/Makefile b/scripts/basic/Makefile
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/scripts/basic/Makefile	Mon Mar 15 19:51:20 2004
@@ -0,0 +1,18 @@
+###
+# Makefile.basic list the most basic programs used during the build process.
+# The programs listed herein is what is needed to do the basic stuff,
+# such as splitting .config and fix dependency file.
+# This initial step is needed to avoid files to be recompiled
+# when kernel configuration changes (which is what happens when
+# .config is included by main Makefile.
+# ---------------------------------------------------------------------------
+# fixdep: 	 Used to generate dependency information during build process
+# split-include: Divide all config symbols up in a number of files in
+#                include/config/...
+# docproc:	 Used in Documentation/docbook 
+
+host-progs	:= fixdep split-include docproc
+always		:= $(host-progs)
+
+# fixdep is needed to compile other host programs
+$(addprefix $(obj)/,$(filter-out fixdep,$(always))): $(obj)/fixdep
diff -Nru a/scripts/basic/docproc.c b/scripts/basic/docproc.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/scripts/basic/docproc.c	Mon Mar 15 19:51:20 2004
@@ -0,0 +1,387 @@
+/*
+ *	docproc is a simple preprocessor for the template files
+ *      used as placeholders for the kernel internal documentation.
+ *	docproc is used for documentation-frontend and
+ *      dependency-generator.
+ *	The two usages have in common that they require
+ *	some knowledge of the .tmpl syntax, therefore they
+ *	are kept together.
+ *
+ *	documentation-frontend
+ *		Scans the template file and call kernel-doc for
+ *		all occurrences of ![EIF]file
+ *		Beforehand each referenced file are scanned for
+ *		any exported sympols "EXPORT_SYMBOL()" statements.
+ *		This is used to create proper -function and
+ *		-nofunction arguments in calls to kernel-doc.
+ *		Usage: docproc doc file.tmpl
+ *
+ *	dependency-generator:
+ *		Scans the template file and list all files
+ *		referenced in a format recognized by make.
+ *		Usage:	docproc depend file.tmpl
+ *		Writes dependency information to stdout
+ *		in the following format:
+ *		file.tmpl src.c	src2.c
+ *		The filenames are obtained from the following constructs:
+ *		!Efilename
+ *		!Ifilename
+ *		!Dfilename
+ *		!Ffilename
+ *		
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <ctype.h>
+#include <unistd.h>
+#include <limits.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+
+/* exitstatus is used to keep track of any failing calls to kernel-doc,
+ * but execution continues. */
+int exitstatus = 0;
+
+typedef void DFL(char *);
+DFL *defaultline;
+
+typedef void FILEONLY(char * file);
+FILEONLY *internalfunctions;
+FILEONLY *externalfunctions;
+FILEONLY *symbolsonly;
+
+typedef void FILELINE(char * file, char * line);
+FILELINE * singlefunctions;
+FILELINE * entity_system;
+
+#define MAXLINESZ     2048
+#define MAXFILES      250
+#define KERNELDOCPATH "scripts/"
+#define KERNELDOC     "kernel-doc"
+#define DOCBOOK       "-docbook"
+#define FUNCTION      "-function"
+#define NOFUNCTION    "-nofunction"
+
+void usage (void)
+{
+	fprintf(stderr, "Usage: docproc {doc|depend} file\n");
+	fprintf(stderr, "Input is read from file.tmpl. Output is sent to stdout\n");
+	fprintf(stderr, "doc: frontend when generating kernel documentation\n");
+	fprintf(stderr, "depend: generate list of files referenced within file\n");
+}
+
+/*
+ * Execute kernel-doc with parameters givin in svec
+ */
+void exec_kernel_doc(char **svec)
+{
+	pid_t pid;
+	int ret;
+	/* Make sure output generated so far are flushed */
+	fflush(stdout);
+	switch(pid=fork()) {
+		case -1:
+			perror("fork");
+			exit(1);
+		case  0:
+			execvp(KERNELDOCPATH KERNELDOC, svec);
+			perror("exec " KERNELDOCPATH KERNELDOC);
+			exit(1);
+		default:
+			waitpid(pid, &ret ,0);
+	}
+	if (WIFEXITED(ret))
+		exitstatus |= WEXITSTATUS(ret);
+	else
+		exitstatus = 0xff;
+}
+
+/* Types used to create list of all exported symbols in a number of files */
+struct symbols
+{
+	char *name;
+};
+
+struct symfile
+{
+	char *filename;
+	struct symbols *symbollist;
+	int symbolcnt;
+};
+
+struct symfile symfilelist[MAXFILES];
+int symfilecnt = 0;
+
+void add_new_symbol(struct symfile *sym, char * symname)
+{
+	sym->symbollist =
+          realloc(sym->symbollist, (sym->symbolcnt + 1) * sizeof(char *));
+	sym->symbollist[sym->symbolcnt++].name = strdup(symname);
+}
+
+/* Add a filename to the list */
+struct symfile * add_new_file(char * filename)
+{
+	symfilelist[symfilecnt++].filename = strdup(filename);
+	return &symfilelist[symfilecnt - 1];					
+}
+/* Check if file already are present in the list */
+struct symfile * filename_exist(char * filename)
+{
+	int i;
+	for (i=0; i < symfilecnt; i++)
+		if (strcmp(symfilelist[i].filename, filename) == 0)
+			return &symfilelist[i];
+	return NULL;
+}
+
+/*
+ * List all files referenced within the template file.
+ * Files are separated by tabs.
+ */
+void adddep(char * file)		   { printf("\t%s", file); }
+void adddep2(char * file, char * line)     { line = line; adddep(file); }
+void noaction(char * line)		   { line = line; }
+void noaction2(char * file, char * line)   { file = file; line = line; }
+
+/* Echo the line without further action */
+void printline(char * line)               { printf("%s", line); }
+
+/* 
+ * Find all symbols exported with EXPORT_SYMBOL and EXPORT_SYMBOL_GPL 
+ * in filename.
+ * All symbols located are stored in symfilelist.
+ */
+void find_export_symbols(char * filename)
+{
+	FILE * fp;
+	struct symfile *sym;
+	char line[MAXLINESZ];
+	if (filename_exist(filename) == NULL) {
+		sym = add_new_file(filename);
+		fp = fopen(filename, "r");
+		if (fp == NULL)
+		{
+			fprintf(stderr, "docproc: ");
+			perror(filename);
+		}
+		while(fgets(line, MAXLINESZ, fp)) {
+			char *p;
+			char *e;
+			if (((p = strstr(line, "EXPORT_SYMBOL_GPL")) != 0) ||
+                            ((p = strstr(line, "EXPORT_SYMBOL")) != 0)) {
+				/* Skip EXPORT_SYMBOL{_GPL} */
+				while (isalnum(*p) || *p == '_')
+					p++;
+				/* Remove paranteses and additional ws */
+				while (isspace(*p))
+					p++;
+				if (*p != '(')
+					continue; /* Syntax error? */
+				else
+					p++;
+				while (isspace(*p))
+					p++;
+				e = p;
+				while (isalnum(*e) || *e == '_')
+					e++;
+				*e = '\0';
+				add_new_symbol(sym, p);
+			}
+		}
+		fclose(fp);
+	}
+}
+
+/*
+ * Document all external or internal functions in a file.
+ * Call kernel-doc with following parameters:
+ * kernel-doc -docbook -nofunction function_name1 filename
+ * function names are obtained from all the the src files
+ * by find_export_symbols.
+ * intfunc uses -nofunction
+ * extfunc uses -function
+ */
+void docfunctions(char * filename, char * type)
+{
+	int i,j;
+	int symcnt = 0;
+	int idx = 0;
+	char **vec;
+	
+	for (i=0; i <= symfilecnt; i++)
+		symcnt += symfilelist[i].symbolcnt;
+	vec = malloc((2 + 2 * symcnt + 2) * sizeof(char*));
+	if (vec == NULL) {
+		perror("docproc: ");
+		exit(1);
+	}
+	vec[idx++] = KERNELDOC;
+	vec[idx++] = DOCBOOK;
+	for (i=0; i < symfilecnt; i++) {
+		struct symfile * sym = &symfilelist[i];
+		for (j=0; j < sym->symbolcnt; j++) {
+			vec[idx++]     = type;
+			vec[idx++] = sym->symbollist[j].name;
+		}
+	}
+	vec[idx++]     = filename;
+	vec[idx] = NULL;
+	printf("<!-- %s -->\n", filename);
+	exec_kernel_doc(vec);
+	fflush(stdout);
+	free(vec);
+}
+void intfunc(char * filename) {	docfunctions(filename, NOFUNCTION); }
+void extfunc(char * filename) { docfunctions(filename, FUNCTION);   }
+
+/*
+ * Document spåecific function(s) in a file.
+ * Call kernel-doc with the following parameters:
+ * kernel-doc -docbook -function function1 [-function function2]
+ */
+void singfunc(char * filename, char * line)
+{
+	char *vec[200]; /* Enough for specific functions */
+        int i, idx = 0;
+        int startofsym = 1;
+	vec[idx++] = KERNELDOC;
+	vec[idx++] = DOCBOOK;
+
+        /* Split line up in individual parameters preceeded by FUNCTION */        
+        for (i=0; line[i]; i++) {
+                if (isspace(line[i])) {
+                        line[i] = '\0';
+                        startofsym = 1;
+                        continue;
+                }
+                if (startofsym) {
+                        startofsym = 0;
+                        vec[idx++] = FUNCTION;
+                        vec[idx++] = &line[i];
+                }
+        }
+	vec[idx++] = filename;
+	vec[idx] = NULL;
+	exec_kernel_doc(vec);
+}
+
+/*
+ * Parse file, calling action specific functions for:
+ * 1) Lines containing !E
+ * 2) Lines containing !I
+ * 3) Lines containing !D
+ * 4) Lines containing !F
+ * 5) Default lines - lines not matching the above
+ */
+void parse_file(FILE *infile)
+{
+	char line[MAXLINESZ];
+	char * s;
+	while(fgets(line, MAXLINESZ, infile)) {
+		if (line[0] == '!') {
+			s = line + 2;
+			switch (line[1]) {
+				case 'E':
+					while (*s && !isspace(*s)) s++;
+					*s = '\0';
+					externalfunctions(line+2);
+					break;
+				case 'I':
+					while (*s && !isspace(*s)) s++;
+					*s = '\0';
+					internalfunctions(line+2);
+					break;
+				case 'D':
+					while (*s && !isspace(*s)) s++;
+                                        *s = '\0';
+                                        symbolsonly(line+2);
+                                        break;
+				case 'F':
+					/* filename */
+					while (*s && !isspace(*s)) s++;
+					*s++ = '\0';
+                                        /* function names */
+					while (isspace(*s))
+						s++;
+					singlefunctions(line +2, s);
+					break;
+				default:
+					defaultline(line);
+			}
+		}
+		else {
+			defaultline(line);
+		}
+	}
+	fflush(stdout);
+}
+		
+
+int main(int argc, char *argv[])
+{
+	FILE * infile;
+	if (argc != 3) {
+		usage();
+		exit(1);
+	}
+	/* Open file, exit on error */
+	infile = fopen(argv[2], "r");
+        if (infile == NULL) {
+                fprintf(stderr, "docproc: ");
+                perror(argv[2]);
+                exit(2);
+        }
+
+	if (strcmp("doc", argv[1]) == 0)
+	{
+		/* Need to do this in two passes.
+		 * First pass is used to collect all symbols exported
+		 * in the various files.
+		 * Second pass generate the documentation.
+		 * This is required because function are declared
+		 * and exported in different files :-((
+		 */
+		/* Collect symbols */
+		defaultline       = noaction;
+		internalfunctions = find_export_symbols;
+		externalfunctions = find_export_symbols;
+		symbolsonly       = find_export_symbols;
+		singlefunctions   = noaction2;
+		parse_file(infile);
+
+		/* Rewind to start from beginning of file again */
+		fseek(infile, 0, SEEK_SET);
+		defaultline       = printline;
+		internalfunctions = intfunc;
+		externalfunctions = extfunc;
+		symbolsonly       = printline;
+		singlefunctions   = singfunc;
+		
+		parse_file(infile);
+	}
+	else if (strcmp("depend", argv[1]) == 0)
+	{
+		/* Create first part of dependency chain
+		 * file.tmpl */
+		printf("%s\t", argv[2]);
+		defaultline       = noaction;
+		internalfunctions = adddep;
+		externalfunctions = adddep;
+		symbolsonly       = adddep;
+		singlefunctions   = adddep2;
+		parse_file(infile);
+		printf("\n");
+	}
+	else
+	{
+		fprintf(stderr, "Unknown option: %s\n", argv[1]);
+		exit(1);
+	}
+	fclose(infile);
+	fflush(stdout);
+	return exitstatus;
+}
+
diff -Nru a/scripts/basic/fixdep.c b/scripts/basic/fixdep.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/scripts/basic/fixdep.c	Mon Mar 15 19:51:20 2004
@@ -0,0 +1,381 @@
+/*
+ * "Optimize" a list of dependencies as spit out by gcc -MD 
+ * for the kernel build
+ * ===========================================================================
+ *
+ * Author       Kai Germaschewski
+ * Copyright    2002 by Kai Germaschewski  <kai.germaschewski@gmx.de>
+ *
+ * This software may be used and distributed according to the terms
+ * of the GNU General Public License, incorporated herein by reference.
+ *
+ *
+ * Introduction:
+ * 
+ * gcc produces a very nice and correct list of dependencies which
+ * tells make when to remake a file.
+ *
+ * To use this list as-is however has the drawback that virtually
+ * every file in the kernel includes <linux/config.h> which then again
+ * includes <linux/autoconf.h>
+ *
+ * If the user re-runs make *config, linux/autoconf.h will be
+ * regenerated.  make notices that and will rebuild every file which
+ * includes autoconf.h, i.e. basically all files. This is extremely
+ * annoying if the user just changed CONFIG_HIS_DRIVER from n to m.
+ * 
+ * So we play the same trick that "mkdep" played before. We replace
+ * the dependency on linux/autoconf.h by a dependency on every config
+ * option which is mentioned in any of the listed prequisites.
+ *  
+ * To be exact, split-include populates a tree in include/config/,
+ * e.g. include/config/his/driver.h, which contains the #define/#undef
+ * for the CONFIG_HIS_DRIVER option.
+ *
+ * So if the user changes his CONFIG_HIS_DRIVER option, only the objects
+ * which depend on "include/linux/config/his/driver.h" will be rebuilt,
+ * so most likely only his driver ;-) 
+ *
+ * The idea above dates, by the way, back to Michael E Chastain, AFAIK.
+ * 
+ * So to get dependencies right, there two issues:
+ * o if any of the files the compiler read changed, we need to rebuild
+ * o if the command line given to the compile the file changed, we
+ *   better rebuild as well.
+ *
+ * The former is handled by using the -MD output, the later by saving
+ * the command line used to compile the old object and comparing it
+ * to the one we would now use.
+ *
+ * Again, also this idea is pretty old and has been discussed on
+ * kbuild-devel a long time ago. I don't have a sensibly working
+ * internet connection right now, so I rather don't mention names
+ * without double checking.
+ *
+ * This code here has been based partially based on mkdep.c, which
+ * says the following about its history:
+ *
+ *   Copyright abandoned, Michael Chastain, <mailto:mec@shout.net>.
+ *   This is a C version of syncdep.pl by Werner Almesberger.
+ *
+ *
+ * It is invoked as
+ *
+ *   fixdep <depfile> <target> <cmdline>
+ *
+ * and will read the dependency file <depfile>
+ *
+ * The transformed dependency snipped is written to stdout.
+ *
+ * It first generates a line
+ *
+ *   cmd_<target> = <cmdline>
+ *
+ * and then basically copies the .<target>.d file to stdout, in the
+ * process filtering out the dependency on linux/autoconf.h and adding
+ * dependencies on include/config/my/option.h for every
+ * CONFIG_MY_OPTION encountered in any of the prequisites.
+ *
+ * It will also filter out all the dependencies on *.ver. We need
+ * to make sure that the generated version checksum are globally up
+ * to date before even starting the recursive build, so it's too late
+ * at this point anyway.
+ *
+ * The algorithm to grep for "CONFIG_..." is bit unusual, but should
+ * be fast ;-) We don't even try to really parse the header files, but
+ * merely grep, i.e. if CONFIG_FOO is mentioned in a comment, it will
+ * be picked up as well. It's not a problem with respect to
+ * correctness, since that can only give too many dependencies, thus
+ * we cannot miss a rebuild. Since people tend to not mention totally
+ * unrelated CONFIG_ options all over the place, it's not an
+ * efficiency problem either.
+ * 
+ * (Note: it'd be easy to port over the complete mkdep state machine,
+ *  but I don't think the added complexity is worth it)
+ */
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <limits.h>
+#include <ctype.h>
+#include <netinet/in.h>
+
+#define INT_CONF ntohl(0x434f4e46)
+#define INT_ONFI ntohl(0x4f4e4649)
+#define INT_NFIG ntohl(0x4e464947)
+#define INT_FIG_ ntohl(0x4649475f)
+
+char *target;
+char *depfile;
+char *cmdline;
+
+void usage(void)
+
+{
+	fprintf(stderr, "Usage: fixdep <depfile> <target> <cmdline>\n");
+	exit(1);
+}
+
+void print_cmdline(void)
+{
+	printf("cmd_%s := %s\n\n", target, cmdline);
+}
+
+char * str_config  = NULL;
+int    size_config = 0;
+int    len_config  = 0;
+
+/*
+ * Grow the configuration string to a desired length.
+ * Usually the first growth is plenty.
+ */
+void grow_config(int len)
+{
+	while (len_config + len > size_config) {
+		if (size_config == 0)
+			size_config = 2048;
+		str_config = realloc(str_config, size_config *= 2);
+		if (str_config == NULL)
+			{ perror("fixdep:malloc"); exit(1); }
+	}
+}
+
+
+
+/*
+ * Lookup a value in the configuration string.
+ */
+int is_defined_config(const char * name, int len)
+{
+	const char * pconfig;
+	const char * plast = str_config + len_config - len;
+	for ( pconfig = str_config + 1; pconfig < plast; pconfig++ ) {
+		if (pconfig[ -1] == '\n'
+		&&  pconfig[len] == '\n'
+		&&  !memcmp(pconfig, name, len))
+			return 1;
+	}
+	return 0;
+}
+
+/*
+ * Add a new value to the configuration string.
+ */
+void define_config(const char * name, int len)
+{
+	grow_config(len + 1);
+
+	memcpy(str_config+len_config, name, len);
+	len_config += len;
+	str_config[len_config++] = '\n';
+}
+
+/*
+ * Clear the set of configuration strings.
+ */
+void clear_config(void)
+{
+	len_config = 0;
+	define_config("", 0);
+}
+
+/*
+ * Record the use of a CONFIG_* word.
+ */
+void use_config(char *m, int slen)
+{
+	char s[PATH_MAX];
+	char *p;
+
+	if (is_defined_config(m, slen))
+	    return;
+
+	define_config(m, slen);
+
+	memcpy(s, m, slen); s[slen] = 0;
+
+	for (p = s; p < s + slen; p++) {
+		if (*p == '_')
+			*p = '/';
+		else
+			*p = tolower((unsigned char)*p);
+	}
+	printf("    $(wildcard include/config/%s.h) \\\n", s);
+}
+
+void parse_config_file(char *map, size_t len)
+{
+	int *end = (int *) (map + len);
+	/* start at +1, so that p can never be < map */
+	int *m   = (int *) map + 1;
+	char *p, *q;
+
+	for (; m < end; m++) {
+		if (*m == INT_CONF) { p = (char *) m  ; goto conf; }
+		if (*m == INT_ONFI) { p = (char *) m-1; goto conf; }
+		if (*m == INT_NFIG) { p = (char *) m-2; goto conf; }
+		if (*m == INT_FIG_) { p = (char *) m-3; goto conf; }
+		continue;
+	conf:
+		if (p > map + len - 7)
+			continue;
+		if (memcmp(p, "CONFIG_", 7))
+			continue;
+		for (q = p + 7; q < map + len; q++) {
+			if (!(isalnum(*q) || *q == '_'))
+				goto found;
+		}
+		continue;
+
+	found: 
+		use_config(p+7, q-p-7);
+	}
+}
+
+/* test is s ends in sub */
+int strrcmp(char *s, char *sub)
+{
+	int slen = strlen(s);
+	int sublen = strlen(sub);
+  
+	if (sublen > slen)
+		return 1;
+	
+	return memcmp(s + slen - sublen, sub, sublen);
+}
+
+void do_config_file(char *filename)
+{
+	struct stat st;
+	int fd;
+	void *map;
+
+	fd = open(filename, O_RDONLY);
+	if (fd < 0) {
+		fprintf(stderr, "fixdep: ");
+		perror(filename);
+		exit(2);
+	}
+	fstat(fd, &st);
+	if (st.st_size == 0) {
+		close(fd);
+		return;
+	}
+	map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if ((long) map == -1) {
+		perror("fixdep: mmap");
+		close(fd);
+		return;
+	}
+	
+	parse_config_file(map, st.st_size);
+
+	munmap(map, st.st_size);
+
+	close(fd);
+}
+
+void parse_dep_file(void *map, size_t len)
+{
+	char *m = map;
+	char *end = m + len;
+	char *p;
+	char s[PATH_MAX];
+
+	p = strchr(m, ':');
+	if (!p) {
+		fprintf(stderr, "fixdep: parse error\n");
+		exit(1);
+	}
+	memcpy(s, m, p-m); s[p-m] = 0;
+	printf("deps_%s := \\\n", target);
+	m = p+1;
+
+	clear_config();
+
+	while (m < end) {
+		while (m < end && (*m == ' ' || *m == '\\' || *m == '\n'))
+			m++;
+		p = m;
+		while (p < end && *p != ' ') p++;
+		if (p == end) {
+			do p--; while (!isalnum(*p));
+			p++;
+		}
+		memcpy(s, m, p-m); s[p-m] = 0;
+		if (strrcmp(s, "include/linux/autoconf.h") &&
+		    strrcmp(s, ".ver")) {
+			printf("  %s \\\n", s);
+			do_config_file(s);
+		}
+		m = p + 1;
+	}
+	printf("\n%s: $(deps_%s)\n\n", target, target);
+	printf("$(deps_%s):\n", target);
+}
+
+void print_deps(void)
+{
+	struct stat st;
+	int fd;
+	void *map;
+
+	fd = open(depfile, O_RDONLY);
+	if (fd < 0) {
+		fprintf(stderr, "fixdep: ");
+		perror(depfile);
+		exit(2);
+	}
+	fstat(fd, &st);
+	if (st.st_size == 0) {
+		fprintf(stderr,"fixdep: %s is empty\n",depfile);
+		close(fd);
+		return;
+	}
+	map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if ((long) map == -1) {
+		perror("fixdep: mmap");
+		close(fd);
+		return;
+	}
+	
+	parse_dep_file(map, st.st_size);
+
+	munmap(map, st.st_size);
+
+	close(fd);
+}
+
+void traps(void)
+{
+	static char test[] __attribute__((aligned(sizeof(int)))) = "CONF";
+
+	if (*(int *)test != INT_CONF) {
+		fprintf(stderr, "fixdep: sizeof(int) != 4 or wrong endianess? %#x\n",
+			*(int *)test);
+		exit(2);
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	traps();
+
+	if (argc != 4)
+		usage();
+		
+	depfile = argv[1];
+	target = argv[2];
+	cmdline = argv[3];
+
+	print_cmdline();
+	print_deps();
+
+	return 0;
+}
diff -Nru a/scripts/basic/split-include.c b/scripts/basic/split-include.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/scripts/basic/split-include.c	Mon Mar 15 19:51:20 2004
@@ -0,0 +1,226 @@
+/*
+ * split-include.c
+ *
+ * Copyright abandoned, Michael Chastain, <mailto:mec@shout.net>.
+ * This is a C version of syncdep.pl by Werner Almesberger.
+ *
+ * This program takes autoconf.h as input and outputs a directory full
+ * of one-line include files, merging onto the old values.
+ *
+ * Think of the configuration options as key-value pairs.  Then there
+ * are five cases:
+ *
+ *    key      old value   new value   action
+ *
+ *    KEY-1    VALUE-1     VALUE-1     leave file alone
+ *    KEY-2    VALUE-2A    VALUE-2B    write VALUE-2B into file
+ *    KEY-3    -           VALUE-3     write VALUE-3  into file
+ *    KEY-4    VALUE-4     -           write an empty file
+ *    KEY-5    (empty)     -           leave old empty file alone
+ */
+
+#include <sys/stat.h>
+#include <sys/types.h>
+
+#include <ctype.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#define ERROR_EXIT(strExit)						\
+    {									\
+	const int errnoSave = errno;					\
+	fprintf(stderr, "%s: ", str_my_name);				\
+	errno = errnoSave;						\
+	perror((strExit));						\
+	exit(1);							\
+    }
+
+
+
+int main(int argc, const char * argv [])
+{
+    const char * str_my_name;
+    const char * str_file_autoconf;
+    const char * str_dir_config;
+
+    FILE * fp_config;
+    FILE * fp_target;
+    FILE * fp_find;
+
+    int buffer_size;
+
+    char * line;
+    char * old_line;
+    char * list_target;
+    char * ptarget;
+
+    struct stat stat_buf;
+
+    /* Check arg count. */
+    if (argc != 3)
+    {
+	fprintf(stderr, "%s: wrong number of arguments.\n", argv[0]);
+	exit(1);
+    }
+
+    str_my_name       = argv[0];
+    str_file_autoconf = argv[1];
+    str_dir_config    = argv[2];
+
+    /* Find a buffer size. */
+    if (stat(str_file_autoconf, &stat_buf) != 0)
+	ERROR_EXIT(str_file_autoconf);
+    buffer_size = 2 * stat_buf.st_size + 4096;
+
+    /* Allocate buffers. */
+    if ( (line        = malloc(buffer_size)) == NULL
+    ||   (old_line    = malloc(buffer_size)) == NULL
+    ||   (list_target = malloc(buffer_size)) == NULL )
+	ERROR_EXIT(str_file_autoconf);
+
+    /* Open autoconfig file. */
+    if ((fp_config = fopen(str_file_autoconf, "r")) == NULL)
+	ERROR_EXIT(str_file_autoconf);
+
+    /* Make output directory if needed. */
+    if (stat(str_dir_config, &stat_buf) != 0)
+    {
+	if (mkdir(str_dir_config, 0755) != 0)
+	    ERROR_EXIT(str_dir_config);
+    }
+
+    /* Change to output directory. */
+    if (chdir(str_dir_config) != 0)
+	ERROR_EXIT(str_dir_config);
+	
+    /* Put initial separator into target list. */
+    ptarget = list_target;
+    *ptarget++ = '\n';
+
+    /* Read config lines. */
+    while (fgets(line, buffer_size, fp_config))
+    {
+	const char * str_config;
+	int is_same;
+	int itarget;
+
+	if (line[0] != '#')
+	    continue;
+	if ((str_config = strstr(line, "CONFIG_")) == NULL)
+	    continue;
+
+	/* Make the output file name. */
+	str_config += sizeof("CONFIG_") - 1;
+	for (itarget = 0; !isspace(str_config[itarget]); itarget++)
+	{
+	    int c = (unsigned char) str_config[itarget];
+	    if (isupper(c)) c = tolower(c);
+	    if (c == '_')   c = '/';
+	    ptarget[itarget] = c;
+	}
+	ptarget[itarget++] = '.';
+	ptarget[itarget++] = 'h';
+	ptarget[itarget++] = '\0';
+
+	/* Check for existing file. */
+	is_same = 0;
+	if ((fp_target = fopen(ptarget, "r")) != NULL)
+	{
+	    fgets(old_line, buffer_size, fp_target);
+	    if (fclose(fp_target) != 0)
+		ERROR_EXIT(ptarget);
+	    if (!strcmp(line, old_line))
+		is_same = 1;
+	}
+
+	if (!is_same)
+	{
+	    /* Auto-create directories. */
+	    int islash;
+	    for (islash = 0; islash < itarget; islash++)
+	    {
+		if (ptarget[islash] == '/')
+		{
+		    ptarget[islash] = '\0';
+		    if (stat(ptarget, &stat_buf) != 0
+		    &&  mkdir(ptarget, 0755)     != 0)
+			ERROR_EXIT( ptarget );
+		    ptarget[islash] = '/';
+		}
+	    }
+
+	    /* Write the file. */
+	    if ((fp_target = fopen(ptarget, "w" )) == NULL)
+		ERROR_EXIT(ptarget);
+	    fputs(line, fp_target);
+	    if (ferror(fp_target) || fclose(fp_target) != 0)
+		ERROR_EXIT(ptarget);
+	}
+
+	/* Update target list */
+	ptarget += itarget;
+	*(ptarget-1) = '\n';
+    }
+
+    /*
+     * Close autoconfig file.
+     * Terminate the target list.
+     */
+    if (fclose(fp_config) != 0)
+	ERROR_EXIT(str_file_autoconf);
+    *ptarget = '\0';
+
+    /*
+     * Fix up existing files which have no new value.
+     * This is Case 4 and Case 5.
+     *
+     * I re-read the tree and filter it against list_target.
+     * This is crude.  But it avoids data copies.  Also, list_target
+     * is compact and contiguous, so it easily fits into cache.
+     *
+     * Notice that list_target contains strings separated by \n,
+     * with a \n before the first string and after the last.
+     * fgets gives the incoming names a terminating \n.
+     * So by having an initial \n, strstr will find exact matches.
+     */
+
+    fp_find = popen("find * -type f -name \"*.h\" -print", "r");
+    if (fp_find == 0)
+	ERROR_EXIT( "find" );
+
+    line[0] = '\n';
+    while (fgets(line+1, buffer_size, fp_find))
+    {
+	if (strstr(list_target, line) == NULL)
+	{
+	    /*
+	     * This is an old file with no CONFIG_* flag in autoconf.h.
+	     */
+
+	    /* First strip the \n. */
+	    line[strlen(line)-1] = '\0';
+
+	    /* Grab size. */
+	    if (stat(line+1, &stat_buf) != 0)
+		ERROR_EXIT(line);
+
+	    /* If file is not empty, make it empty and give it a fresh date. */
+	    if (stat_buf.st_size != 0)
+	    {
+		if ((fp_target = fopen(line+1, "w")) == NULL)
+		    ERROR_EXIT(line);
+		if (fclose(fp_target) != 0)
+		    ERROR_EXIT(line);
+	    }
+	}
+    }
+
+    if (pclose(fp_find) != 0)
+	ERROR_EXIT("find");
+
+    return 0;
+}
diff -Nru a/scripts/docproc.c b/scripts/docproc.c
--- a/scripts/docproc.c	Mon Mar 15 19:51:20 2004
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,387 +0,0 @@
-/*
- *	docproc is a simple preprocessor for the template files
- *      used as placeholders for the kernel internal documentation.
- *	docproc is used for documentation-frontend and
- *      dependency-generator.
- *	The two usages have in common that they require
- *	some knowledge of the .tmpl syntax, therefore they
- *	are kept together.
- *
- *	documentation-frontend
- *		Scans the template file and call kernel-doc for
- *		all occurrences of ![EIF]file
- *		Beforehand each referenced file are scanned for
- *		any exported sympols "EXPORT_SYMBOL()" statements.
- *		This is used to create proper -function and
- *		-nofunction arguments in calls to kernel-doc.
- *		Usage: docproc doc file.tmpl
- *
- *	dependency-generator:
- *		Scans the template file and list all files
- *		referenced in a format recognized by make.
- *		Usage:	docproc depend file.tmpl
- *		Writes dependency information to stdout
- *		in the following format:
- *		file.tmpl src.c	src2.c
- *		The filenames are obtained from the following constructs:
- *		!Efilename
- *		!Ifilename
- *		!Dfilename
- *		!Ffilename
- *		
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <ctype.h>
-#include <unistd.h>
-#include <limits.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-
-/* exitstatus is used to keep track of any failing calls to kernel-doc,
- * but execution continues. */
-int exitstatus = 0;
-
-typedef void DFL(char *);
-DFL *defaultline;
-
-typedef void FILEONLY(char * file);
-FILEONLY *internalfunctions;
-FILEONLY *externalfunctions;
-FILEONLY *symbolsonly;
-
-typedef void FILELINE(char * file, char * line);
-FILELINE * singlefunctions;
-FILELINE * entity_system;
-
-#define MAXLINESZ     2048
-#define MAXFILES      250
-#define KERNELDOCPATH "scripts/"
-#define KERNELDOC     "kernel-doc"
-#define DOCBOOK       "-docbook"
-#define FUNCTION      "-function"
-#define NOFUNCTION    "-nofunction"
-
-void usage (void)
-{
-	fprintf(stderr, "Usage: docproc {doc|depend} file\n");
-	fprintf(stderr, "Input is read from file.tmpl. Output is sent to stdout\n");
-	fprintf(stderr, "doc: frontend when generating kernel documentation\n");
-	fprintf(stderr, "depend: generate list of files referenced within file\n");
-}
-
-/*
- * Execute kernel-doc with parameters givin in svec
- */
-void exec_kernel_doc(char **svec)
-{
-	pid_t pid;
-	int ret;
-	/* Make sure output generated so far are flushed */
-	fflush(stdout);
-	switch(pid=fork()) {
-		case -1:
-			perror("fork");
-			exit(1);
-		case  0:
-			execvp(KERNELDOCPATH KERNELDOC, svec);
-			perror("exec " KERNELDOCPATH KERNELDOC);
-			exit(1);
-		default:
-			waitpid(pid, &ret ,0);
-	}
-	if (WIFEXITED(ret))
-		exitstatus |= WEXITSTATUS(ret);
-	else
-		exitstatus = 0xff;
-}
-
-/* Types used to create list of all exported symbols in a number of files */
-struct symbols
-{
-	char *name;
-};
-
-struct symfile
-{
-	char *filename;
-	struct symbols *symbollist;
-	int symbolcnt;
-};
-
-struct symfile symfilelist[MAXFILES];
-int symfilecnt = 0;
-
-void add_new_symbol(struct symfile *sym, char * symname)
-{
-	sym->symbollist =
-          realloc(sym->symbollist, (sym->symbolcnt + 1) * sizeof(char *));
-	sym->symbollist[sym->symbolcnt++].name = strdup(symname);
-}
-
-/* Add a filename to the list */
-struct symfile * add_new_file(char * filename)
-{
-	symfilelist[symfilecnt++].filename = strdup(filename);
-	return &symfilelist[symfilecnt - 1];					
-}
-/* Check if file already are present in the list */
-struct symfile * filename_exist(char * filename)
-{
-	int i;
-	for (i=0; i < symfilecnt; i++)
-		if (strcmp(symfilelist[i].filename, filename) == 0)
-			return &symfilelist[i];
-	return NULL;
-}
-
-/*
- * List all files referenced within the template file.
- * Files are separated by tabs.
- */
-void adddep(char * file)		   { printf("\t%s", file); }
-void adddep2(char * file, char * line)     { line = line; adddep(file); }
-void noaction(char * line)		   { line = line; }
-void noaction2(char * file, char * line)   { file = file; line = line; }
-
-/* Echo the line without further action */
-void printline(char * line)               { printf("%s", line); }
-
-/* 
- * Find all symbols exported with EXPORT_SYMBOL and EXPORT_SYMBOL_GPL 
- * in filename.
- * All symbols located are stored in symfilelist.
- */
-void find_export_symbols(char * filename)
-{
-	FILE * fp;
-	struct symfile *sym;
-	char line[MAXLINESZ];
-	if (filename_exist(filename) == NULL) {
-		sym = add_new_file(filename);
-		fp = fopen(filename, "r");
-		if (fp == NULL)
-		{
-			fprintf(stderr, "docproc: ");
-			perror(filename);
-		}
-		while(fgets(line, MAXLINESZ, fp)) {
-			char *p;
-			char *e;
-			if (((p = strstr(line, "EXPORT_SYMBOL_GPL")) != 0) ||
-                            ((p = strstr(line, "EXPORT_SYMBOL")) != 0)) {
-				/* Skip EXPORT_SYMBOL{_GPL} */
-				while (isalnum(*p) || *p == '_')
-					p++;
-				/* Remove paranteses and additional ws */
-				while (isspace(*p))
-					p++;
-				if (*p != '(')
-					continue; /* Syntax error? */
-				else
-					p++;
-				while (isspace(*p))
-					p++;
-				e = p;
-				while (isalnum(*e) || *e == '_')
-					e++;
-				*e = '\0';
-				add_new_symbol(sym, p);
-			}
-		}
-		fclose(fp);
-	}
-}
-
-/*
- * Document all external or internal functions in a file.
- * Call kernel-doc with following parameters:
- * kernel-doc -docbook -nofunction function_name1 filename
- * function names are obtained from all the the src files
- * by find_export_symbols.
- * intfunc uses -nofunction
- * extfunc uses -function
- */
-void docfunctions(char * filename, char * type)
-{
-	int i,j;
-	int symcnt = 0;
-	int idx = 0;
-	char **vec;
-	
-	for (i=0; i <= symfilecnt; i++)
-		symcnt += symfilelist[i].symbolcnt;
-	vec = malloc((2 + 2 * symcnt + 2) * sizeof(char*));
-	if (vec == NULL) {
-		perror("docproc: ");
-		exit(1);
-	}
-	vec[idx++] = KERNELDOC;
-	vec[idx++] = DOCBOOK;
-	for (i=0; i < symfilecnt; i++) {
-		struct symfile * sym = &symfilelist[i];
-		for (j=0; j < sym->symbolcnt; j++) {
-			vec[idx++]     = type;
-			vec[idx++] = sym->symbollist[j].name;
-		}
-	}
-	vec[idx++]     = filename;
-	vec[idx] = NULL;
-	printf("<!-- %s -->\n", filename);
-	exec_kernel_doc(vec);
-	fflush(stdout);
-	free(vec);
-}
-void intfunc(char * filename) {	docfunctions(filename, NOFUNCTION); }
-void extfunc(char * filename) { docfunctions(filename, FUNCTION);   }
-
-/*
- * Document spåecific function(s) in a file.
- * Call kernel-doc with the following parameters:
- * kernel-doc -docbook -function function1 [-function function2]
- */
-void singfunc(char * filename, char * line)
-{
-	char *vec[200]; /* Enough for specific functions */
-        int i, idx = 0;
-        int startofsym = 1;
-	vec[idx++] = KERNELDOC;
-	vec[idx++] = DOCBOOK;
-
-        /* Split line up in individual parameters preceeded by FUNCTION */        
-        for (i=0; line[i]; i++) {
-                if (isspace(line[i])) {
-                        line[i] = '\0';
-                        startofsym = 1;
-                        continue;
-                }
-                if (startofsym) {
-                        startofsym = 0;
-                        vec[idx++] = FUNCTION;
-                        vec[idx++] = &line[i];
-                }
-        }
-	vec[idx++] = filename;
-	vec[idx] = NULL;
-	exec_kernel_doc(vec);
-}
-
-/*
- * Parse file, calling action specific functions for:
- * 1) Lines containing !E
- * 2) Lines containing !I
- * 3) Lines containing !D
- * 4) Lines containing !F
- * 5) Default lines - lines not matching the above
- */
-void parse_file(FILE *infile)
-{
-	char line[MAXLINESZ];
-	char * s;
-	while(fgets(line, MAXLINESZ, infile)) {
-		if (line[0] == '!') {
-			s = line + 2;
-			switch (line[1]) {
-				case 'E':
-					while (*s && !isspace(*s)) s++;
-					*s = '\0';
-					externalfunctions(line+2);
-					break;
-				case 'I':
-					while (*s && !isspace(*s)) s++;
-					*s = '\0';
-					internalfunctions(line+2);
-					break;
-				case 'D':
-					while (*s && !isspace(*s)) s++;
-                                        *s = '\0';
-                                        symbolsonly(line+2);
-                                        break;
-				case 'F':
-					/* filename */
-					while (*s && !isspace(*s)) s++;
-					*s++ = '\0';
-                                        /* function names */
-					while (isspace(*s))
-						s++;
-					singlefunctions(line +2, s);
-					break;
-				default:
-					defaultline(line);
-			}
-		}
-		else {
-			defaultline(line);
-		}
-	}
-	fflush(stdout);
-}
-		
-
-int main(int argc, char *argv[])
-{
-	FILE * infile;
-	if (argc != 3) {
-		usage();
-		exit(1);
-	}
-	/* Open file, exit on error */
-	infile = fopen(argv[2], "r");
-        if (infile == NULL) {
-                fprintf(stderr, "docproc: ");
-                perror(argv[2]);
-                exit(2);
-        }
-
-	if (strcmp("doc", argv[1]) == 0)
-	{
-		/* Need to do this in two passes.
-		 * First pass is used to collect all symbols exported
-		 * in the various files.
-		 * Second pass generate the documentation.
-		 * This is required because function are declared
-		 * and exported in different files :-((
-		 */
-		/* Collect symbols */
-		defaultline       = noaction;
-		internalfunctions = find_export_symbols;
-		externalfunctions = find_export_symbols;
-		symbolsonly       = find_export_symbols;
-		singlefunctions   = noaction2;
-		parse_file(infile);
-
-		/* Rewind to start from beginning of file again */
-		fseek(infile, 0, SEEK_SET);
-		defaultline       = printline;
-		internalfunctions = intfunc;
-		externalfunctions = extfunc;
-		symbolsonly       = printline;
-		singlefunctions   = singfunc;
-		
-		parse_file(infile);
-	}
-	else if (strcmp("depend", argv[1]) == 0)
-	{
-		/* Create first part of dependency chain
-		 * file.tmpl */
-		printf("%s\t", argv[2]);
-		defaultline       = noaction;
-		internalfunctions = adddep;
-		externalfunctions = adddep;
-		symbolsonly       = adddep;
-		singlefunctions   = adddep2;
-		parse_file(infile);
-		printf("\n");
-	}
-	else
-	{
-		fprintf(stderr, "Unknown option: %s\n", argv[1]);
-		exit(1);
-	}
-	fclose(infile);
-	fflush(stdout);
-	return exitstatus;
-}
-
diff -Nru a/scripts/fixdep.c b/scripts/fixdep.c
--- a/scripts/fixdep.c	Mon Mar 15 19:51:20 2004
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,381 +0,0 @@
-/*
- * "Optimize" a list of dependencies as spit out by gcc -MD 
- * for the kernel build
- * ===========================================================================
- *
- * Author       Kai Germaschewski
- * Copyright    2002 by Kai Germaschewski  <kai.germaschewski@gmx.de>
- *
- * This software may be used and distributed according to the terms
- * of the GNU General Public License, incorporated herein by reference.
- *
- *
- * Introduction:
- * 
- * gcc produces a very nice and correct list of dependencies which
- * tells make when to remake a file.
- *
- * To use this list as-is however has the drawback that virtually
- * every file in the kernel includes <linux/config.h> which then again
- * includes <linux/autoconf.h>
- *
- * If the user re-runs make *config, linux/autoconf.h will be
- * regenerated.  make notices that and will rebuild every file which
- * includes autoconf.h, i.e. basically all files. This is extremely
- * annoying if the user just changed CONFIG_HIS_DRIVER from n to m.
- * 
- * So we play the same trick that "mkdep" played before. We replace
- * the dependency on linux/autoconf.h by a dependency on every config
- * option which is mentioned in any of the listed prequisites.
- *  
- * To be exact, split-include populates a tree in include/config/,
- * e.g. include/config/his/driver.h, which contains the #define/#undef
- * for the CONFIG_HIS_DRIVER option.
- *
- * So if the user changes his CONFIG_HIS_DRIVER option, only the objects
- * which depend on "include/linux/config/his/driver.h" will be rebuilt,
- * so most likely only his driver ;-) 
- *
- * The idea above dates, by the way, back to Michael E Chastain, AFAIK.
- * 
- * So to get dependencies right, there two issues:
- * o if any of the files the compiler read changed, we need to rebuild
- * o if the command line given to the compile the file changed, we
- *   better rebuild as well.
- *
- * The former is handled by using the -MD output, the later by saving
- * the command line used to compile the old object and comparing it
- * to the one we would now use.
- *
- * Again, also this idea is pretty old and has been discussed on
- * kbuild-devel a long time ago. I don't have a sensibly working
- * internet connection right now, so I rather don't mention names
- * without double checking.
- *
- * This code here has been based partially based on mkdep.c, which
- * says the following about its history:
- *
- *   Copyright abandoned, Michael Chastain, <mailto:mec@shout.net>.
- *   This is a C version of syncdep.pl by Werner Almesberger.
- *
- *
- * It is invoked as
- *
- *   fixdep <depfile> <target> <cmdline>
- *
- * and will read the dependency file <depfile>
- *
- * The transformed dependency snipped is written to stdout.
- *
- * It first generates a line
- *
- *   cmd_<target> = <cmdline>
- *
- * and then basically copies the .<target>.d file to stdout, in the
- * process filtering out the dependency on linux/autoconf.h and adding
- * dependencies on include/config/my/option.h for every
- * CONFIG_MY_OPTION encountered in any of the prequisites.
- *
- * It will also filter out all the dependencies on *.ver. We need
- * to make sure that the generated version checksum are globally up
- * to date before even starting the recursive build, so it's too late
- * at this point anyway.
- *
- * The algorithm to grep for "CONFIG_..." is bit unusual, but should
- * be fast ;-) We don't even try to really parse the header files, but
- * merely grep, i.e. if CONFIG_FOO is mentioned in a comment, it will
- * be picked up as well. It's not a problem with respect to
- * correctness, since that can only give too many dependencies, thus
- * we cannot miss a rebuild. Since people tend to not mention totally
- * unrelated CONFIG_ options all over the place, it's not an
- * efficiency problem either.
- * 
- * (Note: it'd be easy to port over the complete mkdep state machine,
- *  but I don't think the added complexity is worth it)
- */
-
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <limits.h>
-#include <ctype.h>
-#include <netinet/in.h>
-
-#define INT_CONF ntohl(0x434f4e46)
-#define INT_ONFI ntohl(0x4f4e4649)
-#define INT_NFIG ntohl(0x4e464947)
-#define INT_FIG_ ntohl(0x4649475f)
-
-char *target;
-char *depfile;
-char *cmdline;
-
-void usage(void)
-
-{
-	fprintf(stderr, "Usage: fixdep <depfile> <target> <cmdline>\n");
-	exit(1);
-}
-
-void print_cmdline(void)
-{
-	printf("cmd_%s := %s\n\n", target, cmdline);
-}
-
-char * str_config  = NULL;
-int    size_config = 0;
-int    len_config  = 0;
-
-/*
- * Grow the configuration string to a desired length.
- * Usually the first growth is plenty.
- */
-void grow_config(int len)
-{
-	while (len_config + len > size_config) {
-		if (size_config == 0)
-			size_config = 2048;
-		str_config = realloc(str_config, size_config *= 2);
-		if (str_config == NULL)
-			{ perror("fixdep:malloc"); exit(1); }
-	}
-}
-
-
-
-/*
- * Lookup a value in the configuration string.
- */
-int is_defined_config(const char * name, int len)
-{
-	const char * pconfig;
-	const char * plast = str_config + len_config - len;
-	for ( pconfig = str_config + 1; pconfig < plast; pconfig++ ) {
-		if (pconfig[ -1] == '\n'
-		&&  pconfig[len] == '\n'
-		&&  !memcmp(pconfig, name, len))
-			return 1;
-	}
-	return 0;
-}
-
-/*
- * Add a new value to the configuration string.
- */
-void define_config(const char * name, int len)
-{
-	grow_config(len + 1);
-
-	memcpy(str_config+len_config, name, len);
-	len_config += len;
-	str_config[len_config++] = '\n';
-}
-
-/*
- * Clear the set of configuration strings.
- */
-void clear_config(void)
-{
-	len_config = 0;
-	define_config("", 0);
-}
-
-/*
- * Record the use of a CONFIG_* word.
- */
-void use_config(char *m, int slen)
-{
-	char s[PATH_MAX];
-	char *p;
-
-	if (is_defined_config(m, slen))
-	    return;
-
-	define_config(m, slen);
-
-	memcpy(s, m, slen); s[slen] = 0;
-
-	for (p = s; p < s + slen; p++) {
-		if (*p == '_')
-			*p = '/';
-		else
-			*p = tolower((unsigned char)*p);
-	}
-	printf("    $(wildcard include/config/%s.h) \\\n", s);
-}
-
-void parse_config_file(char *map, size_t len)
-{
-	int *end = (int *) (map + len);
-	/* start at +1, so that p can never be < map */
-	int *m   = (int *) map + 1;
-	char *p, *q;
-
-	for (; m < end; m++) {
-		if (*m == INT_CONF) { p = (char *) m  ; goto conf; }
-		if (*m == INT_ONFI) { p = (char *) m-1; goto conf; }
-		if (*m == INT_NFIG) { p = (char *) m-2; goto conf; }
-		if (*m == INT_FIG_) { p = (char *) m-3; goto conf; }
-		continue;
-	conf:
-		if (p > map + len - 7)
-			continue;
-		if (memcmp(p, "CONFIG_", 7))
-			continue;
-		for (q = p + 7; q < map + len; q++) {
-			if (!(isalnum(*q) || *q == '_'))
-				goto found;
-		}
-		continue;
-
-	found: 
-		use_config(p+7, q-p-7);
-	}
-}
-
-/* test is s ends in sub */
-int strrcmp(char *s, char *sub)
-{
-	int slen = strlen(s);
-	int sublen = strlen(sub);
-  
-	if (sublen > slen)
-		return 1;
-	
-	return memcmp(s + slen - sublen, sub, sublen);
-}
-
-void do_config_file(char *filename)
-{
-	struct stat st;
-	int fd;
-	void *map;
-
-	fd = open(filename, O_RDONLY);
-	if (fd < 0) {
-		fprintf(stderr, "fixdep: ");
-		perror(filename);
-		exit(2);
-	}
-	fstat(fd, &st);
-	if (st.st_size == 0) {
-		close(fd);
-		return;
-	}
-	map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
-	if ((long) map == -1) {
-		perror("fixdep: mmap");
-		close(fd);
-		return;
-	}
-	
-	parse_config_file(map, st.st_size);
-
-	munmap(map, st.st_size);
-
-	close(fd);
-}
-
-void parse_dep_file(void *map, size_t len)
-{
-	char *m = map;
-	char *end = m + len;
-	char *p;
-	char s[PATH_MAX];
-
-	p = strchr(m, ':');
-	if (!p) {
-		fprintf(stderr, "fixdep: parse error\n");
-		exit(1);
-	}
-	memcpy(s, m, p-m); s[p-m] = 0;
-	printf("deps_%s := \\\n", target);
-	m = p+1;
-
-	clear_config();
-
-	while (m < end) {
-		while (m < end && (*m == ' ' || *m == '\\' || *m == '\n'))
-			m++;
-		p = m;
-		while (p < end && *p != ' ') p++;
-		if (p == end) {
-			do p--; while (!isalnum(*p));
-			p++;
-		}
-		memcpy(s, m, p-m); s[p-m] = 0;
-		if (strrcmp(s, "include/linux/autoconf.h") &&
-		    strrcmp(s, ".ver")) {
-			printf("  %s \\\n", s);
-			do_config_file(s);
-		}
-		m = p + 1;
-	}
-	printf("\n%s: $(deps_%s)\n\n", target, target);
-	printf("$(deps_%s):\n", target);
-}
-
-void print_deps(void)
-{
-	struct stat st;
-	int fd;
-	void *map;
-
-	fd = open(depfile, O_RDONLY);
-	if (fd < 0) {
-		fprintf(stderr, "fixdep: ");
-		perror(depfile);
-		exit(2);
-	}
-	fstat(fd, &st);
-	if (st.st_size == 0) {
-		fprintf(stderr,"fixdep: %s is empty\n",depfile);
-		close(fd);
-		return;
-	}
-	map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
-	if ((long) map == -1) {
-		perror("fixdep: mmap");
-		close(fd);
-		return;
-	}
-	
-	parse_dep_file(map, st.st_size);
-
-	munmap(map, st.st_size);
-
-	close(fd);
-}
-
-void traps(void)
-{
-	static char test[] __attribute__((aligned(sizeof(int)))) = "CONF";
-
-	if (*(int *)test != INT_CONF) {
-		fprintf(stderr, "fixdep: sizeof(int) != 4 or wrong endianess? %#x\n",
-			*(int *)test);
-		exit(2);
-	}
-}
-
-int main(int argc, char *argv[])
-{
-	traps();
-
-	if (argc != 4)
-		usage();
-		
-	depfile = argv[1];
-	target = argv[2];
-	cmdline = argv[3];
-
-	print_cmdline();
-	print_deps();
-
-	return 0;
-}
diff -Nru a/scripts/split-include.c b/scripts/split-include.c
--- a/scripts/split-include.c	Mon Mar 15 19:51:20 2004
+++ /dev/null	Wed Dec 31 16:00:00 1969
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

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317604AbSGXVYl>; Wed, 24 Jul 2002 17:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317610AbSGXVYl>; Wed, 24 Jul 2002 17:24:41 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:56588 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S317604AbSGXVYS>;
	Wed, 24 Jul 2002 17:24:18 -0400
Date: Wed, 24 Jul 2002 23:34:47 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: torvalds@transmeta.com, davej@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] docbook: scripts/docproc improved [5/9]
Message-ID: <20020724233447.D12782@mars.ravnborg.org>
References: <20020724232021.A12622@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020724232021.A12622@mars.ravnborg.org>; from sam@ravnborg.org on Wed, Jul 24, 2002 at 11:20:21PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.435   -> 1.436  
#	scripts/gen-all-syms	1.2     ->         (deleted)      
#	   scripts/docproc.c	1.2     -> 1.3    
#	      scripts/docgen	1.3     ->         (deleted)      
#	    scripts/Makefile	1.9     -> 1.10   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/24	sam@mars.ravnborg.org	1.436
# [PATCH] docbook: scripts/docproc improved [5/9]
# This is the first patch in a serie to clean-up the DocBook
# Makefile.
# docproc is extented to include the functionality previously provided by
# gen-all-syms and docgen. Furthermore the necessity to specify which
# files to search for EXPORT_SYMBOL are removed, the information is now
# read in the .tmpl files.
# docproc is furthermore extended to generate dependency information.
# gen-all-syms and docgen are deleted.
# --------------------------------------------
#
diff -Nru a/scripts/Makefile b/scripts/Makefile
--- a/scripts/Makefile	Wed Jul 24 22:52:07 2002
+++ b/scripts/Makefile	Wed Jul 24 22:52:07 2002
@@ -7,7 +7,7 @@
 # can't do it
 CHMOD_FILES := docgen gen-all-syms kernel-doc mkcompile_h makelst
 
-all: fixdep split-include $(CHMOD_FILES)
+all: fixdep split-include docproc $(CHMOD_FILES)
 
 $(CHMOD_FILES): FORCE
 	@chmod a+x $@
@@ -36,11 +36,6 @@
 	  cat $(TAIL)                                           \
 	) > $@
 	chmod 755 $@
-
-# DocBook stuff
-# ---------------------------------------------------------------------------
-
-doc-progs: docproc
 
 # ---------------------------------------------------------------------------
 
diff -Nru a/scripts/docgen b/scripts/docgen
--- a/scripts/docgen	Wed Jul 24 22:52:07 2002
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,10 +0,0 @@
-#!/bin/sh
-set -e
-if [ -z "$scripts_objtree" ]
-then
-	X=`$TOPDIR/scripts/gen-all-syms "$*"`
-	$TOPDIR/scripts/docproc $X
-else
-	X=`${scripts_objtree}gen-all-syms "$*"`
-	TOPDIR=. ${scripts_objtree}docproc $X
-fi
diff -Nru a/scripts/docproc.c b/scripts/docproc.c
--- a/scripts/docproc.c	Wed Jul 24 22:52:07 2002
+++ b/scripts/docproc.c	Wed Jul 24 22:52:07 2002
@@ -1,104 +1,387 @@
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
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <ctype.h>
 #include <unistd.h>
+#include <limits.h>
 #include <sys/types.h>
 #include <sys/wait.h>
 
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
 /*
- *	A simple filter for the templates
+ * Execute kernel-doc with parameters givin in svec
  */
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
+		exitstatus = WEXITSTATUS(ret);
+	else
+		exitstatus = 0xff;
+}
 
-int main(int argc, char *argv[])
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
 {
-	char buf[1024];
-	char *vec[8192];
-	char *fvec[200];
-	char **svec;
-	char type[64];
 	int i;
-	int vp=2;
-	int ret=0;
-	pid_t pid;
+	for (i=0; i < symfilecnt; i++)
+		if (strcmp(symfilelist[i].filename, filename) == 0)
+			return &symfilelist[i];
+	return NULL;
+}
 
+/*
+ * List all files referenced within the template file.
+ * Files are separated by tabs.
+ */
+void adddep(char * file)		   { printf("\t%s", file); }
+void adddep2(char * file, char * line)     { line = line; adddep(file); }
+void noaction(char * line)		   { line = line; }
+void noaction2(char * file, char * line)   { file = file; line = line; }
 
-	if(chdir(getenv("TOPDIR")))
-	{
-		perror("chdir");
-		exit(1);
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
 	}
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
 	
-	/*
-	 *	Build the exec array ahead of time.
-	 */
-	vec[0]="kernel-doc";
-	vec[1]="-docbook";
-	for(i=1;vp<8189;i++)
-	{
-		if(argv[i]==NULL)
-			break;
-		vec[vp++]=type;
-		vec[vp++]=argv[i];
+	for (i=0; i <= symfilecnt; i++)
+		symcnt += symfilelist[i].symbolcnt;
+	vec = malloc((2 + 2 * symcnt + 2) * sizeof(char*));
+	if (vec == NULL) {
+		perror("docproc: ");
+		exit(1);
 	}
-	vec[vp++]=buf+2;
-	vec[vp++]=NULL;
-	
-	/*
-	 *	Now process the template
-	 */
-	 
-	while(fgets(buf, 1024, stdin))
-	{
-		if(*buf!='!') {
-			printf("%s", buf);
-			continue;
+	vec[idx++] = KERNELDOC;
+	vec[idx++] = DOCBOOK;
+	for (i=0; i < symfilecnt; i++) {
+		struct symfile * sym = &symfilelist[i];
+		for (j=0; j < sym->symbolcnt; j++) {
+			vec[idx++]     = type;
+			vec[idx++] = sym->symbollist[j].name;
 		}
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
 
-		fflush(stdout);
-		svec = vec;
-		if(buf[1]=='E')
-			strcpy(type, "-function");
-		else if(buf[1]=='I')
-			strcpy(type, "-nofunction");	
-		else if(buf[1]=='F') {
-			int snarf = 0;
-			fvec[0] = "kernel-doc";
-			fvec[1] = "-docbook";
-			strcpy (type, "-function");
-			vp = 2;
-			for (i = 2; buf[i]; i++) {
-				if (buf[i] == ' ' || buf[i] == '\n') {
-					buf[i] = '\0';
-					snarf = 1;
-					continue;
-				}
-
-				if (snarf) {
-					snarf = 0;
-					fvec[vp++] = type;
-					fvec[vp++] = &buf[i];
-				}
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
 			}
-			fvec[vp++] = &buf[2];
-			fvec[vp] = NULL;
-			svec = fvec;
-		} else
-		{
-			fprintf(stderr, "Unknown ! escape.\n");
-			exit(1);
 		}
-		switch(pid=fork())
-		{
-		case -1:
-			perror("fork");
-			exit(1);
-		case  0:
-			execvp("scripts/kernel-doc", svec);
-			perror("exec scripts/kernel-doc");
-			exit(1);
-		default:
-			waitpid(pid, &ret ,0);
+		else {
+			defaultline(line);
 		}
 	}
-	exit(ret);
+	fflush(stdout);
 }
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
diff -Nru a/scripts/gen-all-syms b/scripts/gen-all-syms
--- a/scripts/gen-all-syms	Wed Jul 24 22:52:07 2002
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,7 +0,0 @@
-#!/bin/sh
-for i in $*
-do
-	grep "EXPORT_SYMBOL.*(.*)" "$i" \
-		| sed -e "s/EXPORT_SYMBOL.*(/  /" \
-		| sed -e "s/).*$//" | sed -e "s/^  //"
-done

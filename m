Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbUCLVLP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 16:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262690AbUCLVLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 16:11:15 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:58951 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262923AbUCLVKL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 16:10:11 -0500
Date: Fri, 12 Mar 2004 22:02:32 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: fix modpost when used with O=
Message-ID: <20040312210232.GA6250@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

modpost or to be more specific sumversion.c was not behaving
correct when used with O= and MODULE_VERSION was used.
Previously it failed to use local .h when calculation
the md-sum in case of a O= build.

The following patch introduces the following:
- A generic get_next_line()
- Check that the topmost part of the directory matches
- Using strrch when checking for file with suffix .o
- Use NOFAIL for allocations in sumversion
- Avoid memory leak in new_module

The generic get_next_line will pay off when Andreas
implmentation of storing symbil addresses in a seperate
file is introduced.

	Sam

kbuild-fix-modpost.patch

diff -Nru a/scripts/modpost.c b/scripts/modpost.c
--- a/scripts/modpost.c	Fri Mar 12 21:54:55 2004
+++ b/scripts/modpost.c	Fri Mar 12 21:54:55 2004
@@ -11,6 +11,7 @@
  * Usage: modpost vmlinux module1.o module2.o ...
  */
 
+#include <ctype.h>
 #include "modpost.h"
 
 /* Are we using CONFIG_MODVERSIONS? */
@@ -44,8 +45,6 @@
 	va_end(arglist);
 }
 
-#define NOFAIL(ptr)	do_nofail((ptr), __FILE__, __LINE__, #ptr)
-
 void *do_nofail(void *ptr, const char *file, int line, const char *expr)
 {
 	if (!ptr) {
@@ -63,21 +62,19 @@
 new_module(char *modname)
 {
 	struct module *mod;
-	char *p;
-	size_t len;
+	char *p, *s;
 	
 	mod = NOFAIL(malloc(sizeof(*mod)));
 	memset(mod, 0, sizeof(*mod));
 	p = NOFAIL(strdup(modname));
 
-	len = strlen(p);
-
 	/* strip trailing .o */
-	if (len > 2 && p[len-2] == '.' && p[len-1] == 'o')
-		p[len -2] = '\0';
+	if ((s = strrchr(p, '.')) != NULL)
+		if (strcmp(s, ".o") == 0)
+			*s = '\0';
 
 	/* add to list */
-	mod->name = NOFAIL(strdup(p));
+	mod->name = p;
 	mod->next = modules;
 	modules = mod;
 
@@ -207,6 +204,42 @@
 	if (map == MAP_FAILED)
 		return NULL;
 	return map;
+}
+
+/*
+   Return a copy of the next line in a mmap'ed file.
+   spaces in the beginning of the line is trimmed away.
+   Return a pointer to a static buffer.
+*/
+char*
+get_next_line(unsigned long *pos, void *file, unsigned long size)
+{
+	static char line[4096];
+	int skip = 1;
+	size_t len = 0;
+	char *p = (char *)file + *pos;
+	char *s = line;
+
+	for (; *pos < size ; (*pos)++)
+	{
+		if (skip && isspace(*p)) {
+			p++;
+			continue;
+		}
+		skip = 0;
+		if (*p != '\n' && (*pos < size)) {
+			len++;
+			*s++ = *p++;
+			if (len > 4095)
+				break; /* Too long, stop */
+		} else {
+			/* End of string */
+			*s = '\0';
+			return line;
+		}
+	}
+	/* End of buffer */
+	return NULL;
 }
 
 void
diff -Nru a/scripts/modpost.h b/scripts/modpost.h
--- a/scripts/modpost.h	Fri Mar 12 21:54:55 2004
+++ b/scripts/modpost.h	Fri Mar 12 21:54:55 2004
@@ -53,6 +53,9 @@
 
 #endif
 
+#define NOFAIL(ptr)   do_nofail((ptr), __FILE__, __LINE__, #ptr)
+void *do_nofail(void *ptr, const char *file, int line, const char *expr);
+
 struct buffer {
 	char *p;
 	int pos;
@@ -95,4 +98,5 @@
 			unsigned long modinfo_offset);
 
 void *grab_file(const char *filename, unsigned long *size);
+char* get_next_line(unsigned long *pos, void *file, unsigned long size);
 void release_file(void *file, unsigned long size);
diff -Nru a/scripts/sumversion.c b/scripts/sumversion.c
--- a/scripts/sumversion.c	Fri Mar 12 21:54:55 2004
+++ b/scripts/sumversion.c	Fri Mar 12 21:54:55 2004
@@ -323,12 +323,12 @@
  * figure out source file. */
 static int parse_source_files(const char *objfile, struct md4_ctx *md)
 {
-	char *cmd, *file, *p, *end;
+	char *cmd, *file, *line, *dir;
 	const char *base;
-	unsigned long flen;
-	int dirlen, ret = 0;
+	unsigned long flen, pos = 0;
+	int dirlen, ret = 0, check_files = 0;
 
-	cmd = malloc(strlen(objfile) + sizeof("..cmd"));
+	cmd = NOFAIL(malloc(strlen(objfile) + sizeof("..cmd")));
 
 	base = strrchr(objfile, '/');
 	if (base) {
@@ -339,6 +339,9 @@
 		dirlen = 0;
 		sprintf(cmd, ".%s.cmd", objfile);
 	}
+	dir = NOFAIL(malloc(dirlen + 1));
+	strncpy(dir, objfile, dirlen);
+	dir[dirlen] = '\0';
 
 	file = grab_file(cmd, &flen);
 	if (!file) {
@@ -357,48 +360,38 @@
 
 	   Sum all files in the same dir or subdirs.
 	*/
-	/* Strictly illegal: file is not nul terminated. */
-	p = strstr(file, "\ndeps_");
-	if (!p) {
-		fprintf(stderr, "Warning: could not find deps_ line in %s\n",
-			cmd);
-		goto out_file;
-	}
-	p = strstr(p, ":=");
-	if (!p) {
-		fprintf(stderr, "Warning: could not find := line in %s\n",
-			cmd);
-		goto out_file;
-	}
-	p += strlen(":=");
-	p += strspn(p, " \\\n");
-
-	end = strstr(p, "\n\n");
-	if (!end) {
-		fprintf(stderr, "Warning: could not find end line in %s\n",
-			cmd);
-		goto out_file;
-	}
-
-	while (p < end) {
-		unsigned int len;
+	while ((line = get_next_line(&pos, file, flen)) != NULL) {
+		char* p = line;
+		if (strncmp(line, "deps_", sizeof("deps_")-1) == 0) {
+			check_files = 1;
+			continue;
+		}
+		if (!check_files)
+			continue;
+	
+		/* Continue until line does not end with '\' */
+		if ( *(p + strlen(p)-1) != '\\')
+			break;	
+		/* Terminate line at first space, to get rid of final ' \' */
+		while (*p) {
+			if isspace(*p) {
+				*p = '\0';
+				break;
+			}
+			p++;
+		}
 
-		len = strcspn(p, " \\\n");
-		if (memcmp(objfile, p, dirlen) == 0) {
-			char source[len + 1];
-
-			memcpy(source, p, len);
-			source[len] = '\0';
-			printf("parsing %s\n", source);
-			if (!parse_file(source, md)) {
+		/* Check if this file is in same dir as objfile */
+		if ((strstr(line, dir)+strlen(dir)-1) == strrchr(line, '/')) {
+			if (!parse_file(line, md)) {
 				fprintf(stderr,
 					"Warning: could not open %s: %s\n",
-					source, strerror(errno));
+					line, strerror(errno));
 				goto out_file;
 			}
+			
 		}
-		p += len;
-		p += strspn(p, " \\\n");
+		
 	}
 
 	/* Everyone parsed OK */
@@ -406,6 +399,7 @@
 out_file:
 	release_file(file, flen);
 out:
+	free(dir);
 	free(cmd);
 	return ret;
 }

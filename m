Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264103AbTFIAwB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 20:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbTFIAwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 20:52:01 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73]:42959
	"EHLO michonline.com") by vger.kernel.org with ESMTP
	id S264103AbTFIAv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 20:51:58 -0400
Date: Sun, 8 Jun 2003 21:11:28 -0400
From: Ryan Anderson <ryan@michonline.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitor-discuss@lists.sourceforge.net
Subject: [PATCH][SPARSE] Runtime detection of gcc include paths
Message-ID: <20030609011128.GI20872@michonline.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org,
	kernel-janitor-discuss@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update pre-process.c to do runtime detection of gcc's internal include
paths.

This uses the same method as previously was used, it just performs the
lookup at runtime.

I do not believe this will work for cross-compiles, though, I believe
the fix will be fairly trivial.  (Given that I don't cross-compile, I'm
not quite sure what the exact mechanisms to do so are.)

This should set things up to be able to provide packaged versions.  My
next patch will (probably) be everything necessary to build a Debian
package.

# This is a BitKeeper generated patch for the following project:
# Project Name: TSCT - The Silly C Tokenizer
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.355   -> 1.356  
#	            Makefile	1.23    -> 1.24   
#	       pre-process.c	1.65    -> 1.67   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/08	ryan@mythryan2.(none)	1.356
# Rework the way gcc internal includes are found to be done entirely at run-time.
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Sun Jun  8 21:04:32 2003
+++ b/Makefile	Sun Jun  8 21:04:32 2003
@@ -32,7 +32,7 @@
 expression.o: $(LIB_H)
 lib.o: $(LIB_H)
 parse.o: $(LIB_H)
-pre-process.o: $(LIB_H) pre-process.h
+pre-process.o: $(LIB_H) 
 scope.o: $(LIB_H)
 show-parse.o: $(LIB_H)
 symbol.o: $(LIB_H)
@@ -40,8 +40,6 @@
 test-parsing.o: $(LIB_H)
 tokenize.o: $(LIB_H)
 
-pre-process.h:
-	echo "#define GCC_INTERNAL_INCLUDE \"`$(CC) -print-file-name=include`\"" > pre-process.h
 
 clean:
-	rm -f *.[oasi] core core.[0-9]* $(PROGRAMS) pre-process.h
+	rm -f *.[oasi] core core.[0-9]* $(PROGRAMS)
diff -Nru a/pre-process.c b/pre-process.c
--- a/pre-process.c	Sun Jun  8 21:04:32 2003
+++ b/pre-process.c	Sun Jun  8 21:04:32 2003
@@ -18,7 +18,6 @@
 #include <fcntl.h>
 #include <limits.h>
 
-#include "pre-process.h"
 #include "lib.h"
 #include "parse.h"
 #include "token.h"
@@ -45,8 +44,7 @@
 	NULL,
 };
 
-const char *gcc_includepath[] = {
-	GCC_INTERNAL_INCLUDE,
+const char *gcc_includepath[INCLUDEPATHS+1] = {
 	NULL
 };
 
@@ -531,6 +529,68 @@
 	}
 	return 0;
 }
+
+static int init_gcc_include_path()
+{
+	char cc[128];
+	char cmd[256];
+	char *s;
+	char buffer[128];;
+	FILE *p;
+
+	s = getenv("CC");
+	if (s) {
+		strncpy(cc,s,127);
+		cc[127]='\0';
+
+	} else {
+		strcpy(cc,"gcc");
+	}
+
+	snprintf(cmd,256,"%s --print-file-name=include",cc);
+
+	p = popen(cmd,"r");
+	if (!p) {
+		perror("ERROR: failed to find gcc-include-path");
+		return 0;
+	}
+
+	/* The format of each line is simply "pathname\n".
+	 * So we simply need to strip the last character off the
+	 * line before storing it.
+	 */
+
+	int includes = 0;
+	do {
+		s = fgets(buffer,127,p);
+		if (s) {
+			buffer[strlen(buffer)-1] = '\0';
+			gcc_includepath[includes] = strdup(buffer); 
+			includes++;
+		}
+
+	} while (includes < INCLUDEPATHS - 1 && !feof(p));
+
+	gcc_includepath[includes] = NULL;
+
+	pclose(p);
+
+	return 1;
+
+
+}
+
+
+static int do_gcc_include_path(struct token *head, struct token *token, const char *filename, int flen)
+{
+	static int initialized = 0;
+	if (!initialized) {
+		if (!init_gcc_include_path())
+			return 0;
+		initialized = 1;
+	}
+	return do_include_path(gcc_includepath,head,token,filename,flen);
+}
 	
 
 static void do_include(int local, struct stream *stream, struct token *head, struct token *token, const char *filename)
@@ -556,7 +616,7 @@
 		return;
 	if (do_include_path(sys_includepath, head, token, filename, flen))
 		return;
-	if (do_include_path(gcc_includepath, head, token, filename, flen))
+	if (do_gcc_include_path(head,token,filename,flen))
 		return;
 
 	error(token->pos, "unable to open '%s'", filename);

-- 

Ryan Anderson
  sometimes Pug Majere

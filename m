Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbTB0GkI>; Thu, 27 Feb 2003 01:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261375AbTB0GkI>; Thu, 27 Feb 2003 01:40:08 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:63140 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S261353AbTB0GkG>; Thu, 27 Feb 2003 01:40:06 -0500
Message-ID: <3E5DB755.20707@kegel.com>
Date: Wed, 26 Feb 2003 22:59:33 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] kernel source spellchecker
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since the main remaining feature before release of the 2.6
kernel is fixing all the remaining spelling errors,
this patch seems appropriate.  This is against 2.4 but
should apply to other versions as well.
It's not very smart, but should help get us to our
all-important goal of 100% correctly spellt kernel source.
Todo: make it ignore names from the MAINTAINERS file,
the list of signals and syscalls, and other well-known
english words seem mostly in Webster's Posix edition;
rewrite in Perl rather than C, or add real Makefile entry.
Enjoy!
- Dan

--- /dev/null	2002-08-30 16:31:37.000000000 -0700
+++ linux/scripts/spellcheck-kernel	2003-02-26 22:51:46.000000000 -0800
@@ -0,0 +1,12 @@
+#!/bin/sh
+# Script to spellcheck kernel.
+# usage: spellcheck-kernel [ sourcedir ]
+#     The source directory defaults to /usr/src/linux.
+# e.g.
+#   scripts/spellcheck-kernel .
+#      Check spelling of the kernel tree in the current directory
+
+sourcedir=${1-/usr/src/linux}
+
+make -C .. scripts/lspell
+find $sourcedir -name '*.[ch]' | xargs ./lspell
--- /dev/null	2002-08-30 16:31:37.000000000 -0700
+++ linux/scripts/lspell.c	2003-02-26 22:51:14.000000000 -0800
@@ -0,0 +1,74 @@
+/*
+ * C comment spell checker
+ * For each given source file, print the filename, then
+ * extract all comments from the file, send them through the system
+ * spellchecker, sort the list of words flagged as misspellings,
+ * and word-wrap the sorted list.
+ * Copyright 2003, Dan Kegel.  Licensed under GPL.  See the file ../COPYING for details.
+ */
+#include <stdio.h>
+int
+main(int argc, char **argv)
+{
+	int argi;
+
+	for (argi = 1; argi < argc; argi++) {
+		int c;
+		enum state_t { NONCOMMENT, SLASH, COMMENT, STAR, EOLCOMMENT };
+		enum state_t state = NONCOMMENT;
+		FILE *fp = fopen(argv[argi], "rt");
+		if (!fp) {
+			perror(argv[argi]);
+			continue;
+		}
+		FILE *pout = popen("/usr/bin/spell | sort -f | fmt", "w");
+		if (!pout) {
+			perror("/usr/bin/spell | sort -f | fmt");
+			exit(1);
+		}
+		printf("\n%s:\n", argv[argi]);
+		fflush(stdout);
+		while ((c = getc(fp)) != EOF) {
+			switch (state) {
+			case NONCOMMENT:
+				if (c == '/')
+					state = SLASH;
+				break;
+			case SLASH:
+				if (c == '*')
+					state = COMMENT;
+				else if (c == '/')
+					state = EOLCOMMENT;
+				else {
+					state = NONCOMMENT;
+				}
+				break;
+			case COMMENT:
+				if (c == '*')
+					state = STAR;
+				else
+					fputc(c, pout);
+				break;
+			case STAR:
+				if (c == '/')
+					state = NONCOMMENT;
+				else {
+					if (c != '*') {
+						fputc('\n', pout);
+						state = COMMENT;
+					}
+				}
+				break;
+			case EOLCOMMENT:
+				if (c == '\n')
+					state = NONCOMMENT;
+				else
+					fputc(c, pout);
+				break;
+			}
+		}
+		fclose(pout);
+		fclose(fp);
+	}
+	exit(0);
+}

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267932AbUH0V5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267932AbUH0V5t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 17:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267610AbUH0Vy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 17:54:57 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:17150 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264213AbUH0VxS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 17:53:18 -0400
From: trini@kernel.crashing.org
Message-Id: <200408272153.OAA28845@av.mvista.com>
Subject: [patch 2/3] 
To: sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org, jdubois@mc.com
Date: Fri, 27 Aug 2004 14:53:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use getopt_long() or getopt(), depending on the host

From: Jean-Christophe Dubois <jdubois@mc.com>.

We do not always have GNU getopt_long(), so when we don't, just use
getopt() and the short options.  We do this based on __GNU_LIBRARY__
being set, or not.  Originally from Jean-Christophe Dubois <jdubois@mc.com>.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>
---

 Makefile                                            |    0 
 linux-2.6-solaris-trini/scripts/genksyms/genksyms.c |   15 +++++++++++++++
 2 files changed, 15 insertions(+)

diff -puN scripts/genksyms/genksyms.c~getopt scripts/genksyms/genksyms.c
--- linux-2.6-solaris/scripts/genksyms/genksyms.c~getopt	2004-08-27 14:47:06.411222247 -0700
+++ linux-2.6-solaris-trini/scripts/genksyms/genksyms.c	2004-08-27 14:47:06.417220855 -0700
@@ -27,7 +27,9 @@
 #include <unistd.h>
 #include <assert.h>
 #include <stdarg.h>
+#ifdef __GNU_LIBRARY__
 #include <getopt.h>
+#endif /* __GNU_LIBRARY__ */
 
 #include "genksyms.h"
 
@@ -502,12 +504,21 @@ void genksyms_usage(void)
 	fputs("Usage:\n"
 	      "genksyms [-dDwqhV] > /path/to/.tmp_obj.ver\n"
 	      "\n"
+#ifdef __GNU_LIBRARY__
 	      "  -d, --debug           Increment the debug level (repeatable)\n"
 	      "  -D, --dump            Dump expanded symbol defs (for debugging only)\n"
 	      "  -w, --warnings        Enable warnings\n"
 	      "  -q, --quiet           Disable warnings (default)\n"
 	      "  -h, --help            Print this message\n"
 	      "  -V, --version         Print the release version\n"
+#else  /* __GNU_LIBRARY__ */
+             "  -d                    Increment the debug level (repeatable)\n"
+             "  -D                    Dump expanded symbol defs (for debugging only)\n"
+             "  -w                    Enable warnings\n"
+             "  -q                    Disable warnings (default)\n"
+             "  -h                    Print this message\n"
+             "  -V                    Print the release version\n"
+#endif /* __GNU_LIBRARY__ */
 	      , stderr);
 }
 
@@ -516,6 +527,7 @@ main(int argc, char **argv)
 {
   int o;
 
+#ifdef __GNU_LIBRARY__
   struct option long_opts[] = {
     {"debug", 0, 0, 'd'},
     {"warnings", 0, 0, 'w'},
@@ -528,6 +540,9 @@ main(int argc, char **argv)
 
   while ((o = getopt_long(argc, argv, "dwqVDk:p:",
 			  &long_opts[0], NULL)) != EOF)
+#else  /* __GNU_LIBRARY__ */
+  while ((o = getopt(argc, argv, "dwqVDk:p:")) != EOF)
+#endif /* __GNU_LIBRARY__ */
     switch (o)
       {
       case 'd':
diff -L shell_commands -puN /dev/null /dev/null
diff -puN Makefile~getopt Makefile
_

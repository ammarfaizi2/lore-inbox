Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264701AbUGIVA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264701AbUGIVA0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 17:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264850AbUGIVA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 17:00:26 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:16357 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S264701AbUGIVAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 17:00:12 -0400
Date: Fri, 9 Jul 2004 14:00:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix building on Solaris (and don't break Cygwin)
Message-ID: <20040709210011.GG28002@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is from Jean-Christophe Dubois <jdubois@mc.com>.  On
Solaris 2.8, <stdint.h> does not exist, but <inttypes.h> does.  However,
on cygwin (the other odd place that the kernel is compiled on)
<inttypes.h> doesn't exist.  So we end up with something like the
following.
Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- linux-2.6.7/scripts/sumversion.c    Wed Jun 16 01:19:43 2004
+++ 2.6/scripts/sumversion.c    Fri Jul  9 04:10:27 2004
@@ -1,5 +1,9 @@
 #include <netinet/in.h>
+#ifdef __sun__
+#include <inttypes.h>
+#else // __sun__
 #include <stdint.h>
+#endif // __sun__
 #include <ctype.h>
 #include <errno.h>
 #include <string.h>
--- linux-2.6.7/scripts/genksyms/genksyms.c     Wed Jun 16 01:19:23 2004
+++ 2.6/scripts/genksyms/genksyms.c     Thu Jul  8 11:04:04 2004
@@ -27,7 +27,9 @@
 #include <unistd.h>
 #include <assert.h>
 #include <stdarg.h>
+#ifdef __GNU_LIBRARY__
 #include <getopt.h>
+#endif /* __GNU_LIBRARY__ */
 
 #include "genksyms.h"
 
@@ -502,12 +504,21 @@
        fputs("Usage:\n"
              "genksyms [-dDwqhV] > /path/to/.tmp_obj.ver\n"
              "\n"
+#ifdef __GNU_LIBRARY__
              "  -d, --debug           Increment the debug level
(repeatable)\n"
              "  -D, --dump            Dump expanded symbol defs (for
debugging only)\n"
              "  -w, --warnings        Enable warnings\n"
              "  -q, --quiet           Disable warnings (default)\n"
              "  -h, --help            Print this message\n"
              "  -V, --version         Print the release version\n"
+#else  /* __GNU_LIBRARY__ */
+             "  -d                    Increment the debug level
(repeatable)\n"
+             "  -D                    Dump expanded symbol defs (for
debugging only)\n"
+             "  -w                    Enable warnings\n"
+             "  -q                    Disable warnings (default)\n"
+             "  -h                    Print this message\n"
+             "  -V                    Print the release version\n"
+#endif /* __GNU_LIBRARY__ */
              , stderr);
 }
 
@@ -516,6 +527,7 @@
 {
   int o;
 
+#ifdef __GNU_LIBRARY__
   struct option long_opts[] = {
     {"debug", 0, 0, 'd'},
     {"warnings", 0, 0, 'w'},
@@ -528,6 +540,9 @@
 
   while ((o = getopt_long(argc, argv, "dwqVDk:p:",
                          &long_opts[0], NULL)) != EOF)
+#else  /* __GNU_LIBRARY__ */
+  while ((o = getopt(argc, argv, "dwqVDk:p:")) != EOF)
+#endif /* __GNU_LIBRARY__ */
     switch (o)
       {
       case 'd':
--- linux-2.6.7/arch/ppc/boot/utils/mkbugboot.c Wed Jun 16 01:19:36 2004
+++ 2.6/arch/ppc/boot/utils/mkbugboot.c Fri Jul  9 04:11:43 2004
@@ -21,6 +21,11 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <fcntl.h>
+#ifdef __sun__
+#include <inttypes.h>
+#else // __sun__
+#include <stdint.h>
+#endif // __sun__
 
 #ifdef __i386__
 #define cpu_to_be32(x) le32_to_cpu(x)
@@ -48,11 +53,6 @@
 
 /* size of read buffer */
 #define SIZE 0x1000
-
-/* typedef long int32_t; */
-typedef unsigned long uint32_t;
-typedef unsigned short uint16_t;
-typedef unsigned char uint8_t;
 
 /* PPCBUG ROM boot header */
 typedef struct bug_boot_header {

-- 
Tom Rini
http://gate.crashing.org/~trini/

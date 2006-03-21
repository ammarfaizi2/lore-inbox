Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030439AbWCUQVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030439AbWCUQVf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbWCUQVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:21:32 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:31244 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030311AbWCUQVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:13 -0500
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 39/46] kbuild: fix genksyms build error
In-Reply-To: <11429580572017-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:57 +0100
Message-Id: <1142958057756-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

genksyms needs to know when a symbol must have a "_" prefex as is
true for a few architectures.
Pass $(ARCH) as commandline argument and hardcode what architectures that
needs this info.
Previous attemt to take it from elfconfig.h was br0ken since elfconfig.h
is a generated file.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/Makefile.build      |    2 +-
 scripts/genksyms/genksyms.c |   17 ++++++++++++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

c79c7b0923ff353d12194e83628bcca5a8606564
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 7afe3e7..19ef2bc 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -166,7 +166,7 @@ cmd_cc_o_c = $(CC) $(c_flags) -c -o $(@D
 cmd_modversions =							\
 	if $(OBJDUMP) -h $(@D)/.tmp_$(@F) | grep -q __ksymtab; then	\
 		$(CPP) -D__GENKSYMS__ $(c_flags) $<			\
-		| $(GENKSYMS)						\
+		| $(GENKSYMS) -a $(ARCH)				\
 		> $(@D)/.tmp_$(@F:.o=.ver);				\
 									\
 		$(LD) $(LDFLAGS) -r -o $@ $(@D)/.tmp_$(@F) 		\
diff --git a/scripts/genksyms/genksyms.c b/scripts/genksyms/genksyms.c
index ef8822e..da8ff4f 100644
--- a/scripts/genksyms/genksyms.c
+++ b/scripts/genksyms/genksyms.c
@@ -32,7 +32,6 @@
 #endif /* __GNU_LIBRARY__ */
 
 #include "genksyms.h"
-#include "../mod/elfconfig.h"
 /*----------------------------------------------------------------------*/
 
 #define HASH_BUCKETS  4096
@@ -44,6 +43,8 @@ int cur_line = 1;
 char *cur_filename, *output_directory;
 
 int flag_debug, flag_dump_defs, flag_warnings;
+const char *arch = "";
+const char *mod_prefix = "";
 
 static int errors;
 static int nsyms;
@@ -458,7 +459,7 @@ export_symbol(const char *name)
 	fputs(">\n", debugfile);
 
       /* Used as a linker script. */
-      printf("%s__crc_%s = 0x%08lx ;\n", MODULE_SYMBOL_PREFIX, name, crc);
+      printf("%s__crc_%s = 0x%08lx ;\n", mod_prefix, name, crc);
     }
 }
 
@@ -529,6 +530,7 @@ main(int argc, char **argv)
 
 #ifdef __GNU_LIBRARY__
   struct option long_opts[] = {
+    {"arch", 1, 0, 'a'},
     {"debug", 0, 0, 'd'},
     {"warnings", 0, 0, 'w'},
     {"quiet", 0, 0, 'q'},
@@ -538,13 +540,16 @@ main(int argc, char **argv)
     {0, 0, 0, 0}
   };
 
-  while ((o = getopt_long(argc, argv, "dwqVDk:p:",
+  while ((o = getopt_long(argc, argv, "a:dwqVDk:p:",
 			  &long_opts[0], NULL)) != EOF)
 #else  /* __GNU_LIBRARY__ */
-  while ((o = getopt(argc, argv, "dwqVDk:p:")) != EOF)
+  while ((o = getopt(argc, argv, "a:dwqVDk:p:")) != EOF)
 #endif /* __GNU_LIBRARY__ */
     switch (o)
       {
+      case 'a':
+	arch = optarg;
+	break;
       case 'd':
 	flag_debug++;
 	break;
@@ -567,7 +572,9 @@ main(int argc, char **argv)
 	genksyms_usage();
 	return 1;
       }
-
+    if ((strcmp(arch, "v850") == 0) ||
+        (strcmp(arch, "h8300") == 0))
+      mod_prefix = "_";
     {
       extern int yydebug;
       extern int yy_flex_debug;
-- 
1.0.GIT



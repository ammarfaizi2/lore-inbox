Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWCLOaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWCLOaF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 09:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWCLOaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 09:30:05 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:9992 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750758AbWCLOaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 09:30:04 -0500
Date: Sun, 12 Mar 2006 15:29:41 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: fix genksyms build error
Message-ID: <20060312142941.GA26471@mars.ravnborg.org>
References: <20060312031036.3a382581.akpm@osdl.org> <200603121416.26583.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603121416.26583.rjw@sisk.pl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2006 at 02:16:26PM +0100, Rafael J. Wysocki wrote:
> On Sunday 12 March 2006 12:10, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm1/
> 
> Doesn't compile for me:
> 
> rafael@albercik:~/src/mm/linux-2.6.16-rc6-mm1> make
>   CHK     include/linux/version.h
>   SPLIT   include/linux/autoconf.h -> include/config/*
>   HOSTCC  scripts/genksyms/genksyms.o
> scripts/genksyms/genksyms.c:35:30: error: ../mod/elfconfig.h: No such file or directory
It a stupid dependency on a generated file.
The file only gets generated upon a successfull 'make modules', whereas
genksyms is used for every file compiled as a module.
The workaround is to do:
disable CONFIG_MODVERSIONS
make modules
enable CONFIG_MODVERSIONS
make

We could eventually fetch definition from <asm/module.h> but that seems
to drag all other stuff in.
So fix is instead to hardcode the check for the two relevant
architectures direct in genksyms.

Is genksyms used outside the kernel?

	Sam


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

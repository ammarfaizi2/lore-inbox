Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265816AbSKKQ7k>; Mon, 11 Nov 2002 11:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265825AbSKKQ7k>; Mon, 11 Nov 2002 11:59:40 -0500
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:58565 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S265816AbSKKQ7W>; Mon, 11 Nov 2002 11:59:22 -0500
Date: Mon, 11 Nov 2002 10:06:04 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: [PATCH] Have split-include take another argument
Message-ID: <20021111170604.GA658@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  The following patch makes split-include take another argument,
which is the prefix of what is being split up.  This is needed since I'm
working on a system which will allow for various params in the kernel to
be tweaked at compile-time, without offering numerous CONFIG options
(see http://marc.theaimsgroup.com/?l=linux-kernel&m=103669658505842&w=2).
I'm sending this out for two reasons.  First, does anyone see any
problems with the patch itself?  Second, Kai, would you be willing to
apply this patch now, or would should I wait until the system is ready?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== Makefile 1.320 vs edited =====
--- 1.320/Makefile	Mon Nov 11 08:08:41 2002
+++ edited/Makefile	Mon Nov 11 09:30:45 2002
@@ -413,7 +413,7 @@
 
 include/config/MARKER: scripts/split-include include/linux/autoconf.h
 	@echo '  SPLIT  include/linux/autoconf.h -> include/config/*'
-	@scripts/split-include include/linux/autoconf.h include/config
+	@scripts/split-include include/linux/autoconf.h include/config CONFIG_
 	@touch $@
 
 # 	if .config is newer than include/linux/autoconf.h, someone tinkered
===== scripts/split-include.c 1.3 vs edited =====
--- 1.3/scripts/split-include.c	Sun Jun  2 18:34:13 2002
+++ edited/scripts/split-include.c	Mon Nov 11 09:29:55 2002
@@ -46,6 +46,7 @@
     const char * str_my_name;
     const char * str_file_autoconf;
     const char * str_dir_config;
+    const char * str_split_token;
 
     FILE * fp_config;
     FILE * fp_target;
@@ -61,7 +62,7 @@
     struct stat stat_buf;
 
     /* Check arg count. */
-    if (argc != 3)
+    if (argc != 4)
     {
 	fprintf(stderr, "%s: wrong number of arguments.\n", argv[0]);
 	exit(1);
@@ -70,6 +71,7 @@
     str_my_name       = argv[0];
     str_file_autoconf = argv[1];
     str_dir_config    = argv[2];
+    str_split_token   = argv[3];
 
     /* Find a buffer size. */
     if (stat(str_file_autoconf, &stat_buf) != 0)
@@ -110,11 +112,11 @@
 
 	if (line[0] != '#')
 	    continue;
-	if ((str_config = strstr(line, "CONFIG_")) == NULL)
+	if ((str_config = strstr(line, str_split_token)) == NULL)
 	    continue;
 
 	/* Make the output file name. */
-	str_config += sizeof("CONFIG_") - 1;
+	str_config += strlen(str_split_token);
 	for (itarget = 0; !isspace(str_config[itarget]); itarget++)
 	{
 	    int c = (unsigned char) str_config[itarget];

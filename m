Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266870AbUHOUNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266870AbUHOUNJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 16:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266874AbUHOUNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 16:13:09 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:39991 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S266870AbUHOUMj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 16:12:39 -0400
Date: Sun, 15 Aug 2004 22:15:13 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: kbuild: bogus has no CRC warning
Message-ID: <20040815201513.GA14133@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040815201224.GI7682@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040815201224.GI7682@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/15 11:54:27+02:00 sam@mars.ravnborg.org 
#   kbuild: Bogus "has no CRC" in external module builds
#   
#   From: Pavel Roskin <proski@gnu.org>
#   The recent fixes for the external module build have fixed the major
#   breakage, but they left one annoyance unfixed.  If CONFIG_MODVERSIONS is
#   disabled, a warning is printed for every exported symbol that is has no
#   CRC.  For instance, I see this when compiling the standalone Orinoco
#   driver on Linux 2.6.6-rc3:
#   
#   *** Warning: "__orinoco_down" [/usr/local/src/orinoco/spectrum_cs.ko] has
#   no CRC!
#   *** Warning: "hermes_struct_init" [/usr/local/src/orinoco/spectrum_cs.ko]
#   has no CRC!
#   *** Warning: "free_orinocodev" [/usr/local/src/orinoco/spectrum_cs.ko] has
#   no CRC!
#   [further warnings skipped]
#   
#   I have found that the "-i" option for modpost is used for external builds,
#   whereas the internal modules use "-o".  The "-i" option causes read_dump()
#   in modpost.c to be called.  This function sets "modversions" variable
#   under some conditions that I don't understand.  The comment before the
#   modversions declarations says: "Are we using CONFIG_MODVERSIONS?"
#   
#   Apparently modpost fails to answer this question.  I think it's better to
#   use an explicit option rather than a kludge.
#   
#   The attached patch adds a new option "-m" that is specified if and only if
#   CONFIG_MODVERSIONS is enabled.  The patch has been successfully tested
#   both with and without CONFIG_MODVERSIONS.
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# scripts/mod/modpost.c
#   2004/08/15 11:54:12+02:00 sam@mars.ravnborg.org +4 -3
#   Do not try to guess modversions - use -m option
# 
# scripts/Makefile.modpost
#   2004/08/15 11:54:12+02:00 sam@mars.ravnborg.org +2 -1
#   Pass -m option to modpost if CONFIG_MODVERSIONS
# 
diff -Nru a/scripts/Makefile.modpost b/scripts/Makefile.modpost
--- a/scripts/Makefile.modpost	2004-08-15 22:14:34 +02:00
+++ b/scripts/Makefile.modpost	2004-08-15 22:14:34 +02:00
@@ -50,7 +50,8 @@
 # Step 2), invoke modpost
 #  Includes step 3,4
 quiet_cmd_modpost = MODPOST
-      cmd_modpost = scripts/mod/modpost \
+      cmd_modpost = scripts/mod/modpost            \
+        $(if $(CONFIG_MODVERSIONS),-m)             \
 	$(if $(KBUILD_EXTMOD),-i,-o) $(symverfile) \
 	$(filter-out FORCE,$^)
 
diff -Nru a/scripts/mod/modpost.c b/scripts/mod/modpost.c
--- a/scripts/mod/modpost.c	2004-08-15 22:14:34 +02:00
+++ b/scripts/mod/modpost.c	2004-08-15 22:14:34 +02:00
@@ -343,7 +343,6 @@
 			crc = (unsigned int) sym->st_value;
 			add_exported_symbol(symname + strlen(CRC_PFX),
 					    mod, &crc);
-			modversions = 1;
 		}
 		break;
 	case SHN_UNDEF:
@@ -649,7 +648,6 @@
 
 		if (!(mod = find_module(modname))) {
 			if (is_vmlinux(modname)) {
-				modversions = 1;
 				have_vmlinux = 1;
 			}
 			mod = new_module(NOFAIL(strdup(modname)));
@@ -696,10 +694,13 @@
 	char *dump_read = NULL, *dump_write = NULL;
 	int opt;
 
-	while ((opt = getopt(argc, argv, "i:o:")) != -1) {
+	while ((opt = getopt(argc, argv, "i:mo:")) != -1) {
 		switch(opt) {
 			case 'i':
 				dump_read = optarg;
+				break;
+			case 'm':
+				modversions = 1;
 				break;
 			case 'o':
 				dump_write = optarg;

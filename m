Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267292AbUHDGNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267292AbUHDGNf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 02:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267272AbUHDGMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 02:12:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:48286 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267292AbUHDGHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 02:07:35 -0400
Date: Tue, 3 Aug 2004 22:57:53 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: sam@ravnborg.org, zippel@linux-m68k.org
Subject: [PATCH] save kernel version in .config file
Message-Id: <20040803225753.15220897.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(from June/2004 email thread:
http://marc.theaimsgroup.com/?t=108753573200001&r=1&w=2
)

Several people found this useful, none opposed (afaik).

Saves kernel version in .config file, e.g.:

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.8-rc3
# Tue Aug  3 22:55:57 2004
#

Please merge.
---

Save kernel version info and date when writing .config file.
Tested with 'make {menuconfig|xconfig|gconfig}'.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


diffstat:=
 scripts/kconfig/confdata.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff -Naurp ./scripts/kconfig/confdata.c~config_version ./scripts/kconfig/confdata.c
--- ./scripts/kconfig/confdata.c~config_version	2004-06-15 22:20:21.000000000 -0700
+++ ./scripts/kconfig/confdata.c	2004-06-19 21:14:24.000000000 -0700
@@ -8,6 +8,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <time.h>
 #include <unistd.h>
 
 #define LKC_DIRECT_LINK
@@ -268,6 +269,7 @@ int conf_write(const char *name)
 	char dirname[128], tmpname[128], newname[128];
 	int type, l;
 	const char *str;
+	time_t now;
 
 	dirname[0] = 0;
 	if (name && name[0]) {
@@ -301,14 +303,25 @@ int conf_write(const char *name)
 		if (!out_h)
 			return 1;
 	}
+	sym = sym_lookup("KERNELRELEASE", 0);
+	sym_calc_value(sym);
+	time(&now);
 	fprintf(out, "#\n"
 		     "# Automatically generated make config: don't edit\n"
-		     "#\n");
+		     "# Linux kernel version: %s\n"
+		     "# %s"
+		     "#\n",
+		     sym_get_string_value(sym),
+		     ctime(&now));
 	if (out_h)
 		fprintf(out_h, "/*\n"
 			       " * Automatically generated C config: don't edit\n"
+			       " * Linux kernel version: %s\n"
+			       " * %s"
 			       " */\n"
-			       "#define AUTOCONF_INCLUDED\n");
+			       "#define AUTOCONF_INCLUDED\n",
+			       sym_get_string_value(sym),
+			       ctime(&now));
 
 	if (!sym_change_count)
 		sym_clear_all_valid();



--

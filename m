Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263847AbUFTEwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263847AbUFTEwz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 00:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbUFTEwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 00:52:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:4538 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263847AbUFTEwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 00:52:51 -0400
Date: Sat, 19 Jun 2004 21:47:40 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH] save kernel version in .config file
Message-Id: <20040619214740.6490fc22.rddunlap@osdl.org>
In-Reply-To: <20040619040717.GA32209@alpha.home.local>
References: <20040617220651.0ceafa91.rddunlap@osdl.org>
	<20040618053455.GF29808@alpha.home.local>
	<20040618205602.GC4441@mars.ravnborg.org>
	<20040618150535.6a421bdb.rddunlap@osdl.org>
	<20040619040717.GA32209@alpha.home.local>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jun 2004 06:07:17 +0200 Willy Tarreau wrote:

| On Fri, Jun 18, 2004 at 03:05:35PM -0700, Randy.Dunlap wrote:
|  
| > OK, I've added date, based on Sam's comments, but someone tell me,
| > when/why does filesystem-timestamp not work for this?

and then Roman made some very good comments about looking up and
printing symbol values and testing with xconfig and gconfig.
Thanks, Roman.

Having done all of that successfully, here is the updated patch for
2.6.7.



Save kernel version info and date when writing .config file.

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

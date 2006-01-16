Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWAPMRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWAPMRH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 07:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWAPMRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 07:17:06 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:24370 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750740AbWAPMRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 07:17:05 -0500
Date: Mon, 16 Jan 2006 21:17:07 +0900
To: ak@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] makes print_symbol() return int
Message-ID: <20060116121706.GB539@miraclelinux.com>
References: <20060116121611.GA539@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060116121611.GA539@miraclelinux.com>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes print_symbol() return the number of characters printed.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
----
 include/linux/kallsyms.h |   17 ++++++++++-------
 kernel/kallsyms.c        |    4 ++--
 2 files changed, 12 insertions(+), 9 deletions(-)

--- 2.6-git.orig/include/linux/kallsyms.h	2006-01-03 12:21:10.000000000 +0900
+++ 2.6-git/include/linux/kallsyms.h	2006-01-11 14:02:57.578291640 +0900
@@ -20,7 +20,7 @@ const char *kallsyms_lookup(unsigned lon
 			    char **modname, char *namebuf);
 
 /* Replace "%s" in format with address, if found */
-extern void __print_symbol(const char *fmt, unsigned long address);
+extern int __print_symbol(const char *fmt, unsigned long address);
 
 #else /* !CONFIG_KALLSYMS */
 
@@ -38,7 +38,10 @@ static inline const char *kallsyms_looku
 }
 
 /* Stupid that this does nothing, but I didn't create this mess. */
-#define __print_symbol(fmt, addr)
+static inline int __print_symbol(const char *fmt, unsigned long addr)
+{
+	return 0;
+}
 #endif /*CONFIG_KALLSYMS*/
 
 /* This macro allows us to keep printk typechecking */
@@ -58,10 +61,10 @@ do {						\
 #define print_fn_descriptor_symbol(fmt, addr) print_symbol(fmt, addr)
 #endif
 
-#define print_symbol(fmt, addr)			\
-do {						\
-	__check_printsym_format(fmt, "");	\
-	__print_symbol(fmt, addr);		\
-} while(0)
+static inline int print_symbol(const char *fmt, unsigned long addr)
+{
+	__check_printsym_format(fmt, "");
+	return __print_symbol(fmt, addr);
+}
 
 #endif /*_LINUX_KALLSYMS_H*/
--- 2.6-git.orig/kernel/kallsyms.c	2006-01-03 12:21:10.000000000 +0900
+++ 2.6-git/kernel/kallsyms.c	2006-01-11 13:45:13.056123608 +0900
@@ -231,7 +231,7 @@ const char *kallsyms_lookup(unsigned lon
 }
 
 /* Replace "%s" in format with address, or returns -errno. */
-void __print_symbol(const char *fmt, unsigned long address)
+int __print_symbol(const char *fmt, unsigned long address)
 {
 	char *modname;
 	const char *name;
@@ -251,7 +251,7 @@ void __print_symbol(const char *fmt, uns
 		else
 			sprintf(buffer, "%s+%#lx/%#lx", name, offset, size);
 	}
-	printk(fmt, buffer);
+	return printk(fmt, buffer);
 }
 
 /* To avoid using get_symbol_offset for every symbol, we carry prefix along. */

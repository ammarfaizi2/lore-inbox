Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWAPMSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWAPMSA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 07:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750700AbWAPMSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 07:18:00 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:27698 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750718AbWAPMR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 07:17:59 -0500
Date: Mon, 16 Jan 2006 21:18:01 +0900
To: ak@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] use usual call trace format on x86-64
Message-ID: <20060116121800.GC539@miraclelinux.com>
References: <20060116121611.GA539@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060116121611.GA539@miraclelinux.com>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use print_symbol() to dump call trace.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
----
 traps.c |   29 +++++++----------------------
 1 files changed, 7 insertions(+), 22 deletions(-)

--- 2.6-mm/arch/x86_64/kernel/traps.c.orig	2006-01-08 00:49:46.000000000 +0900
+++ 2.6-mm/arch/x86_64/kernel/traps.c	2006-01-08 00:54:07.000000000 +0900
@@ -30,6 +30,7 @@
 #include <linux/moduleparam.h>
 #include <linux/nmi.h>
 #include <linux/kprobes.h>
+#include <linux/kallsyms.h> 
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -93,30 +94,14 @@ static inline void conditional_sti(struc
 
 static int kstack_depth_to_print = 10;
 
-#ifdef CONFIG_KALLSYMS
-#include <linux/kallsyms.h> 
-int printk_address(unsigned long address)
-{ 
-	unsigned long offset = 0, symsize;
-	const char *symname;
-	char *modname;
-	char *delim = ":"; 
-	char namebuf[128];
-
-	symname = kallsyms_lookup(address, &symsize, &offset, &modname, namebuf); 
-	if (!symname) 
-		return printk("[<%016lx>]", address);
-	if (!modname) 
-		modname = delim = ""; 		
-        return printk("<%016lx>{%s%s%s%s%+ld}",
-		      address,delim,modname,delim,symname,offset); 
-} 
-#else
 int printk_address(unsigned long address)
 { 
-	return printk("[<%016lx>]", address);
-} 
-#endif
+	int len;
+
+	len = printk("[<%016lx>]", address);
+	len += print_symbol(" %s", address);
+	return len;
+}
 
 static unsigned long *in_exception_stack(unsigned cpu, unsigned long stack,
 					unsigned *usedp, const char **idp)

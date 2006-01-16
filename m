Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWAPNle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWAPNle (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 08:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWAPNld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 08:41:33 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:24120 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750703AbWAPNld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 08:41:33 -0500
Date: Mon, 16 Jan 2006 22:41:36 +0900
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] changes about Call Trace:
Message-ID: <20060116134136.GB6707@miraclelinux.com>
References: <20060116121611.GA539@miraclelinux.com> <200601161322.12209.ak@suse.de> <20060116134109.GA6707@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060116134109.GA6707@miraclelinux.com>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use print_symbol() to dump call trace.
Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

--- 2.6-git/arch/x86_64/kernel/traps.c.orig	2006-01-16 22:05:38.000000000 +0900
+++ 2.6-git/arch/x86_64/kernel/traps.c	2006-01-16 22:07:36.000000000 +0900
@@ -30,6 +30,7 @@
 #include <linux/moduleparam.h>
 #include <linux/nmi.h>
 #include <linux/kprobes.h>
+#include <linux/kallsyms.h> 
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -92,30 +93,14 @@ static inline void conditional_sti(struc
 
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
+	len = printk("<%016lx>", address);
+	len += print_symbol(" %s", address);
+	return len;
+}
 
 static unsigned long *in_exception_stack(unsigned cpu, unsigned long stack,
 					unsigned *usedp, const char **idp)

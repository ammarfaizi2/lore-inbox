Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWAQKPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWAQKPL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 05:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbWAQKPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 05:15:11 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:60613 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932378AbWAQKPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 05:15:10 -0500
Date: Tue, 17 Jan 2006 19:15:13 +0900
To: ak@suse.de, linux-kernel@vger.kernel.org
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Christoph Hellwig <hch@infradead.org>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: [PATCH 2/4] x86-64: Use print_symbol() to dump call trace
Message-ID: <20060117101513.GC19473@miraclelinux.com>
References: <20060117101339.GA19473@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060117101339.GA19473@miraclelinux.com>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use print_symbol() to dump call trace on x86-64.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
----

 traps.c |   29 +++++++----------------------
 1 files changed, 7 insertions(+), 22 deletions(-)

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

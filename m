Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbUKDVKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbUKDVKB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 16:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbUKDVGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 16:06:38 -0500
Received: from cantor.suse.de ([195.135.220.2]:39059 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262443AbUKDVFw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 16:05:52 -0500
Date: Thu, 4 Nov 2004 22:05:47 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: fix initcall_debug on ppc64/ia64
Message-ID: <20041104210547.GA16238@suse.de>
References: <20041102195130.GA13589@suse.de> <20041103152628.19753cf2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041103152628.19753cf2.akpm@osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Nov 03, Andrew Morton wrote:

> Olaf Hering <olh@suse.de> wrote:
> >
> > Is a patch like that acceptable (for mainline)? Currently only the
> > descriptor is printed, not the function itself. Another redirection is
> > needed.
> 
> Is this acked by Paul and Anton?  If so, I'll replace __powerpc64__ with
> CONFIG_PPC64 and run with it.


I guess we need something like this.
Just where to put it, how to name it and how to handle ia64:


diff -purNx tags linux-2.6.9/include/linux/kallsyms.h linux-2.6.10-rc1-bk14.initcall_debug/include/linux/kallsyms.h
--- linux-2.6.9/include/linux/kallsyms.h	2004-10-18 23:53:06.000000000 +0200
+++ linux-2.6.10-rc1-bk14.initcall_debug/include/linux/kallsyms.h	2004-11-04 21:37:19.789304911 +0100
@@ -47,6 +47,15 @@ __attribute__((format(printf,1,2)));
 static inline void __check_printsym_format(const char *fmt, ...)
 {
 }
+#ifdef CONFIG_PPC64
+#define print_foo_symbol(fmt, addr)		\
+do {						\
+	unsigned long *__pfs = (unsigned long*) addr;		\
+	print_symbol(fmt, __pfs[0]);		\
+} while (0)
+#else
+#define print_foo_symbol(fmt, addr) print_symbol(fmt, addr)
+#endif
 
 #define print_symbol(fmt, addr)			\
 do {						\
diff -purNx tags linux-2.6.9/init/main.c linux-2.6.10-rc1-bk14.initcall_debug/init/main.c
--- linux-2.6.9/init/main.c	2004-11-04 21:01:04.878455673 +0100
+++ linux-2.6.10-rc1-bk14.initcall_debug/init/main.c	2004-11-04 21:08:01.191792667 +0100
@@ -604,7 +604,7 @@ static void __init do_initcalls(void)
 
 		if (initcall_debug) {
 			printk(KERN_DEBUG "Calling initcall 0x%p", *call);
-			print_symbol(": %s()", (unsigned long) *call);
+			print_foo_symbol(": %s()", (unsigned long) *call);
 			printk("\n");
 		}
 

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

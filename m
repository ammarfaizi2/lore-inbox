Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262672AbUKEM71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbUKEM71 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 07:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbUKEM71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 07:59:27 -0500
Received: from cantor.suse.de ([195.135.220.2]:32997 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262666AbUKEM7G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 07:59:06 -0500
Date: Fri, 5 Nov 2004 13:49:22 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix initcall_debug on ppc64/ia64
Message-ID: <20041105124922.GA25239@suse.de>
References: <20041102195130.GA13589@suse.de> <20041103152628.19753cf2.akpm@osdl.org> <20041104210547.GA16238@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041104210547.GA16238@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ia64 and ppc64 have function descriptors.
Booting with initcall_debug will print the descriptor address, not the
address and name of the actual function. Another redirection is
required.

Tested on ppc, ppc64 and ia64.

Signed-off-by: Olaf Hering <olh@suse.de>

diff -purNx tags linux-2.6.9/include/linux/kallsyms.h linux-2.6.10-rc1-bk14.initcall_debug/include/linux/kallsyms.h
--- linux-2.6.9/include/linux/kallsyms.h	2004-10-18 23:53:06.000000000 +0200
+++ linux-2.6.10-rc1-bk14.initcall_debug/include/linux/kallsyms.h	2004-11-05 10:27:48.722687802 +0100
@@ -47,6 +47,16 @@ __attribute__((format(printf,1,2)));
 static inline void __check_printsym_format(const char *fmt, ...)
 {
 }
+/* ia64 and ppc64 use function descriptors, which contain the real address */
+#if defined(CONFIG_IA64) || defined(CONFIG_PPC64)
+#define print_fn_descriptor_symbol(fmt, addr)		\
+do {						\
+	unsigned long *__faddr = (unsigned long*) addr;		\
+	print_symbol(fmt, __faddr[0]);		\
+} while (0)
+#else
+#define print_fn_descriptor_symbol(fmt, addr) print_symbol(fmt, addr)
+#endif
 
 #define print_symbol(fmt, addr)			\
 do {						\
diff -purNx tags linux-2.6.9/init/main.c linux-2.6.10-rc1-bk14.initcall_debug/init/main.c
--- linux-2.6.9/init/main.c	2004-11-04 21:01:04.000000000 +0100
+++ linux-2.6.10-rc1-bk14.initcall_debug/init/main.c	2004-11-05 10:19:32.254301065 +0100
@@ -604,7 +604,7 @@ static void __init do_initcalls(void)
 
 		if (initcall_debug) {
 			printk(KERN_DEBUG "Calling initcall 0x%p", *call);
-			print_symbol(": %s()", (unsigned long) *call);
+			print_fn_descriptor_symbol(": %s()", (unsigned long) *call);
 			printk("\n");
 		}
 
-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

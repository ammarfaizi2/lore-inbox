Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288146AbSAMVlx>; Sun, 13 Jan 2002 16:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288159AbSAMVlo>; Sun, 13 Jan 2002 16:41:44 -0500
Received: from petasus.iil.intel.com ([192.198.152.69]:48373 "EHLO
	petasus.iil.intel.com") by vger.kernel.org with ESMTP
	id <S288146AbSAMVlj>; Sun, 13 Jan 2002 16:41:39 -0500
Message-ID: <3C41FEF0.2010402@intel.com>
Date: Sun, 13 Jan 2002 23:41:04 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Organization: Intel
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: __FUNCTION__ - for /arch/mips
Content-Type: multipart/mixed;
 boundary="------------070706030603020602000809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070706030603020602000809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
patch attached fixes __FUNCTION__ concatenation for mips arch. No side 
effects. Patch against 2.4.18-pre3.


--------------070706030603020602000809
Content-Type: text/plain;
 name="__FUNCTION__.mips.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="__FUNCTION__.mips.patch"

diff -ur -X /home/vkondra-l/lib/dontdiff linux-2.4.18-pre3.orig/arch/mips/kernel/traps.c linux-2.4.18-pre3.patched/arch/mips/kernel/traps.c
--- linux-2.4.18-pre3.orig/arch/mips/kernel/traps.c	Sun Sep  9 20:43:01 2001
+++ linux-2.4.18-pre3.patched/arch/mips/kernel/traps.c	Fri Jan 11 23:54:42 2002
@@ -191,13 +191,13 @@
 spinlock_t die_lock;
 
 extern void __die(const char * str, struct pt_regs * regs, const char *where,
-                  unsigned long line)
+                  const char* func, unsigned long line)
 {
 	console_verbose();
 	spin_lock_irq(&die_lock);
 	printk("%s", str);
 	if (where)
-		printk(" in %s, line %ld", where, line);
+		printk(" in %s:%s, line %ld", where, (func ? : "???"), line);
 	printk(":\n");
 	show_regs(regs);
 	printk("Process %s (pid: %d, stackpage=%08lx)\n",
@@ -211,10 +211,10 @@
 }
 
 void __die_if_kernel(const char * str, struct pt_regs * regs, const char *where,
-	unsigned long line)
+	const char* func, unsigned long line)
 {
 	if (!user_mode(regs))
-		__die(str, regs, where, line);
+		__die(str, regs, where, func, line);
 }
 
 extern const struct exception_table_entry __start___dbe_table[];
diff -ur -X /home/vkondra-l/lib/dontdiff linux-2.4.18-pre3.orig/include/asm-mips/system.h linux-2.4.18-pre3.patched/include/asm-mips/system.h
--- linux-2.4.18-pre3.orig/include/asm-mips/system.h	Sun Sep  9 20:43:01 2001
+++ linux-2.4.18-pre3.patched/include/asm-mips/system.h	Sat Jan 12 00:03:07 2002
@@ -252,13 +252,13 @@
 extern void *set_except_vector(int n, void *addr);
 
 extern void __die(const char *, struct pt_regs *, const char *where,
-	unsigned long line) __attribute__((noreturn));
+	const char* func, unsigned long line) __attribute__((noreturn));
 extern void __die_if_kernel(const char *, struct pt_regs *, const char *where,
-	unsigned long line);
+	const char* func, unsigned long line);
 
 #define die(msg, regs)							\
-	__die(msg, regs, __FILE__ ":"__FUNCTION__, __LINE__)
+	__die(msg, regs, __FILE__, __FUNCTION__, __LINE__)
 #define die_if_kernel(msg, regs)					\
-	__die_if_kernel(msg, regs, __FILE__ ":"__FUNCTION__, __LINE__)
+	__die_if_kernel(msg, regs, __FILE__, __FUNCTION__, __LINE__)
 
 #endif /* _ASM_SYSTEM_H */

--------------070706030603020602000809--


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267415AbTBXSOP>; Mon, 24 Feb 2003 13:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267384AbTBXSN2>; Mon, 24 Feb 2003 13:13:28 -0500
Received: from d06lmsgate-6.uk.ibm.com ([194.196.100.252]:32937 "EHLO
	d06lmsgate-6.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S267065AbTBXSKL> convert rfc822-to-8bit; Mon, 24 Feb 2003 13:10:11 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (6/13): unified extable code.
Date: Mon, 24 Feb 2003 19:10:12 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200302241910.12035.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

update extable support in s390 and s390x

this makes use of the unified extable code.
for 31 bit s390, this is slightly more complicated
than the other architectures, but as long as 
no one outside /arch uses search_exception_tables,
everything should work nicely

diff -urN linux-2.5.62/arch/s390/kernel/traps.c linux-2.5.62-s390/arch/s390/kernel/traps.c
--- linux-2.5.62/arch/s390/kernel/traps.c	Mon Feb 17 23:56:11 2003
+++ linux-2.5.62-s390/arch/s390/kernel/traps.c	Mon Feb 24 18:24:13 2003
@@ -268,9 +268,10 @@
 		}
 #endif
         } else {
-                unsigned long fixup = search_exception_table(regs->psw.addr);
+                const struct exception_table_entry *fixup;
+                fixup = search_exception_tables(regs->psw.addr & 0x7fffffff);
                 if (fixup)
-                        regs->psw.addr = fixup;
+                        regs->psw.addr = fixup->fixup | PSW_ADDR_AMODE31;
                 else
                         die(str, regs, interruption_code);
         }
diff -urN linux-2.5.62/arch/s390/mm/extable.c linux-2.5.62-s390/arch/s390/mm/extable.c
--- linux-2.5.62/arch/s390/mm/extable.c	Mon Feb 17 23:56:25 2003
+++ linux-2.5.62-s390/arch/s390/mm/extable.c	Mon Feb 24 18:24:13 2003
@@ -2,10 +2,8 @@
  *  arch/s390/mm/extable.c
  *
  *  S390 version
- *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Hartmut Penner (hp@de.ibm.com)
  *
- *  Derived from "arch/i386/mm/extable.c"
+ *  identical to arch/i386/mm/extable.c
  */
 
 #include <linux/config.h>
@@ -13,63 +11,24 @@
 #include <linux/spinlock.h>
 #include <asm/uaccess.h>
 
-extern const struct exception_table_entry __start___ex_table[];
-extern const struct exception_table_entry __stop___ex_table[];
-
-static inline unsigned long
-search_one_table(const struct exception_table_entry *first,
-		 const struct exception_table_entry *last,
-		 unsigned long value)
+/* Simple binary search */
+const struct exception_table_entry *
+search_extable(const struct exception_table_entry *first,
+	       const struct exception_table_entry *last,
+	       unsigned long value)
 {
-        while (first <= last) {
+	while (first <= last) {
 		const struct exception_table_entry *mid;
 		long diff;
 
 		mid = (last - first) / 2 + first;
 		diff = mid->insn - value;
-                if (diff == 0)
-                        return mid->fixup;
-                else if (diff < 0)
-                        first = mid+1;
-                else
-                        last = mid-1;
-        }
-        return 0;
-}
-
-extern spinlock_t modlist_lock;
-
-unsigned long
-search_exception_table(unsigned long addr)
-{
-	struct list_head *i;
-	unsigned long ret = 0;
-
-#ifndef CONFIG_MODULES
-        addr &= 0x7fffffff;  /* remove amode bit from address */
-	/* There is only the kernel to search.  */
-	ret = search_one_table(__start___ex_table, __stop___ex_table-1, addr);
-	if (ret) ret = ret | PSW_ADDR_AMODE31;
-	return ret;
-#else
-	unsigned long flags;
-        addr &= 0x7fffffff;  /* remove amode bit from address */
-
-	/* The kernel is the last "module" -- no need to treat it special. */
-	spin_lock_irqsave(&modlist_lock, flags);
-	list_for_each(i, &extables) {
-		struct exception_table *ex
-			= list_entry(i, struct exception_table, list);
-		if (ex->num_entries == 0)
-			continue;
-		ret = search_one_table(ex->entry,
-				       ex->entry + ex->num_entries - 1, addr);
-		if (ret) {
-			ret = ret | PSW_ADDR_AMODE31;
-			break;
-		}
+		if (diff == 0)
+			return mid;
+		else if (diff < 0)
+			first = mid+1;
+		else
+			last = mid-1;
 	}
-	spin_unlock_irqrestore(&modlist_lock, flags);
-	return ret;
-#endif
+	return NULL;
 }
diff -urN linux-2.5.62/arch/s390/mm/fault.c linux-2.5.62-s390/arch/s390/mm/fault.c
--- linux-2.5.62/arch/s390/mm/fault.c	Mon Feb 17 23:56:45 2003
+++ linux-2.5.62-s390/arch/s390/mm/fault.c	Mon Feb 24 18:24:13 2003
@@ -25,6 +25,7 @@
 #include <linux/compatmac.h>
 #include <linux/init.h>
 #include <linux/console.h>
+#include <linux/module.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -151,7 +152,7 @@
         struct vm_area_struct * vma;
         unsigned long address;
 	int user_address;
-        unsigned long fixup;
+	const struct exception_table_entry *fixup;
 	int si_code = SEGV_MAPERR;
 
         tsk = current;
@@ -267,8 +268,9 @@
 
 no_context:
         /* Are we prepared to handle this kernel fault?  */
-        if ((fixup = search_exception_table(regs->psw.addr)) != 0) {
-                regs->psw.addr = fixup;
+	fixup = search_exception_tables(regs->psw.addr & 0x7fffffff);
+	if (fixup) {
+		regs->psw.addr = fixup->fixup | PSW_ADDR_AMODE31;
                 return;
         }
 
diff -urN linux-2.5.62/arch/s390x/kernel/traps.c linux-2.5.62-s390/arch/s390x/kernel/traps.c
--- linux-2.5.62/arch/s390x/kernel/traps.c	Mon Feb 17 23:56:42 2003
+++ linux-2.5.62-s390/arch/s390x/kernel/traps.c	Mon Feb 24 18:24:13 2003
@@ -269,9 +269,10 @@
 		}
 #endif
         } else {
-                unsigned long fixup = search_exception_table(regs->psw.addr);
+                const struct exception_table_entry *fixup;
+                fixup = search_exception_tables(regs->psw.addr);
                 if (fixup)
-                        regs->psw.addr = fixup;
+                        regs->psw.addr = fixup->fixup;
                 else
                         die(str, regs, interruption_code);
         }
diff -urN linux-2.5.62/arch/s390x/mm/extable.c linux-2.5.62-s390/arch/s390x/mm/extable.c
--- linux-2.5.62/arch/s390x/mm/extable.c	Mon Feb 17 23:56:10 2003
+++ linux-2.5.62-s390/arch/s390x/mm/extable.c	Mon Feb 24 18:24:13 2003
@@ -11,58 +11,24 @@
 #include <linux/spinlock.h>
 #include <asm/uaccess.h>
 
-extern const struct exception_table_entry __start___ex_table[];
-extern const struct exception_table_entry __stop___ex_table[];
-
-static inline unsigned long
-search_one_table(const struct exception_table_entry *first,
-		 const struct exception_table_entry *last,
-		 unsigned long value)
+/* Simple binary search */
+const struct exception_table_entry *
+search_extable(const struct exception_table_entry *first,
+	       const struct exception_table_entry *last,
+	       unsigned long value)
 {
-        while (first <= last) {
+	while (first <= last) {
 		const struct exception_table_entry *mid;
 		long diff;
 
 		mid = (last - first) / 2 + first;
 		diff = mid->insn - value;
-                if (diff == 0)
-                        return mid->fixup;
-                else if (diff < 0)
-                        first = mid+1;
-                else
-                        last = mid-1;
-        }
-        return 0;
-}
-
-extern spinlock_t modlist_lock;
-
-unsigned long
-search_exception_table(unsigned long addr)
-{
-	unsigned long ret = 0;
-	
-#ifndef CONFIG_MODULES
-	/* There is only the kernel to search.  */
-	ret = search_one_table(__start___ex_table, __stop___ex_table-1, addr);
-	return ret;
-#else
-	unsigned long flags;
-	struct list_head *i;
-
-	/* The kernel is the last "module" -- no need to treat it special.  */
-	spin_lock_irqsave(&modlist_lock, flags);
-	list_for_each(i, &extables) {
-		struct exception_table *ex
-			= list_entry(i, struct exception_table, list);
-		if (ex->num_entries == 0)
-			continue;
-		ret = search_one_table(ex->entry,
-				       ex->entry + ex->num_entries - 1, addr);
-		if (ret)
-			break;
+		if (diff == 0)
+			return mid;
+		else if (diff < 0)
+			first = mid+1;
+		else
+			last = mid-1;
 	}
-	spin_unlock_irqrestore(&modlist_lock, flags);
-	return ret;
-#endif
+	return NULL;
 }
diff -urN linux-2.5.62/arch/s390x/mm/fault.c linux-2.5.62-s390/arch/s390x/mm/fault.c
--- linux-2.5.62/arch/s390x/mm/fault.c	Mon Feb 17 23:56:11 2003
+++ linux-2.5.62-s390/arch/s390x/mm/fault.c	Mon Feb 24 18:24:13 2003
@@ -24,6 +24,7 @@
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/console.h>
+#include <linux/module.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -151,7 +152,7 @@
         struct vm_area_struct * vma;
         unsigned long address;
 	int user_address;
-        unsigned long fixup;
+	const struct exception_table_entry *fixup;
 	int si_code = SEGV_MAPERR;
 
         tsk = current;
@@ -267,8 +268,9 @@
 
 no_context:
         /* Are we prepared to handle this kernel fault?  */
-        if ((fixup = search_exception_table(regs->psw.addr)) != 0) {
-                regs->psw.addr = fixup;
+	fixup = search_exception_tables(regs->psw.addr);
+	if (fixup) {
+		regs->psw.addr = fixup->fixup;
                 return;
         }
 
diff -urN linux-2.5.62/include/asm-s390/uaccess.h linux-2.5.62-s390/include/asm-s390/uaccess.h
--- linux-2.5.62/include/asm-s390/uaccess.h	Mon Feb 17 23:56:00 2003
+++ linux-2.5.62-s390/include/asm-s390/uaccess.h	Mon Feb 24 18:24:13 2003
@@ -71,10 +71,6 @@
         unsigned long insn, fixup;
 };
 
-/* Returns 0 if exception not found and fixup otherwise.  */
-extern unsigned long search_exception_table(unsigned long);
-
-
 /*
  * These are the main single-value transfer routines.  They automatically
  * use the right size if we just have the right pointer type.
diff -urN linux-2.5.62/include/asm-s390x/uaccess.h linux-2.5.62-s390/include/asm-s390x/uaccess.h
--- linux-2.5.62/include/asm-s390x/uaccess.h	Mon Feb 17 23:55:51 2003
+++ linux-2.5.62-s390/include/asm-s390x/uaccess.h	Mon Feb 24 18:24:13 2003
@@ -71,10 +71,6 @@
         unsigned long insn, fixup;
 };
 
-/* Returns 0 if exception not found and fixup otherwise.  */
-extern unsigned long search_exception_table(unsigned long);
-
-
 /*
  * These are the main single-value transfer routines.  They automatically
  * use the right size if we just have the right pointer type.


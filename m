Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262395AbSI2Fxd>; Sun, 29 Sep 2002 01:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262397AbSI2Fxd>; Sun, 29 Sep 2002 01:53:33 -0400
Received: from bitchcake.off.net ([216.138.242.5]:46758 "EHLO mail.off.net")
	by vger.kernel.org with ESMTP id <S262395AbSI2Fx3>;
	Sun, 29 Sep 2002 01:53:29 -0400
Date: Sun, 29 Sep 2002 01:58:52 -0400
From: Zach Brown <zab@zabbo.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.39 list_head debugging
Message-ID: <20020929015852.K13817@bitchcake.off.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

	This patch adds some straight-forward assertions that check the
validity of arguments to the list_* inlines.  It tries to simply check
that a list member is really on a doubly linked list and that the 4
links it's involved with aren't crap.  It should be constant-time on
stuff that is likely to be in cache anyway.  

	The patch already caught some list_heads that were not being
maintained properly ; list_empty was failing on them even though they
weren't on lists.  (their pointers had slab poison, were NULL, etc. ) 

	With those two errors fixed, and I think akpm is going to send
you the patches, the box appears to run fine with very light testing.

-- 
 zach

===== include/linux/list.h 1.17 vs edited =====
--- 1.17/include/linux/list.h	Mon Sep 23 10:03:52 2002
+++ linux-2.5.39/include/linux/list.h	Fri Sep 27 18:28:30 2002
@@ -3,6 +3,7 @@
 
 #if defined(__KERNEL__) || defined(_LVM_H_INCLUDE)
 
+#include <linux/kernel.h> /* ouch.. just for bug_on */
 #include <linux/prefetch.h>
 
 /*
@@ -28,6 +29,26 @@
 	(ptr)->next = (ptr); (ptr)->prev = (ptr); \
 } while (0)
 
+#ifdef CONFIG_DEBUG_LIST_HEAD
+
+static inline struct list_head * __list_valid(struct list_head *list)
+{
+	BUG_ON(list == NULL);
+	BUG_ON(list->next == NULL);
+	BUG_ON(list->prev == NULL);
+	BUG_ON(list->next->prev != list);
+	BUG_ON(list->prev->next != list);
+	BUG_ON((list->next == list) && (list->prev != list));
+	BUG_ON((list->prev == list) && (list->next != list));
+
+	return list;
+}
+#else 
+
+#define __list_valid(args...)
+
+#endif
+
 /*
  * Insert a new entry between two known consecutive entries. 
  *
@@ -54,7 +75,9 @@
  */
 static inline void list_add(struct list_head *new, struct list_head *head)
 {
+	__list_valid(head);
 	__list_add(new, head, head->next);
+	__list_valid(new);
 }
 
 /**
@@ -67,7 +90,9 @@
  */
 static inline void list_add_tail(struct list_head *new, struct list_head *head)
 {
+	__list_valid(head);
 	__list_add(new, head->prev, head);
+	__list_valid(new);
 }
 
 /*
@@ -90,6 +115,7 @@
  */
 static inline void list_del(struct list_head *entry)
 {
+	__list_valid(entry);
 	__list_del(entry->prev, entry->next);
 	entry->next = (void *) 0;
 	entry->prev = (void *) 0;
@@ -101,6 +127,7 @@
  */
 static inline void list_del_init(struct list_head *entry)
 {
+	__list_valid(entry);
 	__list_del(entry->prev, entry->next);
 	INIT_LIST_HEAD(entry); 
 }
@@ -112,6 +139,7 @@
  */
 static inline void list_move(struct list_head *list, struct list_head *head)
 {
+	__list_valid(list);
         __list_del(list->prev, list->next);
         list_add(list, head);
 }
@@ -124,6 +152,7 @@
 static inline void list_move_tail(struct list_head *list,
 				  struct list_head *head)
 {
+	__list_valid(list);
         __list_del(list->prev, list->next);
         list_add_tail(list, head);
 }
@@ -134,6 +163,7 @@
  */
 static inline int list_empty(struct list_head *head)
 {
+	__list_valid(head);
 	return head->next == head;
 }
 
@@ -158,6 +188,8 @@
  */
 static inline void list_splice(struct list_head *list, struct list_head *head)
 {
+	__list_valid(list);
+	__list_valid(head);
 	if (!list_empty(list))
 		__list_splice(list, head);
 }
@@ -172,6 +204,8 @@
 static inline void list_splice_init(struct list_head *list,
 				    struct list_head *head)
 {
+	__list_valid(list);
+	__list_valid(head);
 	if (!list_empty(list)) {
 		__list_splice(list, head);
 		INIT_LIST_HEAD(list);
@@ -193,8 +227,9 @@
  * @head:	the head for your list.
  */
 #define list_for_each(pos, head) \
-	for (pos = (head)->next, prefetch(pos->next); pos != (head); \
-        	pos = pos->next, prefetch(pos->next))
+	for (pos = (head)->next, prefetch(pos->next); \
+		__list_valid(pos), pos != (head); \
+        	__list_valid(pos), pos = pos->next, prefetch(pos->next))
 
 /**
  * __list_for_each	-	iterate over a list
@@ -207,7 +242,9 @@
  * or 1 entry) most of the time.
  */
 #define __list_for_each(pos, head) \
-	for (pos = (head)->next; pos != (head); pos = pos->next)
+	for (pos = (head)->next; \
+		__list_valid(pos), pos != (head); \
+		__list_valid(pos), pos = pos->next)
 
 /**
  * list_for_each_prev	-	iterate over a list backwards
@@ -215,8 +252,9 @@
  * @head:	the head for your list.
  */
 #define list_for_each_prev(pos, head) \
-	for (pos = (head)->prev, prefetch(pos->prev); pos != (head); \
-        	pos = pos->prev, prefetch(pos->prev))
+	for (pos = (head)->prev, prefetch(pos->prev); \
+		__list_valid(pos), pos != (head); \
+        	__list_valid(pos), pos = pos->prev, prefetch(pos->prev))
         	
 /**
  * list_for_each_safe	-	iterate over a list safe against removal of list entry
@@ -225,7 +263,8 @@
  * @head:	the head for your list.
  */
 #define list_for_each_safe(pos, n, head) \
-	for (pos = (head)->next, n = pos->next; pos != (head); \
+	for (pos = (head)->next, n = pos->next; \
+		__list_valid(pos), pos != (head); \
 		pos = n, n = pos->next)
 
 /**
@@ -237,7 +276,7 @@
 #define list_for_each_entry(pos, head, member)				\
 	for (pos = list_entry((head)->next, typeof(*pos), member),	\
 		     prefetch(pos->member.next);			\
-	     &pos->member != (head); 					\
+	     __list_valid(&pos->member), &pos->member != (head); 	\
 	     pos = list_entry(pos->member.next, typeof(*pos), member),	\
 		     prefetch(pos->member.next))
 
===== arch/alpha/config.in 1.29 vs edited =====
--- 1.29/arch/alpha/config.in	Wed Aug 28 11:16:05 2002
+++ linux-2.5.39/arch/alpha/config.in	Fri Sep 27 18:09:38 2002
@@ -390,6 +390,7 @@
    bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
    bool '  Read-write spinlock debugging' CONFIG_DEBUG_RWLOCK
    bool '  Semaphore debugging' CONFIG_DEBUG_SEMAPHORE
+   bool '  struct list_head debugging' CONFIG_DEBUG_LIST_HEAD
 else
    define_tristate CONFIG_MATHEMU y
 fi
===== arch/arm/config.in 1.38 vs edited =====
--- 1.38/arch/arm/config.in	Mon Jul 15 09:54:04 2002
+++ linux-2.5.39/arch/arm/config.in	Fri Sep 27 18:10:03 2002
@@ -669,6 +669,7 @@
 dep_bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ $CONFIG_DEBUG_KERNEL
 dep_bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK $CONFIG_DEBUG_KERNEL
 dep_bool '  Wait queue debugging' CONFIG_DEBUG_WAITQ $CONFIG_DEBUG_KERNEL
+dep_bool '  struct list_head debugging' CONFIG_DEBUG_LIST_HEAD $CONFIG_DEBUG_KERNEL
 dep_bool '  Verbose BUG() reporting (adds 70K)' CONFIG_DEBUG_BUGVERBOSE $CONFIG_DEBUG_KERNEL
 dep_bool '  Verbose kernel error messages' CONFIG_DEBUG_ERRORS $CONFIG_DEBUG_KERNEL
 # These options are only for real kernel hackers who want to get their hands dirty. 
===== arch/i386/config.in 1.49 vs edited =====
--- 1.49/arch/i386/config.in	Thu Sep 26 08:27:16 2002
+++ linux-2.5.39/arch/i386/config.in	Fri Sep 27 18:10:29 2002
@@ -432,6 +432,7 @@
    bool '  Memory mapped I/O debugging' CONFIG_DEBUG_IOVIRT
    bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
    bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
+   bool '  struct list_head debugging' CONFIG_DEBUG_LIST_HEAD
    if [ "$CONFIG_HIGHMEM" = "y" ]; then
       bool '  Highmem debugging' CONFIG_DEBUG_HIGHMEM
    fi
===== arch/ia64/config.in 1.33 vs edited =====
--- 1.33/arch/ia64/config.in	Sat Sep 21 01:25:52 2002
+++ linux-2.5.39/arch/ia64/config.in	Fri Sep 27 18:10:42 2002
@@ -277,6 +277,7 @@
    fi
    bool '  Debug memory allocations' CONFIG_DEBUG_SLAB
    bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
+   bool '  struct list_head debugging' CONFIG_DEBUG_LIST_HEAD
    bool '  Turn on compare-and-exchange bug checking (slow!)' CONFIG_IA64_DEBUG_CMPXCHG
    bool '  Turn on irq debug checks (slow!)' CONFIG_IA64_DEBUG_IRQ
 fi
===== arch/m68k/config.in 1.19 vs edited =====
--- 1.19/arch/m68k/config.in	Tue Aug 13 03:33:49 2002
+++ linux-2.5.39/arch/m68k/config.in	Fri Sep 27 18:10:57 2002
@@ -541,6 +541,7 @@
    bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
    bool '  Debug memory allocations' CONFIG_DEBUG_SLAB
    bool '  Verbose BUG() reporting' CONFIG_DEBUG_BUGVERBOSE
+   bool '  struct list_head debuggiing' CONFIG_DEBUG_LIST_HEAD
 fi
 
 endmenu
===== arch/mips/config.in 1.19 vs edited =====
--- 1.19/arch/mips/config.in	Wed Aug 28 11:16:05 2002
+++ linux-2.5.39/arch/mips/config.in	Fri Sep 27 18:12:26 2002
@@ -489,6 +489,7 @@
   bool 'Low-level debugging' CONFIG_LL_DEBUG
 fi
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'struct list_head debugging' CONFIG_DEBUG_LIST_HEAD
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'Run uncached' CONFIG_MIPS_UNCACHED
 fi
===== arch/mips64/config.in 1.18 vs edited =====
--- 1.18/arch/mips64/config.in	Wed Aug 28 11:16:05 2002
+++ linux-2.5.39/arch/mips64/config.in	Fri Sep 27 18:12:08 2002
@@ -243,6 +243,7 @@
 fi
 bool 'Remote GDB kernel debugging' CONFIG_REMOTE_DEBUG
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'struct list_head debugging' CONFIG_DEBUG_LIST_HEAD
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'Run uncached' CONFIG_MIPS_UNCACHED
 fi
===== arch/parisc/config.in 1.12 vs edited =====
--- 1.12/arch/parisc/config.in	Sun Aug 25 15:44:57 2002
+++ linux-2.5.39/arch/parisc/config.in	Fri Sep 27 18:12:41 2002
@@ -188,6 +188,7 @@
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'struct list_head debugging' CONFIG_DEBUG_LIST_HEAD
 endmenu
 
 source security/Config.in
===== arch/ppc/config.in 1.43 vs edited =====
--- 1.43/arch/ppc/config.in	Thu Sep 19 21:35:59 2002
+++ linux-2.5.39/arch/ppc/config.in	Fri Sep 27 18:13:11 2002
@@ -585,6 +585,7 @@
 
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
 bool 'Spinlock debugging' CONFIG_DEBUG_SPINLOCK
+bool 'struct list_head debugging' CONFIG_DEBUG_LIST_HEAD
 bool 'Include kgdb kernel debugger' CONFIG_KGDB
 if [ "$CONFIG_KGDB" = "y" ]; then
    choice 'Serial Port'			\
===== arch/ppc64/config.in 1.16 vs edited =====
--- 1.16/arch/ppc64/config.in	Wed Aug 28 23:26:41 2002
+++ linux-2.5.39/arch/ppc64/config.in	Fri Sep 27 18:12:58 2002
@@ -196,6 +196,7 @@
 if [ "$CONFIG_DEBUG_KERNEL" != "n" ]; then
    bool '  Debug memory allocations' CONFIG_DEBUG_SLAB
    bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
+   bool '  struct list_head debugging' CONFIG_DEBUG_LIST_HEAD
    bool '  Include xmon kernel debugger' CONFIG_XMON
    if [ "$CONFIG_XMON" = "y" ]; then
       bool '  Enable xmon by default' CONFIG_XMON_DEFAULT
===== arch/s390/config.in 1.10 vs edited =====
--- 1.10/arch/s390/config.in	Mon Jul 22 11:54:56 2002
+++ linux-2.5.39/arch/s390/config.in	Fri Sep 27 18:13:23 2002
@@ -73,6 +73,7 @@
 #  bool 'Remote GDB kernel debugging' CONFIG_REMOTE_DEBUG
 #fi
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'struct list_head debugging' CONFIG_DEBUG_LIST_HEAD
 endmenu
 
 source security/Config.in
===== arch/s390x/config.in 1.9 vs edited =====
--- 1.9/arch/s390x/config.in	Mon Jul 22 11:54:56 2002
+++ linux-2.5.39/arch/s390x/config.in	Fri Sep 27 18:13:36 2002
@@ -76,6 +76,7 @@
 #  bool 'Remote GDB kernel debugging' CONFIG_REMOTE_DEBUG
 #fi
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'struct list_head debugging' CONFIG_DEBUG_LIST_HEAD
 endmenu
 
 source security/Config.in
===== arch/sh/config.in 1.16 vs edited =====
--- 1.16/arch/sh/config.in	Sun Aug 25 15:41:58 2002
+++ linux-2.5.39/arch/sh/config.in	Fri Sep 27 18:13:50 2002
@@ -362,6 +362,7 @@
 comment 'Kernel hacking'
 
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'struct list_head debugging' CONFIG_DEBUG_LIST_HEAD
 bool 'Use LinuxSH standard BIOS' CONFIG_SH_STANDARD_BIOS
 if [ "$CONFIG_SH_STANDARD_BIOS" = "y" ]; then
    bool 'Early printk support' CONFIG_SH_EARLY_PRINTK
===== arch/sparc/config.in 1.24 vs edited =====
--- 1.24/arch/sparc/config.in	Wed Sep 18 16:20:23 2002
+++ linux-2.5.39/arch/sparc/config.in	Fri Sep 27 18:14:09 2002
@@ -239,6 +239,7 @@
 bool 'Debug memory allocations' CONFIG_DEBUG_SLAB
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
 bool 'Spinlock debugging' CONFIG_DEBUG_SPINLOCK
+bool 'struct list_head debugging' CONFIG_DEBUG_LIST_HEAD
 
 endmenu
 
===== arch/sparc64/config.in 1.37 vs edited =====
--- 1.37/arch/sparc64/config.in	Wed Sep 18 16:20:23 2002
+++ linux-2.5.39/arch/sparc64/config.in	Fri Sep 27 18:13:59 2002
@@ -281,6 +281,7 @@
    bool '  Debug memory allocations' CONFIG_DEBUG_SLAB
    bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
    bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
+   bool '  struct list_head debugging' CONFIG_DEBUG_LIST_HEAD
    bool '  Verbose BUG() reporting (adds 70K)' CONFIG_DEBUG_BUGVERBOSE
    bool '  D-cache flush debugging' CONFIG_DEBUG_DCFLUSH
 fi
===== arch/um/config.in 1.1 vs edited =====
--- 1.1/arch/um/config.in	Fri Sep  6 10:29:28 2002
+++ linux-2.5.39/arch/um/config.in	Fri Sep 27 18:14:22 2002
@@ -77,6 +77,7 @@
 comment 'Kernel hacking'
 bool 'Debug memory allocations' CONFIG_DEBUG_SLAB
 bool 'Enable kernel debugging symbols' CONFIG_DEBUGSYM
+bool 'struct list_head debugging' CONFIG_DEBUG_LIST_HEAD
 if [ "$CONFIG_XTERM_CHAN" = "y" ]; then
    dep_bool 'Enable ptrace proxy' CONFIG_PT_PROXY $CONFIG_DEBUGSYM
 else 
===== arch/x86_64/config.in 1.14 vs edited =====
--- 1.14/arch/x86_64/config.in	Sun Aug 25 15:42:58 2002
+++ linux-2.5.39/arch/x86_64/config.in	Fri Sep 27 18:14:33 2002
@@ -221,6 +221,7 @@
 #   bool '  Memory mapped I/O debugging' CONFIG_DEBUG_IOVIRT
    bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
    bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
+   bool '  struct list_head debugging' CONFIG_DEBUG_LIST_HEAD
    bool '  Additional run-time checks' CONFIG_CHECKING
    bool '  Debug __init statements' CONFIG_INIT_DEBUG
 fi

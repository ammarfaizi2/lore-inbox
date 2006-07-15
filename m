Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbWGOUEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbWGOUEY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 16:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030275AbWGOUEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 16:04:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11440 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030267AbWGOUEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 16:04:23 -0400
Date: Sat, 15 Jul 2006 16:04:14 -0400
From: Dave Jones <davej@redhat.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: memory corruptor in .18rc1-git
Message-ID: <20060715200414.GB3672@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <200607151556_MC3-1-C510-CFA2@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607151556_MC3-1-C510-CFA2@compuserve.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2006 at 03:54:35PM -0400, Chuck Ebbert wrote:

 > Shouldn't those four 'if' statements use unlikely()?  There's no sense
 > causing more slowdown than necessary, even in debug code.

good point.

 > And I'd change the messages slightly, e.g.:
 > 
 >         "list_add: corruption: next->prev should be %p, was %p\n"
 > 
 > Some people build (accidentally?) without verbose debug info and
 > don't get line numbers.
 
Ok, you're the second person to ask for this, so I'll make the change.

Andrew,Linus, here's the latest incarnation.
(Not build-tested yet, willdo after packing for OLS, but the changes
 should be trivial enough not to blow up).

		Dave

Debug variants of linked-list manipulation macros.

Signed-off-by: Dave Jones <davej@redhat.com>

diff --git a/include/linux/list.h b/include/linux/list.h
index 6b74adf..5617c77 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -39,6 +39,7 @@ static inline void INIT_LIST_HEAD(struct
  * This is only for internal list manipulation where we know
  * the prev/next entries already!
  */
+#ifndef CONFIG_DEBUG_LIST
 static inline void __list_add(struct list_head *new,
 			      struct list_head *prev,
 			      struct list_head *next)
@@ -48,6 +49,11 @@ static inline void __list_add(struct lis
 	new->prev = prev;
 	prev->next = new;
 }
+#else
+extern void __list_add(struct list_head *new,
+			      struct list_head *prev,
+			      struct list_head *next);
+#endif
 
 /**
  * list_add - add a new entry
@@ -57,10 +63,15 @@ static inline void __list_add(struct lis
  * Insert a new entry after the specified head.
  * This is good for implementing stacks.
  */
+#ifndef CONFIG_DEBUG_LIST
 static inline void list_add(struct list_head *new, struct list_head *head)
 {
 	__list_add(new, head, head->next);
 }
+#else
+extern void list_add(struct list_head *new, struct list_head *head);
+#endif
+
 
 /**
  * list_add_tail - add a new entry
@@ -153,12 +164,16 @@ static inline void __list_del(struct lis
  * Note: list_empty on entry does not return true after this, the entry is
  * in an undefined state.
  */
+#ifndef CONFIG_DEBUG_LIST
 static inline void list_del(struct list_head *entry)
 {
 	__list_del(entry->prev, entry->next);
 	entry->next = LIST_POISON1;
 	entry->prev = LIST_POISON2;
 }
+#else
+extern void list_del(struct list_head *entry);
+#endif
 
 /**
  * list_del_rcu - deletes entry from list without re-initialization
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e5889b1..bb17ce3 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -311,6 +311,15 @@ config DEBUG_VM
 
 	  If unsure, say N.
 
+config DEBUG_LIST
+	bool "Debug linked list manipulation"
+	depends on DEBUG_KERNEL
+	help
+	  Enable this to turn on extended checks in the linked-list
+	  walking routines.
+
+	  If unsure, say N.
+
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
 	depends on DEBUG_KERNEL && (X86 || CRIS || M68K || M68KNOMMU || FRV || UML || S390)
diff --git a/lib/Makefile b/lib/Makefile
index be9719a..7d7da98 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -28,6 +28,7 @@ lib-$(CONFIG_GENERIC_HWEIGHT) += hweight
 obj-$(CONFIG_LOCK_KERNEL) += kernel_lock.o
 obj-$(CONFIG_PLIST) += plist.o
 obj-$(CONFIG_DEBUG_PREEMPT) += smp_processor_id.o
+obj-$(CONFIG_DEBUG_LIST) += list_debug.o
 
 ifneq ($(CONFIG_HAVE_DEC_LOCK),y)
   lib-y += dec_and_lock.o
diff --git a/lib/list_debug.c b/lib/list_debug.c
new file mode 100644
index 0000000..0b48b95
--- /dev/null
+++ b/lib/list_debug.c
@@ -0,0 +1,77 @@
+/*
+ * Copyright 2006, Red Hat, Inc., Dave Jones
+ * Released under the General Public License (GPL).
+ *
+ * This file contains the linked list implementations for
+ * DEBUG_LIST.
+ */
+
+#include <linux/module.h>
+#include <linux/list.h>
+
+/*
+ * Insert a new entry between two known consecutive entries.
+ *
+ * This is only for internal list manipulation where we know
+ * the prev/next entries already!
+ */
+
+void __list_add(struct list_head *new,
+			      struct list_head *prev,
+			      struct list_head *next)
+{
+	if (unlikely(next->prev != prev)) {
+		printk("list_add corruption. next->prev should be %p, but was %p\n",
+			prev, next->prev);
+		BUG();
+	}
+	if (unlikely(prev->next != next)) {
+		printk("list_add corruption. prev->next should be %p, but was %p\n",
+			next, prev->next);
+		BUG();
+	}
+	next->prev = new;
+	new->next = next;
+	new->prev = prev;
+	prev->next = new;
+}
+EXPORT_SYMBOL(__list_add);
+
+/**
+ * list_add - add a new entry
+ * @new: new entry to be added
+ * @head: list head to add it after
+ *
+ * Insert a new entry after the specified head.
+ * This is good for implementing stacks.
+ */
+void list_add(struct list_head *new, struct list_head *head)
+{
+	__list_add(new, head, head->next);
+}
+EXPORT_SYMBOL(list_add);
+
+/**
+ * list_del - deletes entry from list.
+ * @entry: the element to delete from the list.
+ * Note: list_empty on entry does not return true after this, the entry is
+ * in an undefined state.
+ */
+void list_del(struct list_head *entry)
+{
+	if (unlikely(entry->prev->next != entry)) {
+		printk("list_del corruption. prev->next should be %p, but was %p\n",
+			entry, entry->prev->next);
+		BUG();
+	}
+	if (unlikely(entry->next->prev != entry)) {
+		printk("list_del corruption. next->prev should be %p, but was %p\n",
+			entry, entry->next->prev);
+		BUG();
+	}
+	__list_del(entry->prev, entry->next);
+	entry->next = LIST_POISON1;
+	entry->prev = LIST_POISON2;
+}
+EXPORT_SYMBOL(list_del);
+
-- 
http://www.codemonkey.org.uk

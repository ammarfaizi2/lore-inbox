Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161258AbWGNEb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161258AbWGNEb3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 00:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161260AbWGNEb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 00:31:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52413 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161258AbWGNEb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 00:31:28 -0400
Date: Fri, 14 Jul 2006 00:31:12 -0400
From: Dave Jones <davej@redhat.com>
To: Willy Tarreau <w@1wt.eu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: memory corruptor in .18rc1-git
Message-ID: <20060714043112.GA20478@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Willy Tarreau <w@1wt.eu>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	torvalds@osdl.org
References: <20060713221330.GB3371@redhat.com> <20060713152425.86412ea3.akpm@osdl.org> <20060713223029.GD3371@redhat.com> <20060714041254.GG2037@1wt.eu> <20060714042039.GB22802@redhat.com> <20060714042525.GH2037@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060714042525.GH2037@1wt.eu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2006 at 06:25:25AM +0200, Willy Tarreau wrote:
 > > > Then you might consider slightly changing the debug messages, because they
 > > > are identical in list_add and list_del. Having a way to differenciate
 > > > between the two functions might give one more indication.
 > > 
 > > BUG() gives a line number.
 > 
 > oops! sorry, I did not notice it just after the printk(). Next time I will
 > not post before coffee :-)

Though in the case I hit this morning, the text from the BUG() wouldn't
have made it over serial. But then, unless the first few chars were different,
not much else would have either. It didn't even complete the printk.

For most cases though, it should suffice. It gives enough clues that
'something stomped on memory' in cases like I saw, and in other cases
where the box still survives, it'll be possible to get the full context
from dmesg.  For info, here's a cleaned up variant of the patch with
some suggestions from Linus.  Andrew also merged an earlier variant into -mm.

		Dave

diff --git a/include/linux/list.h b/include/linux/list.h
index 6b74adf..26e5abc 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -57,10 +57,15 @@ static inline void __list_add(struct lis
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
@@ -153,12 +158,16 @@ static inline void __list_del(struct lis
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
index 0000000..28b2d46
--- /dev/null
+++ b/lib/list_debug.c
@@ -0,0 +1,60 @@
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
+	if (head->next->prev != head) {
+		printk("List corruption. next->prev should be %p, but was %p\n",
+			head, head->next->prev);
+		BUG();
+	}
+	if (head->prev->next != head) {
+		printk("List corruption. prev->next should be %p, but was %p\n",
+			head, head->prev->next);
+		BUG();
+	}
+
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
+	if (entry->prev->next != entry) {
+		printk("List corruption. prev->next should be %p, but was %p\n",
+			entry, entry->prev->next);
+		BUG();
+	}
+	if (entry->next->prev != entry) {
+		printk("List corruption. next->prev should be %p, but was %p\n",
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

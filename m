Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030428AbWGMWNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030428AbWGMWNn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 18:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030426AbWGMWNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 18:13:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24040 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030428AbWGMWNn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 18:13:43 -0400
Date: Thu, 13 Jul 2006 18:13:30 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: memory corruptor in .18rc1-git
Message-ID: <20060713221330.GB3371@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Three times in the last week, I've had a box running the -git-du-jour
spontaneously reboot.  It just happened again, this time I had a serial
console hooked up, but it rebooted before transferring much data.
The one thing it did spew however was "List corruption. prev->ne",
which came from the patch below which I had in my tree.
(The latter half is likely irrelevant, and came from chasing a different bug)

Things in common at all three times it happened..
reading email, and listening to oggs with rhythmbox.
Another ALSA bug maybe ?

I've up'd the speed of the serial console, in the hope that more chars
make it over the wire before reboot should this happen again.

		Dave


--- linux-2.6/include/linux/list.h~	2005-08-08 15:34:50.000000000 -0400
+++ linux-2.6/include/linux/list.h	2005-08-08 15:35:22.000000000 -0400
@@ -5,7 +5,9 @@
 
 #include <linux/stddef.h>
 #include <linux/prefetch.h>
+#include <linux/kernel.h>
 #include <asm/system.h>
+#include <asm/bug.h>
 
 /*
  * These are non-NULL pointers that will result in page faults
@@ -52,6 +52,16 @@ static inline void __list_add(struct lis
 			      struct list_head *prev,
 			      struct list_head *next)
 {
+	if (next->prev != prev) {
+		printk("List corruption. next->prev should be %p, but was %p\n",
+				prev, next->prev);
+		BUG();
+	}
+	if (prev->next != next) {
+		printk("List corruption. prev->next should be %p, but was %p\n",
+				next, prev->next);
+		BUG();
+	}
 	next->prev = new;
 	new->next = next;
 	new->prev = prev;
@@ -162,6 +162,16 @@ static inline void __list_del(struct lis
  */
 static inline void list_del(struct list_head *entry)
 {
+	if (entry->prev->next != entry) {
+		printk("List corruption. prev->next should be %p, but was %p\n",
+				entry, entry->prev->next);
+		BUG();
+	}
+	if (entry->next->prev != entry) {
+		printk("List corruption. next->prev should be %p, but was %p\n",
+				entry, entry->next->prev);
+		BUG();
+	}
 	__list_del(entry->prev, entry->next);
 	entry->next = LIST_POISON1;
 	entry->prev = LIST_POISON2;



It _may_ give more information about exactly which wait-queue (or rather, 
what the poll function that was related to that wait-queue) seems to be 
corrupted. 

		Linus

---
diff --git a/fs/select.c b/fs/select.c
index a8109ba..8cd6dc3 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -23,6 +23,7 @@ #include <linux/personality.h> /* for ST
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/rcupdate.h>
+#include <linux/kallsyms.h>
 
 #include <asm/uaccess.h>
 
@@ -65,7 +66,8 @@ EXPORT_SYMBOL(poll_initwait);
 
 static void free_poll_entry(struct poll_table_entry *entry)
 {
-	remove_wait_queue(entry->wait_address,&entry->wait);
+	if (remove_wait_queue(entry->wait_address,&entry->wait) < 0)
+		print_symbol("bad poll-entry for %s", (unsigned long) entry->filp->f_op->poll);
 	fput(entry->filp);
 }
 
diff --git a/include/linux/wait.h b/include/linux/wait.h
index d285182..4c1d74e 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -115,7 +115,7 @@ #define is_sync_wait(wait)	(!(wait) || (
 
 extern void FASTCALL(add_wait_queue(wait_queue_head_t *q, wait_queue_t * wait));
 extern void FASTCALL(add_wait_queue_exclusive(wait_queue_head_t *q, wait_queue_t * wait));
-extern void FASTCALL(remove_wait_queue(wait_queue_head_t *q, wait_queue_t * wait));
+extern int FASTCALL(remove_wait_queue(wait_queue_head_t *q, wait_queue_t * wait));
 
 static inline void __add_wait_queue(wait_queue_head_t *head, wait_queue_t *new)
 {
diff --git a/kernel/wait.c b/kernel/wait.c
index 791681c..5cdf169 100644
--- a/kernel/wait.c
+++ b/kernel/wait.c
@@ -33,13 +33,35 @@ void fastcall add_wait_queue_exclusive(w
 }
 EXPORT_SYMBOL(add_wait_queue_exclusive);
 
-void fastcall remove_wait_queue(wait_queue_head_t *q, wait_queue_t *wait)
+int fastcall remove_wait_queue(wait_queue_head_t *q, wait_queue_t *wait)
 {
 	unsigned long flags;
+	struct list_head *list;
+	int seen, retval;
 
 	spin_lock_irqsave(&q->lock, flags);
-	__remove_wait_queue(q, wait);
+	list = &q->task_list;
+	seen = 0;
+	retval = -1;
+
+	do {
+		struct list_head *next;
+		if (list == &wait->task_list)
+			seen++;
+		next = list->next;
+		if (next->prev != list) {
+			seen += 2;
+			break;
+		}
+		list = next;
+	} while (list != &q->task_list);
+
+	if (seen == 1) {
+		__remove_wait_queue(q, wait);
+		retval = 0;
+	}
 	spin_unlock_irqrestore(&q->lock, flags);
+	return retval;
 }
 EXPORT_SYMBOL(remove_wait_queue);
 

-- 
http://www.codemonkey.org.uk

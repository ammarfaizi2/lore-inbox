Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262528AbVAPPXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbVAPPXh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 10:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbVAPPXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 10:23:37 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:36031 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262528AbVAPPXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 10:23:15 -0500
Message-ID: <41EA95BD.42F10C9E@tv-sign.ru>
Date: Sun, 16 Jan 2005 19:26:37 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] introduce __mod_page_state(offset, delta)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduces a __mod_page_state(offset, delta) function
and converts mod_page_state() to use it.

Unexports and staticizes page_states per cpu variable.

   text    data     bss     dec     hex filename
1818704  615884       0 2434588  25261c vmlinux-old
1817632  615884       0 2433516  2521ec vmlinux-new

1072 bytes. (Adds 64 bytes without CONFIG_SMP).

I do not think it can hurt performance, but i do not
know how to check.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.11-rc1/include/linux/page-flags.h~	2005-01-15 18:40:55.000000000 +0300
+++ 2.6.11-rc1/include/linux/page-flags.h	2005-01-15 19:07:48.000000000 +0300
@@ -133,40 +133,32 @@ struct page_state {
 	unsigned long pgrotated;	/* pages rotated to tail of the LRU */
 };
 
-DECLARE_PER_CPU(struct page_state, page_states);
-
 extern void get_page_state(struct page_state *ret);
 extern void get_full_page_state(struct page_state *ret);
 extern unsigned long __read_page_state(unsigned offset);
+extern void __mod_page_state(unsigned offset, unsigned long delta);
 
 #define read_page_state(member) \
 	__read_page_state(offsetof(struct page_state, member))
 
-#define mod_page_state(member, delta)					\
-	do {								\
-		unsigned long flags;					\
-		local_irq_save(flags);					\
-		__get_cpu_var(page_states).member += (delta);		\
-		local_irq_restore(flags);				\
-	} while (0)
-
+#define mod_page_state(member, delta)	\
+	__mod_page_state(offsetof(struct page_state, member), (delta))
 
 #define inc_page_state(member)	mod_page_state(member, 1UL)
 #define dec_page_state(member)	mod_page_state(member, 0UL - 1)
 #define add_page_state(member,delta) mod_page_state(member, (delta))
 #define sub_page_state(member,delta) mod_page_state(member, 0UL - (delta))
 
-#define mod_page_state_zone(zone, member, delta)			\
-	do {								\
-		unsigned long flags;					\
-		local_irq_save(flags);					\
-		if (is_highmem(zone))					\
-			__get_cpu_var(page_states).member##_high += (delta);\
-		else if (is_normal(zone))				\
-			__get_cpu_var(page_states).member##_normal += (delta);\
-		else							\
-			__get_cpu_var(page_states).member##_dma += (delta);\
-		local_irq_restore(flags);				\
+#define mod_page_state_zone(zone, member, delta)				\
+	do {									\
+		unsigned offset;						\
+		if (is_highmem(zone))						\
+			offset = offsetof(struct page_state, member##_high);	\
+		else if (is_normal(zone))					\
+			offset = offsetof(struct page_state, member##_normal);	\
+		else								\
+			offset = offsetof(struct page_state, member##_dma);	\
+		__mod_page_state(offset, (delta));				\
 	} while (0)
 
 /*
--- 2.6.11-rc1/mm/page_alloc.c~	2005-01-15 18:40:55.000000000 +0300
+++ 2.6.11-rc1/mm/page_alloc.c	2005-01-15 19:08:48.000000000 +0300
@@ -984,8 +984,7 @@ static void show_node(struct zone *zone)
  * The result is unavoidably approximate - it can change
  * during and after execution of this function.
  */
-DEFINE_PER_CPU(struct page_state, page_states) = {0};
-EXPORT_PER_CPU_SYMBOL(page_states);
+static DEFINE_PER_CPU(struct page_state, page_states) = {0};
 
 atomic_t nr_pagecache = ATOMIC_INIT(0);
 EXPORT_SYMBOL(nr_pagecache);
@@ -1045,6 +1044,19 @@ unsigned long __read_page_state(unsigned
 	return ret;
 }
 
+void __mod_page_state(unsigned offset, unsigned long delta)
+{
+	unsigned long flags;
+	void* ptr;
+
+	local_irq_save(flags);
+	ptr = &__get_cpu_var(page_states);
+	*(unsigned long*)(ptr + offset) += delta;
+	local_irq_restore(flags);
+}
+
+EXPORT_SYMBOL(__mod_page_state);
+
 void __get_zone_counts(unsigned long *active, unsigned long *inactive,
 			unsigned long *free, struct pglist_data *pgdat)
 {

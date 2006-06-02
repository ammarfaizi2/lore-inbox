Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWFBLxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWFBLxT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 07:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWFBLxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 07:53:18 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:30761
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751137AbWFBLxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 07:53:18 -0400
Message-Id: <448042FB.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Fri, 02 Jun 2006 13:54:03 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andrew Morton" <akpm@osdl.org>, "Andreas Kleen" <ak@suse.de>
Cc: "Ingo Molnar" <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] allow unwinder to build without module support
	being configured
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add proper conditionals to be able to build with CONFIG_MODULES=n.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

Index: 2.6.17-rc5-unwind-generic/include/linux/unwind.h
===================================================================
--- 2.6.17-rc5-unwind-generic.orig/include/linux/unwind.h	2006-06-02 13:23:30.000000000 +0200
+++ 2.6.17-rc5-unwind-generic/include/linux/unwind.h	2006-06-02 13:32:48.000000000 +0200
@@ -29,12 +29,16 @@ struct module;
  */
 extern void unwind_init(void);
 
+#ifdef CONFIG_MODULES
+
 extern void *unwind_add_table(struct module *,
                               const void *table_start,
                               unsigned long table_size);
 
 extern void unwind_remove_table(void *handle, int init_only);
 
+#endif
+
 extern int unwind_init_frame_info(struct unwind_frame_info *,
                                   struct task_struct *,
                                   /*const*/ struct pt_regs *);
@@ -72,6 +76,8 @@ struct unwind_frame_info {};
 
 static inline void unwind_init(void) {}
 
+#ifdef CONFIG_MODULES
+
 static inline void *unwind_add_table(struct module *mod,
                                      const void *table_start,
                                      unsigned long table_size)
@@ -79,6 +85,8 @@ static inline void *unwind_add_table(str
 	return NULL;
 }
 
+#endif
+
 static inline void unwind_remove_table(void *handle, int init_only)
 {
 }
Index: 2.6.17-rc5-unwind-generic/kernel/unwind.c
===================================================================
--- 2.6.17-rc5-unwind-generic.orig/kernel/unwind.c	2006-06-02 13:23:30.000000000 +0200
+++ 2.6.17-rc5-unwind-generic/kernel/unwind.c	2006-06-02 13:32:48.000000000 +0200
@@ -172,6 +172,8 @@ void __init unwind_init(void)
 	                  __start_unwind, __end_unwind - __start_unwind);
 }
 
+#ifdef CONFIG_MODULES
+
 /* Must be called with module_mutex held. */
 void *unwind_add_table(struct module *module,
                        const void *table_start,
@@ -253,6 +255,8 @@ void unwind_remove_table(void *handle, i
 		kfree(table);
 }
 
+#endif /* CONFIG_MODULES */
+
 static uleb128_t get_uleb128(const u8 **pcur, const u8 *end)
 {
 	const u8 *cur = *pcur;



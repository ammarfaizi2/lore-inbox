Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWE2Vqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWE2Vqc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWE2VXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:23:34 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:62903 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751315AbWE2VXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:23:12 -0400
Date: Mon, 29 May 2006 23:23:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 06/61] lock validator: add __module_address() method
Message-ID: <20060529212333.GF3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

add __module_address() method - to be used by lockdep.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 include/linux/module.h |    6 ++++++
 kernel/module.c        |   14 ++++++++++++++
 2 files changed, 20 insertions(+)

Index: linux/include/linux/module.h
===================================================================
--- linux.orig/include/linux/module.h
+++ linux/include/linux/module.h
@@ -371,6 +371,7 @@ static inline int module_is_live(struct 
 /* Is this address in a module? (second is with no locks, for oops) */
 struct module *module_text_address(unsigned long addr);
 struct module *__module_text_address(unsigned long addr);
+int __module_address(unsigned long addr);
 
 /* Returns module and fills in value, defined and namebuf, or NULL if
    symnum out of range. */
@@ -509,6 +510,11 @@ static inline struct module *__module_te
 	return NULL;
 }
 
+static inline int __module_address(unsigned long addr)
+{
+	return 0;
+}
+
 /* Get/put a kernel symbol (calls should be symmetric) */
 #define symbol_get(x) ({ extern typeof(x) x __attribute__((weak)); &(x); })
 #define symbol_put(x) do { } while(0)
Index: linux/kernel/module.c
===================================================================
--- linux.orig/kernel/module.c
+++ linux/kernel/module.c
@@ -2222,6 +2222,20 @@ const struct exception_table_entry *sear
 	return e;
 }
 
+/*
+ * Is this a valid module address? We don't grab the lock.
+ */
+int __module_address(unsigned long addr)
+{
+	struct module *mod;
+
+	list_for_each_entry(mod, &modules, list)
+		if (within(addr, mod->module_core, mod->core_size))
+			return 1;
+	return 0;
+}
+
+
 /* Is this a valid kernel address?  We don't grab the lock: we are oopsing. */
 struct module *__module_text_address(unsigned long addr)
 {

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261599AbSL2Uri>; Sun, 29 Dec 2002 15:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261640AbSL2Uri>; Sun, 29 Dec 2002 15:47:38 -0500
Received: from verein.lst.de ([212.34.181.86]:17163 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S261599AbSL2Urf>;
	Sun, 29 Dec 2002 15:47:35 -0500
Date: Sun, 29 Dec 2002 21:55:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] more deprectation bits
Message-ID: <20021229215554.A11360@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the deprecated attribute to __deprecated to make it obvious
this is something special and to avoid namespace clashes.

Mark more functionality deprecated:

 - sleep_on & friends
 - old module interfaces

This gives quite a lot warnings, I'll start to fix the ones in
core code and stuff I maintain now..


--- 1.7/include/linux/compiler.h	Sat Dec 28 12:45:03 2002
+++ edited/include/linux/compiler.h	Sun Dec 29 18:52:54 2002
@@ -21,9 +21,9 @@
  * and then gcc will emit a warning for each usage of the function.
  */
 #if __GNUC__ >= 3
-#define deprecated	__attribute__((deprecated))
+#define __deprecated	__attribute__((deprecated))
 #else
-#define deprecated
+#define __deprecated
 #endif
 
 /* This macro obfuscates arithmetic on a variable address so that gcc
--- 1.5/include/linux/ioport.h	Sat Dec 28 17:14:46 2002
+++ edited/include/linux/ioport.h	Sun Dec 29 18:53:36 2002
@@ -108,7 +108,7 @@
 #define check_mem_region(start,n)	__check_region(&iomem_resource, (start), (n))
 #define release_mem_region(start,n)	__release_region(&iomem_resource, (start), (n))
 
-extern int deprecated __check_region(struct resource *, unsigned long, unsigned long);
+extern int __deprecated __check_region(struct resource *, unsigned long, unsigned long);
 extern void __release_region(struct resource *, unsigned long, unsigned long);
 
 #define get_ioport_list(buf)	get_resource_list(&ioport_resource, buf, PAGE_SIZE)
--- 1.30/include/linux/module.h	Mon Dec  2 01:44:43 2002
+++ edited/include/linux/module.h	Sun Dec 29 19:50:27 2002
@@ -296,9 +296,20 @@
 #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:" #x)
 
 /* BELOW HERE ALL THESE ARE OBSOLETE AND WILL VANISH */
-#define __MOD_INC_USE_COUNT(mod) \
-	do { __unsafe(mod); (void)try_module_get(mod); } while(0)
-#define __MOD_DEC_USE_COUNT(mod) module_put(mod)
+static inline void __deprecated __MOD_INC_USE_COUNT(struct module *module)
+{
+	__unsafe(module);
+	/*
+	 * Yes, we ignore the retval here, that's why it's deprecated.
+	 */
+	try_module_get(module);
+}
+
+static inline void __deprecated __MOD_DEC_USE_COUNT(struct module *module)
+{
+	module_put(module);
+}
+
 #define SET_MODULE_OWNER(dev) ((dev)->owner = THIS_MODULE)
 
 struct obsolete_modparm {
@@ -319,14 +330,21 @@
 /* People do this inside their init routines, when the module isn't
    "live" yet.  They should no longer be doing that, but
    meanwhile... */
+static inline void __deprecated _MOD_INC_USE_COUNT(struct module *module)
+{
+	__unsafe(module);
+
 #if defined(CONFIG_MODULE_UNLOAD) && defined(MODULE)
-#define MOD_INC_USE_COUNT	\
-	do { __unsafe(THIS_MODULE); local_inc(&THIS_MODULE->ref[get_cpu()].count); put_cpu(); } while (0)
+	local_inc(&module->ref[get_cpu()].count);
+	put_cpu();
 #else
-#define MOD_INC_USE_COUNT \
-	do { __unsafe(THIS_MODULE); (void)try_module_get(THIS_MODULE); } while (0)
+	try_module_get(module);
 #endif
-#define MOD_DEC_USE_COUNT module_put(THIS_MODULE)
+}
+#define MOD_INC_USE_COUNT \
+	_MOD_INC_USE_COUNT(THIS_MODULE)
+#define MOD_DEC_USE_COUNT \
+	__MOD_DEC_USE_COUNT(THIS_MODULE)
 #define try_inc_mod_count(mod) try_module_get(mod)
 #define EXPORT_NO_SYMBOLS
 extern int module_dummy_usage;
@@ -364,5 +382,4 @@
 extern const void *inter_module_get(const char *);
 extern const void *inter_module_get_request(const char *, const char *);
 extern void inter_module_put(const char *);
-
 #endif /* _LINUX_MODULE_H */
--- 1.12/include/linux/wait.h	Fri Nov 15 10:36:32 2002
+++ edited/include/linux/wait.h	Sun Dec 29 19:05:26 2002
@@ -11,6 +11,7 @@
 #ifdef __KERNEL__
 
 #include <linux/config.h>
+#include <linux/compiler.h>
 #include <linux/list.h>
 #include <linux/stddef.h>
 #include <linux/spinlock.h>
@@ -244,11 +245,11 @@
  * They are racy.  DO NOT use them, use the wait_event* interfaces above.  
  * We plan to remove these interfaces during 2.7.
  */
-extern void FASTCALL(sleep_on(wait_queue_head_t *q));
-extern long FASTCALL(sleep_on_timeout(wait_queue_head_t *q,
+extern void __deprecated FASTCALL(sleep_on(wait_queue_head_t *q));
+extern long __deprecated FASTCALL(sleep_on_timeout(wait_queue_head_t *q,
 				      signed long timeout));
-extern void FASTCALL(interruptible_sleep_on(wait_queue_head_t *q));
-extern long FASTCALL(interruptible_sleep_on_timeout(wait_queue_head_t *q,
+extern void __deprecated FASTCALL(interruptible_sleep_on(wait_queue_head_t *q));
+extern long __deprecated FASTCALL(interruptible_sleep_on_timeout(wait_queue_head_t *q,
 						    signed long timeout));
 
 /*
--- 1.7/kernel/resource.c	Sat Dec 28 17:05:55 2002
+++ edited/kernel/resource.c	Sun Dec 29 18:53:07 2002
@@ -237,7 +237,7 @@
 	return res;
 }
 
-int deprecated __check_region(struct resource *parent, unsigned long start, unsigned long n)
+int __deprecated __check_region(struct resource *parent, unsigned long start, unsigned long n)
 {
 	struct resource * res;
 
===== kernel/sched.c 1.145 vs edited =====
--- 1.145/kernel/sched.c	Mon Dec  2 08:06:13 2002
+++ edited/kernel/sched.c	Sun Dec 29 18:57:50 2002
@@ -1238,7 +1238,7 @@
 	__remove_wait_queue(q, &wait);				\
 	spin_unlock_irqrestore(&q->lock, flags);
 
-void interruptible_sleep_on(wait_queue_head_t *q)
+void __deprecated interruptible_sleep_on(wait_queue_head_t *q)
 {
 	SLEEP_ON_VAR
 
@@ -1249,7 +1249,7 @@
 	SLEEP_ON_TAIL
 }
 
-long interruptible_sleep_on_timeout(wait_queue_head_t *q, long timeout)
+long __deprecated interruptible_sleep_on_timeout(wait_queue_head_t *q, long timeout)
 {
 	SLEEP_ON_VAR
 
@@ -1262,7 +1262,7 @@
 	return timeout;
 }
 
-void sleep_on(wait_queue_head_t *q)
+void __deprecated sleep_on(wait_queue_head_t *q)
 {
 	SLEEP_ON_VAR
 	
@@ -1273,7 +1273,7 @@
 	SLEEP_ON_TAIL
 }
 
-long sleep_on_timeout(wait_queue_head_t *q, long timeout)
+long __deprecated sleep_on_timeout(wait_queue_head_t *q, long timeout)
 {
 	SLEEP_ON_VAR
 	

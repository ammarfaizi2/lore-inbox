Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262755AbVBYR0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262755AbVBYR0h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 12:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbVBYR0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 12:26:37 -0500
Received: from fire.osdl.org ([65.172.181.4]:38326 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262755AbVBYR02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 12:26:28 -0500
Date: Fri, 25 Feb 2005 09:26:21 -0800
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org
Cc: linux-audit@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] detangle audit.h from fs.h
Message-ID: <20050225172621.GA15867@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently touching audit.h triggers a large rebuild because it's sucked
in via fs.h.  It's there because of the getname()/putname() requirements
that come with CONFIG_AUDITSYSCALL.  Remove header dependency by pushing
relevant putname() implementation into fs/namei.c.  It adds function
call overhead for putname() callers when CONFIG_AUDITSYSCALL is set,
quite minor cost for detangled source.  Any objections?

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== include/linux/fs.h 1.378 vs edited =====
--- 1.378/include/linux/fs.h	2005-02-22 16:17:36 -08:00
+++ edited/include/linux/fs.h	2005-02-24 15:59:53 -08:00
@@ -210,7 +210,6 @@ extern int dir_notify_enable;
 #include <linux/list.h>
 #include <linux/radix-tree.h>
 #include <linux/prio_tree.h>
-#include <linux/audit.h>
 #include <linux/init.h>
 
 #include <asm/atomic.h>
@@ -1268,13 +1267,7 @@ extern void __init vfs_caches_init(unsig
 #ifndef CONFIG_AUDITSYSCALL
 #define putname(name)   __putname(name)
 #else
-#define putname(name)							\
-	do {								\
-		if (unlikely(current->audit_context))			\
-			audit_putname(name);				\
-		else							\
-			__putname(name);				\
-	} while (0)
+extern void putname(const char *name);
 #endif
 
 extern int register_blkdev(unsigned int, const char *);
===== fs/namei.c 1.118 vs edited =====
--- 1.118/fs/namei.c	2005-01-20 21:00:21 -08:00
+++ edited/fs/namei.c	2005-02-24 15:58:47 -08:00
@@ -148,10 +148,21 @@ char * getname(const char __user * filen
 			result = ERR_PTR(retval);
 		}
 	}
-	if (unlikely(current->audit_context) && !IS_ERR(result) && result)
-		audit_getname(result);
+	audit_getname(result);
 	return result;
 }
+
+#ifdef CONFIG_AUDITSYSCALL
+void putname(const char *name)
+{
+	if (unlikely(current->audit_context))
+		audit_putname(name);
+	else
+		__putname(name);
+}
+EXPORT_SYMBOL(putname);
+#endif
+
 
 /**
  * generic_permission  -  check for access rights on a Posix-like filesystem
===== kernel/auditsc.c 1.6 vs edited =====
--- 1.6/kernel/auditsc.c	2005-01-30 22:33:47 -08:00
+++ edited/kernel/auditsc.c	2005-02-24 16:06:06 -08:00
@@ -800,7 +800,9 @@ void audit_getname(const char *name)
 {
 	struct audit_context *context = current->audit_context;
 
-	BUG_ON(!context);
+	if (!context || IS_ERR(name) || !name)
+		return;
+
 	if (!context->in_syscall) {
 #if AUDIT_DEBUG == 2
 		printk(KERN_ERR "%s:%d(:%d): ignoring getname(%p)\n",
@@ -855,7 +857,6 @@ void audit_putname(const char *name)
 	}
 #endif
 }
-EXPORT_SYMBOL(audit_putname);
 
 /* Store the inode and device from a lookup.  Called from
  * fs/namei.c:path_lookup(). */
===== fs/proc/base.c 1.88 vs edited =====
--- 1.88/fs/proc/base.c	2005-01-30 22:33:47 -08:00
+++ edited/fs/proc/base.c	2005-02-24 16:03:06 -08:00
@@ -32,6 +32,7 @@
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/ptrace.h>
+#include <linux/audit.h>
 #include "internal.h"
 
 /*

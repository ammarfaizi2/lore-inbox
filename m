Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVBAABv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVBAABv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 19:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbVBAAAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 19:00:23 -0500
Received: from lists.us.dell.com ([143.166.224.162]:59830 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261454AbVAaXuo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 18:50:44 -0500
Date: Mon, 31 Jan 2005 17:50:39 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 2.6.11-rc2] vmlinux: add SETUP_DESC() to describe __setup() options
Message-ID: <20050131235039.GD24164@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__setup() options are traditionally documented in
Documentation/kernel-parameters.txt.  However, it would be nice if
they could be documented alongside the implementation, similar to
MODULE_PARM_DESC() fields for modules, and if 'modinfo vmlinux' could
report such.

Patch below adds a new macro, SETUP_DESC(), which can be used to
document the use cases of __setup() options.  A usage example in
kernel/audit.c is provided as well.

$ modinfo vmlinux | grep setup_param
setup_param:    audit:0 = disable, 1 = enable (kernel/audit.c)

Feedback requested.

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

===== include/linux/init.h 1.35 vs edited =====
--- 1.35/include/linux/init.h	2005-01-04 20:48:02 -06:00
+++ edited/include/linux/init.h	2005-01-31 17:22:41 -06:00
@@ -127,6 +127,15 @@
 		__attribute__((aligned((sizeof(long)))))	\
 		= { __setup_str_##unique_id, fn, early }
 
+#define __setup_cat(a) __setup_str_ ## a
+#define __SETUP_INFO(tag, name, info)					  \
+static const char __setup_cat(name)[]				          \
+  __attribute_used__							  \
+  __attribute__((section(".modinfo"),unused)) = __stringify(tag) "=" info " (" __FILE__ ")"
+
+#define SETUP_DESC(_parm, desc) \
+        __SETUP_INFO(setup_param, _parm, #_parm ":" desc)
+
 #define __setup_null_param(str, unique_id)			\
 	__setup_param(str, unique_id, NULL, 0)
 
@@ -202,6 +211,7 @@
 #define __setup_null_param(str, unique_id) 	/* nothing */
 #define __setup(str, func) 			/* nothing */
 #define __obsolete_setup(str) 			/* nothing */
+#define SETUP_DESC(_parm, desc)		        /* nothing */
 #endif
 
 /* Data marked not to be saved by software_suspend() */



===== kernel/audit.c 1.6 vs edited =====
--- 1.6/kernel/audit.c	2005-01-20 22:56:04 -06:00
+++ edited/kernel/audit.c	2005-01-31 15:55:43 -06:00
@@ -617,7 +617,7 @@
 }
 
 __setup("audit=", audit_enable);
-
+SETUP_DESC(audit, "0 = disable, 1 = enable");
 
 /* Obtain an audit buffer.  This routine does locking to obtain the
  * audit buffer, but then no locking is required for calls to

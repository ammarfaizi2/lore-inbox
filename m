Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWGXRxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWGXRxJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 13:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWGXRwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 13:52:53 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:64986 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932263AbWGXRva
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 13:51:30 -0400
Subject: [RFC][PATCH 5/6] SLIM: make and config stuff
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>
Cc: Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
Content-Type: text/plain
Date: Mon, 24 Jul 2006 10:51:43 -0700
Message-Id: <1153763503.5171.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the Makefile, Kconfig and .h files for SLIM.

Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
security/Kconfig       |    1
security/Makefile      |    1
security/slim/Kconfig  |    6 ++
security/slim/Makefile |    6 ++
security/slim/slim.h   |  102 +++++++++++++++++++++++++++++++++++++++
5 files changed, 116 insertions(+)

--- linux-2.6.17/security/slim/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17/security/slim/Makefile	2006-07-06 14:24:00.000000000 -0700
@@ -0,0 +1,6 @@
+#
+# Makefile for building the SLIM module as part of the kernel tree.
+#
+
+obj-$(CONFIG_SECURITY_SLIM) += slim.o
+slim-y 	:= slm_main.o slm_secfs.o
--- linux-2.6.17/security/slim/Kconfig	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17/security/slim/Kconfig	2006-07-05 09:23:11.000000000 -0700
@@ -0,0 +1,6 @@
+config SECURITY_SLIM
+	tristate "SLIM support"
+	depends on SECURITY && SECURITY_NETWORK
+	help
+	  The Simple Linux Integrity Module implements a modified low water-mark
+	  mandatory access control integrity model.
--- linux-2.6.17/security/Makefile	2006-04-26 19:19:25.000000000 -0700
+++ linux-2.6.17/security/Makefile	2006-07-05 11:51:35.000000000 -0700
@@ -3,6 +3,7 @@
 #
 
 obj-$(CONFIG_KEYS)			+= keys/
+obj-$(CONFIG_SECURITY_SLIM)		+= slim/
 subdir-$(CONFIG_SECURITY_SELINUX)	+= selinux
 
 # if we don't select a security model, use the default capabilities
--- linux-2.6.17/security/Kconfig	2006-04-26 19:19:25.000000000 -0700
+++ linux-2.6.17/security/Kconfig	2006-07-05 09:23:11.000000000 -0700
@@ -101,5 +101,6 @@ config SECURITY_SECLVL
 
 source security/selinux/Kconfig
 
+source security/slim/Kconfig
 endmenu
 
--- linux-2.6.17/security/slim/slim.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17/security/slim/slim.h	2006-07-13 16:23:05.000000000 -0700
@@ -0,0 +1,102 @@
+/*
+ * slim.h - simple linux integrity module
+ *
+ * SLIM's specific model is:
+ *
+ *  All objects are labeled with exteded attributes to indicate:
+ *      Integrity Access Class (IAC)
+ *      Secrecy Access Class (SAC)
+ *
+ *  All processes inherit from their parents:
+ *      Integrity Read Access Class (IRAC)
+ *      Integrity Write/Execute Access Class (IWXAC)
+ *      Secrecy Write Access Class (SWAC)
+ *      Secrecy Read/Execute Access Class (SRXAC)
+ *
+ *  SLIM enforces the following Mandatory Access Control Rules:
+ *      Read:
+ *          IRAC(process) <= IAC(object)
+ *          SRXAC(process) >= SAC(object)
+ *      Write:
+ *          IWXAC(process) >= IAC(object)
+ *          SWAC(process) <= SAC(process)
+ *      Execute:
+ *          IWXAC(process) <= IAC(object)
+ *          SRXAC(process) >= SAC(object)
+*/
+
+#include <linux/security.h>
+#include <linux/version.h>
+#include <linux/spinlock_types.h>
+
+struct xattr_data {
+	char *name;
+	void *value;
+	size_t len;
+};
+
+ssize_t generic_getxattr(struct dentry *dentry, const char *name, void *buffer,
+			 size_t size);
+ssize_t generic_listxattr(struct dentry *dentry, char *buffer,
+			  size_t buffer_size);
+int generic_setxattr(struct dentry *dentry, const char *name, const void *value,
+		     size_t size, int flags);
+enum slm_iac_level {		/* integrity access class */
+	SLM_IAC_ERROR = -2,
+	SLM_IAC_EXEMPT = -1, 
+	SLM_IAC_NOTDEFINED = 0, 
+	SLM_IAC_UNTRUSTED,
+	SLM_IAC_USER, 
+	SLM_IAC_SYSTEM, 
+	SLM_IAC_HIGHEST
+};
+extern char *slm_iac_str[];
+
+enum slm_sac_level {		/* secrecy access class */
+	SLM_SAC_ERROR = -2,
+	SLM_SAC_EXEMPT = -1, 
+	SLM_SAC_NOTDEFINED = 0,
+	SLM_SAC_PUBLIC, 
+	SLM_SAC_USER,
+	SLM_SAC_USER_SENSITIVE, 
+	SLM_SAC_SYSTEM_SENSITIVE, 
+	SLM_SAC_HIGHEST
+};
+
+struct slm_tsec_data {		/* task security data (process info) */
+	enum slm_iac_level iac_r;	/* read low integrity files */
+	enum slm_iac_level iac_wx;	/* ability to write/execute higher */
+	enum slm_sac_level sac_w;	/* ability to write low secrecy files */
+	enum slm_sac_level sac_rx;	/* read/execute high secrecy files */
+	int unlimited;		/* unlimited guard process */
+	struct dentry *script_dentry;	/* used when filename != interp */
+	spinlock_t lock;
+};
+
+struct slm_file_xattr {		/* file extended attributes */
+	enum slm_iac_level iac_level;	/* integrity */
+	enum slm_sac_level sac_level;	/* secrecy */
+	struct slm_tsec_data guard;	/* guard process information */
+};
+
+#define SLM_LSM_ID 0x999
+extern int slm_idx;
+
+struct slm_isec_data {
+	struct slm_file_xattr level;
+	spinlock_t lock;
+};
+
+static inline int is_kernel_thread(struct task_struct *tsk)
+{
+	return (!tsk->mm) ? 1 : 0;
+}
+
+extern struct slm_xattr_config *slm_parse_config(char *data,
+						 unsigned long datalen,
+						 int *datasize);
+
+extern int slm_init_config(void);
+
+extern __init int slm_init_secfs(void);
+extern __exit void slm_cleanup_secfs(void);



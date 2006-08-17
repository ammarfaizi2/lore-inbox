Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbWHQTyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbWHQTyS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 15:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbWHQTyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 15:54:05 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:20189 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030220AbWHQTxp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 15:53:45 -0400
Subject: [RFC][PATCH 6/8] SLIM: make and config stuff
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>
Cc: Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 12:53:30 -0700
Message-Id: <1155844410.6788.60.camel@localhost.localdomain>
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

--- linux-2.6.18-rc3/security/slim/slim.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.18-rc3-working/security/slim/slim.h	2006-08-07 13:00:14.000000000 -0500
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
--- linux-2.6.18-rc3/security/slim/Makefile	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.18-rc3-working/security/slim/Makefile	2006-08-04 13:29:13.000000000 -0500
@@ -0,0 +1,6 @@
+#
+# Makefile for building the SLIM module as part of the kernel tree.
+#
+
+obj-$(CONFIG_SECURITY_SLIM) += slim.o
+slim-y 	:= slm_main.o slm_secfs.o
--- linux-2.6.18-rc3/security/slim/Kconfig	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.18-rc3-working/security/slim/Kconfig	2006-08-04 13:29:13.000000000 -0500
@@ -0,0 +1,6 @@
+config SECURITY_SLIM
+	boolean "SLIM support"
+	depends on SECURITY && SECURITY_NETWORK
+	help
+	  The Simple Linux Integrity Module implements a modified low water-mark
+	  mandatory access control integrity model.
--- linux-2.6.18-rc3/security/Makefile	2006-07-30 01:15:36.000000000 -0500
+++ linux-2.6.18-rc3-working/security/Makefile	2006-08-01 12:21:24.000000000 -0500
@@ -3,6 +3,7 @@
 #
 
 obj-$(CONFIG_KEYS)			+= keys/
+obj-$(CONFIG_SECURITY_SLIM)		+= slim/
 subdir-$(CONFIG_SECURITY_SELINUX)	+= selinux
 
 # if we don't select a security model, use the default capabilities
--- linux-2.6.18-rc3/security/Kconfig	2006-07-30 01:15:36.000000000 -0500
+++ linux-2.6.18-rc3-working/security/Kconfig	2006-08-01 12:21:24.000000000 -0500
@@ -107,5 +107,6 @@ config SECURITY_SECLVL
 
 source security/selinux/Kconfig
 
+source security/slim/Kconfig
 endmenu
 



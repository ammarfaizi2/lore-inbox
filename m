Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbTJGBJL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 21:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTJGBJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 21:09:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61970 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261780AbTJGBJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 21:09:05 -0400
Date: Mon, 6 Oct 2003 21:09:11 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, <linux-kernel@vger.kernel.org>,
       <selinux@tycho.nsa.gov>
Subject: [PATCH][SELINUX] add policyvers to selinuxfs
Message-ID: <Pine.LNX.4.44.0310062102040.2813-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a file to the root selinuxfs directory which returns the
security policy version associated with the currently running kernel.  
Its purpose is to allow scripts to determine which version of policy to
load.

Please apply.


- James
-- 
James Morris
<jmorris@redhat.com>

diff -urN -X dontdiff linux-2.6.0-test6-mm2.orig/security/selinux/include/security.h linux-2.6.0-test6-mm2.w1/security/selinux/include/security.h
--- linux-2.6.0-test6-mm2.orig/security/selinux/include/security.h	2003-09-27 20:50:07.000000000 -0400
+++ linux-2.6.0-test6-mm2.w1/security/selinux/include/security.h	2003-10-03 15:06:59.901346808 -0400
@@ -13,6 +13,7 @@
 #define SECCLASS_NULL			0x0000 /* no class */
 
 #define SELINUX_MAGIC 0xf97cff8c
+#define POLICYDB_VERSION 15
 
 #ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
 extern int selinux_enabled;
diff -urN -X dontdiff linux-2.6.0-test6-mm2.orig/security/selinux/selinuxfs.c linux-2.6.0-test6-mm2.w1/security/selinux/selinuxfs.c
--- linux-2.6.0-test6-mm2.orig/security/selinux/selinuxfs.c	2003-09-27 20:51:22.000000000 -0400
+++ linux-2.6.0-test6-mm2.w1/security/selinux/selinuxfs.c	2003-10-03 15:04:31.579895096 -0400
@@ -37,7 +37,8 @@
 	SEL_ACCESS,	/* compute access decision */
 	SEL_CREATE,	/* compute create labeling decision */
 	SEL_RELABEL,	/* compute relabeling decision */
-	SEL_USER	/* compute reachable user contexts */
+	SEL_USER,	/* compute reachable user contexts */
+	SEL_POLICYVERS	/* return policy version for this kernel */
 };
 
 static ssize_t sel_read_enforce(struct file *filp, char *buf,
@@ -125,6 +126,46 @@
 	.write		= sel_write_enforce,
 };
 
+static ssize_t sel_read_policyvers(struct file *filp, char *buf,
+                                   size_t count, loff_t *ppos)
+{
+	char *page;
+	ssize_t length;
+	ssize_t end;
+
+	if (count < 0 || count > PAGE_SIZE)
+		return -EINVAL;
+	if (!(page = (char*)__get_free_page(GFP_KERNEL)))
+		return -ENOMEM;
+	memset(page, 0, PAGE_SIZE);
+
+	length = snprintf(page, PAGE_SIZE, "%u", POLICYDB_VERSION);
+	if (length < 0) {
+		free_page((unsigned long)page);
+		return length;
+	}
+
+	if (*ppos >= length) {
+		free_page((unsigned long)page);
+		return 0;
+	}
+	if (count + *ppos > length)
+		count = length - *ppos;
+	end = count + *ppos;
+	if (copy_to_user(buf, (char *) page + *ppos, count)) {
+		count = -EFAULT;
+		goto out;
+	}
+	*ppos = end;
+out:
+	free_page((unsigned long)page);
+	return count;
+}
+
+static struct file_operations sel_policyvers_ops = {
+	.read		= sel_read_policyvers,
+};
+
 static ssize_t sel_write_load(struct file * file, const char * buf,
 			      size_t count, loff_t *ppos)
 
@@ -568,6 +609,7 @@
 		[SEL_CREATE] = {"create", &transaction_ops, S_IRUGO|S_IWUGO},
 		[SEL_RELABEL] = {"relabel", &transaction_ops, S_IRUGO|S_IWUGO},
 		[SEL_USER] = {"user", &transaction_ops, S_IRUGO|S_IWUGO},
+		[SEL_POLICYVERS] = {"policyvers", &sel_policyvers_ops, S_IRUGO},
 		/* last one */ {""}
 	};
 	return simple_fill_super(sb, SELINUX_MAGIC, selinux_files);
diff -urN -X dontdiff linux-2.6.0-test6-mm2.orig/security/selinux/ss/policydb.h linux-2.6.0-test6-mm2.w1/security/selinux/ss/policydb.h
--- linux-2.6.0-test6-mm2.orig/security/selinux/ss/policydb.h	2003-09-27 20:50:38.000000000 -0400
+++ linux-2.6.0-test6-mm2.w1/security/selinux/ss/policydb.h	2003-10-03 15:06:59.291439528 -0400
@@ -225,7 +225,6 @@
 
 #define PERM_SYMTAB_SIZE 32
 
-#define POLICYDB_VERSION 15
 #define POLICYDB_CONFIG_MLS    1
 
 #define OBJECT_R "object_r"


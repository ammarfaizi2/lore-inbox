Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbVHVVaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbVHVVaz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbVHVVaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:30:55 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:28800 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751167AbVHVVay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:30:54 -0400
Date: Mon, 22 Aug 2005 03:20:28 -0500
From: serue@us.ibm.com
To: serue@us.ibm.com
Cc: lkml <linux-kernel@vger.kernel.org>, linux-security-module@wirex.com,
       Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH -mm 3/3] [LSM] Stacking support for inode_init_security
Message-ID: <20050822082028.GB25390@sergelap.austin.ibm.com>
References: <20050822080401.GA26125@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050822080401.GA26125@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds two stackable test LSMs which only define
inode_init_security().  Any file created while these modules are
loaded should have the xattrs ("security.name1", "value1") and
("security.name2", "value2").

thanks,
-serge

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
--
 testinitsec1.c |   75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 testinitsec2.c |   75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 150 insertions(+)

Index: linux-2.6.13-rc6-mm1/security/testinitsec1.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.13-rc6-mm1/security/testinitsec1.c	2005-08-19 17:01:57.000000000 -0500
@@ -0,0 +1,75 @@
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/security.h>
+
+#define VALUE "value1"
+#define NAME "name1"
+#define MY_NAME "testinitsec1"
+static int test_init_security(struct inode *inode, struct inode *dir,
+				       struct list_head *head)
+{
+	char *namep = NULL, *valuep = NULL;
+	struct xattr_data *data = NULL;
+
+	if (!head)
+		return 0;
+
+	data = kmalloc(sizeof(struct xattr_data), GFP_KERNEL);
+	if (!data)
+		goto err;
+	namep = kmalloc(32, GFP_KERNEL);
+	if (!namep)
+		goto err;
+	valuep = kmalloc(32, GFP_KERNEL);
+	if (!valuep)
+		goto err;
+
+	strcpy(namep, NAME);
+	strcpy(valuep, VALUE);
+	data->name = namep;
+	data->value = valuep;
+	data->len = strlen(VALUE);
+	INIT_LIST_HEAD(&data->list);
+	list_add_tail(&data->list, head);
+	return 0;
+err:
+	kfree(namep);
+	kfree(valuep);
+	kfree(data);
+	return -ENOMEM;
+}
+
+static struct security_operations testlsm_security_ops = {
+	.owner =			THIS_MODULE,
+
+	.inode_init_security =		test_init_security,
+};
+
+static int __init testlsm_init (void)
+{
+	if (mod_reg_security (MY_NAME, &testlsm_security_ops, NULL)) {
+		printk (KERN_INFO "Failure registering testlsm "
+			" module with primary security module.\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+
+static void __exit testlsm_exit (void)
+{
+	if (unregister_security (&testlsm_security_ops)) {
+		printk (KERN_INFO "Failure unregistering testlsm "
+			"module with the kernel\n");
+	}
+	printk (KERN_INFO "init_security test module removed\n");
+}
+
+security_initcall (testlsm_init);
+module_exit (testlsm_exit);
+
+MODULE_DESCRIPTION("inode_initsecurity test LSM module");
+MODULE_LICENSE("GPL");
+
Index: linux-2.6.13-rc6-mm1/security/testinitsec2.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.13-rc6-mm1/security/testinitsec2.c	2005-08-19 17:01:57.000000000 -0500
@@ -0,0 +1,75 @@
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/security.h>
+
+#define VALUE "value2"
+#define NAME "name2"
+#define MY_NAME "testinitsec2"
+static int test_init_security(struct inode *inode, struct inode *dir,
+				       struct list_head *head)
+{
+	char *namep = NULL, *valuep = NULL;
+	struct xattr_data *data = NULL;
+
+	if (!head)
+		return 0;
+
+	data = kmalloc(sizeof(struct xattr_data), GFP_KERNEL);
+	if (!data)
+		goto err;
+	namep = kmalloc(32, GFP_KERNEL);
+	if (!namep)
+		goto err;
+	valuep = kmalloc(32, GFP_KERNEL);
+	if (!valuep)
+		goto err;
+
+	strcpy(namep, NAME);
+	strcpy(valuep, VALUE);
+	data->name = namep;
+	data->value = valuep;
+	data->len = strlen(VALUE);
+	INIT_LIST_HEAD(&data->list);
+	list_add_tail(&data->list, head);
+	return 0;
+err:
+	kfree(namep);
+	kfree(valuep);
+	kfree(data);
+	return -ENOMEM;
+}
+
+static struct security_operations testlsm_security_ops = {
+	.owner =			THIS_MODULE,
+
+	.inode_init_security =		test_init_security,
+};
+
+static int __init testlsm_init (void)
+{
+	if (mod_reg_security (MY_NAME, &testlsm_security_ops, NULL)) {
+		printk (KERN_INFO "Failure registering testlsm "
+			" module with primary security module.\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+
+static void __exit testlsm_exit (void)
+{
+	if (unregister_security (&testlsm_security_ops)) {
+		printk (KERN_INFO "Failure unregistering testlsm "
+			"module with the kernel\n");
+	}
+	printk (KERN_INFO "init_security test module removed\n");
+}
+
+security_initcall (testlsm_init);
+module_exit (testlsm_exit);
+
+MODULE_DESCRIPTION("inode_initsecurity test LSM module");
+MODULE_LICENSE("GPL");
+

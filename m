Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262509AbVC2H1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbVC2H1W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 02:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbVC2H1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 02:27:13 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:53336 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262509AbVC2HNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 02:13:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=umgt6puxkpE7sChl2yKcfSzzpH2j9fkcjTYIoz2qUURBwqLVyVYCZOTeQpEICNP+XsucV2YvQLl4HrjMz7BZD0pfssytofWoCAZ+QiJVbdCB8xAfAOmVkI3ksKPRq27hr3fVQvVZscRke0BpACUYWvJO979CCN6HL/oEufwKogU=
Message-ID: <df35dfeb05032823137a208b46@mail.gmail.com>
Date: Mon, 28 Mar 2005 23:13:38 -0800
From: Yum Rayan <yum.rayan@gmail.com>
Reply-To: Yum Rayan <yum.rayan@gmail.com>
To: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: [PATCH] Reduce stack usage in module.c
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attempt to reduce stack usage in module.c (linux-2.6.12-rc1-mm3). 
Specifically from checkstack.pl

Before patch
------------------
who_is_doing_it: 512 
obsolete_params: 160

After patch
----------------
who_is_doing_it: none
obsolete_params: 12

Also while at it, fix following in who_is_doing_it(...)
- use only as much memory is needed
- do not write past array index for the boundary case

Patch is against linux-2.6.12-rc1-mm3

Thanks,
Rayan

Signed-off-by: Yum Rayan <yum.rayan@gmail.com>

--- kernel/module.c.orig	2005-03-28 22:32:35.000000000 -0800
+++ kernel/module.c	2005-03-28 22:49:26.000000000 -0800
@@ -769,15 +769,25 @@
 	struct kernel_param *kp;
 	unsigned int i;
 	int ret;
+	char *sym_name = NULL;
+	unsigned int sym_name_len = 0;
 
 	kp = kmalloc(sizeof(kp[0]) * num, GFP_KERNEL);
 	if (!kp)
 		return -ENOMEM;
 
-	for (i = 0; i < num; i++) {
-		char sym_name[128 + sizeof(MODULE_SYMBOL_PREFIX)];
+	if (num) {
+		sym_name_len = 128 + sizeof (MODULE_SYMBOL_PREFIX);
+		sym_name = kmalloc(sym_name_len, GFP_KERNEL);
+		if (!sym_name) {
+			ret = -ENOMEM;
+			goto free_kp;
+		}
+	}
 
-		snprintf(sym_name, sizeof(sym_name), "%s%s",
+	for (i = 0; i < num; i++) {
+		
+		snprintf(sym_name, sym_name_len, "%s%s",
 			 MODULE_SYMBOL_PREFIX, obsparm[i].name);
 
 		kp[i].name = obsparm[i].name;
@@ -791,13 +801,15 @@
 			printk("%s: falsely claims to have parameter %s\n",
 			       name, obsparm[i].name);
 			ret = -EINVAL;
-			goto out;
+			goto free_sym;
 		}
 		kp[i].arg = &obsparm[i];
 	}
 
 	ret = parse_args(name, args, kp, num, NULL);
- out:
+ free_sym:
+	kfree(sym_name);
+ free_kp:
 	kfree(kp);
 	return ret;
 }
@@ -1399,12 +1411,16 @@
 static void who_is_doing_it(void)
 {
 	/* Print out all the args. */
-	char args[512];
+	char *args;
 	unsigned long i, len = current->mm->arg_end - current->mm->arg_start;
 
 	if (len > 512)
 		len = 512;
 
+	args = kmalloc(len + 1, GFP_KERNEL);
+	if (!args)
+		return;
+
 	len -= copy_from_user(args, (void *)current->mm->arg_start, len);
 
 	for (i = 0; i < len; i++) {
@@ -1413,6 +1429,7 @@
 	}
 	args[i] = 0;
 	printk("ARGS: %s\n", args);
+	kfree(args);
 }
 
 /* Allocate and load the module: note that size of section 0 is always

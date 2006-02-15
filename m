Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422875AbWBNXsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422875AbWBNXsy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 18:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422890AbWBNXsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 18:48:53 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:47573 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422875AbWBNXsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 18:48:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=U28SgKulwxiZLoT+v6PY2b4Qqdpupm4BxaVnmNsM4SeU/L4RD78nOS470VGcmgluN/soaJ8DZKxVxl7+AnUc7Knztu8OdXOPR5Xn5M7flgSQT3T4xTytyoCOx7W4gYTnCELVVXA+CNbW6TqT7qmqkbACRw3ftOy7rYvcd52+xIg=
Date: Tue, 14 Feb 2006 21:48:40 -0300
From: Davi Arnaut <davi.arnaut@gmail.com>
To: akpm@osdl.org
Cc: davi.arnaut@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATH 1/2] strndup_user, convert (module)
Message-Id: <20060214214840.fc0434cb.davi.arnaut@gmail.com>
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert kernel/module.c string duplication to strdup_user()

Signed-off-by: Davi Arnaut <davi.arnaut@gmail.com>
--

diff --git a/kernel/module.c b/kernel/module.c
index 5aad477..d7d428d 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1538,7 +1538,6 @@ static struct module *load_module(void _
 	unsigned int i, symindex = 0, strindex = 0, setupindex, exindex,
 		exportindex, modindex, obsparmindex, infoindex, gplindex,
 		crcindex, gplcrcindex, versindex, pcpuindex;
-	long arglen;
 	struct module *mod;
 	long err = 0;
 	void *percpu = NULL, *ptr = NULL; /* Stops spurious gcc warning */
@@ -1655,23 +1654,11 @@ static struct module *load_module(void _
 	}
 
 	/* Now copy in args */
-	arglen = strlen_user(uargs);
-	if (!arglen) {
-		err = -EFAULT;
-		goto free_hdr;
-	}
-	args = kmalloc(arglen, GFP_KERNEL);
-	if (!args) {
-		err = -ENOMEM;
+	args = strdup_user(uargs);
+	if (IS_ERR(args)) {
+		err = PTR_ERR(args);
 		goto free_hdr;
 	}
-	if (copy_from_user(args, uargs, arglen) != 0) {
-		err = -EFAULT;
-		goto free_mod;
-	}
-
-	/* Userspace could have altered the string after the strlen_user() */
-	args[arglen - 1] = '\0';
 
 	if (find_module(mod->name)) {
 		err = -EEXIST;

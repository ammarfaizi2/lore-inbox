Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316825AbSGHI0N>; Mon, 8 Jul 2002 04:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316826AbSGHI0M>; Mon, 8 Jul 2002 04:26:12 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:24778 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S316825AbSGHI0L>; Mon, 8 Jul 2002 04:26:11 -0400
Message-Id: <200207080828.g688Sdo51968@d06relay02.portsmouth.uk.ibm.com>
Content-Type: text/plain; charset=US-ASCII
From: Peter Oberparleiter <oberpapr@softhome.net>
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.18/2.5.24 kernel/module.c - minor bugs
Date: Mon, 8 Jul 2002 10:27:50 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Keith Owens <kaos@ocs.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch fixes two minor bugs in kernel/module.c in current linux
kernel versions (2.4.18/2.5.24) which could cause problems in some
rare situations:


1. A size-check in sys_create_module is off by one. The check reads

        if (size < sizeof(struct module)+namelen) {
                error = -EINVAL;
                goto err1;
        }

while a subsequent write to a "size"-long buffer expects one more
byte ("mod" being the buffer pointer of type struct module*):

        memcpy((char*)(mod+1), name, namelen+1);


2. In case "struct module" used by insmod is larger than the one used
by the kernel (e.g. newer version), module loading will fail.

This is because sys_create_module initializes the module buffer with 

                      0:  struct module
  sizeof(struct module):  char[] module_name

while sys_init_module copies the insmod-provided "struct module" data into
this buffer, overwriting the adjacent module name with the extra "struct
module" fields. As a result, the following sanity check will fail

        if (namelen != n_namelen || strcmp(n_name, mod_tmp.name) != 0) {
                printk(KERN_ERR "init_module: changed module name to "
                                "%s' from %s'\n",
                       n_name, mod_tmp.name);
                goto err3;
        }

because mod_tmp.name points to the overwritten module name.

This can be easily fixed using the already existing copy of the module name
in "name_tmp".


Following is the patch implementing these two fixes (diff against 2.4.17,
works for 2.4.18, 2.5.24):

========================================
--- linux-2.4.17/kernel/module.c	Sun Nov 11 20:23:14 2001
+++ linux-2.4.17-modfix/kernel/module.c	Mon Jul  8 09:50:57 2002
@@ -303,7 +303,7 @@
 		error = namelen;
 		goto err0;
 	}
-	if (size < sizeof(struct module)+namelen) {
+	if (size < sizeof(struct module)+namelen+1) {
 		error = -EINVAL;
 		goto err1;
 	}
@@ -482,10 +482,10 @@
 		error = n_namelen;
 		goto err2;
 	}
-	if (namelen != n_namelen || strcmp(n_name, mod_tmp.name) != 0) {
+	if (namelen != n_namelen || strcmp(n_name, name_tmp) != 0) {
 		printk(KERN_ERR "init_module: changed module name to "
 				"`%s' from `%s'\n",
-		       n_name, mod_tmp.name);
+		       n_name, name_tmp);
 		goto err3;
 	}
 
========================================


Regards,
  Peter Oberparleiter

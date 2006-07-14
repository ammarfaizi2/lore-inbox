Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422736AbWGNTw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422736AbWGNTw7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 15:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422735AbWGNTw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 15:52:59 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:3767 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1422736AbWGNTw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 15:52:58 -0400
Message-Id: <200607141952.k6EJqOtL005577@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] UML - fix utsname build breakage
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 14 Jul 2006 15:52:23 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some -mm-only material leaked into a patch destined for mainline, and I didn't
notice.

This was the replacement of system_utsname with utsname() that's required by
the uts namespace patch.  This patch reverts those changes (which are correct
in -mm) so that mainline UML builds again.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/kernel/syscall.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/syscall.c	2006-07-14 12:42:46.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/syscall.c	2006-07-14 15:43:31.000000000 -0400
@@ -110,7 +110,7 @@ long sys_uname(struct old_utsname __user
 	if (!name)
 		return -EFAULT;
 	down_read(&uts_sem);
-	err = copy_to_user(name, utsname(), sizeof (*name));
+	err = copy_to_user(name, &system_utsname, sizeof (*name));
 	up_read(&uts_sem);
 	return err?-EFAULT:0;
 }
@@ -126,21 +126,21 @@ long sys_olduname(struct oldold_utsname 
 
   	down_read(&uts_sem);
 
-	error = __copy_to_user(&name->sysname, &utsname()->sysname,
+	error = __copy_to_user(&name->sysname,&system_utsname.sysname,
 			       __OLD_UTS_LEN);
-	error |= __put_user(0, name->sysname + __OLD_UTS_LEN);
-	error |= __copy_to_user(&name->nodename, &utsname()->nodename,
+	error |= __put_user(0,name->sysname+__OLD_UTS_LEN);
+	error |= __copy_to_user(&name->nodename,&system_utsname.nodename,
 				__OLD_UTS_LEN);
-	error |= __put_user(0, name->nodename + __OLD_UTS_LEN);
-	error |= __copy_to_user(&name->release, &utsname()->release,
+	error |= __put_user(0,name->nodename+__OLD_UTS_LEN);
+	error |= __copy_to_user(&name->release,&system_utsname.release,
 				__OLD_UTS_LEN);
-	error |= __put_user(0, name->release + __OLD_UTS_LEN);
-	error |= __copy_to_user(&name->version, &utsname()->version,
+	error |= __put_user(0,name->release+__OLD_UTS_LEN);
+	error |= __copy_to_user(&name->version,&system_utsname.version,
 				__OLD_UTS_LEN);
-	error |= __put_user(0, name->version + __OLD_UTS_LEN);
-	error |= __copy_to_user(&name->machine, &utsname()->machine,
+	error |= __put_user(0,name->version+__OLD_UTS_LEN);
+	error |= __copy_to_user(&name->machine,&system_utsname.machine,
 				__OLD_UTS_LEN);
-	error |= __put_user(0, name->machine + __OLD_UTS_LEN);
+	error |= __put_user(0,name->machine+__OLD_UTS_LEN);
 
 	up_read(&uts_sem);
 


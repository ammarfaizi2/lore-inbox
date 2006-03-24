Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbWCXSOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWCXSOB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWCXSNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:13:54 -0500
Received: from [198.99.130.12] ([198.99.130.12]:49046 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751388AbWCXSNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:13:52 -0500
Message-Id: <200603241815.k2OIF3sG005565@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 14/16] UML - Prevent umid theft
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 Mar 2006 13:15:03 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Behavior when booting two UMLs with the same umid was broken.  The
second one would steal the umid.  This fixes that, making the second
UML take a random umid instead.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/os-Linux/umid.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/umid.c	2006-02-09 18:49:55.000000000 -0500
+++ linux-2.6.15/arch/um/os-Linux/umid.c	2006-02-10 14:11:28.000000000 -0500
@@ -143,8 +143,10 @@ static int not_dead_yet(char *dir)
 		goto out_close;
 	}
 
-	if((kill(p, 0) == 0) || (errno != ESRCH))
+	if((kill(p, 0) == 0) || (errno != ESRCH)){
+		printk("umid \"%s\" is already in use by pid %d\n", umid, p);
 		return 1;
+	}
 
 	err = actually_do_remove(dir);
 	if(err)
@@ -234,33 +236,44 @@ int __init make_umid(void)
 	err = mkdir(tmp, 0777);
 	if(err < 0){
 		err = -errno;
-		if(errno != EEXIST)
+		if(err != -EEXIST)
 			goto err;
 
-		if(not_dead_yet(tmp) < 0)
+		/* 1   -> this umid is already in use
+		 * < 0 -> we couldn't remove the umid directory
+		 * In either case, we can't use this umid, so return -EEXIST.
+		 */
+		if(not_dead_yet(tmp) != 0)
 			goto err;
 
 		err = mkdir(tmp, 0777);
 	}
-	if(err < 0){
-		printk("Failed to create '%s' - err = %d\n", umid, err);
-		goto err_rmdir;
+	if(err){
+		err = -errno;
+		printk("Failed to create '%s' - err = %d\n", umid, -errno);
+		goto err;
 	}
 
 	umid_setup = 1;
 
 	create_pid_file();
 
-	return 0;
-
- err_rmdir:
-	rmdir(tmp);
+	err = 0;
  err:
 	return err;
 }
 
 static int __init make_umid_init(void)
 {
+	if(!make_umid())
+		return 0;
+
+	/* If initializing with the given umid failed, then try again with
+	 * a random one.
+	 */
+	printk("Failed to initialize umid \"%s\", trying with a random umid\n",
+	       umid);
+	*umid = '\0';
 	make_umid();
 
 	return 0;


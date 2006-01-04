Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbWACXp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbWACXp4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbWACXpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:45:55 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:38293 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S965007AbWACXpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:45:51 -0500
Message-Id: <200601040037.k040bSjg012523@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/12] UML - use kstrdup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Jan 2006 19:37:27 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There were a bunch of calls to uml_strdup dating from before kstrdup
was introduced.  This changes those calls.  It doesn't eliminate the
definition since there is still a couple of calls in userspace code (which
should probably call the libc strdup).

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/line.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/line.c	2005-12-19 21:20:32.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/line.c	2005-12-19 21:24:25.000000000 -0500
@@ -562,10 +562,11 @@ int line_setup(struct line *lines, unsig
 
 int line_config(struct line *lines, unsigned int num, char *str)
 {
-	char *new = uml_strdup(str);
+	char *new;
 
+	new = kstrdup(str, GFP_KERNEL);
 	if(new == NULL){
-		printk("line_config - uml_strdup failed\n");
+		printk("line_config - kstrdup failed\n");
 		return -ENOMEM;
 	}
 	return !line_setup(lines, num, new, 0);
@@ -677,10 +678,9 @@ void lines_init(struct line *lines, int 
 		INIT_LIST_HEAD(&line->chan_list);
 		spin_lock_init(&line->lock);
 		if(line->init_str != NULL){
-			line->init_str = uml_strdup(line->init_str);
+			line->init_str = kstrdup(line->init_str, GFP_KERNEL);
 			if(line->init_str == NULL)
-				printk("lines_init - uml_strdup returned "
-				       "NULL\n");
+				printk("lines_init - kstrdup returned NULL\n");
 		}
 	}
 }
Index: linux-2.6.15/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/mconsole_kern.c	2005-12-19 21:20:28.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/mconsole_kern.c	2005-12-19 21:21:29.000000000 -0500
@@ -563,7 +563,7 @@ int mconsole_init(void)
 	}
 
 	if(notify_socket != NULL){
-		notify_socket = uml_strdup(notify_socket);
+		notify_socket = kstrdup(notify_socket, GFP_KERNEL);
 		if(notify_socket != NULL)
 			mconsole_notify(notify_socket, MCONSOLE_SOCKET,
 					mconsole_socket_name, 
Index: linux-2.6.15/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/net_kern.c	2005-12-19 21:20:28.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/net_kern.c	2005-12-19 21:21:47.000000000 -0500
@@ -586,7 +586,7 @@ static int net_config(char *str)
 	err = eth_parse(str, &n, &str);
 	if(err) return(err);
 
-	str = uml_strdup(str);
+	str = kstrdup(str, GFP_KERNEL);
 	if(str == NULL){
 		printk(KERN_ERR "net_config failed to strdup string\n");
 		return(-1);
Index: linux-2.6.15/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/ubd_kern.c	2005-12-19 21:20:32.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/ubd_kern.c	2005-12-19 21:22:00.000000000 -0500
@@ -706,7 +706,7 @@ static int ubd_config(char *str)
 {
 	int n, err;
 
-	str = uml_strdup(str);
+	str = kstrdup(str, GFP_KERNEL);
 	if(str == NULL){
 		printk(KERN_ERR "ubd_config failed to strdup string\n");
 		return(1);


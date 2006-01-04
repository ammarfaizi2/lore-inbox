Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965157AbWACXs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbWACXs2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWACXqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:46:10 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:40341 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S965023AbWACXpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:45:53 -0500
Message-Id: <200601040037.k040bgcf012560@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 8/12] UML - line_setup interface change
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Jan 2006 19:37:42 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

line_setup is changed to return the device which it set up, rather
than just success or failure.  This will be important in the
line-config patch.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/line.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/line.c	2006-01-03 17:29:31.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/line.c	2006-01-03 17:32:25.000000000 -0500
@@ -555,12 +555,13 @@ int line_setup(struct line *lines, unsig
 			}
 		}
 	}
-	return 1;
+	return n == -1 ? num : n;
 }
 
 int line_config(struct line *lines, unsigned int num, char *str)
 {
 	char *new;
+	int n;
 
 	if(*str == '='){
 		printk("line_config - can't configure all devices from "
@@ -573,7 +574,8 @@ int line_config(struct line *lines, unsi
 		printk("line_config - kstrdup failed\n");
 		return -ENOMEM;
 	}
-	return !line_setup(lines, num, new);
+	n = line_setup(lines, num, new);
+	return n < 0 ? n : 0;
 }
 
 int line_get_config(char *name, struct line *lines, unsigned int num, char *str,
@@ -624,10 +626,14 @@ int line_id(char **str, int *start_out, 
 
 int line_remove(struct line *lines, unsigned int num, int n)
 {
+	int err;
 	char config[sizeof("conxxxx=none\0")];
 
 	sprintf(config, "%d=none", n);
-	return !line_setup(lines, num, config);
+	err = line_setup(lines, num, config);
+	if(err >= 0)
+		err = 0;
+	return err;
 }
 
 struct tty_driver *line_register_devfs(struct lines *set,


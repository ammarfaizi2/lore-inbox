Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWDOTta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWDOTta (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 15:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWDOTta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 15:49:30 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3088 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751313AbWDOTt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 15:49:29 -0400
Date: Sat, 15 Apr 2006 21:49:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: dwmw2@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] drivers/char/applicom.c: proper module_{init,exit}
Message-ID: <20060415194928.GL15022@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch:
- converts the driver to use module_{init,exit}
- let the driver print a warning if the old __setup is used

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/applicom.c |   17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

--- linux-2.6.17-rc1-mm2-full/drivers/char/applicom.c.old	2006-04-15 21:19:31.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/char/applicom.c	2006-04-15 21:23:36.000000000 +0200
@@ -166,11 +166,7 @@ static int ac_register_board(unsigned lo
 	return boardno + 1;
 }
 
-#ifdef MODULE
-
-#define applicom_init init_module
-
-void cleanup_module(void)
+static void __exit applicom_exit(void)
 {
 	unsigned int i;
 
@@ -188,9 +184,7 @@ void cleanup_module(void)
 	}
 }
 
-#endif				/* MODULE */
-
-int __init applicom_init(void)
+static int __init applicom_init(void)
 {
 	int i, numisa = 0;
 	struct pci_dev *dev = NULL;
@@ -358,10 +352,9 @@ out:
 	return ret;
 }
 
+module_init(applicom_init);
+module_exit(applicom_exit);
 
-#ifndef MODULE
-__initcall(applicom_init);
-#endif
 
 static ssize_t ac_write(struct file *file, const char __user *buf, size_t count, loff_t * ppos)
 {
@@ -870,6 +863,8 @@ static int __init applicom_setup(char *s
 		return 0;
 	}
 
+	printk(KERN_WARNING "applicom= is deprecated\n  please use applicom.irq= and applicom.mem=\n");
+
 	mem = ints[1];
 	irq = ints[2];
 	return 1;


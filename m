Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbVFUByW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVFUByW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 21:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbVFTX7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 19:59:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:55012 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261784AbVFTXAB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 19:00:01 -0400
Cc: akpm@osdl.org
Subject: [PATCH] fix up ipmi code after class_simple.c removal
In-Reply-To: <1119308364310@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:24 -0700
Message-Id: <1119308364685@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] fix up ipmi code after class_simple.c removal

Cc: Corey Minyard <minyard@acm.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit eb51b65005737b777e0709683b061d5f82aefd97
tree 1e458e31a6c07da7c245c3e10293c7c7459c390f
parent 733a366c34aea88def75dee478f92233410ab3c4
author Andrew Morton <akpm@osdl.org> Thu, 05 May 2005 15:06:38 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:12 -0700

 drivers/char/ipmi/ipmi_devintf.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_devintf.c b/drivers/char/ipmi/ipmi_devintf.c
--- a/drivers/char/ipmi/ipmi_devintf.c
+++ b/drivers/char/ipmi/ipmi_devintf.c
@@ -520,7 +520,7 @@ MODULE_PARM_DESC(ipmi_major, "Sets the m
 		 " interface.  Other values will set the major device number"
 		 " to that value.");
 
-static struct class_simple *ipmi_class;
+static struct class *ipmi_class;
 
 static void ipmi_new_smi(int if_num)
 {
@@ -529,12 +529,12 @@ static void ipmi_new_smi(int if_num)
 	devfs_mk_cdev(dev, S_IFCHR | S_IRUSR | S_IWUSR,
 		      "ipmidev/%d", if_num);
 
-	class_simple_device_add(ipmi_class, dev, NULL, "ipmi%d", if_num);
+	class_device_create(ipmi_class, dev, NULL, "ipmi%d", if_num);
 }
 
 static void ipmi_smi_gone(int if_num)
 {
-	class_simple_device_remove(MKDEV(ipmi_major, if_num));
+	class_device_destroy(ipmi_class, MKDEV(ipmi_major, if_num));
 	devfs_remove("ipmidev/%d", if_num);
 }
 
@@ -555,7 +555,7 @@ static __init int init_ipmi_devintf(void
 	printk(KERN_INFO "ipmi device interface version "
 	       IPMI_DEVINTF_VERSION "\n");
 
-	ipmi_class = class_simple_create(THIS_MODULE, "ipmi");
+	ipmi_class = class_create(THIS_MODULE, "ipmi");
 	if (IS_ERR(ipmi_class)) {
 		printk(KERN_ERR "ipmi: can't register device class\n");
 		return PTR_ERR(ipmi_class);
@@ -563,7 +563,7 @@ static __init int init_ipmi_devintf(void
 
 	rv = register_chrdev(ipmi_major, DEVICE_NAME, &ipmi_fops);
 	if (rv < 0) {
-		class_simple_destroy(ipmi_class);
+		class_destroy(ipmi_class);
 		printk(KERN_ERR "ipmi: can't get major %d\n", ipmi_major);
 		return rv;
 	}
@@ -577,7 +577,7 @@ static __init int init_ipmi_devintf(void
 	rv = ipmi_smi_watcher_register(&smi_watcher);
 	if (rv) {
 		unregister_chrdev(ipmi_major, DEVICE_NAME);
-		class_simple_destroy(ipmi_class);
+		class_destroy(ipmi_class);
 		printk(KERN_WARNING "ipmi: can't register smi watcher\n");
 		return rv;
 	}
@@ -588,7 +588,7 @@ module_init(init_ipmi_devintf);
 
 static __exit void cleanup_ipmi(void)
 {
-	class_simple_destroy(ipmi_class);
+	class_destroy(ipmi_class);
 	ipmi_smi_watcher_unregister(&smi_watcher);
 	devfs_remove(DEVICE_NAME);
 	unregister_chrdev(ipmi_major, DEVICE_NAME);


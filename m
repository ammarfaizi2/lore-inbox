Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVETG47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVETG47 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 02:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVETG47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 02:56:59 -0400
Received: from ip-svs-1.Informatik.Uni-Oldenburg.DE ([134.106.12.126]:11716
	"EHLO aechz.svs.informatik.uni-oldenburg.de") by vger.kernel.org
	with ESMTP id S261359AbVETG4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 02:56:51 -0400
Date: Fri, 20 May 2005 08:56:23 +0200
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: Corey Minyard <minyard@acm.org>
Cc: Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add sysfs support for the IPMI device interface
Message-ID: <20050520065623.GA11075@titan.lahn.de>
Mail-Followup-To: Corey Minyard <minyard@acm.org>,
	Linus Torvalds <torvalds@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <428D208C.1000307@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428D208C.1000307@acm.org>
Organization: UUCP-Freunde Lahn e.V.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, May 19, 2005 at 06:26:04PM -0500, Corey Minyard wrote:
...
> Add support for sysfs to the IPMI device interface.
...
> Signed-off-by: Corey Minyard <minyard@acm.org>
...
> Index: linux-2.6.11-mm1/drivers/char/ipmi/ipmi_devintf.c
...
> static void ipmi_new_smi(int if_num)
> {
> +    char                  name[10];
...
>     devfs_mk_cdev(MKDEV(ipmi_major, if_num),
>               S_IFCHR | S_IRUSR | S_IWUSR,
>               "ipmidev/%d", if_num);
> +
> +    snprintf(name, sizeof(name), "ipmi%d", if_num);
> +    class_simple_device_add(ipmi_class, dev, NULL, name);

What happend to Dimitry Torokovs comment in
http://marc.theaimsgroup.com/?l=linux-kernel&m=111232712029756&w=2
and your reply in
http://marc.theaimsgroup.com/?l=linux-kernel&m=111232954415119&w=2
According to linux/device.h:250, class_simple_device_add() has a
printf() like argument, so you don't need to snprintf() the name on your
own.

Add support for sysfs to the IPMI device interface.

Signed-off-by: Corey Minyard <minyard@acm.org>
Signed-off-by: Philipp Hahn <pmhahn@titan.lahn.de>

Index: linux-2.6.12-rc1/drivers/char/ipmi/ipmi_devintf.c
===================================================================
--- linux-2.6.12-rc1.orig/drivers/char/ipmi/ipmi_devintf.c
+++ linux-2.6.12-rc1/drivers/char/ipmi/ipmi_devintf.c
@@ -44,6 +44,7 @@
 #include <linux/ipmi.h>
 #include <asm/semaphore.h>
 #include <linux/init.h>
+#include <linux/device.h>
 
 #define IPMI_DEVINTF_VERSION "v33"
 
@@ -519,15 +520,21 @@
 		 " interface.  Other values will set the major device number"
 		 " to that value.");
 
+static struct class *ipmi_class;
+
 static void ipmi_new_smi(int if_num)
 {
-	devfs_mk_cdev(MKDEV(ipmi_major, if_num),
-		      S_IFCHR | S_IRUSR | S_IWUSR,
+	dev_t dev = MKDEV(ipmi_major, if_num);
+
+	devfs_mk_cdev(dev, S_IFCHR | S_IRUSR | S_IWUSR,
 		      "ipmidev/%d", if_num);
+
+	class_simple_device_add(ipmi_class, dev, NULL, "ipmi%d", if_num);
 }
 
 static void ipmi_smi_gone(int if_num)
 {
+	class_simple_device_remove(ipmi_class, MKDEV(ipmi_major, if_num));
 	devfs_remove("ipmidev/%d", if_num);
 }
 
@@ -548,8 +555,15 @@
 	printk(KERN_INFO "ipmi device interface version "
 	       IPMI_DEVINTF_VERSION "\n");
 
+	ipmi_class = class_simple_create(THIS_MODULE, "ipmi");
+	if (IS_ERR(ipmi_class)) {
+		printk(KERN_ERR "ipmi: can't register device class\n");
+		return PTR_ERR(ipmi_class);
+	}
+
 	rv = register_chrdev(ipmi_major, DEVICE_NAME, &ipmi_fops);
 	if (rv < 0) {
+		class_simple_destroy(ipmi_class);
 		printk(KERN_ERR "ipmi: can't get major %d\n", ipmi_major);
 		return rv;
 	}
@@ -563,6 +577,7 @@
 	rv = ipmi_smi_watcher_register(&smi_watcher);
 	if (rv) {
 		unregister_chrdev(ipmi_major, DEVICE_NAME);
+		class_simple_destroy(ipmi_class);
 		printk(KERN_WARNING "ipmi: can't register smi watcher\n");
 		return rv;
 	}
@@ -573,6 +588,7 @@
 
 static __exit void cleanup_ipmi(void)
 {
+	class_simple_destroy(ipmi_class);
 	ipmi_smi_watcher_unregister(&smi_watcher);
 	devfs_remove(DEVICE_NAME);
 	unregister_chrdev(ipmi_major, DEVICE_NAME);

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de

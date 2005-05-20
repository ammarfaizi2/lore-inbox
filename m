Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVETNAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVETNAu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 09:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVETNAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 09:00:50 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:20617 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261455AbVETNAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 09:00:30 -0400
Message-ID: <428DDF6C.5080701@acm.org>
Date: Fri, 20 May 2005 08:00:28 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Cc: Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add sysfs support for the IPMI device interface
References: <428D208C.1000307@acm.org> <20050520065623.GA11075@titan.lahn.de>
In-Reply-To: <20050520065623.GA11075@titan.lahn.de>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philipp Matthias Hahn wrote:

>
>
>What happend to Dimitry Torokovs comment in
>http://marc.theaimsgroup.com/?l=linux-kernel&m=111232712029756&w=2
>and your reply in
>http://marc.theaimsgroup.com/?l=linux-kernel&m=111232954415119&w=2
>According to linux/device.h:250, class_simple_device_add() has a
>printf() like argument, so you don't need to snprintf() the name on your
>own.
>  
>
Thank you.  My stupid mailer ate the tabs, and you fixed that, too.  
This looks good to go in.

-Corey

>Add support for sysfs to the IPMI device interface.
>
>Signed-off-by: Corey Minyard <minyard@acm.org>
>Signed-off-by: Philipp Hahn <pmhahn@titan.lahn.de>
>
>Index: linux-2.6.12-rc1/drivers/char/ipmi/ipmi_devintf.c
>===================================================================
>--- linux-2.6.12-rc1.orig/drivers/char/ipmi/ipmi_devintf.c
>+++ linux-2.6.12-rc1/drivers/char/ipmi/ipmi_devintf.c
>@@ -44,6 +44,7 @@
> #include <linux/ipmi.h>
> #include <asm/semaphore.h>
> #include <linux/init.h>
>+#include <linux/device.h>
> 
> #define IPMI_DEVINTF_VERSION "v33"
> 
>@@ -519,15 +520,21 @@
> 		 " interface.  Other values will set the major device number"
> 		 " to that value.");
> 
>+static struct class *ipmi_class;
>+
> static void ipmi_new_smi(int if_num)
> {
>-	devfs_mk_cdev(MKDEV(ipmi_major, if_num),
>-		      S_IFCHR | S_IRUSR | S_IWUSR,
>+	dev_t dev = MKDEV(ipmi_major, if_num);
>+
>+	devfs_mk_cdev(dev, S_IFCHR | S_IRUSR | S_IWUSR,
> 		      "ipmidev/%d", if_num);
>+
>+	class_simple_device_add(ipmi_class, dev, NULL, "ipmi%d", if_num);
> }
> 
> static void ipmi_smi_gone(int if_num)
> {
>+	class_simple_device_remove(ipmi_class, MKDEV(ipmi_major, if_num));
> 	devfs_remove("ipmidev/%d", if_num);
> }
> 
>@@ -548,8 +555,15 @@
> 	printk(KERN_INFO "ipmi device interface version "
> 	       IPMI_DEVINTF_VERSION "\n");
> 
>+	ipmi_class = class_simple_create(THIS_MODULE, "ipmi");
>+	if (IS_ERR(ipmi_class)) {
>+		printk(KERN_ERR "ipmi: can't register device class\n");
>+		return PTR_ERR(ipmi_class);
>+	}
>+
> 	rv = register_chrdev(ipmi_major, DEVICE_NAME, &ipmi_fops);
> 	if (rv < 0) {
>+		class_simple_destroy(ipmi_class);
> 		printk(KERN_ERR "ipmi: can't get major %d\n", ipmi_major);
> 		return rv;
> 	}
>@@ -563,6 +577,7 @@
> 	rv = ipmi_smi_watcher_register(&smi_watcher);
> 	if (rv) {
> 		unregister_chrdev(ipmi_major, DEVICE_NAME);
>+		class_simple_destroy(ipmi_class);
> 		printk(KERN_WARNING "ipmi: can't register smi watcher\n");
> 		return rv;
> 	}
>@@ -573,6 +588,7 @@
> 
> static __exit void cleanup_ipmi(void)
> {
>+	class_simple_destroy(ipmi_class);
> 	ipmi_smi_watcher_unregister(&smi_watcher);
> 	devfs_remove(DEVICE_NAME);
> 	unregister_chrdev(ipmi_major, DEVICE_NAME);
>
>BYtE
>Philipp
>  
>


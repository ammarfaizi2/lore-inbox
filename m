Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263202AbUCPBVx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262887AbUCPBTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:19:42 -0500
Received: from mail.kroah.org ([65.200.24.183]:54703 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262943AbUCPADO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:03:14 -0500
Subject: Re: [PATCH] Driver Core update for 2.6.4
In-Reply-To: <10793951453984@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 15:59:05 -0800
Message-Id: <10793951451334@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.84.2, 2004/03/10 16:04:33-08:00, chrisw@osdl.org

[PATCH] Patch to hook up PPP to simple class sysfs support

* Hanna Linder (hannal@us.ibm.com) wrote:
> +		ppp_class = class_simple_create(THIS_MODULE, "ppp");
> +		class_simple_device_add(ppp_class, MKDEV(PPP_MAJOR, 0), NULL, "ppp");

What happens if that class_simple_create() fails?  Actually,
class_simple_device_add could fail too, but doesn't seem anybody is
checking for that.

>  		err = devfs_mk_cdev(MKDEV(PPP_MAJOR, 0),
>  				S_IFCHR|S_IRUSR|S_IWUSR, "ppp");
> -		if (err)
> +		if (err) {
>  			unregister_chrdev(PPP_MAJOR, "ppp");
> +			class_simple_device_remove(MKDEV(PPP_MAJOR,0));
> +		}

need to destroy the class on error path to avoid leak.

> @@ -2540,6 +2547,7 @@ static void __exit ppp_cleanup(void)
>  	if (unregister_chrdev(PPP_MAJOR, "ppp") != 0)
>  		printk(KERN_ERR "PPP: failed to unregister PPP device\n");
>  	devfs_remove("ppp");
> +	class_simple_device_remove(MKDEV(PPP_MAJOR, 0));

ditto.  this will leak and would cause oops on reload of module.

something like below.


 drivers/net/ppp_generic.c |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletion(-)


diff -Nru a/drivers/net/ppp_generic.c b/drivers/net/ppp_generic.c
--- a/drivers/net/ppp_generic.c	Mon Mar 15 15:30:17 2004
+++ b/drivers/net/ppp_generic.c	Mon Mar 15 15:30:17 2004
@@ -45,6 +45,7 @@
 #include <linux/smp_lock.h>
 #include <linux/rwsem.h>
 #include <linux/stddef.h>
+#include <linux/device.h>
 #include <net/slhc_vj.h>
 #include <asm/atomic.h>
 
@@ -271,6 +272,8 @@
 static int ppp_disconnect_channel(struct channel *pch);
 static void ppp_destroy_channel(struct channel *pch);
 
+static struct class_simple *ppp_class;
+
 /* Translates a PPP protocol number to a NP index (NP == network protocol) */
 static inline int proto_to_npindex(int proto)
 {
@@ -804,15 +807,29 @@
 	printk(KERN_INFO "PPP generic driver version " PPP_VERSION "\n");
 	err = register_chrdev(PPP_MAJOR, "ppp", &ppp_device_fops);
 	if (!err) {
+		ppp_class = class_simple_create(THIS_MODULE, "ppp");
+		if (IS_ERR(ppp_class)) {
+			err = PTR_ERR(ppp_class);
+			goto out_chrdev;
+		}
+		class_simple_device_add(ppp_class, MKDEV(PPP_MAJOR, 0), NULL, "ppp");
 		err = devfs_mk_cdev(MKDEV(PPP_MAJOR, 0),
 				S_IFCHR|S_IRUSR|S_IWUSR, "ppp");
 		if (err)
-			unregister_chrdev(PPP_MAJOR, "ppp");
+			goto out_class;
 	}
 
+out:
 	if (err)
 		printk(KERN_ERR "failed to register PPP device (%d)\n", err);
 	return err;
+
+out_class:
+	class_simple_device_remove(MKDEV(PPP_MAJOR,0));
+	class_simple_destroy(ppp_class);
+out_chrdev:
+	unregister_chrdev(PPP_MAJOR, "ppp");
+	goto out;
 }
 
 /*
@@ -2545,6 +2562,8 @@
 	if (unregister_chrdev(PPP_MAJOR, "ppp") != 0)
 		printk(KERN_ERR "PPP: failed to unregister PPP device\n");
 	devfs_remove("ppp");
+	class_simple_device_remove(MKDEV(PPP_MAJOR, 0));
+	class_simple_destroy(ppp_class);
 }
 
 /*


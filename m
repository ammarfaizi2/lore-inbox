Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbUCDDzo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 22:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbUCDDzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 22:55:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:14767 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261317AbUCDDzk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 22:55:40 -0500
Date: Wed, 3 Mar 2004 19:55:39 -0800
From: Chris Wright <chrisw@osdl.org>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH 2.6] Patch to hook up PPP to simple class sysfs support
Message-ID: <20040303195539.S22989@build.pdx.osdl.net>
References: <200403032328.i23NSwlv009796@orion.dwf.com> <22370000.1078362205@w-hlinder.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <22370000.1078362205@w-hlinder.beaverton.ibm.com>; from hannal@us.ibm.com on Wed, Mar 03, 2004 at 05:03:26PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

thanks,
-chris

===== drivers/net/ppp_generic.c 1.43 vs edited =====
--- 1.43/drivers/net/ppp_generic.c	Wed Feb 18 19:42:37 2004
+++ edited/drivers/net/ppp_generic.c	Wed Mar  3 19:08:24 2004
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

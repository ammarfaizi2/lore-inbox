Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbUCDBCS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 20:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUCDBCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 20:02:18 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:64203 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261361AbUCDBCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 20:02:16 -0500
Date: Wed, 03 Mar 2004 17:03:26 -0800
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com, hannal@us.ibm.com
Subject: [PATCH 2.6] Patch to hook up PPP to simple class sysfs support
Message-ID: <22370000.1078362205@w-hlinder.beaverton.ibm.com>
In-Reply-To: <200403032328.i23NSwlv009796@orion.dwf.com>
References: <200403032328.i23NSwlv009796@orion.dwf.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is a small patch to add PPP support to /sys/class.

Please consider for inclusion.

Thanks.

Hanna
----

diff -Nrup -Xdontdiff linux-2.6.3/drivers/net/ppp_generic.c linux-2.6.3p/drivers/net/ppp_generic.c
--- linux-2.6.3/drivers/net/ppp_generic.c	2004-02-17 19:59:31.000000000 -0800
+++ linux-2.6.3p/drivers/net/ppp_generic.c	2004-03-03 15:14:07.000000000 -0800
@@ -45,6 +45,7 @@
 #include <linux/smp_lock.h>
 #include <linux/rwsem.h>
 #include <linux/stddef.h>
+#include <linux/device.h>
 #include <net/slhc_vj.h>
 #include <asm/atomic.h>

@@ -271,6 +272,8 @@ static int ppp_connect_channel(struct ch
 static int ppp_disconnect_channel(struct channel *pch);
 static void ppp_destroy_channel(struct channel *pch);

+static struct class_simple *ppp_class;
+
 /* Translates a PPP protocol number to a NP index (NP == network protocol) */
 static inline int proto_to_npindex(int proto)
 {
@@ -799,10 +802,14 @@ static int __init ppp_init(void)
 	printk(KERN_INFO "PPP generic driver version " PPP_VERSION "\n");
 	err = register_chrdev(PPP_MAJOR, "ppp", &ppp_device_fops);
 	if (!err) {
+		ppp_class = class_simple_create(THIS_MODULE, "ppp");
+		class_simple_device_add(ppp_class, MKDEV(PPP_MAJOR, 0), NULL, "ppp");
 		err = devfs_mk_cdev(MKDEV(PPP_MAJOR, 0),
 				S_IFCHR|S_IRUSR|S_IWUSR, "ppp");
-		if (err)
+		if (err) {
 			unregister_chrdev(PPP_MAJOR, "ppp");
+			class_simple_device_remove(MKDEV(PPP_MAJOR,0));
+		}
 	}

 	if (err)
@@ -2540,6 +2547,7 @@ static void __exit ppp_cleanup(void)
 	if (unregister_chrdev(PPP_MAJOR, "ppp") != 0)
 		printk(KERN_ERR "PPP: failed to unregister PPP device\n");
 	devfs_remove("ppp");
+	class_simple_device_remove(MKDEV(PPP_MAJOR, 0));
 }

 /*


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262745AbVGKVYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbVGKVYK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 17:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbVGKVWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 17:22:07 -0400
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:48539 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S262745AbVGKVUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 17:20:08 -0400
Subject: Re: [openib-general] [PATCH 26/29v2] Add kernel portion of user CM
	implementation
From: Tom Duffy <tduffy@sun.com>
To: Hal Rosenstock <halr@voltaire.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <1121110427.4389.5036.camel@hal.voltaire.com>
References: <1121110427.4389.5036.camel@hal.voltaire.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 11 Jul 2005 14:19:28 -0700
Message-Id: <1121116768.3028.9.camel@duffman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-11.fc5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-11 at 16:59 -0400, Hal Rosenstock wrote:
> Add kernel portion of user CM implementation

Hal, does this compile?  As it doesn't seem to include the patch I sent
to openib-general changing class_simple to class, I don't think it
should work on 2.6.13-rc.

[ also, in future patch bombs, could you please set the references
header so that the message thread properly, thanks ]

Signed-off-by: Tom Duffy <tduffy@sun.com>

Index: linux-2.6.13-rc2-openib/drivers/infiniband/core/ucm.c
===================================================================
--- linux-2.6.13-rc2-openib/drivers/infiniband/core/ucm.c	(revision 2832)
+++ linux-2.6.13-rc2-openib/drivers/infiniband/core/ucm.c	(working copy)
@@ -1339,7 +1339,7 @@ static struct file_operations ib_ucm_fop
 };
 
 
-static struct class_simple *ib_ucm_class;
+static struct class *ib_ucm_class;
 static struct cdev	  ib_ucm_cdev;
 
 static int __init ib_ucm_init(void)
@@ -1360,17 +1360,14 @@ static int __init ib_ucm_init(void)
 		goto err_cdev;
 	}
 
-	ib_ucm_class = class_simple_create(THIS_MODULE, "infiniband_cm");
+	ib_ucm_class = class_create(THIS_MODULE, "infiniband_cm");
 	if (IS_ERR(ib_ucm_class)) {
 		result = PTR_ERR(ib_ucm_class);
 		printk(KERN_ERR "UCM: Error <%d> creating class\n", result);
 		goto err_class;
 	}
 
-	class_simple_device_add(ib_ucm_class,
-				IB_UCM_DEV,
-				NULL,
-				"ucm");
+	class_device_create(ib_ucm_class, IB_UCM_DEV, NULL, "ucm");
 	
 	idr_init(&ctx_id_table);
 	init_MUTEX(&ctx_id_mutex);
@@ -1386,8 +1383,8 @@ err_chr:
 
 static void __exit ib_ucm_cleanup(void)
 {
-	class_simple_device_remove(IB_UCM_DEV);
-	class_simple_destroy(ib_ucm_class);
+	class_device_destroy(ib_ucm_class, IB_UCM_DEV);
+	class_destroy(ib_ucm_class);
 	cdev_del(&ib_ucm_cdev);
 	unregister_chrdev_region(IB_UCM_DEV, 1);
 }


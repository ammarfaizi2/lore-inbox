Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264354AbTEGXG3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264336AbTEGXF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:05:56 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:61951 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264337AbTEGXCD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:02:03 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10523493881777@kroah.com>
Subject: Re: [PATCH] TTY changes for 2.5.69
In-Reply-To: <1052349388865@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 7 May 2003 16:16:28 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1113, 2003/05/07 15:02:02-07:00, hannal@us.ibm.com

[PATCH] isdn/capi  tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT


 drivers/isdn/capi/capi.c |    8 +-------
 1 files changed, 1 insertion(+), 7 deletions(-)


diff -Nru a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
--- a/drivers/isdn/capi/capi.c	Wed May  7 16:00:12 2003
+++ b/drivers/isdn/capi/capi.c	Wed May  7 16:00:12 2003
@@ -200,10 +200,8 @@
 	unsigned int minor = 0;
 	unsigned long flags;
   
-  	MOD_INC_USE_COUNT;
 	mp = kmalloc(sizeof(*mp), GFP_ATOMIC);
   	if (!mp) {
-  		MOD_DEC_USE_COUNT;
   		printk(KERN_ERR "capi: can't alloc capiminor\n");
 		return 0;
 	}
@@ -249,7 +247,6 @@
 	skb_queue_purge(&mp->outqueue);
 	capiminor_del_all_ack(mp);
 	kfree(mp);
-	MOD_DEC_USE_COUNT;
 }
 
 struct capiminor *capiminor_find(unsigned int minor)
@@ -1280,6 +1277,7 @@
 	
 	memset(drv, 0, sizeof(struct tty_driver));
 	drv->magic = TTY_DRIVER_MAGIC;
+	drv->owner = THIS_MODULE;
 	drv->driver_name = "capi_nc";
 	drv->name = "capi/";
 	drv->major = capi_ttymajor;
@@ -1460,7 +1458,6 @@
 	char *p;
 	char *compileinfo;
 
-	MOD_INC_USE_COUNT;
 
 	if ((p = strchr(revision, ':')) != 0 && p[1]) {
 		strncpy(rev, p + 2, sizeof(rev));
@@ -1472,7 +1469,6 @@
 
 	if (register_chrdev(capi_major, "capi20", &capi_fops)) {
 		printk(KERN_ERR "capi20: unable to get major %d\n", capi_major);
-		MOD_DEC_USE_COUNT;
 		return -EIO;
 	}
 
@@ -1484,7 +1480,6 @@
 #ifdef CONFIG_ISDN_CAPI_MIDDLEWARE
 	if (capinc_tty_init() < 0) {
 		unregister_chrdev(capi_major, "capi20");
-		MOD_DEC_USE_COUNT;
 		return -ENOMEM;
 	}
 #endif /* CONFIG_ISDN_CAPI_MIDDLEWARE */
@@ -1503,7 +1498,6 @@
 	printk(KERN_NOTICE "capi20: Rev %s: started up with major %d%s\n",
 				rev, capi_major, compileinfo);
 
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 


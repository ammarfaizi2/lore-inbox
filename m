Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261421AbRE0KLs>; Sun, 27 May 2001 06:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261434AbRE0KLi>; Sun, 27 May 2001 06:11:38 -0400
Received: from smtp2.Stanford.EDU ([171.64.14.116]:13238 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S261421AbRE0KL1>; Sun, 27 May 2001 06:11:27 -0400
From: "Akash Jain" <aki.jain@stanford.edu>
To: <torvals@transmeta.com>, <ncorbic@sangoma.com>, <dm@sangoma.com>,
        <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>, <su.class.cs99q@nntp.stanford.edu>
Subject: [PATCH] net/wanrouter/wanmain.c
Date: Sun, 27 May 2001 03:07:37 -0700
Message-ID: <GLEPIDKFGKPCBDLKDHEAAELFDDAA.aki.jain@stanford.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey All,
Here are a few bug fixes in net/wanrouter/wanmain.c

line 765: use var conf of size 1272 bytes on the stack

line 617: use freed ptr conf

line 803: forget to free pppdev before aborting during another null check

Thanks!
-aki-


--- net/wanrouter/wanmain.c.orig	Thu Apr 12 12:11:39 2001
+++ net/wanrouter/wanmain.c	Tue May 22 23:49:30 2001
@@ -611,10 +611,10 @@

 	if (conf->data_size && conf->data){
 		if(conf->data_size > 128000 || conf->data_size < 0) {
-			kfree(conf);
 			printk(KERN_INFO
 			    "%s: ERROR, Invalid firmware data size %i !\n",
 					wandev->name, conf->data_size);
+			kfree(conf);
 		        return -EINVAL;;
 		}

@@ -762,7 +762,7 @@

 static int device_new_if (wan_device_t *wandev, wanif_conf_t *u_conf)
 {
-	wanif_conf_t conf;
+	wanif_conf_t *conf;
 	netdevice_t *dev=NULL;
       #ifdef CONFIG_WANPIPE_MULTPPP
 	struct ppp_device *pppdev=NULL;
@@ -773,26 +773,33 @@
 		return -ENODEV;

       #if defined (LINUX_2_1) || defined (LINUX_2_4)
-	if(copy_from_user(&conf, u_conf, sizeof(wanif_conf_t)))
+	if(copy_from_user(conf, u_conf, sizeof(wanif_conf_t))){
+	        kfree(conf);
 		return -EFAULT;
+	}
       #else
         err = verify_area(VERIFY_READ, u_conf, sizeof(wanif_conf_t));
-        if (err)
+        if (err){
+	        kfree(conf);
                 return err;
-        memcpy_fromfs((void*)&conf, (void*)u_conf, sizeof(wanif_conf_t));
+	}
+        memcpy_fromfs((void*)conf, (void*)u_conf, sizeof(wanif_conf_t));
       #endif

-	if (conf.magic != ROUTER_MAGIC)
+	if (conf->magic != ROUTER_MAGIC){
+	        kfree(conf);
 		return -EINVAL;
+	}

 	err = -EPROTONOSUPPORT;


 #ifdef CONFIG_WANPIPE_MULTPPP
-	if (conf.config_id == WANCONFIG_MPPP){
+	if (conf->config_id == WANCONFIG_MPPP){

 		pppdev = kmalloc(sizeof(struct ppp_device), GFP_KERNEL);
 		if (pppdev == NULL){
+		        kfree(conf);
 			return -ENOBUFS;
 		}
 		memset(pppdev, 0, sizeof(struct ppp_device));
@@ -800,6 +807,8 @@
 	      #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,16)
 		pppdev->dev = kmalloc(sizeof(netdevice_t), GFP_KERNEL);
 		if (pppdev->dev == NULL){
+		        kfree(conf);
+		        kfree(pppdev);
 			return -ENOBUFS;
 		}
 		memset(pppdev->dev, 0, sizeof(netdevice_t));
@@ -817,6 +826,7 @@

 		dev = kmalloc(sizeof(netdevice_t), GFP_KERNEL);
 		if (dev == NULL){
+		        kfree(conf);
 			return -ENOBUFS;
 		}
 		memset(dev, 0, sizeof(netdevice_t));
@@ -825,10 +835,11 @@

 #else
 	/* Sync PPP is disabled */
-	if (conf.config_id != WANCONFIG_MPPP){
+	if (conf->config_id != WANCONFIG_MPPP){

 		dev = kmalloc(sizeof(netdevice_t), GFP_KERNEL);
 		if (dev == NULL){
+		        kfree(conf);
 			return -ENOBUFS;
 		}
 		memset(dev, 0, sizeof(netdevice_t));
@@ -836,6 +847,7 @@
 	}else{
 		printk(KERN_INFO "%s: Wanpipe Mulit-Port PPP support has not been
compiled in!\n",
 				wandev->name);
+		kfree(conf);
 		return err;
 	}
 #endif
@@ -876,6 +888,7 @@
 				++wandev->ndev;

 				unlock_adapter_irq(&wandev->lock, &smp_flags);
+				kfree(conf);
 				return 0;	/* done !!! */
 			}
 		}
@@ -891,18 +904,19 @@


       #ifdef CONFIG_WANPIPE_MULTPPP
-	if (conf.config_id == WANCONFIG_MPPP){
+	if (conf->config_id == WANCONFIG_MPPP){
 		kfree(pppdev);
 	}else{
 		kfree(dev);
 	}
       #else
 	/* Sync PPP is disabled */
-	if (conf.config_id != WANCONFIG_MPPP){
+	if (conf->config_id != WANCONFIG_MPPP){
 		kfree(dev);
 	}
       #endif

+	kfree(conf);
 	return err;
 }



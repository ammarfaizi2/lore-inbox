Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267346AbUBSPMP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 10:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267385AbUBSPJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 10:09:29 -0500
Received: from verein.lst.de ([212.34.189.10]:63706 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S267297AbUBSPFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 10:05:15 -0500
Date: Thu, 19 Feb 2004 16:05:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: scherr@net4you.at
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix module reference counting in zoran driver
Message-ID: <20040219150510.GA29687@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, scherr@net4you.at,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -3.849 () BAYES_00,DOMAIN_BODY
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Take a reference before calling into the module and release it after
we're done.  Also remove the useless (and wrong) refcounting in
videocodec - symbols from this module are used by other modules if
we call into those functions so it can't be unloaded anyway.

We really need to add a debug check to tip all those
try_module_get(THIS_MODULE) callers..


--- 1.3/drivers/media/video/videocodec.c	Thu Feb 19 04:42:41 2004
+++ edited/drivers/media/video/videocodec.c	Wed Feb 18 03:45:29 2004
@@ -108,13 +108,17 @@
 		if ((master->flags & h->codec->flags) == master->flags) {
 			dprintk(4, "videocodec_attach: try '%s'\n",
 				h->codec->name);
+
+			if (!try_module_get(h->codec->owner))
+				return NULL;
+
 			codec =
 			    kmalloc(sizeof(struct videocodec), GFP_KERNEL);
 			if (!codec) {
 				dprintk(1,
 					KERN_ERR
 					"videocodec_attach: no mem\n");
-				return NULL;
+				goto out_module_put;
 			}
 			memcpy(codec, h->codec, sizeof(struct videocodec));
 
@@ -132,26 +136,12 @@
 					dprintk(1,
 						KERN_ERR
 						"videocodec_attach: no memory\n");
-					kfree(codec);
-					return NULL;
+					goto out_kfree;
 				}
 				memset(ptr, 0,
 				       sizeof(struct attached_list));
 				ptr->codec = codec;
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-				MOD_INC_USE_COUNT;
-#else
-				if (!try_module_get(THIS_MODULE)) {
-					dprintk(1,
-						KERN_ERR
-						"videocodec: failed to increment usecount\n");
-					kfree(codec);
-					kfree(ptr);
-					return NULL;
-				}
-#endif
-
 				a = h->list;
 				if (!a) {
 					h->list = ptr;
@@ -177,6 +167,12 @@
 
 	dprintk(1, KERN_ERR "videocodec_attach: no codec found!\n");
 	return NULL;
+
+ out_module_put:
+	module_put(h->codec->owner);
+ out_kfree:
+	kfree(codec);
+	return NULL;
 }
 
 int
@@ -228,16 +224,10 @@
 					dprintk(4,
 						"videocodec: delete middle\n");
 				}
+				module_put(a->codec->owner);
 				kfree(a->codec);
 				kfree(a);
 				h->attached -= 1;
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-				MOD_DEC_USE_COUNT;
-#else
-				module_put(THIS_MODULE);
-#endif
-
 				return 0;
 			}
 			prev = a;
@@ -274,18 +264,6 @@
 	memset(ptr, 0, sizeof(struct codec_list));
 	ptr->codec = codec;
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	MOD_INC_USE_COUNT;
-#else
-	if (!try_module_get(THIS_MODULE)) {
-		dprintk(1,
-			KERN_ERR
-			"videocodec: failed to increment module count\n");
-		kfree(ptr);
-		return -ENODEV;
-	}
-#endif
-
 	if (!h) {
 		codeclist_top = ptr;
 		dprintk(4, "videocodec: hooked in as first element\n");
@@ -342,13 +320,6 @@
 					"videocodec: delete middle element\n");
 			}
 			kfree(h);
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-			MOD_DEC_USE_COUNT;
-#else
-			module_put(THIS_MODULE);
-#endif
-
 			return 0;
 		}
 		prev = h;
===== drivers/media/video/videocodec.h 1.1 vs edited =====
--- 1.1/drivers/media/video/videocodec.h	Wed Aug 20 23:29:31 2003
+++ edited/drivers/media/video/videocodec.h	Wed Feb 18 03:45:29 2004
@@ -249,6 +249,7 @@
 };
 
 struct videocodec {
+	struct module *owner;
 	/* -- filled in by slave device during register -- */
 	char name[32];
 	unsigned long magic;	/* may be used for client<->master attaching */
===== drivers/media/video/zr36016.c 1.1 vs edited =====
--- 1.1/drivers/media/video/zr36016.c	Wed Aug 20 23:29:31 2003
+++ edited/drivers/media/video/zr36016.c	Wed Feb 18 03:45:29 2004
@@ -422,12 +422,6 @@
 		codec->data = NULL;
 
 		zr36016_codecs--;
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-		MOD_DEC_USE_COUNT;
-#else
-		module_put(THIS_MODULE);
-#endif
-
 		return 0;
 	}
 
@@ -470,19 +464,6 @@
 	ptr->num = zr36016_codecs++;
 	ptr->codec = codec;
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	MOD_INC_USE_COUNT;
-#else
-	if (!try_module_get(THIS_MODULE)) {
-		dprintk(1,
-			KERN_ERR
-			"zr36016: failed to increase module use count\n");
-		kfree(ptr);
-		zr36016_codecs--;
-		return -ENODEV;
-	}
-#endif
-
 	//testing
 	res = zr36016_basic_test(ptr);
 	if (res < 0) {
@@ -504,6 +485,7 @@
 }
 
 static const struct videocodec zr36016_codec = {
+	.owner = THIS_MODULE,
 	.name = "zr36016",
 	.magic = 0L,		// magic not used
 	.flags =
===== drivers/media/video/zr36050.c 1.1 vs edited =====
--- 1.1/drivers/media/video/zr36050.c	Wed Aug 20 23:29:31 2003
+++ edited/drivers/media/video/zr36050.c	Wed Feb 18 03:45:29 2004
@@ -737,12 +737,6 @@
 		codec->data = NULL;
 
 		zr36050_codecs--;
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-		MOD_DEC_USE_COUNT;
-#else
-		module_put(THIS_MODULE);
-#endif
-
 		return 0;
 	}
 
@@ -785,19 +779,6 @@
 	ptr->num = zr36050_codecs++;
 	ptr->codec = codec;
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	MOD_INC_USE_COUNT;
-#else
-	if (!try_module_get(THIS_MODULE)) {
-		dprintk(1,
-			KERN_ERR
-			"zr36050: failed to increase module use count\n");
-		kfree(ptr);
-		zr36050_codecs--;
-		return -ENODEV;
-	}
-#endif
-
 	//testing
 	res = zr36050_basic_test(ptr);
 	if (res < 0) {
@@ -826,6 +807,7 @@
 }
 
 static const struct videocodec zr36050_codec = {
+	.owner = THIS_MODULE,
 	.name = "zr36050",
 	.magic = 0L,		// magic not used
 	.flags =
===== drivers/media/video/zr36060.c 1.1 vs edited =====
--- 1.1/drivers/media/video/zr36060.c	Wed Aug 20 23:29:31 2003
+++ edited/drivers/media/video/zr36060.c	Wed Feb 18 03:45:29 2004
@@ -868,12 +868,6 @@
 		codec->data = NULL;
 
 		zr36060_codecs--;
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-		MOD_DEC_USE_COUNT;
-#else
-		module_put(THIS_MODULE);
-#endif
-
 		return 0;
 	}
 
@@ -916,19 +910,6 @@
 	ptr->num = zr36060_codecs++;
 	ptr->codec = codec;
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	MOD_INC_USE_COUNT;
-#else
-	if (!try_module_get(THIS_MODULE)) {
-		dprintk(1,
-			KERN_ERR
-			"zr36060: failed to increase module use count\n");
-		kfree(ptr);
-		zr36060_codecs--;
-		return -ENODEV;
-	}
-#endif
-
 	//testing
 	res = zr36060_basic_test(ptr);
 	if (res < 0) {
@@ -958,6 +939,7 @@
 }
 
 static const struct videocodec zr36060_codec = {
+	.owner = THIS_MODULE,
 	.name = "zr36060",
 	.magic = 0L,		// magic not used
 	.flags =
===== drivers/scsi/megaraid.c 1.59 vs edited =====
--- 1.59/drivers/scsi/megaraid.c	Fri Jan 23 06:37:03 2004
+++ edited/drivers/scsi/megaraid.c	Wed Feb 18 03:45:29 2004
@@ -4614,6 +4614,7 @@
 }
 
 static struct scsi_host_template megaraid_template = {
+	.module				= THIS_MODULE,
 	.name				= "MegaRAID",
 	.proc_name			= "megaraid",
 	.info				= megaraid_info,

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262587AbTHZRqw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 13:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbTHZRqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 13:46:51 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:6032 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262587AbTHZRqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 13:46:40 -0400
Message-Id: <200308261746.h7QHkXNv027698@ginger.cmf.nrl.navy.mil>
To: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
cc: linux-kernel@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
       Bartlomiej Solarz-Niesluchowski <solarz@wsisiz.edu.pl>
Subject: Re: linux-2.4.22 Oops on ATM PCA-200EPC 
In-Reply-To: Message from Lukasz Trabinski <lukasz@wsisiz.edu.pl> 
   of "Tue, 26 Aug 2003 01:11:13 +0200." <Pine.LNX.4.53.0308260104580.17995@oceanic.wsisiz.edu.pl> 
Date: Tue, 26 Aug 2003 13:46:34 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.53.0308260104580.17995@oceanic.wsisiz.edu.pl>,Lukasz Tra
binski writes:
>I have always used vanilla kernel with very old patch for ATM
>(name: linux-2.3.99-pre6-fore200e-0.2f.patch) It worked well -
>trouble-free. 
>I have just tried vanilla 2.4.22, here is oops. ATM doesn't work :(

yep, i screwed that up.  when clip isnt a module, the common code try
to manipulate the module count while fails.  see if this patch makes
it better -- apply with patch -p1 in your linux source tree.

--- linux-2.4.22/net/atm/common.c.000	Tue Aug 26 10:40:30 2003
+++ linux-2.4.22/net/atm/common.c	Tue Aug 26 13:12:35 2003
@@ -672,7 +672,8 @@
 			}
 			if (try_atm_clip_ops()) {
 				ret_val = atm_clip_ops->clip_create(arg);
-				__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
+				if (atm_clip_ops->owner)
+					__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
 			} else
 				ret_val = -ENOSYS;
 			goto done;
@@ -687,7 +688,8 @@
 #endif
 			if (try_atm_clip_ops()) {
 				error = atm_clip_ops->atm_init_atmarp(vcc);
-				__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
+				if (atm_clip_ops->owner)
+					__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
 				if (!error)
 					sock->state = SS_CONNECTED;
 				ret_val = error;
@@ -701,7 +703,8 @@
 			}
 			if (try_atm_clip_ops()) {
 				ret_val = atm_clip_ops->clip_mkip(vcc, arg);
-				__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
+				if (atm_clip_ops->owner)
+					__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
 			} else
 				ret_val = -ENOSYS;
 			goto done;
@@ -712,7 +715,8 @@
 			}
 			if (try_atm_clip_ops()) {
 				ret_val = atm_clip_ops->clip_setentry(vcc, arg);
-				__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
+				if (atm_clip_ops->owner)
+					__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
 			} else
 				ret_val = -ENOSYS;
 			goto done;
@@ -723,7 +727,8 @@
 			}
 			if (try_atm_clip_ops()) {
 				ret_val = atm_clip_ops->clip_encap(vcc, arg);
-				__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
+				if (atm_clip_ops->owner)
+					__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
 			} else
 				ret_val = -ENOSYS;
 			goto done;
--- linux-2.4.22/net/atm/proc.c.000	Tue Aug 26 13:30:23 2003
+++ linux-2.4.22/net/atm/proc.c	Tue Aug 26 13:31:58 2003
@@ -358,7 +358,7 @@
 				spin_unlock_irqrestore(&dev->lock, flags);
 				spin_unlock(&atm_dev_lock);
 #if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
-				if (clip_info)
+				if (clip_info && atm_clip_ops->owner)
 					__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
 #endif
 				return strlen(buf);
@@ -367,8 +367,8 @@
 	}
 	spin_unlock(&atm_dev_lock);
 #if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
-	if (clip_info)
-		__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
+	if (clip_info && atm_clip_ops->owner)
+			__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
 #endif
 	return 0;
 }
@@ -458,7 +458,8 @@
 				if (--count) continue;
 				atmarp_info(n->dev,entry,NULL,buf);
 				read_unlock_bh(&clip_tbl_hook->lock);
-				__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
+				if (atm_clip_ops->owner)
+					__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
 				return strlen(buf);
 			}
 			for (vcc = entry->vccs; vcc;
@@ -466,12 +467,14 @@
 				if (--count) continue;
 				atmarp_info(n->dev,entry,vcc,buf);
 				read_unlock_bh(&clip_tbl_hook->lock);
-				__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
+				if (atm_clip_ops->owner)
+					__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
 				return strlen(buf);
 			}
 		}
 	read_unlock_bh(&clip_tbl_hook->lock);
-	__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
+	if (atm_clip_ops->owner)
+		__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
 	return 0;
 }
 #endif

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264203AbTH1UDj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 16:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264214AbTH1UDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 16:03:39 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:7921 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S264203AbTH1UDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 16:03:33 -0400
Message-Id: <200308282003.h7SK3Ml5001781@ginger.cmf.nrl.navy.mil>
To: Krzysztof Sierota <krzysiek@mediaone.pl>
cc: linux-kernel@vger.kernel.org, linux-atm@vger.rutgers.edu
Subject: Re: 2.4.22 oops in ATM 2.4.21 works fine 
In-Reply-To: Message from Krzysztof Sierota <krzysiek@mediaone.pl> 
   of "Thu, 28 Aug 2003 15:59:01 -0000." <200308281559.01395.krzysiek@mediaone.pl> 
Date: Thu, 28 Aug 2003 16:03:23 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>the 2.4.22 kernel is oopsing at start scripts, machine stays alive, but A=
>TM=20
>does not work. 2.4.21 works just fine.

try this patch:

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

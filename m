Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263680AbTE3NoC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 09:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263681AbTE3NoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 09:44:02 -0400
Received: from relax.cmf.nrl.navy.mil ([134.207.10.227]:640 "EHLO
	relax.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S263680AbTE3Nnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 09:43:53 -0400
Date: Fri, 30 May 2003 09:57:11 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
Message-Id: <200305301357.h4UDvBq01098@relax.cmf.nrl.navy.mil>
To: davem@redhat.com
Subject: [PATCH][ATM] hold rtnl around device {de}registration
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

at one point you suggested using the rtnl_lock to protect the
atm device registration/deregistation nonsense.  how 'bout this?

[ATM]: hold rtnl around device {de}registration

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1157  -> 1.1158 
#	      net/atm/proc.c	1.15    -> 1.16   
#	 net/atm/signaling.c	1.8     -> 1.9    
#	 net/atm/resources.c	1.9     -> 1.10   
#	    net/atm/common.c	1.26    -> 1.27   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/19	chas@relax.cmf.nrl.navy.mil	1.1158
# [ATM]: hold rtnl around device {de}registration
# --------------------------------------------
#
diff -Nru a/net/atm/common.c b/net/atm/common.c
--- a/net/atm/common.c	Fri May 30 09:49:21 2003
+++ b/net/atm/common.c	Fri May 30 09:49:21 2003
@@ -376,18 +376,16 @@
 		struct atm_dev *dev = NULL;
 		struct list_head *p, *next;
 
-		spin_lock(&atm_dev_lock);
+		rtnl_lock();
 		list_for_each_safe(p, next, &atm_devs) {
 			dev = list_entry(p, struct atm_dev, dev_list);
 			atm_dev_hold(dev);
-			spin_unlock(&atm_dev_lock);
 			if (!atm_do_connect_dev(vcc,dev,vpi,vci))
 				break;
 			atm_dev_release(dev);
 			dev = NULL;
-			spin_lock(&atm_dev_lock);
 		}
-		spin_unlock(&atm_dev_lock);
+		rtnl_lock();
 		if (!dev) return -ENODEV;
 	}
 	if (vpi == ATM_VPI_UNSPEC || vci == ATM_VCI_UNSPEC)
@@ -642,17 +640,17 @@
 				goto done;
 			}
 			size = 0;
-			spin_lock(&atm_dev_lock);
+			rtnl_lock();
 			list_for_each(p, &atm_devs)
 				size += sizeof(int);
 			if (size > len) {
-				spin_unlock(&atm_dev_lock);
+				rtnl_unlock();
 				ret_val = -E2BIG;
 				goto done;
 			}
 			tmp_buf = kmalloc(size, GFP_ATOMIC);
 			if (!tmp_buf) {
-				spin_unlock(&atm_dev_lock);
+				rtnl_unlock();
 				ret_val = -ENOMEM;
 				goto done;
 			}
@@ -661,7 +659,7 @@
 				dev = list_entry(p, struct atm_dev, dev_list);
 				*tmp_p++ = dev->number;
 			}
-			spin_unlock(&atm_dev_lock);
+			rtnl_unlock();
 		        ret_val = ((copy_to_user(buf, tmp_buf, size)) ||
 			    put_user(size, &((struct atm_iobuf *) arg)->length)
 			    ) ? -EFAULT : 0;
diff -Nru a/net/atm/proc.c b/net/atm/proc.c
--- a/net/atm/proc.c	Fri May 30 09:49:21 2003
+++ b/net/atm/proc.c	Fri May 30 09:49:21 2003
@@ -314,16 +314,16 @@
 		    "AAL(TX,err,RX,err,drop) ...               [refcnt]\n");
 	}
 	left = pos-1;
-	spin_lock(&atm_dev_lock);
+	rtnl_lock();
 	list_for_each(p, &atm_devs) {
 		dev = list_entry(p, struct atm_dev, dev_list);
 		if (left-- == 0) {
 			dev_info(dev,buf);
-			spin_unlock(&atm_dev_lock);
+			rtnl_unlock();
 			return strlen(buf);
 		}
 	}
-	spin_unlock(&atm_dev_lock);
+	rtnl_unlock();
 	return 0;
 }
 
@@ -349,7 +349,7 @@
 	if (try_atm_clip_ops())
 		clip_info = 1;
 #endif
-	spin_lock(&atm_dev_lock);
+	rtnl_lock();
 	list_for_each(p, &atm_devs) {
 		dev = list_entry(p, struct atm_dev, dev_list);
 		spin_lock_irqsave(&dev->lock, flags);
@@ -357,7 +357,7 @@
 			if (vcc->sk->family == PF_ATMPVC && vcc->dev && !left--) {
 				pvc_info(vcc,buf,clip_info);
 				spin_unlock_irqrestore(&dev->lock, flags);
-				spin_unlock(&atm_dev_lock);
+				rtnl_unlock();
 #if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
 				if (clip_info)
 					module_put(atm_clip_ops->owner);
@@ -366,7 +366,7 @@
 			}
 		spin_unlock_irqrestore(&dev->lock, flags);
 	}
-	spin_unlock(&atm_dev_lock);
+	rtnl_unlock();
 #if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
 	if (clip_info)
 		module_put(atm_clip_ops->owner);
@@ -388,7 +388,7 @@
 		    "Address"," Itf VPI VCI   Fam Flags Reply Send buffer"
 		    "     Recv buffer\n");
 	left = pos-1;
-	spin_lock(&atm_dev_lock);
+	rtnl_lock();
 	list_for_each(p, &atm_devs) {
 		dev = list_entry(p, struct atm_dev, dev_list);
 		spin_lock_irqsave(&dev->lock, flags);
@@ -396,12 +396,12 @@
 			if (!left--) {
 				vc_info(vcc,buf);
 				spin_unlock_irqrestore(&dev->lock, flags);
-				spin_unlock(&atm_dev_lock);
+				rtnl_unlock();
 				return strlen(buf);
 			}
 		spin_unlock_irqrestore(&dev->lock, flags);
 	}
-	spin_unlock(&atm_dev_lock);
+	rtnl_unlock();
 
 	return 0;
 }
@@ -418,7 +418,7 @@
 	if (!pos)
 		return sprintf(buf,"Itf VPI VCI           State      Remote\n");
 	left = pos-1;
-	spin_lock(&atm_dev_lock);
+	rtnl_lock();
 	list_for_each(p, &atm_devs) {
 		dev = list_entry(p, struct atm_dev, dev_list);
 		spin_lock_irqsave(&dev->lock, flags);
@@ -426,12 +426,12 @@
 			if (vcc->sk->family == PF_ATMSVC && !left--) {
 				svc_info(vcc,buf);
 				spin_unlock_irqrestore(&dev->lock, flags);
-				spin_unlock(&atm_dev_lock);
+				rtnl_unlock();
 				return strlen(buf);
 			}
 		spin_unlock_irqrestore(&dev->lock, flags);
 	}
-	spin_unlock(&atm_dev_lock);
+	rtnl_unlock();
 
 	return 0;
 }
diff -Nru a/net/atm/resources.c b/net/atm/resources.c
--- a/net/atm/resources.c	Fri May 30 09:49:21 2003
+++ b/net/atm/resources.c	Fri May 30 09:49:21 2003
@@ -27,7 +27,7 @@
 
 
 LIST_HEAD(atm_devs);
-spinlock_t atm_dev_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t atm_dev_lock = SPIN_LOCK_UNLOCKED;
 
 static struct atm_dev *__alloc_atm_dev(const char *type)
 {
@@ -58,7 +58,6 @@
 	list_for_each(p, &atm_devs) {
 		dev = list_entry(p, struct atm_dev, dev_list);
 		if ((dev->ops) && (dev->number == number)) {
-			atm_dev_hold(dev);
 			return dev;
 		}
 	}
@@ -71,6 +70,8 @@
 
 	spin_lock(&atm_dev_lock);
 	dev = __atm_dev_lookup(number);
+	if (dev)
+		atm_dev_hold(dev);
 	spin_unlock(&atm_dev_lock);
 	return dev;
 }
@@ -86,11 +87,9 @@
 		    type);
 		return NULL;
 	}
-	spin_lock(&atm_dev_lock);
+	rtnl_lock();
 	if (number != -1) {
 		if ((inuse = __atm_dev_lookup(number))) {
-			atm_dev_release(inuse);
-			spin_unlock(&atm_dev_lock);
 			__free_atm_dev(dev);
 			return NULL;
 		}
@@ -98,7 +97,6 @@
 	} else {
 		dev->number = 0;
 		while ((inuse = __atm_dev_lookup(dev->number))) {
-			atm_dev_release(inuse);
 			dev->number++;
 		}
 	}
@@ -110,8 +108,6 @@
 		memset(&dev->flags, 0, sizeof(dev->flags));
 	memset(&dev->stats, 0, sizeof(dev->stats));
 	atomic_set(&dev->refcnt, 1);
-	list_add_tail(&dev->dev_list, &atm_devs);
-	spin_unlock(&atm_dev_lock);
 
 #ifdef CONFIG_PROC_FS
 	if (ops->proc_read) {
@@ -119,15 +115,17 @@
 			printk(KERN_ERR "atm_dev_register: "
 			       "atm_proc_dev_register failed for dev %s\n",
 			       type);
-			spin_lock(&atm_dev_lock);
-			list_del(&dev->dev_list);
-			spin_unlock(&atm_dev_lock);
 			__free_atm_dev(dev);
 			return NULL;
 		}
 	}
 #endif
 
+	spin_lock(&atm_dev_lock);
+	list_add_tail(&dev->dev_list, &atm_devs);
+	spin_unlock(&atm_dev_lock);
+	rtnl_unlock();
+
 	return dev;
 }
 
@@ -136,6 +134,7 @@
 {
 	unsigned long warning_time;
 
+	rtnl_lock();
 #ifdef CONFIG_PROC_FS
 	if (dev->ops->proc_read)
 		atm_proc_dev_deregister(dev);
@@ -156,6 +155,7 @@
                         warning_time = jiffies;
                 }
         }
+	rtnl_unlock();
 
 	__free_atm_dev(dev);
 }
diff -Nru a/net/atm/signaling.c b/net/atm/signaling.c
--- a/net/atm/signaling.c	Fri May 30 09:49:21 2003
+++ b/net/atm/signaling.c	Fri May 30 09:49:21 2003
@@ -220,14 +220,14 @@
 		printk(KERN_ERR "sigd_close: closing with requests pending\n");
 	skb_queue_purge(&vcc->sk->receive_queue);
 
-	spin_lock(&atm_dev_lock);
+	rtnl_lock();
 	list_for_each(p, &atm_devs) {
 		dev = list_entry(p, struct atm_dev, dev_list);
 		spin_lock_irqsave(&dev->lock, flags);
 		purge_vccs(dev->vccs);
 		spin_unlock_irqrestore(&dev->lock, flags);
 	}
-	spin_unlock(&atm_dev_lock);
+	rtnl_unlock();
 }
 
 

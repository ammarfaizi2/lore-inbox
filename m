Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268808AbTBZQAl>; Wed, 26 Feb 2003 11:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268803AbTBZP7s>; Wed, 26 Feb 2003 10:59:48 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:12943 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S268802AbTBZP7a>; Wed, 26 Feb 2003 10:59:30 -0500
Message-Id: <200302261609.h1QG9YGi005066@locutus.cmf.nrl.navy.mil>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] remove mod_inc_use_count from lec 
In-reply-to: Your message of "Wed, 26 Feb 2003 07:30:50 EST."
             <200302261230.h1QCUox9003790@locutus.cmf.nrl.navy.mil> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Wed, 26 Feb 2003 11:09:34 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lets try this again.  for now there are two owner pointers, the original
in atmdev_ops and another in the struct shared between the common code
and the lane code.  the shared one pointers to the private owner.
would that be the 'right' way or should i just ignore the owner field
in atmdev_ops.

Index: linux/net/atm/lec.h
===================================================================
RCS file: /home/chas/CVSROOT/linux/net/atm/lec.h,v
retrieving revision 1.3
retrieving revision 1.4
diff -u -r1.3 -r1.4
--- linux/net/atm/lec.h	24 Feb 2003 13:24:46 -0000	1.3
+++ linux/net/atm/lec.h	26 Feb 2003 15:52:44 -0000	1.4
@@ -65,6 +65,7 @@
         int (*mcast_attach)(struct atm_vcc *vcc, int arg);
         int (*vcc_attach)(struct atm_vcc *vcc, void *arg);
         struct net_device **(*get_lecs)(void);
+        struct module *owner;
 };
 
 /*
Index: linux/net/atm/proc.c
===================================================================
RCS file: /home/chas/CVSROOT/linux/net/atm/proc.c,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -r1.1 -r1.2
--- linux/net/atm/proc.c	20 Feb 2003 13:46:30 -0000	1.1
+++ linux/net/atm/proc.c	26 Feb 2003 15:52:44 -0000	1.2
@@ -444,8 +444,11 @@
 	}
 	if (atm_lane_ops.get_lecs == NULL)
 		return 0; /* the lane module is not there yet */
-	else
-		dev_lec = atm_lane_ops.get_lecs();
+
+	if (!try_module_get(atm_lane_ops.owner))
+		return 0;
+
+	dev_lec = atm_lane_ops.get_lecs();
 
 	count = pos;
 	for(d=0;d<MAX_LEC_ITF;d++) {
@@ -458,6 +461,7 @@
 				e=sprintf(buf,"%s ",
 				    dev_lec[d]->name);
 				lec_info(entry,buf+e);
+				module_put(atm_lane_ops.owner);
 				return strlen(buf);
 			}
 		}
@@ -466,6 +470,7 @@
 			if (--count) continue;
 			e=sprintf(buf,"%s ",dev_lec[d]->name);
 			lec_info(entry, buf+e);
+			module_put(atm_lane_ops.owner);
 			return strlen(buf);
 		}
 		for(entry=priv->lec_no_forward; entry;
@@ -473,6 +478,7 @@
 			if (--count) continue;
 			e=sprintf(buf,"%s ",dev_lec[d]->name);
 			lec_info(entry, buf+e);
+			module_put(atm_lane_ops.owner);
 			return strlen(buf);
 		}
 		for(entry=priv->mcast_fwds; entry;
@@ -480,9 +486,11 @@
 			if (--count) continue;
 			e=sprintf(buf,"%s ",dev_lec[d]->name);
 			lec_info(entry, buf+e);
+			module_put(atm_lane_ops.owner);
 			return strlen(buf);
 		}
 	}
+	module_put(atm_lane_ops.owner);
 	return 0;
 }
 #endif
Index: linux/net/atm/common.c
===================================================================
RCS file: /home/chas/CVSROOT/linux/net/atm/common.c,v
retrieving revision 1.4
retrieving revision 1.5
diff -u -r1.4 -r1.5
--- linux/net/atm/common.c	25 Feb 2003 20:06:54 -0000	1.4
+++ linux/net/atm/common.c	26 Feb 2003 15:52:44 -0000	1.5
@@ -685,12 +685,15 @@
 			}
                         if (atm_lane_ops.lecd_attach == NULL)
 				atm_lane_init();
-                        if (atm_lane_ops.lecd_attach == NULL) { /* try again */
+                        if (!try_module_get(atm_lane_ops.owner)) { /* try again */
 				ret_val = -ENOSYS;
 				goto done;
 			}
 			error = atm_lane_ops.lecd_attach(vcc, (int)arg);
-			if (error >= 0) sock->state = SS_CONNECTED;
+			if (error >= 0)
+				sock->state = SS_CONNECTED;
+			else
+				module_put(atm_lane_ops.owner);
 			ret_val =  error;
 			goto done;
                 case ATMLEC_MCAST:
Index: linux/net/atm/lec.c
===================================================================
RCS file: /home/chas/CVSROOT/linux/net/atm/lec.c,v
retrieving revision 1.8
retrieving revision 1.10
diff -u -r1.8 -r1.10
--- linux/net/atm/lec.c	25 Feb 2003 11:59:08 -0000	1.8
+++ linux/net/atm/lec.c	26 Feb 2003 15:52:44 -0000	1.10
@@ -543,12 +543,12 @@
         }
   
 	printk("%s: Shut down!\n", dev->name);
-        MOD_DEC_USE_COUNT;
 }
 
 static struct atmdev_ops lecdev_ops = {
         .close	= lec_atm_close,
-        .send	= lec_atm_send
+        .send	= lec_atm_send,
+        .owner	= THIS_MODULE
 };
 
 static struct atm_dev lecatm_dev = {
@@ -824,7 +824,6 @@
         if (dev_lec[i]->flags & IFF_UP) {
                 netif_start_queue(dev_lec[i]);
         }
-        MOD_INC_USE_COUNT;
         return i;
 }
 
@@ -834,6 +833,7 @@
         ops->mcast_attach = lec_mcast_attach;
         ops->vcc_attach = lec_vcc_attach;
         ops->get_lecs = get_dev_lec;
+        ops->owner = lecdev_ops.owner;
 
         printk("lec.c: " __DATE__ " " __TIME__ " initialized\n");
 
@@ -859,6 +859,7 @@
         atm_lane_ops.mcast_attach = NULL;
         atm_lane_ops.vcc_attach = NULL;
         atm_lane_ops.get_lecs = NULL;
+        atm_lane_ops.owner = NULL;
 
         for (i = 0; i < MAX_LEC_ITF; i++) {
                 if (dev_lec[i] != NULL) {

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbTELVQk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 17:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbTELVQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 17:16:40 -0400
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:58518 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262763AbTELVOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 17:14:49 -0400
Message-Id: <200305122126.h4CLQ4Gi030745@locutus.cmf.nrl.navy.mil>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] make clip modular 
In-reply-to: Your message of "Mon, 12 May 2003 11:57:58 PDT."
             <20030512.115758.39166911.davem@redhat.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Mon, 12 May 2003 17:26:04 -0400
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030512.115758.39166911.davem@redhat.com>,"David S. Miller" writes
:
>This doesn't work and is quite racey.
>   +			if (!atm_clip_ops || !try_module_get(atm_clip_ops->owne
>...
>MPOA/LEC/MPC probably have nearly identical bugs and it would
>be great if you could fix them up too.

yes, i know these are broken.  i was going to fix that later but i could
fix the clip now i suppose.  how about this for now for clip (lane et al
will come later):

--- linux-2.5.68/net/Kconfig.001	Thu May  8 10:56:23 2003
+++ linux-2.5.68/net/Kconfig	Thu May  8 10:56:36 2003
@@ -230,7 +230,7 @@
 	  further details.
 
 config ATM_CLIP
-	bool "Classical IP over ATM (EXPERIMENTAL)"
+	tristate "Classical IP over ATM (EXPERIMENTAL)"
 	depends on ATM && INET
 	help
 	  Classical IP over ATM for PVCs and SVCs, supporting InARP and
--- linux-2.5.68/net/atm/common.c.004	Thu May  8 18:52:14 2003
+++ linux-2.5.68/net/atm/common.c	Mon May 12 17:20:25 2003
@@ -57,6 +57,25 @@
 #endif
 #endif
 
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
+#include <net/atmclip.h>
+struct atm_clip_ops *atm_clip_ops;
+DECLARE_MUTEX(atm_clip_ops_mutex);
+
+void atm_clip_ops_set(struct atm_clip_ops *hook)
+{
+	down(&atm_clip_ops_mutex);
+	atm_clip_ops = hook;
+	up(&atm_clip_ops_mutex);
+}
+
+#ifdef CONFIG_ATM_CLIP_MODULE
+EXPORT_SYMBOL(atm_clip_ops);
+EXPORT_SYMBOL(atm_clip_ops_mutex);
+EXPORT_SYMBOL(atm_clip_ops_set);
+#endif
+#endif
+
 #if defined(CONFIG_PPPOATM) || defined(CONFIG_PPPOATM_MODULE)
 int (*pppoatm_ioctl_hook)(struct atm_vcc *, unsigned int, unsigned long);
 EXPORT_SYMBOL(pppoatm_ioctl_hook);
@@ -623,19 +642,30 @@
 			if (!error) sock->state = SS_CONNECTED;
 			ret_val = error;
 			goto done;
-#ifdef CONFIG_ATM_CLIP
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
 		case SIOCMKCLIP:
 			if (!capable(CAP_NET_ADMIN))
 				ret_val = -EPERM;
 			else 
-				ret_val = clip_create(arg);
+				ret_val = atm_clip_ops->clip_create(arg);
 			goto done;
 		case ATMARPD_CTRL:
 			if (!capable(CAP_NET_ADMIN)) {
 				ret_val = -EPERM;
 				goto done;
 			}
-			error = atm_init_atmarp(vcc);
+#if defined(CONFIG_ATM_CLIP_MODULE)
+			if (!atm_clip_ops)
+				request_module("clip");
+#endif
+			down(&atm_clip_ops_mutex);
+			if (!atm_clip_ops || !try_module_get(atm_clip_ops->owner)) {
+				up(&atm_clip_ops_mutex);
+				ret_val = -ENOSYS;
+				goto done;
+			}
+			up(&atm_clip_ops_mutex);
+			error = atm_clip_ops->atm_init_atmarp(vcc);
 			if (!error) sock->state = SS_CONNECTED;
 			ret_val = error;
 			goto done;
@@ -643,19 +673,19 @@
 			if (!capable(CAP_NET_ADMIN)) 
 				ret_val = -EPERM;
 			else 
-				ret_val = clip_mkip(vcc,arg);
+				ret_val = atm_clip_ops->clip_mkip(vcc, arg);
 			goto done;
 		case ATMARP_SETENTRY:
 			if (!capable(CAP_NET_ADMIN)) 
 				ret_val = -EPERM;
 			else
-				ret_val = clip_setentry(vcc,arg);
+				ret_val = atm_clip_ops->clip_setentry(vcc, arg);
 			goto done;
 		case ATMARP_ENCAP:
 			if (!capable(CAP_NET_ADMIN)) 
 				ret_val = -EPERM;
 			else
-				ret_val = clip_encap(vcc,arg);
+				ret_val = atm_clip_ops->clip_encap(vcc, arg);
 			goto done;
 #endif
 #if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
--- linux-2.5.68/net/atm/proc.c.000	Thu May  8 11:10:14 2003
+++ linux-2.5.68/net/atm/proc.c	Mon May 12 17:08:36 2003
@@ -39,7 +39,7 @@
 #include "common.h" /* atm_proc_init prototype */
 #include "signaling.h" /* to get sigd - ugly too */
 
-#ifdef CONFIG_ATM_CLIP
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
 #include <net/atmclip.h>
 #include "ipcommon.h"
 extern void clip_push(struct atm_vcc *vcc,struct sk_buff *skb);
@@ -89,7 +89,7 @@
 }
 
 
-#ifdef CONFIG_ATM_CLIP
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
 
 
 static int svc_addr(char *buf,struct sockaddr_atmsvc *addr)
@@ -178,17 +178,24 @@
 	    aal_name[vcc->qos.aal],vcc->qos.rxtp.min_pcr,
 	    class_name[vcc->qos.rxtp.traffic_class],vcc->qos.txtp.min_pcr,
 	    class_name[vcc->qos.txtp.traffic_class]);
-#ifdef CONFIG_ATM_CLIP
-	if (vcc->push == clip_push) {
-		struct clip_vcc *clip_vcc = CLIP_VCC(vcc);
-		struct net_device *dev;
-
-		dev = clip_vcc->entry ? clip_vcc->entry->neigh->dev : NULL;
-		off += sprintf(buf+off,"CLIP, Itf:%s, Encap:",
-		    dev ? dev->name : "none?");
-		if (clip_vcc->encap) off += sprintf(buf+off,"LLC/SNAP");
-		else off += sprintf(buf+off,"None");
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
+	down(&atm_clip_ops_mutex);
+	if (atm_clip_ops && try_module_get(atm_clip_ops->owner)) {
+		if (vcc->push == atm_clip_ops->clip_push) {
+			struct clip_vcc *clip_vcc = CLIP_VCC(vcc);
+			struct net_device *dev;
+
+			dev = clip_vcc->entry ? clip_vcc->entry->neigh->dev : NULL;
+			off += sprintf(buf+off,"CLIP, Itf:%s, Encap:",
+			    dev ? dev->name : "none?");
+			if (clip_vcc->encap)
+				off += sprintf(buf+off,"LLC/SNAP");
+			else
+				off += sprintf(buf+off,"None");
+		}
+		module_put(atm_clip_ops->owner);
 	}
+	up(&atm_clip_ops_mutex);
 #endif
 	strcpy(buf+off,"\n");
 }
@@ -407,7 +414,7 @@
 	return 0;
 }
 
-#ifdef CONFIG_ATM_CLIP
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
 static int atm_arp_info(loff_t pos,char *buf)
 {
 	struct neighbour *n;
@@ -417,28 +424,37 @@
 		return sprintf(buf,"IPitf TypeEncp Idle IP address      "
 		    "ATM address\n");
 	}
+	down(&atm_clip_ops_mutex);
+	if (!atm_clip_ops || !try_module_get(atm_clip_ops->owner)) {
+		up(&atm_clip_ops_mutex);
+		return 0;
+	}
+	down(&atm_clip_ops_mutex);
 	count = pos;
-	read_lock_bh(&clip_tbl.lock);
+	read_lock_bh(&clip_tbl_hook->lock);
 	for (i = 0; i <= NEIGH_HASHMASK; i++)
-		for (n = clip_tbl.hash_buckets[i]; n; n = n->next) {
+		for (n = clip_tbl_hook->hash_buckets[i]; n; n = n->next) {
 			struct atmarp_entry *entry = NEIGH2ENTRY(n);
 			struct clip_vcc *vcc;
 
 			if (!entry->vccs) {
 				if (--count) continue;
 				atmarp_info(n->dev,entry,NULL,buf);
-				read_unlock_bh(&clip_tbl.lock);
+				read_unlock_bh(&clip_tbl_hook->lock);
+				module_put(atm_clip_ops->owner);
 				return strlen(buf);
 			}
 			for (vcc = entry->vccs; vcc;
 			    vcc = vcc->next) {
 				if (--count) continue;
 				atmarp_info(n->dev,entry,vcc,buf);
-				read_unlock_bh(&clip_tbl.lock);
+				read_unlock_bh(&clip_tbl_hook->lock);
+				module_put(atm_clip_ops->owner);
 				return strlen(buf);
 			}
 		}
-	read_unlock_bh(&clip_tbl.lock);
+	read_unlock_bh(&clip_tbl_hook->lock);
+	module_put(atm_clip_ops->owner);
 	return 0;
 }
 #endif
@@ -610,7 +626,7 @@
 	CREATE_ENTRY(pvc);
 	CREATE_ENTRY(svc);
 	CREATE_ENTRY(vc);
-#ifdef CONFIG_ATM_CLIP
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
 	CREATE_ENTRY(arp);
 #endif
 #if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
--- linux-2.5.68/net/atm/pvc.c.000	Thu May  8 19:49:23 2003
+++ linux-2.5.68/net/atm/pvc.c	Mon May 12 16:42:45 2003
@@ -7,16 +7,12 @@
 #include <linux/net.h>		/* struct socket, struct proto_ops */
 #include <linux/atm.h>		/* ATM stuff */
 #include <linux/atmdev.h>	/* ATM devices */
-#include <linux/atmclip.h>	/* Classical IP over ATM */
 #include <linux/errno.h>	/* error codes */
 #include <linux/kernel.h>	/* printk */
 #include <linux/init.h>
 #include <linux/skbuff.h>
 #include <linux/bitops.h>
 #include <net/sock.h>		/* for sock_no_* */
-#ifdef CONFIG_ATM_CLIP
-#include <net/atmclip.h>
-#endif
 
 #include "resources.h"		/* devs and vccs */
 #include "common.h"		/* common for PVCs and SVCs */
@@ -129,9 +125,6 @@
 		printk(KERN_ERR "ATMPVC: can't register (%d)",error);
 		return error;
 	}
-#ifdef CONFIG_ATM_CLIP
-	atm_clip_init();
-#endif
 #ifdef CONFIG_PROC_FS
 	error = atm_proc_init();
 	if (error) printk("atm_proc_init fails with %d\n",error);
--- linux-2.5.68/net/atm/clip.c.004	Thu May  8 10:53:44 2003
+++ linux-2.5.68/net/atm/clip.c	Mon May 12 17:13:36 2003
@@ -7,6 +7,8 @@
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/kernel.h> /* for UINT_MAX */
+#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <linux/wait.h>
@@ -45,6 +47,7 @@
 
 struct net_device *clip_devs = NULL;
 struct atm_vcc *atmarpd = NULL;
+static struct neigh_table clip_tbl;
 static struct timer_list idle_timer;
 static int start_timer = 1;
 
@@ -187,7 +190,7 @@
 }
 
 
-void clip_push(struct atm_vcc *vcc,struct sk_buff *skb)
+static void clip_push(struct atm_vcc *vcc,struct sk_buff *skb)
 {
 	struct clip_vcc *clip_vcc = CLIP_VCC(vcc);
 
@@ -325,7 +328,7 @@
 }
 
 
-struct neigh_table clip_tbl = {
+static struct neigh_table clip_tbl = {
 	NULL,			/* next */
 	AF_INET,		/* family */
 	sizeof(struct neighbour)+sizeof(struct atmarp_entry), /* entry_size */
@@ -371,7 +374,7 @@
  */
 
 
-int clip_encap(struct atm_vcc *vcc,int mode)
+static int clip_encap(struct atm_vcc *vcc,int mode)
 {
 	CLIP_VCC(vcc)->encap = mode;
 	return 0;
@@ -468,7 +471,7 @@
 }
 
 
-int clip_mkip(struct atm_vcc *vcc,int timeout)
+static int clip_mkip(struct atm_vcc *vcc,int timeout)
 {
 	struct clip_vcc *clip_vcc;
 	struct sk_buff_head copy;
@@ -508,7 +511,7 @@
 }
 
 
-int clip_setentry(struct atm_vcc *vcc,u32 ip)
+static int clip_setentry(struct atm_vcc *vcc,u32 ip)
 {
 	struct neighbour *neigh;
 	struct atmarp_entry *entry;
@@ -581,7 +584,7 @@
 }
 
 
-int clip_create(int number)
+static int clip_create(int number)
 {
 	struct net_device *dev;
 	struct clip_priv *clip_priv;
@@ -701,28 +704,23 @@
 		    "pending\n");
 	skb_queue_purge(&vcc->sk->receive_queue);
 	DPRINTK("(done)\n");
+	module_put(THIS_MODULE);
 }
 
 
 static struct atmdev_ops atmarpd_dev_ops = {
-	.close =atmarpd_close,
+	.close = atmarpd_close
 };
 
 
 static struct atm_dev atmarpd_dev = {
-	&atmarpd_dev_ops,
-	NULL,		/* no PHY */
-	"arpd",		/* type */
-	999,		/* dummy device number */
-	NULL,NULL,	/* pretend not to have any VCCs */
-	NULL,NULL,	/* no data */
-	0,		/* no flags */
-	NULL,		/* no local address */
-	{ 0 }		/* no ESI, no statistics */
+	.ops =			&atmarpd_dev_ops,
+	.type =			"arpd",
+	.number = 		999,
 };
 
 
-int atm_init_atmarp(struct atm_vcc *vcc)
+static int atm_init_atmarp(struct atm_vcc *vcc)
 {
 	struct net_device *dev;
 
@@ -752,10 +750,56 @@
 	return 0;
 }
 
+static struct atm_clip_ops __atm_clip_ops = {
+	.clip_create =		clip_create,
+	.clip_mkip =		clip_mkip,
+	.clip_setentry =	clip_setentry,
+	.clip_encap =		clip_encap,
+	.clip_push =		clip_push,
+	.atm_init_atmarp =	atm_init_atmarp,
+	.owner =		THIS_MODULE
+};
 
-void atm_clip_init(void)
+static int __init atm_clip_init(void)
 {
+	/* we should use neigh_table_init() */
 	clip_tbl.lock = RW_LOCK_UNLOCKED;
 	clip_tbl.kmem_cachep = kmem_cache_create(clip_tbl.id,
 	    clip_tbl.entry_size, 0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+
+	/* so neigh_ifdown() doesn't complain */
+	clip_tbl.proxy_timer.data = 0;
+	clip_tbl.proxy_timer.function = 0;
+	init_timer(&clip_tbl.proxy_timer);
+	skb_queue_head_init(&clip_tbl.proxy_queue);
+
+	clip_tbl_hook = &clip_tbl;
+	atm_clip_ops_set(&__atm_clip_ops);
+
+	return 0;
 }
+
+static void __exit atm_clip_exit(void)
+{
+	struct net_device *dev, *next;
+
+	atm_clip_ops_set(NULL);
+	clip_tbl_hook = NULL;
+
+	neigh_ifdown(&clip_tbl, NULL);
+	dev = clip_devs;
+	while (dev) {
+		next = PRIV(dev)->next;
+		unregister_netdev(dev);
+		kfree(dev);
+		dev = next;
+	}
+	if (start_timer == 0) del_timer(&idle_timer);
+
+	kmem_cache_destroy(clip_tbl.kmem_cachep);
+}
+
+module_init(atm_clip_init);
+module_exit(atm_clip_exit);
+
+MODULE_LICENSE("GPL");
--- linux-2.5.68/net/atm/ipcommon.c.000	Thu May  8 19:58:15 2003
+++ linux-2.5.68/net/atm/ipcommon.c	Thu May  8 19:58:23 2003
@@ -67,4 +67,5 @@
 }
 
 
+EXPORT_SYMBOL(llc_oui);
 EXPORT_SYMBOL(skb_migrate);
--- linux-2.5.68/net/atm/Makefile.001	Thu May  8 19:53:44 2003
+++ linux-2.5.68/net/atm/Makefile	Thu May  8 20:20:26 2003
@@ -2,13 +2,15 @@
 # Makefile for the ATM Protocol Families.
 #
 
+atm-y		:= addr.o pvc.o signaling.o svc.o common.o atm_misc.o raw.o resources.o
 mpoa-objs	:= mpc.o mpoa_caches.o mpoa_proc.o
 
-obj-$(CONFIG_ATM) := addr.o pvc.o signaling.o svc.o common.o atm_misc.o raw.o resources.o
-
-obj-$(CONFIG_ATM_CLIP) += clip.o ipcommon.o
-obj-$(CONFIG_ATM_BR2684) += br2684.o ipcommon.o
-obj-$(CONFIG_NET_SCH_ATM) += ipcommon.o
+obj-$(CONFIG_ATM) += atm.o
+obj-$(CONFIG_ATM_CLIP) += clip.o
+atm-$(subst m,y,$(CONFIG_ATM_CLIP)) += ipcommon.o
+obj-$(CONFIG_ATM_BR2684) += br2684.o
+atm-$(subst m,y,$(CONFIG_ATM_BR2684)) += ipcommon.o
+atm-$(subst m,y,$CONFIG_NET_SCH_ATM)) += ipcommon.o
 obj-$(CONFIG_PROC_FS) += proc.o
 
 obj-$(CONFIG_ATM_LANE) += lec.o
--- linux-2.5.68/net/netsyms.c.000	Thu May  8 18:41:07 2003
+++ linux-2.5.68/net/netsyms.c	Thu May  8 18:48:39 2003
@@ -45,6 +45,9 @@
 #include <linux/ip.h>
 #include <net/protocol.h>
 #include <net/arp.h>
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
+#include <net/atmclip.h>
+#endif
 #include <net/ip.h>
 #include <net/udp.h>
 #include <net/tcp.h>
@@ -528,6 +531,9 @@
 EXPORT_SYMBOL(ip_rcv);
 EXPORT_SYMBOL(arp_rcv);
 EXPORT_SYMBOL(arp_tbl);
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
+EXPORT_SYMBOL(clip_tbl_hook);
+#endif
 EXPORT_SYMBOL(arp_find);
 
 #endif  /* CONFIG_INET */
--- linux-2.5.68/net/ipv4/arp.c.000	Thu May  8 18:42:10 2003
+++ linux-2.5.68/net/ipv4/arp.c	Thu May  8 20:01:59 2003
@@ -108,8 +108,9 @@
 #include <net/netrom.h>
 #endif
 #endif
-#ifdef CONFIG_ATM_CLIP
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
 #include <net/atmclip.h>
+struct neigh_table *clip_tbl_hook;
 #endif
 
 #include <asm/system.h>
@@ -443,8 +444,8 @@
 		if (dev->flags&(IFF_LOOPBACK|IFF_POINTOPOINT))
 			nexthop = 0;
 		n = __neigh_lookup_errno(
-#ifdef CONFIG_ATM_CLIP
-		    dev->type == ARPHRD_ATM ? &clip_tbl :
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
+		    dev->type == ARPHRD_ATM ? clip_tbl_hook :
 #endif
 		    &arp_tbl, &nexthop, dev);
 		if (IS_ERR(n))
--- linux-2.5.68/include/net/atmclip.h.000	Thu May  8 18:02:19 2003
+++ linux-2.5.68/include/net/atmclip.h	Mon May 12 16:48:01 2003
@@ -55,13 +55,22 @@
 };
 
 
-extern struct atm_vcc *atmarpd; /* ugly */
-extern struct neigh_table clip_tbl;
+#ifdef __KERNEL__
+struct atm_clip_ops {
+	int (*clip_create)(int number);
+	int (*clip_mkip)(struct atm_vcc *vcc,int timeout);
+	int (*clip_setentry)(struct atm_vcc *vcc,u32 ip);
+	int (*clip_encap)(struct atm_vcc *vcc,int mode);
+	void (*clip_push)(struct atm_vcc *vcc,struct sk_buff *skb);
+	int (*atm_init_atmarp)(struct atm_vcc *vcc);
+	struct module *owner;
+};
+
+void atm_clip_ops_set(struct atm_clip_ops *);
+extern struct semaphore atm_clip_ops_mutex;
 
-int clip_create(int number);
-int clip_mkip(struct atm_vcc *vcc,int timeout);
-int clip_setentry(struct atm_vcc *vcc,u32 ip);
-int clip_encap(struct atm_vcc *vcc,int mode);
-void atm_clip_init(void);
+extern struct neigh_table *clip_tbl_hook;
+extern struct atm_clip_ops *atm_clip_ops;
+#endif
 
 #endif

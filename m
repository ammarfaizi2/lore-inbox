Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268896AbRHPX2S>; Thu, 16 Aug 2001 19:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269002AbRHPX2K>; Thu, 16 Aug 2001 19:28:10 -0400
Received: from tyranny.egregious.net ([206.159.99.12]:64772 "HELO
	tyranny.egregious.net") by vger.kernel.org with SMTP
	id <S268896AbRHPX2E>; Thu, 16 Aug 2001 19:28:04 -0400
Date: Thu, 16 Aug 2001 16:28:10 -0700
From: Will <will@loopfree.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.8 frame diverter for modules
Message-ID: <20010816162810.A12338@loopfree.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here is a patch against 2.4.8 that implements support for diverting network frames
to an arbitrary kernel module. It is similar to the user-level packet diverter
except that it handles both incoming and outgoing packets, and the module can
discard the packet if it wants to. There is also a callback when a packet is freed.
This allows a modular way of doing low-level packet frobbing without going out to
userland.

As noted in the code, it currently only supports 1 'diverter module', but it would
be pretty easy to support more...

Comments? Anyone find this sort of thing useful besides us?

-- 
-Will  :: AD6XL :: http://www.loopfree.net/
 Orton :: finger will@tyranny.egregious.net for GPG public key

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="moddv-patch-2.4.8"

diff -urP linux-clean/include/linux/moddv.h linux/include/linux/moddv.h
--- linux-clean/include/linux/moddv.h	Wed Dec 31 16:00:00 1969
+++ linux/include/linux/moddv.h	Thu Aug 16 11:50:10 2001
@@ -0,0 +1,31 @@
+#ifndef _MODDV_H_
+#define _MODDV_H_
+
+struct moddv_calls {
+	atomic_t unloading;
+	atomic_t usage;
+	int (*divert_tx)(struct sk_buff **, struct net_device **, struct packet_type **);
+	int (*divert_rx)(struct sk_buff **, struct net_device **, struct packet_type **);
+	void (*divert_bind)(struct net_device *, struct packet_type *);
+	void (*divert_free)(struct sk_buff *);
+};
+
+extern int register_divert_module(struct moddv_calls *);
+extern void unregister_divert_module( struct moddv_calls * );
+void mod_divert_inject_out( struct sk_buff *, struct net_device *);
+void mod_divert_inject_in( struct sk_buff *, struct net_device *, struct packet_type *);
+
+int handle_mod_divert_tx(struct sk_buff **, struct net_device **);
+int handle_mod_divert_rx(struct sk_buff **, struct net_device **, struct packet_type **);
+void mod_divert_skb_use(struct sk_buff *);
+void mod_divert_skb_unuse(struct sk_buff *);
+void mod_divert_init(void);
+
+extern struct moddv_calls *diverter;
+
+#define MDV_DISCARD 1
+#define MDV_HOLD    2
+#define MDV_CHAIN   3
+
+
+#endif  /* _MODDV_H_ */
diff -urP linux-clean/include/linux/netdevice.h linux/include/linux/netdevice.h
--- linux-clean/include/linux/netdevice.h	Thu Aug 16 12:43:55 2001
+++ linux/include/linux/netdevice.h	Thu Aug 16 16:07:35 2001
@@ -418,6 +418,9 @@
 					 struct packet_type *);
 	void			*data;	/* Private to the packet type		*/
 	struct packet_type	*next;
+#ifdef CONFIG_MOD_DIVERT
+	void                    *divertPtr; /* Private ptr for the module diverter */
+#endif
 };
 
 
diff -urP linux-clean/include/linux/skbuff.h linux/include/linux/skbuff.h
--- linux-clean/include/linux/skbuff.h	Thu Aug 16 12:43:55 2001
+++ linux/include/linux/skbuff.h	Thu Aug 16 11:53:34 2001
@@ -213,6 +213,9 @@
 #ifdef CONFIG_NET_SCHED
        __u32           tc_index;               /* traffic control index */
 #endif
+#ifdef CONFIG_MOD_DIVERT
+	void            *divertPtr1;
+#endif
 };
 
 #define SK_WMEM_MAX	65535
diff -urP linux-clean/net/Config.in linux/net/Config.in
--- linux-clean/net/Config.in	Thu Aug 16 12:44:11 2001
+++ linux/net/Config.in	Thu Aug 16 11:58:34 2001
@@ -64,6 +64,7 @@
    tristate 'LAPB Data Link Driver (EXPERIMENTAL)' CONFIG_LAPB
    bool '802.2 LLC (EXPERIMENTAL)' CONFIG_LLC
    bool 'Frame Diverter (EXPERIMENTAL)' CONFIG_NET_DIVERT
+   bool 'Frame diverter for modules (EXPERIMENTAL)' CONFIG_MOD_DIVERT  
 #   if [ "$CONFIG_LLC" = "y" ]; then
 #      bool '  Netbeui (EXPERIMENTAL)' CONFIG_NETBEUI
 #   fi
diff -urP linux-clean/net/core/Makefile linux/net/core/Makefile
--- linux-clean/net/core/Makefile	Thu Aug 16 12:44:10 2001
+++ linux/net/core/Makefile	Thu Aug 16 12:14:53 2001
@@ -24,6 +24,7 @@
 obj-$(CONFIG_NET) += dev.o dev_mcast.o dst.o neighbour.o rtnetlink.o utils.o
 
 obj-$(CONFIG_NETFILTER) += netfilter.o
+obj-$(CONFIG_MOD_DIVERT) += moddv.o
 obj-$(CONFIG_NET_DIVERT) += dv.o
 obj-$(CONFIG_NET_PROFILE) += profile.o
 
diff -urP linux-clean/net/core/dev.c linux/net/core/dev.c
--- linux-clean/net/core/dev.c	Thu Aug 16 12:44:10 2001
+++ linux/net/core/dev.c	Thu Aug 16 12:09:11 2001
@@ -103,6 +103,9 @@
 #if defined(CONFIG_NET_RADIO) || defined(CONFIG_NET_PCMCIA_RADIO)
 #include <linux/wireless.h>		/* Note : will define WIRELESS_EXT */
 #endif	/* CONFIG_NET_RADIO || CONFIG_NET_PCMCIA_RADIO */
+#ifdef CONFIG_MOD_DIVERT
+#include <linux/moddv.h>
+#endif /* CONFIG_MOD_DIVERT */
 #ifdef CONFIG_PLIP
 extern int plip_init(void);
 #endif
@@ -152,8 +155,13 @@
  *		86DD	IPv6
  */
 
+#ifdef CONFIG_MOD_DIVERT
+struct packet_type *ptype_base[16];		/* 16 way hashed list */
+struct packet_type *ptype_all = NULL;		/* Taps */
+#else  /* !CONFIG_MOD_DIVERT */
 static struct packet_type *ptype_base[16];		/* 16 way hashed list */
 static struct packet_type *ptype_all = NULL;		/* Taps */
+#endif /* !CONFIG_MOD_DIVERT */
 
 #ifdef OFFLINE_SAMPLE
 static void sample_queue(unsigned long dummy);
@@ -987,6 +995,12 @@
 			return -ENOMEM;
 	}
 
+	/* call the module diverter */
+#ifdef CONFIG_MOD_DIVERT
+	if (handle_mod_divert_tx(&skb, &dev))
+		return NET_XMIT_SUCCESS;
+#endif
+
 	/* Grab device queue */
 	spin_lock_bh(&dev->queue_lock);
 	q = dev->qdisc;
@@ -1475,6 +1489,10 @@
 							deliver_to_old_ones(pt_prev, skb, 0);
 						else {
 							atomic_inc(&skb->users);
+#ifdef CONFIG_MOD_DIVERT
+							if (handle_mod_divert_rx(&skb, &rx_dev, &pt_prev))
+								goto DEAD_PACKET;
+#endif /* CONFIG_MOD_DIVERT */
 							pt_prev->func(skb,
 								      skb->dev,
 								      pt_prev);
@@ -1487,12 +1505,19 @@
 			if (pt_prev) {
 				if (!pt_prev->data)
 					deliver_to_old_ones(pt_prev, skb, 1);
-				else
+				else {
+#ifdef CONFIG_MOD_DIVERT
+					if (handle_mod_divert_rx(&skb, &rx_dev, &pt_prev))
+						goto DEAD_PACKET;
+#endif /* CONFIG_MOD_DIVERT */
 					pt_prev->func(skb, skb->dev, pt_prev);
+				}
 			} else
 				kfree_skb(skb);
 		}
-
+#ifdef CONFIG_MOD_DIVERT
+DEAD_PACKET:
+#endif
 		dev_put(rx_dev);
 
 		if (bugdet-- < 0 || jiffies - start_time > 1)
@@ -2783,7 +2808,10 @@
 	 */
 	 
 	net_device_init();
-
+	
+#ifdef CONFIG_MOD_DIVERT
+	mod_divert_init();
+#endif /* CONFIG_MOD_DIVERT */
 	return 0;
 }
 
diff -urP linux-clean/net/core/moddv.c linux/net/core/moddv.c
--- linux-clean/net/core/moddv.c	Wed Dec 31 16:00:00 1969
+++ linux/net/core/moddv.c	Thu Aug 16 11:50:10 2001
@@ -0,0 +1,239 @@
+/*   
+ *   Module level frame diverter.
+ * 
+ *   File: moddv.c 
+ *
+ *   Purpose: This file in conjunction with the #ifdef CONFIG_MOD_DIVERT section inside
+ *     of dev.c, skbuff.c, skbuff.h and netdevice.h form a full packet diverter for modules.  
+ *     This system is similar to the user level packet diverter, except it also gets
+ *     outgoing packets, and may discard both incomming and outgoing packet.  There is 
+ *     also a callback for packets being freed.
+ *
+ *     Currently only one diverter module is allowed to register.  This could be changed
+ *     in the furture to accomodate a priority based list such as is used in netfilter.
+ *
+ *     Currently this implementation is for kernel modules only.  Anyone wanting an ioctl
+ *     interface, feel free to write one... 
+ *
+ *   Authors: Seth Keith  ( seth@deterministicnetworks.com )
+ *            Will Orton ( worton@deterministicnetworks.com )
+ */
+
+#include <asm/uaccess.h>
+#include <asm/system.h>
+#include <asm/bitops.h>
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/socket.h>
+#include <linux/sockios.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/if_ether.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/notifier.h>
+#include <linux/skbuff.h>
+#include <linux/brlock.h>
+#include <net/sock.h>
+#include <linux/rtnetlink.h>
+#include <linux/proc_fs.h>
+#include <linux/stat.h>
+#include <linux/if_bridge.h>
+#include <linux/divert.h>
+#include <net/dst.h>
+#include <net/pkt_sched.h>
+#include <net/profile.h>
+#include <net/checksum.h>
+#include <linux/highmem.h>
+#include <linux/init.h>
+#include <linux/kmod.h>
+#include <linux/module.h>
+#include <linux/moddv.h>
+
+spinlock_t divertLock;
+struct moddv_calls *diverter = NULL; 
+static int initted = 0;
+
+extern struct packet_type *ptype_base[16];
+extern struct packet_type *ptype_all;
+extern int dev_queue_xmit( struct sk_buff *);
+
+__inline int enter_diverter(void)
+{ 
+	if (!initted)
+		return 1;
+
+	spin_lock_bh(&divertLock);
+	if (!diverter || atomic_read(&(diverter->unloading))) {
+		spin_unlock_bh(&divertLock);
+		return 1;
+	} else {
+		spin_unlock_bh(&divertLock);
+		atomic_inc(&diverter->usage);
+		return 0; 
+	}
+}
+
+__inline void exit_diverter(void)
+{
+	spin_lock_bh(&divertLock);
+	if (!diverter) {
+		spin_unlock_bh(&divertLock);
+	} else {
+		atomic_dec(&diverter->usage);
+		spin_unlock_bh(&divertLock);
+	}
+}	 
+
+void __init mod_divert_init(void)
+{
+	spin_lock_init(&divertLock);
+	initted = 1;
+}
+
+void call_bind(void)
+{
+	struct net_device *dev;
+	struct packet_type *pt;
+	int i;
+
+	for (dev = dev_base; dev != NULL; dev = dev->next) {
+		for (i = 0; i < 16; i++) {
+			for (pt = ptype_base[i]; pt != NULL; pt = pt->next) {
+				if (diverter->divert_bind)
+					diverter->divert_bind(dev, pt);
+			}
+		}
+	}
+}
+
+int register_divert_module(struct moddv_calls *regcalls)
+{
+	/* Right now we just handle one.  This can easily be changed.
+	 */	 
+	spin_lock_bh(&divertLock);
+
+	if (diverter) {
+		printk(KERN_ERR "Only one diverter is currently supported, and one is already registered.\n"); 
+		spin_unlock_bh(&divertLock);
+		return 1;
+	}
+
+	diverter = regcalls;
+	spin_unlock_bh(&divertLock);
+	call_bind();
+	return 0;
+} 
+
+void unregister_divert_module(struct moddv_calls *regcalls)
+{
+	atomic_set(&diverter->unloading, 1);
+	while (atomic_read(&diverter->usage))
+		schedule();
+
+	spin_lock_bh(&divertLock);
+	diverter = NULL;
+	spin_unlock_bh(&divertLock);
+}
+
+int handle_mod_divert_tx(struct sk_buff **skb, struct net_device **dev)
+{
+	struct packet_type *proto = NULL;
+
+	if (enter_diverter() || !diverter->divert_tx)
+		return 0;
+
+	if ((*skb)->divertPtr1 != NULL) {
+		exit_diverter();
+		return 0;
+	}
+
+	for (proto = ptype_base[ntohs((*skb)->protocol) & 15]; proto; proto = proto->next) {
+		if (proto->type == (*skb)->protocol && (!proto->dev || proto->dev == (*skb)->dev)) {
+			break;
+		}
+	}
+
+	if (!proto) {
+		printk(KERN_ERR "Diverting a packet to a module but cannot find the correct protocol?");
+		exit_diverter();
+		return 0;
+	}
+
+	switch (diverter->divert_tx(skb, dev, &proto)) {
+		case MDV_DISCARD:
+			kfree_skb(*skb);	 
+			exit_diverter();
+			return 1;
+		case MDV_HOLD:
+			exit_diverter();
+			return 1;
+		case MDV_CHAIN:
+			exit_diverter();
+			return 0;		  
+		default:
+			printk(KERN_ERR "Diverter module return an invalid return code from TX!\n");
+			exit_diverter();
+			return 1;
+	}
+} 
+
+int handle_mod_divert_rx(struct sk_buff **skb, struct net_device **dev, struct packet_type **proto )
+{
+	if (enter_diverter() || !diverter->divert_rx)
+		return 0;
+
+	if ((*skb)->divertPtr1 != NULL)	{
+		exit_diverter();
+		return 0;
+	}
+
+	switch (diverter->divert_rx(skb, dev, proto)) {
+		case MDV_DISCARD:
+			kfree_skb(*skb);
+			exit_diverter();
+			return 1;
+		case MDV_HOLD:
+			exit_diverter();
+			return 1;
+		case MDV_CHAIN:
+			exit_diverter();
+			return 0;
+		default:
+			printk(KERN_ERR "Diverter module return an invalid return code from RX!\n");
+			exit_diverter();
+			return 1;
+	}
+} 
+
+void mod_divert_skb_use(struct sk_buff *skb)
+{
+	enter_diverter();
+	exit_diverter();
+}
+
+void mod_divert_skb_unuse(struct sk_buff *skb)
+{
+	if (skb->divertPtr1) {
+		enter_diverter();
+		if (diverter->divert_free)
+			diverter->divert_free(skb);
+		exit_diverter();
+	}
+}
+
+void mod_divert_inject_out(struct sk_buff *skb, struct net_device *dev)
+{
+	skb->dev = dev;
+	dev_queue_xmit(skb);
+}
+
+void mod_divert_inject_in(struct sk_buff *skb, struct net_device *dev, struct packet_type *proto)
+{
+	skb->dev = dev;
+	proto->func(skb, dev, proto);
+}
diff -urP linux-clean/net/core/skbuff.c linux/net/core/skbuff.c
--- linux-clean/net/core/skbuff.c	Thu Aug 16 12:44:10 2001
+++ linux/net/core/skbuff.c	Thu Aug 16 12:35:20 2001
@@ -51,6 +51,9 @@
 #include <linux/cache.h>
 #include <linux/init.h>
 #include <linux/highmem.h>
+#ifdef CONFIG_MOD_DIVERT
+#include <linux/moddv.h>
+#endif /* CONFIG_MOD_DIVERT */
 
 #include <net/ip.h>
 #include <net/protocol.h>
@@ -209,6 +212,9 @@
 	atomic_set(&(skb_shinfo(skb)->dataref), 1);
 	skb_shinfo(skb)->nr_frags = 0;
 	skb_shinfo(skb)->frag_list = NULL;
+#ifdef CONFIG_MOD_DIVERT
+	skb->divertPtr1 = NULL;
+#endif
 	return skb;
 
 nodata:
@@ -250,6 +256,9 @@
 #ifdef CONFIG_NET_SCHED
 	skb->tc_index = 0;
 #endif
+#ifdef CONFIG_MOD_DIVERT
+	skb->divertPtr1 = NULL;
+#endif /* CONFIG_MOD_DIVERT */
 }
 
 static void skb_drop_fraglist(struct sk_buff *skb)
@@ -275,6 +284,9 @@
 
 static void skb_release_data(struct sk_buff *skb)
 {
+#ifdef CONFIG_MOD_DIVERT
+	if (skb->head) {
+#endif
 	if (!skb->cloned ||
 	    atomic_dec_and_test(&(skb_shinfo(skb)->dataref))) {
 		if (skb_shinfo(skb)->nr_frags) {
@@ -288,6 +300,9 @@
 
 		kfree(skb->head);
 	}
+#ifdef CONFIG_MOD_DIVERT
+	}
+#endif
 }
 
 /*
@@ -316,7 +331,12 @@
 		BUG();
 	}
 
+#ifdef CONFIG_MOD_DIVERT
+	if (skb->dst)
+		dst_release(skb->dst);
+#else
 	dst_release(skb->dst);
+#endif
 	if(skb->destructor) {
 		if (in_irq()) {
 			printk(KERN_WARNING "Warning: kfree_skb on hard IRQ %p\n",
@@ -327,6 +347,10 @@
 #ifdef CONFIG_NETFILTER
 	nf_conntrack_put(skb->nfct);
 #endif
+#ifdef CONFIG_MOD_DIVERT
+	if (skb->divertPtr1)
+		mod_divert_skb_unuse(skb);
+#endif /* CONFIG_MOD_DIVERT */
 	skb_headerinit(skb, NULL, 0);  /* clean state */
 	kfree_skbmem(skb);
 }
@@ -404,6 +428,9 @@
 	skb->cloned = 1;
 #ifdef CONFIG_NETFILTER
 	nf_conntrack_get(skb->nfct);
+#endif
+#ifdef CONFIG_MOD_DIVERT
+	n->divertPtr1 = NULL;
 #endif
 	return n;
 }
diff -urP linux-clean/net/netsyms.c linux/net/netsyms.c
--- linux-clean/net/netsyms.c	Thu Aug 16 12:44:09 2001
+++ linux/net/netsyms.c	Thu Aug 16 12:00:38 2001
@@ -34,6 +34,9 @@
 #ifdef CONFIG_NET_DIVERT
 #include <linux/divert.h>
 #endif /* CONFIG_NET_DIVERT */
+#ifdef CONFIG_MOD_DIVERT
+#include <linux/moddv.h>
+#endif /* CONFIG_MOD_DIVERT */
 
 #ifdef CONFIG_NET
 extern __u32 sysctl_wmem_max;
@@ -230,6 +233,11 @@
 EXPORT_SYMBOL(free_divert_blk);
 EXPORT_SYMBOL(divert_ioctl);
 #endif /* CONFIG_NET_DIVERT */
+
+#ifdef CONFIG_MOD_DIVERT
+EXPORT_SYMBOL_NOVERS(register_divert_module);
+EXPORT_SYMBOL_NOVERS(unregister_divert_module);
+#endif /* CONFIG_MOD_DIVERT */
 
 #ifdef CONFIG_INET
 /* Internet layer registration */

--BOKacYhQ+x31HxR3--

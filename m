Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317755AbSGVTpX>; Mon, 22 Jul 2002 15:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317766AbSGVTpW>; Mon, 22 Jul 2002 15:45:22 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:2432 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S317755AbSGVTpJ>;
	Mon, 22 Jul 2002 15:45:09 -0400
Date: Mon, 22 Jul 2002 21:48:14 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: [PATCH] cli/sti in net/802/*
Message-ID: <20020722194814.GA1668@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave, hi Ingo,
   patch below switches 802.2 and SNAP layer to use rwlock instead
of cli/sti. If you think that read_lock() has too much overhead
in this code path, I'm sorry, I have no better solution...

   It also fixes race between two tasks doing register_*_client
at once - there was no locking here.

   If you agree, tell me and I'll forward it to Linus. Or do so
yourself.
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz


diff -urdN linux/net/802/p8022.c linux/net/802/p8022.c
--- linux/net/802/p8022.c	2002-07-22 13:32:52.000000000 +0000
+++ linux/net/802/p8022.c	2002-07-22 19:32:20.000000000 +0000
@@ -31,6 +31,8 @@
 extern void llc_unregister_sap(unsigned char sap);
 
 static struct datalink_proto *p8022_list;
+static rwlock_t p8022_list_lock = RW_LOCK_UNLOCKED;
+
 /*
  *	We don't handle the loopback SAP stuff, the extended
  *	802.2 command set, multicast SAP identifiers and non UI
@@ -53,6 +55,7 @@
 	struct datalink_proto *proto;
 	int rc = 0;
 
+	read_lock(&p8022_list_lock);
 	proto = find_8022_client(*(skb->h.raw));
 	if (!proto) {
 		skb->sk = NULL;
@@ -63,7 +66,8 @@
 	skb->nh.raw += 3;
 	skb_pull(skb, 3);
 	rc = proto->rcvfunc(skb, dev, pt);
-out:	return rc;
+out:	read_unlock(&p8022_list_lock);
+	return rc;
 }
 
 static void p8022_datalink_header(struct datalink_proto *dl,
@@ -84,7 +88,9 @@
 							  struct packet_type *))
 {
 	struct datalink_proto *proto = NULL;
+	unsigned long flags;
 
+	write_lock_irqsave(&p8022_list_lock, flags);
 	if (find_8022_client(type))
 		goto out;
 	proto = kmalloc(sizeof(*proto), GFP_ATOMIC);
@@ -99,7 +105,8 @@
 		p8022_list		= proto;
 		llc_register_sap(type, p8022_rcv);
 	}
-out:	return proto;
+out:	write_unlock_irqrestore(&p8022_list_lock, flags);
+	return proto;
 }
 
 void unregister_8022_client(unsigned char type)
@@ -107,8 +114,7 @@
 	struct datalink_proto *tmp, **clients = &p8022_list;
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	write_lock_irqsave(&p8022_list_lock, flags);
 	while (*clients) {
 		tmp = *clients;
 		if (tmp->type[0] == type) {
@@ -119,7 +125,7 @@
 		}
 		clients = &tmp->next;
 	}
-	restore_flags(flags);
+	write_unlock_irqrestore(&p8022_list_lock, flags);
 }
 
 EXPORT_SYMBOL(register_8022_client);
diff -urdN linux/net/802/psnap.c linux/net/802/psnap.c
--- linux/net/802/psnap.c	2002-07-22 13:32:58.000000000 +0000
+++ linux/net/802/psnap.c	2002-07-22 19:36:43.000000000 +0000
@@ -22,6 +22,7 @@
 
 static struct datalink_proto *snap_list = NULL;
 static struct datalink_proto *snap_dl = NULL;		/* 802.2 DL for SNAP */
+static rwlock_t snap_list_lock = RW_LOCK_UNLOCKED;
 
 /*
  *	Find a snap client by matching the 5 bytes.
@@ -52,9 +53,12 @@
 
 	struct datalink_proto	*proto;
 
+	read_lock(&snap_list_lock);
 	proto = find_snap_client(skb->h.raw);
 	if (proto != NULL)
 	{
+		int err;
+
 		/*
 		 *	Pass the frame on.
 		 */
@@ -65,7 +69,9 @@
 		if (psnap_packet_type.type == 0)
 			psnap_packet_type.type=htons(ETH_P_SNAP);
 
-		return proto->rcvfunc(skb, dev, &psnap_packet_type);
+		err = proto->rcvfunc(skb, dev, &psnap_packet_type);
+		read_unlock(&snap_list_lock);
+		return err;
 	}
 	skb->sk = NULL;
 	kfree_skb(skb);
@@ -104,10 +110,12 @@
 
 struct datalink_proto *register_snap_client(unsigned char *desc, int (*rcvfunc)(struct sk_buff *, struct net_device *, struct packet_type *))
 {
-	struct datalink_proto	*proto;
+	struct datalink_proto	*proto = NULL;
+	unsigned long flags;
 
+	write_lock_irqsave(&snap_list_lock, flags);
 	if (find_snap_client(desc) != NULL)
-		return NULL;
+		goto out;
 
 	proto = (struct datalink_proto *) kmalloc(sizeof(*proto), GFP_ATOMIC);
 	if (proto != NULL)
@@ -121,7 +129,7 @@
 		proto->next = snap_list;
 		snap_list = proto;
 	}
-
+out:	write_unlock_irqrestore(&snap_list_lock, flags);
 	return proto;
 }
 
@@ -135,8 +143,7 @@
 	struct datalink_proto *tmp;
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	write_lock_irqsave(&snap_list_lock, flags);
 
 	while ((tmp = *clients) != NULL)
 	{
@@ -150,5 +157,5 @@
 			clients = &tmp->next;
 	}
 
-	restore_flags(flags);
+	write_unlock_irqrestore(&snap_list_lock, flags);
 }

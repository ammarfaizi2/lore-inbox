Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265648AbTIEVtD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 17:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265633AbTIEVrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 17:47:24 -0400
Received: from palrel11.hp.com ([156.153.255.246]:64150 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S265252AbTIEVom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 17:44:42 -0400
Date: Fri, 5 Sep 2003 14:44:41 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] init failure cleanups
Message-ID: <20030905214441.GG14233@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir2604_init_cleanup-6.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Guennadi Liakhovetski>
	o [FEATURE] Don't leak stuff in various failure paths
	o [FEATURE] Properly initialise self->max_header_size in IrIAP


diff -u -p linux/net/irda/irda_device.d4.c linux/net/irda/irda_device.c
--- linux/net/irda/irda_device.d4.c	Thu Sep  4 18:39:04 2003
+++ linux/net/irda/irda_device.c	Thu Sep  4 18:46:24 2003
@@ -94,6 +94,7 @@ int __init irda_device_init( void)
 	tasks = hashbin_new(HB_LOCK);
 	if (tasks == NULL) {
 		printk(KERN_WARNING "IrDA: Can't allocate tasks hashbin!\n");
+		hashbin_delete(dongles, NULL);
 		return -ENOMEM;
 	}
 
diff -u -p linux/net/irda/iriap.d4.c linux/net/irda/iriap.c
--- linux/net/irda/iriap.d4.c	Thu Sep  4 18:39:13 2003
+++ linux/net/irda/iriap.c	Thu Sep  4 18:46:24 2003
@@ -100,6 +100,7 @@ int __init iriap_init(void)
 	if (!irias_objects) {
 		WARNING("%s: Can't allocate irias_objects hashbin!\n",
 			__FUNCTION__);
+		hashbin_delete(iriap, NULL);
 		return -ENOMEM;
 	}
 
@@ -181,6 +182,10 @@ struct iriap_cb *iriap_open(__u8 slsap_s
 
 	self->confirm = callback;
 	self->priv = priv;
+
+	/* iriap_getvaluebyclass_request() will construct packets before
+	 * we connect, so this must have a sane value... Jean II */
+	self->max_header_size = LMP_MAX_HEADER;
 
 	init_timer(&self->watchdog_timer);
 
diff -u -p linux/net/irda/irias_object.d4.c linux/net/irda/irias_object.c
--- linux/net/irda/irias_object.d4.c	Thu Sep  4 18:39:24 2003
+++ linux/net/irda/irias_object.c	Thu Sep  4 18:46:24 2003
@@ -84,8 +84,8 @@ struct ias_object *irias_new_object( cha
 	obj = (struct ias_object *) kmalloc(sizeof(struct ias_object),
 					    GFP_ATOMIC);
 	if (obj == NULL) {
-		IRDA_DEBUG(0, "%s(), Unable to allocate object!\n",
-			   __FUNCTION__);
+		WARNING("%s(), Unable to allocate object!\n",
+			__FUNCTION__);
 		return NULL;
 	}
 	memset(obj, 0, sizeof( struct ias_object));
@@ -98,6 +98,12 @@ struct ias_object *irias_new_object( cha
 	 * than the objects spinlock. Never grap the objects spinlock
 	 * while holding any attrib spinlock (risk of deadlock). Jean II */
 	obj->attribs = hashbin_new(HB_LOCK);
+
+	if (obj->attribs == NULL) {
+		WARNING("%s(), Unable to allocate attribs!\n", __FUNCTION__);
+		kfree(obj);
+		return NULL;
+	}
 
 	return obj;
 }
diff -u -p linux/net/irda/irlap.d4.c linux/net/irda/irlap.c
--- linux/net/irda/irlap.d4.c	Thu Sep  4 18:39:34 2003
+++ linux/net/irda/irlap.c	Thu Sep  4 18:46:24 2003
@@ -540,7 +540,13 @@ void irlap_discovery_request(struct irla
 	}
 
 	/* All operations will occur at predictable time, no need to lock */
-	self->discovery_log= hashbin_new(HB_NOLOCK);
+	self->discovery_log = hashbin_new(HB_NOLOCK);
+
+	if (self->discovery_log == NULL) {
+		WARNING("%s(), Unable to allocate discovery log!\n",
+			__FUNCTION__);
+		return;
+	}
 
 	info.S = discovery->nslots; /* Number of slots */
 	info.s = 0; /* Current slot */
diff -u -p linux/net/irda/irlmp.d4.c linux/net/irda/irlmp.c
--- linux/net/irda/irlmp.d4.c	Thu Sep  4 18:39:47 2003
+++ linux/net/irda/irlmp.c	Thu Sep  4 18:46:24 2003
@@ -89,6 +89,15 @@ int __init irlmp_init(void)
 	irlmp->links = hashbin_new(HB_LOCK);
 	irlmp->unconnected_lsaps = hashbin_new(HB_LOCK);
 	irlmp->cachelog = hashbin_new(HB_NOLOCK);
+
+	if ((irlmp->clients == NULL) ||
+	    (irlmp->services == NULL) ||
+	    (irlmp->links == NULL) ||
+	    (irlmp->unconnected_lsaps == NULL) ||
+	    (irlmp->cachelog == NULL)) {
+		return -ENOMEM;
+	}
+
 	spin_lock_init(&irlmp->cachelog->hb_spinlock);
 
 	irlmp->free_lsap_sel = 0x10; /* Reserved 0x00-0x0f */
@@ -287,10 +296,15 @@ void irlmp_register_link(struct irlap_cb
 	lap->magic = LMP_LAP_MAGIC;
 	lap->saddr = saddr;
 	lap->daddr = DEV_ADDR_ANY;
-	lap->lsaps = hashbin_new(HB_LOCK);
 #ifdef CONFIG_IRDA_CACHE_LAST_LSAP
 	lap->cache.valid = FALSE;
 #endif
+	lap->lsaps = hashbin_new(HB_LOCK);
+	if (lap->lsaps == NULL) {
+		WARNING("%s(), unable to kmalloc lsaps\n", __FUNCTION__);
+		kfree(lap);
+		return;
+	}
 
 	lap->lap_state = LAP_STANDBY;
 
diff -u -p linux/net/irda/irttp.d4.c linux/net/irda/irttp.c
--- linux/net/irda/irttp.d4.c	Thu Sep  4 18:40:00 2003
+++ linux/net/irda/irttp.c	Thu Sep  4 18:48:34 2003
@@ -1095,7 +1095,7 @@ int irttp_connect_request(struct tsap_cb
 		 *  headers
 		 */
 		ASSERT(skb_headroom(userdata) >= TTP_MAX_HEADER,
-		       { dev_kfree_skb(tx_skb); return -1; } );
+		       { dev_kfree_skb(userdata); return -1; } );
 	}
 
 	/* Initialize connection parameters */
@@ -1341,7 +1341,8 @@ int irttp_connect_response(struct tsap_c
 		 *  Check that the client has reserved enough space for
 		 *  headers
 		 */
-		ASSERT(skb_headroom(tx_skb) >= TTP_MAX_HEADER, return -1;);
+		ASSERT(skb_headroom(userdata) >= TTP_MAX_HEADER,
+		       { dev_kfree_skb(userdata); return -1; } );
 	}
 
 	self->avail_credit = 0;
@@ -1363,8 +1364,8 @@ int irttp_connect_response(struct tsap_c
 
 	/* SAR enabled? */
 	if (max_sdu_size > 0) {
-		ASSERT(skb_headroom(tx_skb) >= (TTP_MAX_HEADER+TTP_SAR_HEADER),
-		       return -1;);
+		ASSERT(skb_headroom(tx_skb) >= (TTP_MAX_HEADER + TTP_SAR_HEADER),
+		       { dev_kfree_skb(tx_skb); return -1; } );
 
 		/* Insert TTP header with SAR parameters */
 		frame = skb_push(tx_skb, TTP_HEADER+TTP_SAR_HEADER);
diff -u -p linux/net/irda/irnet/irnet_irda.d4.c linux/net/irda/irnet/irnet_irda.c
--- linux/net/irda/irnet/irnet_irda.d4.c	Thu Sep  4 18:40:17 2003
+++ linux/net/irda/irnet/irnet_irda.c	Thu Sep  4 18:46:24 2003
@@ -320,6 +320,8 @@ irnet_discover_next_daddr(irnet_socket *
   /* Create a new IAP instance */
   self->iriap = iriap_open(LSAP_ANY, IAS_CLIENT, self,
 			   irnet_discovervalue_confirm);
+  if(self->iriap == NULL)
+    return -ENOMEM;
 
   /* Next discovery - before the call to avoid races */
   self->disco_index++;
@@ -394,7 +396,8 @@ irnet_discover_daddr_and_lsap_sel(irnet_
   if(ret)
     {
       /* Close IAP */
-      iriap_close(self->iriap);
+      if(self->iriap)
+	iriap_close(self->iriap);
       self->iriap = NULL;
 
       /* Cleanup our copy of the discovery log */

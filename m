Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbUCITLN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 14:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbUCITKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 14:10:14 -0500
Received: from palrel11.hp.com ([156.153.255.246]:30619 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262121AbUCITHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 14:07:11 -0500
Date: Tue, 9 Mar 2004 11:07:06 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] (6/14) irlmp exports and inline
Message-ID: <20040309190706.GG14543@bougret.hpl.hp.com>
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

ir264_irsyms_06_irlmp.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
(6/14) irlmp exports and inline

Move irlmp routines out irsyms.   
Make get_saddr and get_daddr inline
Rename lmp_reasons to irlmp_reasons


diff -u -p -r linux/include/net/irda.s5/irlmp.h linux/include/net/irda/irlmp.h
--- linux/include/net/irda.s5/irlmp.h	Wed Mar  3 17:01:37 2004
+++ linux/include/net/irda/irlmp.h	Mon Mar  8 19:06:24 2004
@@ -249,10 +249,17 @@ int  irlmp_slsap_inuse(__u8 slsap);
 __u8 irlmp_find_free_slsap(void);
 LM_REASON irlmp_convert_lap_reason(LAP_REASON);
 
-__u32 irlmp_get_saddr(struct lsap_cb *self);
-__u32 irlmp_get_daddr(struct lsap_cb *self);
+static inline __u32 irlmp_get_saddr(const struct lsap_cb *self)
+{
+	return (self && !self->lap) ? self->lap->saddr : 0;
+}
 
-extern char *lmp_reasons[];
+static inline __u32 irlmp_get_daddr(const struct lsap_cb *self)
+{
+	return (self && self->lap) ? self->lap->daddr : 0;
+}
+
+extern const char *irlmp_reasons[];
 extern int sysctl_discovery_timeout;
 extern int sysctl_discovery_slots;
 extern int sysctl_discovery;
diff -u -p -r linux/net/irda.s5/iriap.c linux/net/irda/iriap.c
--- linux/net/irda.s5/iriap.c	Mon Mar  8 19:03:37 2004
+++ linux/net/irda/iriap.c	Mon Mar  8 19:06:24 2004
@@ -62,8 +62,6 @@ static const char *ias_charset_types[] =
 static hashbin_t *iriap = NULL;
 static void *service_handle;
 
-extern char *lmp_reasons[];
-
 static void __iriap_close(struct iriap_cb *self);
 static int iriap_register_lsap(struct iriap_cb *self, __u8 slsap_sel, int mode);
 static void iriap_disconnect_indication(void *instance, void *sap,
@@ -291,7 +289,7 @@ static void iriap_disconnect_indication(
 {
 	struct iriap_cb *self;
 
-	IRDA_DEBUG(4, "%s(), reason=%s\n", __FUNCTION__, lmp_reasons[reason]);
+	IRDA_DEBUG(4, "%s(), reason=%s\n", __FUNCTION__, irlmp_reasons[reason]);
 
 	self = (struct iriap_cb *) instance;
 
diff -u -p -r linux/net/irda.s5/irlmp.c linux/net/irda/irlmp.c
--- linux/net/irda.s5/irlmp.c	Wed Mar  3 17:01:39 2004
+++ linux/net/irda/irlmp.c	Mon Mar  8 19:06:24 2004
@@ -25,6 +25,7 @@
  ********************************************************************/
 
 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/skbuff.h>
@@ -49,11 +50,12 @@ struct irlmp_cb *irlmp = NULL;
 /* These can be altered by the sysctl interface */
 int  sysctl_discovery         = 0;
 int  sysctl_discovery_timeout = 3; /* 3 seconds by default */
+EXPORT_SYMBOL(sysctl_discovery_timeout);
 int  sysctl_discovery_slots   = 6; /* 6 slots by default */
 int  sysctl_lap_keepalive_time = LM_IDLE_TIMEOUT * 1000 / HZ;
 char sysctl_devname[65];
 
-char *lmp_reasons[] = {
+const char *irlmp_reasons[] = {
 	"ERROR, NOT USED",
 	"LM_USER_REQUEST",
 	"LM_LAP_DISCONNECT",
@@ -62,8 +64,7 @@ char *lmp_reasons[] = {
 	"LM_INIT_DISCONNECT",
 	"ERROR, NOT USED",
 };
-
-__u8 *irlmp_hint_to_service(__u8 *hint);
+EXPORT_SYMBOL(irlmp_reasons);
 
 /*
  * Function irlmp_init (void)
@@ -189,6 +190,7 @@ struct lsap_cb *irlmp_open_lsap(__u8 sls
 
 	return self;
 }
+EXPORT_SYMBOL(irlmp_open_lsap);
 
 /*
  * Function __irlmp_close_lsap (self)
@@ -264,6 +266,7 @@ void irlmp_close_lsap(struct lsap_cb *se
 	}
 	__irlmp_close_lsap(self);
 }
+EXPORT_SYMBOL(irlmp_close_lsap);
 
 /*
  * Function irlmp_register_irlap (saddr, notify)
@@ -496,6 +499,7 @@ err:
 		dev_kfree_skb(tx_skb);
 	return ret;
 }
+EXPORT_SYMBOL(irlmp_connect_request);
 
 /*
  * Function irlmp_connect_indication (self)
@@ -569,6 +573,7 @@ int irlmp_connect_response(struct lsap_c
 
 	return 0;
 }
+EXPORT_SYMBOL(irlmp_connect_response);
 
 /*
  * Function irlmp_connect_confirm (handle, skb)
@@ -667,6 +672,7 @@ struct lsap_cb *irlmp_dup(struct lsap_cb
 
 	return new;
 }
+EXPORT_SYMBOL(irlmp_dup);
 
 /*
  * Function irlmp_disconnect_request (handle, userdata)
@@ -729,6 +735,7 @@ int irlmp_disconnect_request(struct lsap
 
 	return 0;
 }
+EXPORT_SYMBOL(irlmp_disconnect_request);
 
 /*
  * Function irlmp_disconnect_indication (reason, userdata)
@@ -740,7 +747,7 @@ void irlmp_disconnect_indication(struct 
 {
 	struct lsap_cb *lsap;
 
-	IRDA_DEBUG(1, "%s(), reason=%s\n", __FUNCTION__, lmp_reasons[reason]);
+	IRDA_DEBUG(1, "%s(), reason=%s\n", __FUNCTION__, irlmp_reasons[reason]);
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LMP_LSAP_MAGIC, return;);
 
@@ -900,6 +907,7 @@ void irlmp_discovery_request(int nslots)
 		 * Jean II */
 	}
 }
+EXPORT_SYMBOL(irlmp_discovery_request);
 
 /*
  * Function irlmp_get_discoveries (pn, mask, slots)
@@ -931,6 +939,7 @@ struct irda_device_info *irlmp_get_disco
 	/* Return current cached discovery log */
 	return(irlmp_copy_discoveries(irlmp->cachelog, pn, mask, TRUE));
 }
+EXPORT_SYMBOL(irlmp_get_discoveries);
 
 /*
  * Function irlmp_notify_client (log)
@@ -1122,6 +1131,7 @@ int irlmp_data_request(struct lsap_cb *s
 
 	return ret;
 }
+EXPORT_SYMBOL(irlmp_data_request);
 
 /*
  * Function irlmp_data_indication (handle, skb)
@@ -1433,7 +1443,7 @@ __u8 *irlmp_hint_to_service(__u8 *hint)
 }
 #endif
 
-const __u16 service_hint_mapping[S_END][2] = {
+static const __u16 service_hint_mapping[S_END][2] = {
 	{ HINT_PNP,		0 },			/* S_PNP */
 	{ HINT_PDA,		0 },			/* S_PDA */
 	{ HINT_COMPUTER,	0 },			/* S_COMPUTER */
@@ -1463,6 +1473,7 @@ __u16 irlmp_service_to_hint(int service)
 
 	return hint.word;
 }
+EXPORT_SYMBOL(irlmp_service_to_hint);
 
 /*
  * Function irlmp_register_service (service)
@@ -1490,6 +1501,7 @@ void *irlmp_register_service(__u16 hints
 
 	return (void *)service;
 }
+EXPORT_SYMBOL(irlmp_register_service);
 
 /*
  * Function irlmp_unregister_service (handle)
@@ -1532,6 +1544,7 @@ int irlmp_unregister_service(void *handl
 	spin_unlock_irqrestore(&irlmp->services->hb_spinlock, flags);
 	return 0;
 }
+EXPORT_SYMBOL(irlmp_unregister_service);
 
 /*
  * Function irlmp_register_client (hint_mask, callback1, callback2)
@@ -1568,6 +1581,7 @@ void *irlmp_register_client(__u16 hint_m
 
 	return (void *) client;
 }
+EXPORT_SYMBOL(irlmp_register_client);
 
 /*
  * Function irlmp_update_client (handle, hint_mask, callback1, callback2)
@@ -1599,6 +1613,7 @@ int irlmp_update_client(void *handle, __
 
 	return 0;
 }
+EXPORT_SYMBOL(irlmp_update_client);
 
 /*
  * Function irlmp_unregister_client (handle)
@@ -1628,6 +1643,7 @@ int irlmp_unregister_client(void *handle
 
 	return 0;
 }
+EXPORT_SYMBOL(irlmp_unregister_client);
 
 /*
  * Function irlmp_slsap_inuse (slsap)
@@ -1763,22 +1779,6 @@ LM_REASON irlmp_convert_lap_reason( LAP_
 	}
 
 	return reason;
-}
-
-__u32 irlmp_get_saddr(struct lsap_cb *self)
-{
-	ASSERT(self != NULL, return 0;);
-	ASSERT(self->lap != NULL, return 0;);
-
-	return self->lap->saddr;
-}
-
-__u32 irlmp_get_daddr(struct lsap_cb *self)
-{
-	ASSERT(self != NULL, return 0;);
-	ASSERT(self->lap != NULL, return 0;);
-
-	return self->lap->daddr;
 }
 
 #ifdef CONFIG_PROC_FS
diff -u -p -r linux/net/irda.s5/irsyms.c linux/net/irda/irsyms.c
--- linux/net/irda.s5/irsyms.c	Mon Mar  8 19:03:37 2004
+++ linux/net/irda/irsyms.c	Mon Mar  8 19:06:24 2004
@@ -79,27 +79,6 @@ EXPORT_SYMBOL(irda_param_extract_all);
 EXPORT_SYMBOL(irda_param_pack);
 EXPORT_SYMBOL(irda_param_unpack);
 
-/* IrLMP */
-EXPORT_SYMBOL(irlmp_discovery_request);
-EXPORT_SYMBOL(irlmp_get_discoveries);
-EXPORT_SYMBOL(sysctl_discovery_timeout);
-EXPORT_SYMBOL(irlmp_register_client);
-EXPORT_SYMBOL(irlmp_unregister_client);
-EXPORT_SYMBOL(irlmp_update_client);
-EXPORT_SYMBOL(irlmp_register_service);
-EXPORT_SYMBOL(irlmp_unregister_service);
-EXPORT_SYMBOL(irlmp_service_to_hint);
-EXPORT_SYMBOL(irlmp_data_request);
-EXPORT_SYMBOL(irlmp_open_lsap);
-EXPORT_SYMBOL(irlmp_close_lsap);
-EXPORT_SYMBOL(irlmp_connect_request);
-EXPORT_SYMBOL(irlmp_connect_response);
-EXPORT_SYMBOL(irlmp_disconnect_request);
-EXPORT_SYMBOL(irlmp_get_daddr);
-EXPORT_SYMBOL(irlmp_get_saddr);
-EXPORT_SYMBOL(irlmp_dup);
-EXPORT_SYMBOL(lmp_reasons);
-
 /* IrLAP */
 EXPORT_SYMBOL(irlap_open);
 EXPORT_SYMBOL(irlap_close);

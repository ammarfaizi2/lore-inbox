Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316154AbSEJWor>; Fri, 10 May 2002 18:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316153AbSEJWmu>; Fri, 10 May 2002 18:42:50 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:29691 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316154AbSEJWmS>;
	Fri, 10 May 2002 18:42:18 -0400
Date: Fri, 10 May 2002 15:42:17 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>, irda-users@lists.sourceforge.net,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] : ir253_lsap_cache_fix.diff
Message-ID: <20020510154217.D14407@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir253_lsap_cache_fix.diff :
-------------------------
	        <Following patch from Christoph Bartelmus, mangled by me>
	o [CORRECT] replace the global LSAP cache with LSAP caches private
		to each LAP.
		Fix a bug where two simultaneous connections from two devices
		using the same LSAPs would get mixed up.
		Should also improve performance in similar cases. 


diff -u -p linux/include/net/irda/irlmp.d9.h linux/include/net/irda/irlmp.h
--- linux/include/net/irda/irlmp.d9.h	Tue May  7 14:34:48 2002
+++ linux/include/net/irda/irlmp.h	Tue May  7 15:15:52 2002
@@ -120,6 +120,21 @@ struct lsap_cb {
 };
 
 /*
+ *  Used for caching the last slsap->dlsap->handle mapping
+ *
+ * We don't need to keep/match the remote address in the cache because
+ * we are associated with a specific LAP (which implies it).
+ * Jean II
+ */
+typedef struct {
+	int valid;
+
+	__u8 slsap_sel;
+	__u8 dlsap_sel;
+	struct lsap_cb *lsap;
+} CACHE_ENTRY;
+
+/*
  *  Information about each registred IrLAP layer
  */
 struct lap_cb {
@@ -140,20 +155,16 @@ struct lap_cb {
 	
 	struct qos_info *qos;  /* LAP QoS for this session */
 	struct timer_list idle_timer;
+	
+#ifdef CONFIG_IRDA_CACHE_LAST_LSAP
+	/* The lsap cache was moved from struct irlmp_cb to here because
+	 * it must be associated with the specific LAP. Also, this
+	 * improves performance. - Jean II */
+	CACHE_ENTRY cache;  /* Caching last slsap->dlsap->handle mapping */
+#endif
 };
 
 /*
- *  Used for caching the last slsap->dlsap->handle mapping
- */
-typedef struct {
-	int valid;
-
-	__u8 slsap_sel;
-	__u8 dlsap_sel;
-	struct lsap_cb *lsap;
-} CACHE_ENTRY;
-
-/*
  *  Main structure for IrLMP
  */
 struct irlmp_cb {
@@ -166,9 +177,6 @@ struct irlmp_cb {
 
 	int free_lsap_sel;
 
-#ifdef CONFIG_IRDA_CACHE_LAST_LSAP
-	CACHE_ENTRY cache;  /* Caching last slsap->dlsap->handle mapping */
-#endif
 	struct timer_list discovery_timer;
 
  	hashbin_t *links;         /* IrLAP connection table */
diff -u -p linux/net/irda/irlmp.d9.c linux/net/irda/irlmp.c
--- linux/net/irda/irlmp.d9.c	Tue May  7 14:49:29 2002
+++ linux/net/irda/irlmp.c	Tue May  7 15:11:22 2002
@@ -93,9 +93,6 @@ int __init irlmp_init(void)
 	irlmp->cachelog = hashbin_new(HB_GLOBAL);
 	
 	irlmp->free_lsap_sel = 0x10; /* Reserved 0x00-0x0f */
-#ifdef CONFIG_IRDA_CACHE_LAST_LSAP
-	irlmp->cache.valid = FALSE;
-#endif
 	strcpy(sysctl_devname, "Linux");
 	
 	/* Do discovery every 3 seconds */
@@ -208,10 +205,6 @@ static void __irlmp_close_lsap(struct ls
 	if (self->conn_skb)
 		dev_kfree_skb(self->conn_skb);
 
-#ifdef CONFIG_IRDA_CACHE_LAST_LSAP
-	ASSERT(irlmp != NULL, return;);
-	irlmp->cache.valid = FALSE;
-#endif
 	kfree(self);
 }
 
@@ -247,6 +240,9 @@ void irlmp_close_lsap(struct lsap_cb *se
 		}
 		/* Now, remove from the link */
 		lsap = hashbin_remove(lap->lsaps, (int) self, NULL);
+#ifdef CONFIG_IRDA_CACHE_LAST_LSAP
+		lap->cache.valid = FALSE;
+#endif
 	}
 	self->lap = NULL;
 	/* Check if we found the LSAP! If not then try the unconnected lsaps */
@@ -292,6 +288,9 @@ void irlmp_register_link(struct irlap_cb
 	lap->saddr = saddr;
 	lap->daddr = DEV_ADDR_ANY;
 	lap->lsaps = hashbin_new(HB_GLOBAL);
+#ifdef CONFIG_IRDA_CACHE_LAST_LSAP
+	lap->cache.valid = FALSE;
+#endif
 
 	lap->lap_state = LAP_STANDBY;
 	
@@ -602,7 +601,7 @@ struct lsap_cb *irlmp_dup(struct lsap_cb
 
 	/* Make sure that we invalidate the cache */
 #ifdef CONFIG_IRDA_CACHE_LAST_LSAP
-	irlmp->cache.valid = FALSE;
+	new->lap->cache.valid = FALSE;
 #endif /* CONFIG_IRDA_CACHE_LAST_LSAP */
 
 	return new;
@@ -692,17 +691,16 @@ void irlmp_disconnect_indication(struct 
 		return;
 	}
 
-#ifdef CONFIG_IRDA_CACHE_LAST_LSAP
-	irlmp->cache.valid = FALSE;
-#endif
-
 	/* 
 	 *  Remove association between this LSAP and the link it used 
 	 */
 	ASSERT(self->lap != NULL, return;);
 	ASSERT(self->lap->lsaps != NULL, return;);
-
+	
 	lsap = hashbin_remove(self->lap->lsaps, (int) self, NULL);
+#ifdef CONFIG_IRDA_CACHE_LAST_LSAP
+	self->lap->cache.valid = FALSE;
+#endif
 
 	ASSERT(lsap != NULL, return;);
 	ASSERT(lsap == self, return;);
diff -u -p linux/net/irda/irlmp_frame.d9.c linux/net/irda/irlmp_frame.c
--- linux/net/irda/irlmp_frame.d9.c	Tue May  7 14:49:45 2002
+++ linux/net/irda/irlmp_frame.c	Tue May  7 15:17:01 2002
@@ -408,13 +408,14 @@ void irlmp_link_discovery_confirm(struct
 }
 
 #ifdef CONFIG_IRDA_CACHE_LAST_LSAP
-inline void irlmp_update_cache(struct lsap_cb *self)
+static inline void irlmp_update_cache(struct lap_cb *lap,
+				      struct lsap_cb *lsap)
 {
 	/* Update cache entry */
-	irlmp->cache.dlsap_sel = self->dlsap_sel;
-	irlmp->cache.slsap_sel = self->slsap_sel;
-	irlmp->cache.lsap = self;
-	irlmp->cache.valid = TRUE;
+	lap->cache.dlsap_sel = lsap->dlsap_sel;
+	lap->cache.slsap_sel = lsap->slsap_sel;
+	lap->cache.lsap = lsap;
+	lap->cache.valid = TRUE;
 }
 #endif
 
@@ -423,6 +424,17 @@ inline void irlmp_update_cache(struct ls
  *
  *    Find handle assosiated with destination and source LSAP
  *
+ * Any IrDA connection (LSAP/TSAP) is uniquely identified by
+ * 3 parameters, the local lsap, the remote lsap and the remote address. 
+ * We may initiate multiple connections to the same remote service
+ * (they will have different local lsap), a remote device may initiate
+ * multiple connections to the same local service (they will have
+ * different remote lsap), or multiple devices may connect to the same
+ * service and may use the same remote lsap (and they will have
+ * different remote address).
+ * So, where is the remote address ? Each LAP connection is made with
+ * a single remote device, so imply a specific remote address.
+ * Jean II
  */
 static struct lsap_cb *irlmp_find_lsap(struct lap_cb *self, __u8 dlsap_sel,
 				       __u8 slsap_sel, int status,
@@ -436,11 +448,11 @@ static struct lsap_cb *irlmp_find_lsap(s
 	 *  cache first to avoid the linear search
 	 */
 #ifdef CONFIG_IRDA_CACHE_LAST_LSAP
-	if ((irlmp->cache.valid) && 
-	    (irlmp->cache.slsap_sel == slsap_sel) && 
-	    (irlmp->cache.dlsap_sel == dlsap_sel)) 
+	if ((self->cache.valid) && 
+	    (self->cache.slsap_sel == slsap_sel) && 
+	    (self->cache.dlsap_sel == dlsap_sel)) 
 	{
-		return (irlmp->cache.lsap);
+		return (self->cache.lsap);
 	}
 #endif
 	lsap = (struct lsap_cb *) hashbin_get_first(queue);
@@ -458,7 +470,7 @@ static struct lsap_cb *irlmp_find_lsap(s
 			lsap->dlsap_sel = dlsap_sel;
 			
 #ifdef CONFIG_IRDA_CACHE_LAST_LSAP
-			irlmp_update_cache(lsap);
+			irlmp_update_cache(self, lsap);
 #endif
 			return lsap;
 		}
@@ -469,7 +481,7 @@ static struct lsap_cb *irlmp_find_lsap(s
 		    (lsap->dlsap_sel == dlsap_sel)) 
 		{
 #ifdef CONFIG_IRDA_CACHE_LAST_LSAP
-			irlmp_update_cache(lsap);
+			irlmp_update_cache(self, lsap);
 #endif
 			return lsap;
 		}

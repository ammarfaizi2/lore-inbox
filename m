Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277284AbRJEALN>; Thu, 4 Oct 2001 20:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277283AbRJEALE>; Thu, 4 Oct 2001 20:11:04 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:10195 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S277280AbRJEAKB>;
	Thu, 4 Oct 2001 20:10:01 -0400
Date: Thu, 4 Oct 2001 17:10:26 -0700
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-irda@pasta.cs.uit.no
Subject: [PATCH] ir240_discovery_on_demand-2.diff
Message-ID: <20011004171026.D3290@bougret.hpl.hp.com>
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

ir240_discovery_on_demand-2.diff :
--------------------------------
	o [FEATURE] Enable IrDA discovery on demand while in passive mode
		- Apply only to IrSock and IrNET
		- Was accidentally removed in discovery rework one year ago


diff -u -p linux/include/net/irda/irlmp.d0.h linux/include/net/irda/irlmp.h
--- linux/include/net/irda/irlmp.d0.h	Fri Sep 28 11:54:25 2001
+++ linux/include/net/irda/irlmp.h	Fri Sep 28 12:52:46 2001
@@ -216,7 +216,7 @@ int  irlmp_disconnect_request(struct lsa
 
 void irlmp_discovery_confirm(hashbin_t *discovery_log);
 void irlmp_discovery_request(int nslots);
-struct irda_device_info *irlmp_get_discoveries(int *pn, __u16 mask);
+struct irda_device_info *irlmp_get_discoveries(int *pn, __u16 mask, int nslots);
 void irlmp_do_expiry(void);
 void irlmp_do_discovery(int nslots);
 discovery_t *irlmp_get_discovery_response(void);
diff -u -p linux/net/irda/irlmp.d0.c linux/net/irda/irlmp.c
--- linux/net/irda/irlmp.d0.c	Fri Sep 28 11:53:13 2001
+++ linux/net/irda/irlmp.c	Fri Sep 28 13:45:21 2001
@@ -781,10 +781,6 @@ void irlmp_do_discovery(int nslots)
  */
 void irlmp_discovery_request(int nslots)
 {
-	/* Check if user wants to override the default */
-	if (nslots == DISCOVERY_DEFAULT_SLOTS)
-		nslots = sysctl_discovery_slots;
-
 	/* Return current cached discovery log */
 	irlmp_discovery_confirm(irlmp->cachelog);
 
@@ -792,21 +788,43 @@ void irlmp_discovery_request(int nslots)
 	 * Start a single discovery operation if discovery is not already
          * running 
 	 */
-	if (!sysctl_discovery)
+	if (!sysctl_discovery) {
+		/* Check if user wants to override the default */
+		if (nslots == DISCOVERY_DEFAULT_SLOTS)
+			nslots = sysctl_discovery_slots;
+
 		irlmp_do_discovery(nslots);
-	/* Note : we never do expiry here. Expiry will run on the
-	 * discovery timer regardless of the state of sysctl_discovery
-	 * Jean II */
+		/* Note : we never do expiry here. Expiry will run on the
+		 * discovery timer regardless of the state of sysctl_discovery
+		 * Jean II */
+	}
 }
 
 /*
- * Function irlmp_get_discoveries (pn, mask)
+ * Function irlmp_get_discoveries (pn, mask, slots)
  *
  *    Return the current discovery log
  *
  */
-struct irda_device_info *irlmp_get_discoveries(int *pn, __u16 mask)
+struct irda_device_info *irlmp_get_discoveries(int *pn, __u16 mask, int nslots)
 {
+	/* If discovery is not enabled, it's likely that the discovery log
+	 * will be empty. So, we trigger a single discovery, so that next
+	 * time the user call us there might be some results in the log.
+	 * Jean II
+	 */
+	if (!sysctl_discovery) {
+		/* Check if user wants to override the default */
+		if (nslots == DISCOVERY_DEFAULT_SLOTS)
+			nslots = sysctl_discovery_slots;
+
+		/* Start discovery - will complete sometime later */
+		irlmp_do_discovery(nslots);
+		/* Note : we never do expiry here. Expiry will run on the
+		 * discovery timer regardless of the state of sysctl_discovery
+		 * Jean II */
+	}
+
 	/* Return current cached discovery log */
 	return(irlmp_copy_discoveries(irlmp->cachelog, pn, mask));
 }
diff -u -p linux/net/irda/af_irda.d0.c linux/net/irda/af_irda.c
--- linux/net/irda/af_irda.d0.c	Fri Sep 28 13:47:38 2001
+++ linux/net/irda/af_irda.c	Fri Sep 28 13:49:22 2001
@@ -637,7 +637,7 @@ static int irda_discover_daddr_and_lsap_
 	 * Note : we have to use irlmp_get_discoveries(), as opposed
 	 * to play with the cachelog directly, because while we are
 	 * making our ias query, le log might change... */
-	discoveries = irlmp_get_discoveries(&number, self->mask);
+	discoveries = irlmp_get_discoveries(&number, self->mask, self->nslots);
 	/* Check if the we got some results */
 	if (discoveries == NULL)
 		return -ENETUNREACH;	/* No nodes discovered */
@@ -2091,7 +2091,8 @@ static int irda_getsockopt(struct socket
 	switch (optname) {
 	case IRLMP_ENUMDEVICES:
 		/* Ask lmp for the current discovery log */
-		discoveries = irlmp_get_discoveries(&list.len, self->mask);
+		discoveries = irlmp_get_discoveries(&list.len, self->mask,
+						    self->nslots);
 		/* Check if the we got some results */
 		if (discoveries == NULL)
 			return -EAGAIN;		/* Didn't find any devices */
diff -u -p linux/net/irda/irnet/irnet_ppp.d0b.c linux/net/irda/irnet/irnet_ppp.c
--- linux/net/irda/irnet/irnet_ppp.d0b.c	Thu Oct  4 16:00:57 2001
+++ linux/net/irda/irnet/irnet_ppp.c	Thu Oct  4 16:03:41 2001
@@ -14,7 +14,7 @@
  */
 
 #include "irnet_ppp.h"		/* Private header */
-#include <linux/module.h>
+/* Please put other headers in irnet.h - Thanks */
 
 /************************* CONTROL CHANNEL *************************/
 /*
@@ -200,7 +200,8 @@ irnet_read_discovery_log(irnet_socket *	
       __u16		mask = irlmp_service_to_hint(S_LAN);
 
       /* Ask IrLMP for the current discovery log */
-      ap->discoveries = irlmp_get_discoveries(&ap->disco_number, mask);
+      ap->discoveries = irlmp_get_discoveries(&ap->disco_number, mask,
+					      DISCOVERY_DEFAULT_SLOTS);
       /* Check if the we got some results */
       if(ap->discoveries == NULL)
 	ap->disco_number = -1;
diff -u -p linux/net/irda/irnet/irnet_irda.d0b.c linux/net/irda/irnet/irnet_irda.c
--- linux/net/irda/irnet/irnet_irda.d0b.c	Thu Oct  4 16:00:44 2001
+++ linux/net/irda/irnet/irnet_irda.c	Thu Oct  4 16:02:09 2001
@@ -370,7 +370,8 @@ irnet_discover_daddr_and_lsap_sel(irnet_
   DENTER(IRDA_SR_TRACE, "(self=0x%X)\n", (unsigned int) self);
 
   /* Ask lmp for the current discovery log */
-  self->discoveries = irlmp_get_discoveries(&self->disco_number, self->mask);
+  self->discoveries = irlmp_get_discoveries(&self->disco_number, self->mask,
+					    DISCOVERY_DEFAULT_SLOTS);
 
   /* Check if the we got some results */
   if(self->discoveries == NULL)
@@ -426,7 +427,8 @@ irnet_dname_to_daddr(irnet_socket *	self
   DENTER(IRDA_SR_TRACE, "(self=0x%X)\n", (unsigned int) self);
 
   /* Ask lmp for the current discovery log */
-  discoveries = irlmp_get_discoveries(&number, 0xffff);
+  discoveries = irlmp_get_discoveries(&number, 0xffff,
+				      DISCOVERY_DEFAULT_SLOTS);
   /* Check if the we got some results */
   if(discoveries == NULL)
     DRETURN(-ENETUNREACH, IRDA_SR_INFO, "Cachelog empty...\n");
@@ -664,7 +666,8 @@ irnet_daddr_to_dname(irnet_socket *	self
   DENTER(IRDA_SERV_TRACE, "(self=0x%X)\n", (unsigned int) self);
 
   /* Ask lmp for the current discovery log */
-  discoveries = irlmp_get_discoveries(&number, 0xffff);
+  discoveries = irlmp_get_discoveries(&number, 0xffff,
+				      DISCOVERY_DEFAULT_SLOTS);
   /* Check if the we got some results */
   if (discoveries == NULL)
     DRETURN(-ENETUNREACH, IRDA_SERV_INFO, "Cachelog empty...\n");

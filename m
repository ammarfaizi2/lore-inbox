Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268690AbUJDXIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268690AbUJDXIJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 19:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268674AbUJDXG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 19:06:29 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:38923 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S268690AbUJDW5K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 18:57:10 -0400
Date: Mon, 4 Oct 2004 23:57:09 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] 2.[46]: Permit the official ARP hw type in SIOCSARP
 for FDDI
Message-ID: <Pine.LNX.4.58L.0410040312500.22545@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 The SIOCSARP handling code currently rejects attempts of setting an arp
entry for FDDI devices if the Ethernet ARP hw type is specified in the
request.  Using this ARP hw type is mandated by RFC 1390 (STD 36) and I
think it's reasonable to accept SIOCSARP requests using this type,
especially as it already works this way for ARP packets received from the
network.  One reason for this is bootpd setting explicit ARP cache entries
using the hw type that is also sent to a client.  Here is a patch for both
2.4 and 2.6 that fixes the problem for me.  For consistency with code used
for ARP packets, it makes both Ethernet and IEEE802 ARP hw type acceptable
for FDDI interfaces.  Please apply.

 Applies both to 2.4.27 and to 2.6.8.1.

  Maciej

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>

patch-arp-fddi-1
diff -up --recursive --new-file linux.macro/net/ipv4/arp.c linux/net/ipv4/arp.c
--- linux.macro/net/ipv4/arp.c	2004-04-17 02:59:12.000000000 +0000
+++ linux/net/ipv4/arp.c	2004-08-14 15:33:12.000000000 +0000
@@ -1024,8 +1024,26 @@ int arp_req_set(struct arpreq *r, struct
 		if (!dev)
 			return -EINVAL;
 	}
-	if (r->arp_ha.sa_family != dev->type)	
-		return -EINVAL;
+	switch (dev->type) {
+#ifdef CONFIG_FDDI
+	case ARPHRD_FDDI:
+		/*
+		 * According to RFC 1390, FDDI devices should accept ARP
+		 * hardware types of 1 (Ethernet).  However, to be more
+		 * robust, we'll accept hardware types of either 1 (Ethernet)
+		 * or 6 (IEEE 802.2).
+		 */
+		if (r->arp_ha.sa_family != ARPHRD_FDDI &&
+		    r->arp_ha.sa_family != ARPHRD_ETHER &&
+		    r->arp_ha.sa_family != ARPHRD_IEEE802)
+			return -EINVAL;
+		break;
+#endif
+	default:
+		if (r->arp_ha.sa_family != dev->type)
+			return -EINVAL;
+		break;
+	}
 
 	neigh = __neigh_lookup_errno(&arp_tbl, &ip, dev);
 	err = PTR_ERR(neigh);

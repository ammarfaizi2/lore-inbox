Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272370AbTGaAYy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 20:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272373AbTGaAYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 20:24:54 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:45523 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S272370AbTGaAYu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 20:24:50 -0400
Message-Id: <200307310022.h6V0MGjK012821@death.ibm.com>
To: "David S. Miller" <davem@redhat.com>
cc: Willy Tarreau <willy@w.ods.org>, jgarzik@pobox.com,
       marcelo@conectiva.com.br, netdev@oss.sgi.com,
       bonding-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.22-pre9-bk : bonding bug fixes 
In-Reply-To: Message from "David S. Miller" <davem@redhat.com> 
   of "Wed, 30 Jul 2003 16:49:07 PDT." <20030730164907.43b2d343.davem@redhat.com> 
Date: Wed, 30 Jul 2003 17:22:15 -0700
From: Jay Vosburgh <fubar@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Wed, 30 Jul 2003 16:06:58 +0200
>Willy Tarreau <willy@w.ods.org> wrote:
>
>> there are still a few bugs in the current bonding driver. I've reported them
>> several times now, but perhaps not at the right places...
>
>So now we have these few bug fixes, and the backport of the
>2.6.x version of the bonding code, both submitted on the same
>day in fact :-)
>
>Jeff I'd recommend we put Willy's fixes in if you think they're
>OK, then we can think about the 2.6.x backport work for 2.4.23-preX

	I've been looking at Willy's fixes, and the typo (first patch)
and locking fix (third patch) both look good to me.  The second patch
(the dead code warning) points out a real problem, in that the code in
question really has no function, but the patch probably doesn't go far
enough for a final solution (the variable that code would set,
arp_target_hw_addr, is referenced in other places, but ends up always
being NULL because the dead code is the only place it was ever set).

	A more proper solution would be to simply delete the dead code
and the arp_target_hw_addr variable, and replace the variable
references with NULL.  This means that all of the ARP probes sent will
be sent out as broadcasts, which is what's already happening, this
just makes the code clearer.  Patch follows (which replaces Willy's
second patch).

	Does this sound reasonable to everybody?

	-J

---
	-Jay Vosburgh, IBM Linux Technology Center, fubar@us.ibm.com


--- linux-2.4.22-pre9-bk-wt/drivers/net/bonding/bond_main.c	2003-07-30 17:06:50.000000000 -0700
+++ linux-2.4.22-pre9-bk/drivers/net/bonding/bond_main.c	2003-07-30 17:08:53.000000000 -0700
@@ -463,7 +463,6 @@
 static unsigned long arp_target[MAX_ARP_IP_TARGETS] = { 0, } ;
 static int arp_ip_count = 0;
 static u32 my_ip = 0;
-char *arp_target_hw_addr = NULL;
 
 static char *primary= NULL;
 
@@ -596,8 +595,7 @@
 
 	for (i = 0; (i<MAX_ARP_IP_TARGETS) && arp_target[i]; i++) { 
 		arp_send(ARPOP_REQUEST, ETH_P_ARP, arp_target[i], slave->dev, 
-			 my_ip, arp_target_hw_addr, slave->dev->dev_addr,
-			 arp_target_hw_addr); 
+			 my_ip, NULL, slave->dev->dev_addr, NULL); 
 	} 
 }
  
@@ -1031,10 +1029,6 @@
 	}
 	if (arp_interval> 0) {  /* arp interval, in milliseconds. */
 		del_timer(&bond->arp_timer);
-                if (arp_target_hw_addr != NULL) {
-			kfree(arp_target_hw_addr); 
-			arp_target_hw_addr = NULL;
-		}
 	}
 
 	if (bond_mode == BOND_MODE_8023AD) {
@@ -3281,28 +3275,6 @@
 		memcpy(&my_ip, the_ip, 4);
 	}
 
-	/* if we are sending arp packets and don't know 
-	 * the target hw address, save it so we don't need 
-	 * to use a broadcast address.
-	 * don't do this if in active backup mode because the slaves must 
-	 * receive packets to stay up, and the only ones they receive are 
-	 * broadcasts. 
-	 */
-	if ( (bond_mode != BOND_MODE_ACTIVEBACKUP) && 
-             (arp_ip_count == 1) &&
-	     (arp_interval > 0) && (arp_target_hw_addr == NULL) &&
-	     (skb->protocol == __constant_htons(ETH_P_IP) ) ) {
-		struct ethhdr *eth_hdr = 
-			(struct ethhdr *) (((char *)skb->data));
-		struct iphdr *ip_hdr = (struct iphdr *)(eth_hdr + 1);
-
-		if (arp_target[0] == ip_hdr->daddr) {
-			arp_target_hw_addr = kmalloc(ETH_ALEN, GFP_KERNEL);
-			if (arp_target_hw_addr != NULL)
-				memcpy(arp_target_hw_addr, eth_hdr->h_dest, ETH_ALEN);
-		}
-	}
-
 	read_lock(&bond->lock);
 
 	read_lock(&bond->ptrlock);

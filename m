Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261405AbTCTHXW>; Thu, 20 Mar 2003 02:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261406AbTCTHXW>; Thu, 20 Mar 2003 02:23:22 -0500
Received: from franka.aracnet.com ([216.99.193.44]:13007 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261405AbTCTHXV>; Thu, 20 Mar 2003 02:23:21 -0500
Date: Wed, 19 Mar 2003 23:34:16 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix warning in drivers/net/sis900.c
Message-ID: <13270000.1048145654@[10.10.2.4]>
In-Reply-To: <3E60EC7D.2040802@pobox.com>
References: <51890000.1046538667@[10.10.2.4]> <3E60EC7D.2040802@pobox.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> drivers/net/sis900.c: In function `set_rx_mode':
>> drivers/net/sis900.c:2100: warning: passing arg 2 of `set_bit' from incompatible pointer type
>> 
>> I just cast this. Seems to work fine at the moment, so presumably it's
>> correct.
> 
> 
> Nope -- set_bit wants to work on a real unsigned long.  
> While your patch will work, the proper fix is to not use set_bit :)

Fair enough. How about this? (compile tested, but not machine-tested)
mc_filter is declared as this ...
u16 mc_filter[16] = {0};        /* 256/128 bits multicast hash table */
so I just split off the high & low parts, and use them seperately ...

M.

diff -urpN -X /home/fletch/.diff.exclude virgin/drivers/net/sis900.c sisfix/drivers/net/sis900.c
--- virgin/drivers/net/sis900.c	Mon Mar 17 21:43:45 2003
+++ sisfix/drivers/net/sis900.c	Wed Mar 19 23:27:49 2003
@@ -2094,10 +2094,13 @@ static void set_rx_mode(struct net_devic
 		   use Receive Filter to reject unwanted MCAST packet */
 		struct dev_mc_list *mclist;
 		rx_mode = RFAAB;
-		for (i = 0, mclist = net_dev->mc_list; mclist && i < net_dev->mc_count;
-		     i++, mclist = mclist->next)
-			set_bit(sis900_compute_hashtable_index(mclist->dmi_addr, revision),
-				mc_filter);
+		for (i = 0, mclist = net_dev->mc_list; 
+					mclist && i < net_dev->mc_count;
+					i++, mclist = mclist->next) {
+			int index = sis900_compute_hashtable_index(
+						mclist->dmi_addr, revision);
+			mc_filter[index/16] |= (u16) (1 << (index & 0xff));
+		}
 	}
 
 	/* update Multicast Hash Table in Receive Filter */


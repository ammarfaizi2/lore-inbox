Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291088AbSCLXzR>; Tue, 12 Mar 2002 18:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291102AbSCLXzG>; Tue, 12 Mar 2002 18:55:06 -0500
Received: from pizda.ninka.net ([216.101.162.242]:64128 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291088AbSCLXy6>;
	Tue, 12 Mar 2002 18:54:58 -0500
Date: Tue, 12 Mar 2002 15:52:38 -0800 (PST)
Message-Id: <20020312.155238.21594857.davem@redhat.com>
To: beezly@beezly.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dropped packets on SUN GEM
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1015976181.2652.30.camel@monkey>
In-Reply-To: <1015974664.2652.10.camel@monkey>
	<20020312.151443.03370128.davem@redhat.com>
	<1015976181.2652.30.camel@monkey>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Beezly <beezly@beezly.org.uk>
   Date: 12 Mar 2002 23:36:21 +0000

   14 packets missing.
   
   325*84  = 27300
   14*1500 = 21000
   
   Are these number relevant?

The size of GEM's receive FIFO is 20K :-)
(TX fifo is 9K)

You say you are on 100Mbit, is this to a hub at half-duplex?
That is basically the worst combination for GEM because without Pause
(even my crappy Netgear 100Mbit switches negotiate pause to on with
my GEMs) there is no way to throttle the sender so that the receive
overflow condition will not occur.

Thinking... I guess my gem_rxmac_reset() does not reset the
receive FIFO so until it is filled up and reset none of the
packets received actually make it past the card.

How does it behave with the patch below added to what you are running
right now?

--- drivers/net/sungem.c.~1~	Tue Mar 12 09:35:37 2002
+++ drivers/net/sungem.c	Tue Mar 12 15:51:05 2002
@@ -401,7 +401,11 @@
 		gp->net_stats.rx_over_errors++;
 		gp->net_stats.rx_fifo_errors++;
 
+#if 1
+		return 1;
+#else
 		ret = gem_rxmac_reset(gp);
+#endif
 	}
 
 	if (rxmac_stat & MAC_RXSTAT_ACE)


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbWIWFdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWIWFdz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 01:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWIWFdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 01:33:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51178 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751056AbWIWFdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 01:33:53 -0400
Date: Fri, 22 Sep 2006 22:33:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: auke-jan.h.kok@intel.com, Holger.Kiehl@dwd.de,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@vger.kernel.org, john.ronciak@intel.com
Subject: Re: 2.6.1[78] page allocation failure. order:3, mode:0x20
Message-Id: <20060922223348.1b24fda5.akpm@osdl.org>
In-Reply-To: <20060922.222507.74751476.davem@davemloft.net>
References: <20060922004253.2e2e2612.akpm@osdl.org>
	<4514190C.8010901@intel.com>
	<20060922215000.c1fde093.akpm@osdl.org>
	<20060922.222507.74751476.davem@davemloft.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006 22:25:07 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Andrew Morton <akpm@osdl.org>
> Date: Fri, 22 Sep 2006 21:50:00 -0700
> 
> > On Fri, 22 Sep 2006 10:10:36 -0700
> > Auke Kok <auke-jan.h.kok@intel.com> wrote:
> > 
> > > e1000: account for NET_IP_ALIGN when calculating bufsiz
> > > 
> > > Account for NET_IP_ALIGN when requesting buffer sizes from netdev_alloc_skb to 
> > > reduce slab allocation by half.
> > 
> > Could we please do whatever is needed to get this blessed and merged?  This
> > is such a common problem on such a common driver that I would suggest that
> > we want this in 2.6.18.x as well.  At least, I'd expect distributors to
> > ship this fix (they're nuts if they don't) and so it makes sense to deliver
> > it from kernel.org.
> 
> The NET_IP_ALIGN existed not just for fun :)  There are ramifications
> for removing it.

It's still there, isn't it?

For the 9k MTU case, for example, we end up allocating 16384 byte skbs
instead of 32786 kbytes ones.


diff -puN drivers/net/e1000/e1000_main.c~e1000-account-for-net_ip_align-when-calculating-bufsiz drivers/net/e1000/e1000_main.c
--- a/drivers/net/e1000/e1000_main.c~e1000-account-for-net_ip_align-when-calculating-bufsiz
+++ a/drivers/net/e1000/e1000_main.c
@@ -1101,7 +1101,7 @@ e1000_sw_init(struct e1000_adapter *adap
 
 	pci_read_config_word(pdev, PCI_COMMAND, &hw->pci_cmd_word);
 
-	adapter->rx_buffer_len = MAXIMUM_ETHERNET_VLAN_SIZE;
+	adapter->rx_buffer_len = MAXIMUM_ETHERNET_VLAN_SIZE + NET_IP_ALIGN;
 	adapter->rx_ps_bsize0 = E1000_RXBUFFER_128;
 	hw->max_frame_size = netdev->mtu +
 			     ENET_HEADER_SIZE + ETHERNET_FCS_SIZE;
@@ -3163,26 +3163,27 @@ e1000_change_mtu(struct net_device *netd
 	 * larger slab size
 	 * i.e. RXBUFFER_2048 --> size-4096 slab */
 
-	if (max_frame <= E1000_RXBUFFER_256)
+	if (max_frame + NET_IP_ALIGN <= E1000_RXBUFFER_256)
 		adapter->rx_buffer_len = E1000_RXBUFFER_256;
-	else if (max_frame <= E1000_RXBUFFER_512)
+	else if (max_frame + NET_IP_ALIGN <= E1000_RXBUFFER_512)
 		adapter->rx_buffer_len = E1000_RXBUFFER_512;
-	else if (max_frame <= E1000_RXBUFFER_1024)
+	else if (max_frame + NET_IP_ALIGN <= E1000_RXBUFFER_1024)
 		adapter->rx_buffer_len = E1000_RXBUFFER_1024;
-	else if (max_frame <= E1000_RXBUFFER_2048)
+	else if (max_frame + NET_IP_ALIGN <= E1000_RXBUFFER_2048)
 		adapter->rx_buffer_len = E1000_RXBUFFER_2048;
-	else if (max_frame <= E1000_RXBUFFER_4096)
+	else if (max_frame + NET_IP_ALIGN <= E1000_RXBUFFER_4096)
 		adapter->rx_buffer_len = E1000_RXBUFFER_4096;
-	else if (max_frame <= E1000_RXBUFFER_8192)
+	else if (max_frame + NET_IP_ALIGN <= E1000_RXBUFFER_8192)
 		adapter->rx_buffer_len = E1000_RXBUFFER_8192;
-	else if (max_frame <= E1000_RXBUFFER_16384)
+	else
 		adapter->rx_buffer_len = E1000_RXBUFFER_16384;
 
 	/* adjust allocation if LPE protects us, and we aren't using SBP */
 	if (!adapter->hw.tbi_compatibility_on &&
 	    ((max_frame == MAXIMUM_ETHERNET_FRAME_SIZE) ||
 	     (max_frame == MAXIMUM_ETHERNET_VLAN_SIZE)))
-		adapter->rx_buffer_len = MAXIMUM_ETHERNET_VLAN_SIZE;
+		adapter->rx_buffer_len = MAXIMUM_ETHERNET_VLAN_SIZE +
+					NET_IP_ALIGN;
 
 	netdev->mtu = new_mtu;
 
@@ -4002,7 +4003,8 @@ e1000_alloc_rx_buffers(struct e1000_adap
 	struct e1000_buffer *buffer_info;
 	struct sk_buff *skb;
 	unsigned int i;
-	unsigned int bufsz = adapter->rx_buffer_len + NET_IP_ALIGN;
+	/* we have already accounted for NET_IP_ALIGN */
+	unsigned int bufsz = adapter->rx_buffer_len;
 
 	i = rx_ring->next_to_use;
 	buffer_info = &rx_ring->buffer_info[i];
_


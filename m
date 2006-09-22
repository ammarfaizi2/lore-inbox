Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWIVRR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWIVRR6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 13:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWIVRR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 13:17:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:43034 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S964782AbWIVRR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 13:17:56 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,204,1157353200"; 
   d="scan'208"; a="133328414:sNHT176489068"
Message-ID: <4514190C.8010901@intel.com>
Date: Fri, 22 Sep 2006 10:10:36 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Holger Kiehl <Holger.Kiehl@dwd.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-net <linux-net@vger.kernel.org>, netdev@vger.kernel.org,
       "Ronciak, John" <john.ronciak@intel.com>
Subject: Re: 2.6.1[78] page allocation failure. order:3, mode:0x20
References: <Pine.LNX.4.64.0609220655550.13396@diagnostix.dwd.de> <20060922004253.2e2e2612.akpm@osdl.org>
In-Reply-To: <20060922004253.2e2e2612.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Sep 2006 17:12:25.0281 (UTC) FILETIME=[463B0310:01C6DE6A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 22 Sep 2006 07:27:18 +0000 (GMT)
> Holger Kiehl <Holger.Kiehl@dwd.de> wrote:
> 
>> I get some of the "page allocation failure" errors. My hardware is 4 CPU
>> Opteron with one quad + one dual intel e1000 cards. Kernel is plain 2.6.18
>> and for two cards MTU is set to 9000.
>>
>>     Sep 21 21:03:15 athena kernel: vsftpd: page allocation failure. order:3, mode:0x20
>>     Sep 21 21:03:15 athena kernel:
>>     Sep 21 21:03:15 athena kernel: Call Trace:
>>     Sep 21 21:03:15 athena kernel:  <IRQ> [<ffffffff8024e516>] __alloc_pages+0x282/0x29b
>>     Sep 21 21:03:15 athena kernel:  [<ffffffff8807aa93>] :ip_tables:ipt_do_table+0x1eb/0x318
>>     Sep 21 21:03:15 athena kernel:  [<ffffffff8026614b>] cache_grow+0x134/0x33d
>>     Sep 21 21:03:15 athena kernel:  [<ffffffff8026664c>] cache_alloc_refill+0x189/0x1d7
>>     Sep 21 21:03:15 athena kernel:  [<ffffffff80266724>] __kmalloc+0x8a/0x94
>>     Sep 21 21:03:15 athena kernel:  [<ffffffff803b5438>] __alloc_skb+0x5c/0x123
>>     Sep 21 21:03:15 athena kernel:  [<ffffffff803b5f2e>] __netdev_alloc_skb+0x12/0x2d
>>     Sep 21 21:03:15 athena kernel:  [<ffffffff8033cb22>] e1000_alloc_rx_buffers+0x6f/0x2f3
>>     Sep 21 21:03:15 athena kernel:  [<ffffffff803d1234>] ip_local_deliver+0x173/0x23b
>>     Sep 21 21:03:15 athena kernel:  [<ffffffff8033d29a>] e1000_clean_rx_irq+0x4f4/0x514
> 
> Is OK, it's just a warning and it is expected - the kernel will recover.
> 
> I'm half-inclined to shut the warning up by sticking a __GFP_NOWARN in there.
> 
> But on the other hand, that warning is handy sometimes.  How come kmalloc
> decided to request a 32k hunk of memory when the MTU size is only 9k?  Is
> the driver doing something dumb?
> 
> 	else if (max_frame <= E1000_RXBUFFER_8192)
> 		adapter->rx_buffer_len = E1000_RXBUFFER_8192;
> 	else if (max_frame <= E1000_RXBUFFER_16384)
> 		adapter->rx_buffer_len = E1000_RXBUFFER_16384;
> 
> It sure is.
> 
> This is going to cause an 9000-byte MTU to use a 16384-byte allocation. 
> e1000_alloc_rx_buffers() adds two bytes to that, so we do kmalloc(16386),
> which causes the slab allocator to request 32768 bytes.  All for a 9kbyte skb.

I wonder if we can't account for NET_IP_ALIGN when selecting bufsize, to get at 
rid of at least 1 order size before we netdev_alloc_skb. This should make 9k 
frames only kmalloc(16384) and thus stay within the 16k boundary. I hope.

Completely untested: don't commit :)

Auke

---

e1000: account for NET_IP_ALIGN when calculating bufsiz

Account for NET_IP_ALIGN when requesting buffer sizes from netdev_alloc_skb to 
reduce slab allocation by half.

Signed-off-by: Auke Kok <auke-jan.h.kok@intel.com>

diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index bb0d129..20b1f39 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -1144,7 +1144,7 @@ #endif

  	pci_read_config_word(pdev, PCI_COMMAND, &hw->pci_cmd_word);

-	adapter->rx_buffer_len = MAXIMUM_ETHERNET_VLAN_SIZE;
+	adapter->rx_buffer_len = MAXIMUM_ETHERNET_VLAN_SIZE + NET_IP_ALIGN;
  	adapter->rx_ps_bsize0 = E1000_RXBUFFER_128;
  	hw->max_frame_size = netdev->mtu +
  			     ENET_HEADER_SIZE + ETHERNET_FCS_SIZE;
@@ -3234,26 +3234,27 @@ #define MAX_STD_JUMBO_FRAME_SIZE 9234
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
+		adapter->rx_buffer_len = MAXIMUM_ETHERNET_VLAN_SIZE
+		                         + NET_IP_ALIGN;

  	netdev->mtu = new_mtu;

@@ -4076,7 +4076,8 @@ e1000_alloc_rx_buffers(struct e1000_adap
  	struct e1000_buffer *buffer_info;
  	struct sk_buff *skb;
  	unsigned int i;
-	unsigned int bufsz = adapter->rx_buffer_len + NET_IP_ALIGN;
+	/* we have already accounted for NET_IP_ALIGN */
+	unsigned int bufsz = adapter->rx_buffer_len;

  	i = rx_ring->next_to_use;
  	buffer_info = &rx_ring->buffer_info[i];

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132629AbRBED1Y>; Sun, 4 Feb 2001 22:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132641AbRBED1O>; Sun, 4 Feb 2001 22:27:14 -0500
Received: from granger.mail.mindspring.net ([207.69.200.148]:23347 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S132629AbRBED1F>; Sun, 4 Feb 2001 22:27:05 -0500
Message-ID: <3A7E1D8E.2000807@tuxyturvy.com>
Date: Sun, 04 Feb 2001 22:27:10 -0500
From: Tom Sightler <ttsig@tuxyturvy.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1 i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Anton Altaparmakov <aia21@cam.ac.uk>, Michael Pacey <michael@wd21.co.uk>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [Patch] 3Com 3c523: Can't load module in kernel 2.4.1
In-Reply-To: <20010201193250.B340@kermit.wd21.co.uk>
	 <E14ORB4-000571-00@the-village.bc.nu>
	 <20010201220624.E340@kermit.wd21.co.uk> <5.0.2.1.2.20010202151231.00a43d00@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok all, here's a patch that attempts to make the 3c523 driver work again in 2.4.1.  It includes the following changes:


- fix addresses with bus_to_virt
- reduce xmit buffers from 4 to 1 (puts driver in noop mode like ni52 driver)
- increase recv buffers from 6 to 9 (should help decrease dropped packets)
- add short delay to detect routine (makes cards detectable on fast machines)
- use eth_copy_and_sum for receiving packets

It passed basic stress testing with multiple, simultaneous ftp transfers.

Know bugs:

- Multicast still doesn't work at all (I have patches that seem to fix this but they have other problems)
- Still drops packets under heavy traffic (can be reduced further by lowering MTU on interface)
- Sometimes requires host to send a packet before it starts receiving (I can't reproduce this on my equipment anymore, but needs more testing)

Anyone with this card please test and report back.

Later,
Tom


--- 3c523.c.241	Fri Feb  2 21:09:20 2001
+++ 3c523.c	Sun Feb  4 21:02:18 2001
@@ -148,9 +148,9 @@

  #define RECV_BUFF_SIZE 1524	/* slightly oversized */
  #define XMIT_BUFF_SIZE 1524	/* slightly oversized */
-#define NUM_XMIT_BUFFS 4	/* config for both, 8K and 16K shmem */
-#define NUM_RECV_BUFFS_8  1	/* config for 8K shared mem */
-#define NUM_RECV_BUFFS_16 6	/* config for 16K shared mem */
+#define NUM_XMIT_BUFFS 1	/* config for both, 8K and 16K shmem */
+#define NUM_RECV_BUFFS_8  4	/* config for 8K shared mem */
+#define NUM_RECV_BUFFS_16 9	/* config for 16K shared mem */

  #if (NUM_XMIT_BUFFS == 1)
  #define NO_NOPCOMMANDS		/* only possible with NUM_XMIT_BUFFS=1 */
@@ -303,13 +303,13 @@
  	char *iscp_addrs[2];
  	int i = 0;

- 
p->base = where + size - 0x01000000;
- 
p->memtop = phys_to_virt(where) + size;
- 
p->scp = (struct scp_struct *)phys_to_virt(p->base + SCP_DEFAULT_ADDRESS);
+ 
p->base = (unsigned long) bus_to_virt((unsigned long)where) + size - 0x01000000;
+ 
p->memtop = bus_to_virt((unsigned long)where) + size;
+ 
p->scp = (struct scp_struct *)(p->base + SCP_DEFAULT_ADDRESS);
  	memset((char *) p->scp, 0, sizeof(struct scp_struct));
  	p->scp->sysbus = SYSBUSVAL;	/* 1 = 8Bit-Bus, 0 = 16 Bit */

- 
iscp_addrs[0] = phys_to_virt(where);
+ 
iscp_addrs[0] = bus_to_virt((unsigned long)where);
  	iscp_addrs[1] = (char *) p->scp - sizeof(struct iscp_struct);

  	for (i = 0; i < 2; i++) {
@@ -325,6 +325,7 @@

  		/* apparently, you sometimes have to kick the 82586 twice... */
  		elmc_id_attn586();
+ 
	DELAY(1);

  		if (p->iscp->busy) {	/* i82586 clears 'busy' after successful init */
  	 
	return 0;
@@ -344,8 +345,8 @@
  	elmc_id_reset586();
  	DELAY(2);

- 
p->scp = (struct scp_struct *) phys_to_virt(p->base + SCP_DEFAULT_ADDRESS);
- 
p->scb = (struct scb_struct *) phys_to_virt(dev->mem_start);
+ 
p->scp = (struct scp_struct *) (p->base + SCP_DEFAULT_ADDRESS);
+ 
p->scb = (struct scb_struct *) bus_to_virt(dev->mem_start);
  	p->iscp = (struct iscp_struct *) ((char *) p->scp - sizeof(struct iscp_struct));

  	memset((char *) p->iscp, 0, sizeof(struct iscp_struct));
@@ -518,7 +519,8 @@
  	}
  	dev->mem_end = dev->mem_start + size;	/* set mem_end showed by 'ifconfig' */

- 
((struct priv *) (dev->priv))->base = dev->mem_start + size - 0x01000000;
+ 
((struct priv *) (dev->priv))->memtop = bus_to_virt(dev->mem_start) + size;
+ 
((struct priv *) (dev->priv))->base = (unsigned long) bus_to_virt(dev->mem_start) + size - 0x01000000;
  	alloc586(dev);

  	elmc_id_reset586();	/* make sure it doesn't generate spurious ints */
@@ -944,7 +946,8 @@
  	 
		if (skb != NULL) {
  	 
			skb->dev = dev;
  	 
			skb_reserve(skb, 2);	/* 16 byte alignment */
- 
				memcpy(skb_put(skb, totlen), (u8 *)phys_to_virt(p->base) + (unsigned long) rbd->buffer, totlen);
+ 
				skb_put(skb,totlen);
+ 
				eth_copy_and_sum(skb, (char *) p->base+(unsigned long) rbd->buffer,totlen,0);
  	 
			skb->protocol = eth_type_trans(skb, dev);
  	 
			netif_rx(skb);
  	 
			p->stats.rx_packets++;
@@ -1086,6 +1089,7 @@
  static int elmc_send_packet(struct sk_buff *skb, struct net_device *dev)
  {
  	int len;
+ 
int i;
  #ifndef NO_NOPCOMMANDS
  	int next_nop;
  #endif

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

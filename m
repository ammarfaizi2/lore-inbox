Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314500AbSD1U7d>; Sun, 28 Apr 2002 16:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314501AbSD1U7d>; Sun, 28 Apr 2002 16:59:33 -0400
Received: from relais.videotron.ca ([24.201.245.36]:22207 "EHLO
	VL-MS-MR005.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S314500AbSD1U7b>; Sun, 28 Apr 2002 16:59:31 -0400
From: "Enrico Demarin" <enricod@videotron.ca>
To: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: hard_start_transmit return value and oops
Date: Sun, 28 Apr 2002 17:00:39 -0700
Message-ID: <003a01c1ef10$e6604ab0$0340a8c0@shodan2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I posted a problem I have a while ago, to resum it :

I wrote a kernel module that listens on an ethernet device ( by adding a
protocol handler ), and  "repeats" the traffic on a virtual device
driver.
The problems started with DHCP. I would get kernel oopses when dhcdp
sends the replies on the virtual device. I narrowed it down
to the hard_start_transmit function of my virtual device. 

Dhcpd 3.0 for example would send something with a skb->protocol !=
ETH_P_IP, and my module would report an error

if ( ntohs(skb->protocol) != ETH_P_IP )
 {
  printk(KERN_WARNING "unsupported protocol detected!\n");
  dev_kfree_skb(skb);
  return -EPROTONOSUPPORT;
 }

But as soon as i return -EPROTONOSUPPORT , or whatever non zero value,
the kernel (2.4.17, 2.4.18) would panic.

Since then i found a document entitled "Transmit path guidelines" , that
states that hard_start_transmit must never
return 1 under any normal circumstance, because "it's considered an hard
error unless there  is no way your device  can
tell ahead of time when it's transmit function will become busy".  So i
chosen not to return errors but to simply kfree the skb and drop the
packet. The person who send this document , said it will be into 2.4.19
, the text file was called
"driver.txt". I don't know if this will be useful for anyone else but I
decided to post it anyway. I don't know who wrote .it, I found it at
http://nyu.dyn.dhs.org:8080/~matt/driver.txt.

Bye,
Enrico

---- driver.txt------------------------------------------------------

Documents about softnet driver issues in general can be found
at:

	http://www.firstfloor.org/~andi/softnet/

Transmit path guidelines:

1) The hard_start_xmit method must never return '1' under any
   normal circumstances.  It is considered a hard error unless
   there is no way your device can tell ahead of time when it's
   transmit function will become busy.

   Instead it must maintain the queue properly.  For example,
   for a driver implementing scatter-gather this means:

	static int drv_hard_start_xmit(struct sk_buff *skb,
		   		       struct net_device *dev)
	{
		struct drv *dp = dev->priv;

		lock_tx(dp);
		...
		/* This is a hard error log it. */
		if (TX_BUFFS_AVAIL(dp) <= (skb_shinfo(skb)->nr_frags +
1)) {
			netif_stop_queue(dev);
			unlock_tx(dp);
			printk(KERN_ERR PFX "%s: BUG! Tx Ring full when
queue awake!\n",
			       dev->name);
			return 1;
		}

		... queue packet to card ...
		... update tx consumer index ...

		if (TX_BUFFS_AVAIL(dp) <= (MAX_SKB_FRAGS + 1))
			netif_stop_queue(dev);

		...
		unlock_tx(dp);
		...
	}

   And then at the end of your TX reclaimation event handling:

	if (netif_queue_stopped(dp->dev) &&
            TX_BUFFS_AVAIL(dp) > (MAX_SKB_FRAGS + 1))
		netif_wake_queue(dp->dev);

   For a non-scatter-gather supporting card, the three tests simply
become:

		/* This is a hard error log it. */
		if (TX_BUFFS_AVAIL(dp) <= 0)

   and:

		if (TX_BUFFS_AVAIL(dp) == 0)

   and:

	if (netif_queue_stopped(dp->dev) &&
            TX_BUFFS_AVAIL(dp) > 0)
		netif_wake_queue(dp->dev);

2) Do not forget to update netdev->trans_start to jiffies after
   each new tx packet is given to the hardware.

3) Do not forget that once you return 0 from your hard_start_xmit
   method, it is your driver's responsibility to free up the SKB
   and in some finite amount of time.

   For example, this means that it is not allowed for your TX
   mitigation scheme to let TX packets "hang out" in the TX
   ring unreclaimed forever if no new TX packets are sent.
   This error can deadlock sockets waiting for send buffer room
   to be freed up.

   If you return 1 from the hard_start_xmit method, you must not keep
   any reference to that SKB and you must not attempt to free it up.

Probing guidelines:

1) Any hardware layer address you obtain for your device should
   be verified.  For example, for ethernet check it with
   linux/etherdevice.h:is_valid_ether_addr()


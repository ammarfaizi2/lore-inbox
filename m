Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbUDSRZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 13:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUDSRZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 13:25:59 -0400
Received: from gwout.thalesgroup.com ([195.101.39.227]:21519 "EHLO
	GWOUT.thalesgroup.com") by vger.kernel.org with ESMTP
	id S261505AbUDSRZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 13:25:42 -0400
Message-ID: <66CE949D18BCB249ABE8D9AF48C4F1CE777CF9@helios.clb.tcfr.thales>
From: Christophe.LINDHEIMER@fr.thalesgroup.com
To: linux-kernel@vger.kernel.org
Subject: Question about struct sk_buff usage.
Date: Mon, 19 Apr 2004 19:26:37 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I am developping an application where I need to patch data coming from
Ethernet. ( changgin MAC @ for example )
I have patched the kernel in order to add a hook when a packet is
received.
When netif_receive_skb is called and if the Hook is non null I call it
with the skb as argument.

int netif_receive_skb(struct sk_buff *skb)
{
	struct packet_type *ptype, *pt_prev;
	int ret = NET_RX_DROP;
	unsigned short type = skb->protocol;

	/* Patch C.Lindheimer */
	if ( Lindheimer_Hook_RX != NULL )
	  (*((void (*)(struct sk_buff *))Lindheimer_Hook_RX))(skb);

	if (skb->stamp.tv_sec == 0)
		do_gettimeofday(&skb->stamp);

		...
}

Then here is the Hook I wrote :
	
void Hook_RX(struct sk_buff *skb)
{
  unsigned char *i;
  unsigned char num;
  
  num = (skb->dev)->name[3] - '0';
  printk("Hook RX device %s -> %d\n", ((skb->dev))->name, num);
  printk("h     : %x\n", skb->h.raw); 
  printk("nh    : %x\n", skb->nh.raw);
  printk("mac   : %x\n", skb->mac.raw);
  printk("len   : %x\n", skb->len);
  printk("da len: %x\n", skb->data_len);
  printk("head  : %x\n", skb->head);  
  printk("data  : %x\n", skb->data);  
  printk("tail  : %x\n", skb->tail);  
  printk("end   : %x\n", skb->end);
  
  for ( i = skb->head; i <  skb->end; i++ )
    {
      if ( i ==  skb->data ) printk("** ");
      printk("%x ", *i);
    }
  
....

}

I have two Ethernet devices.
The trace just shows received packets : ARP Packets due to a ping done
on each interface.

Mac eth1 : 0 9 5b 8e ee d3 
Mac machine 1 : 0 10 cd 32 50 8
Mac eth2 : 0 e 7f 64 10 fd 
Mac machein 2 : 0 10 cd 32 4f e0 

I don't understand how skb->head works.
On eth1 I have 16 bytes before reaching the beginning of the paquet (
@ MAC eth1 )
On eth0 I have 18 bytes.

eth0 & eth1 are two hardware differents cards.

what is the right way to find the start of the data in the buffer ?
what is the meaning of skb->data ?

Thanks

Chris

.....
Hook RX device eth1 -> 1
h     : c7805980
nh    : cad65010
mac   : c328a010
len   : 2e
da len: 0
head  : c328a000
data  : c328a01e
tail  : c328a04c
end   : c328a680
12 0 ef 0 f 0 40 1 e 1 0 0 1d 1 0 0 0 9 5b 8e ee d3 0 10 cd 32 50 8 8
6 ** 0 1 8 0 6 4 0 2 0 10 cd 32 50 8 9 f 16 3 0 9 5b 8e ee d3 9 f 16
13 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 94 2d 12 95
39 30 a 6d 61 63 20 20 20 3a 20 63 66 35 31 38 30 31 32 a 6c 65 6e 20
20 20 3a 20 33 36 a 64 61 20 6c 65 6e 3a 20 30 a 68 65 61 64 20 20 3a
20 63 65 31 30 33 64 38 30 a 64 61 74 61 20 20
.....


.........

Hook RX device eth0 -> 0
h     : c41b1834
nh    : c41b1820
mac   : c9c22012
len   : 54
da len: 0
head  : c9c22000
data  : c9c22020
tail  : c9c22074
end   : c9c22680
1 8 46 8d e9 0 0 0 1d 1 0 0 0 0 0 0 a1 3 0 e 7f 64 10 fd 0 10 cd 32 4f
e0 8 0 ** 45 0 0 54 0 45 40 0 40 1 fc 30 9 f 16 13 9 f 16 3 0 0 18 d
10 19 0 1 43 e9 83 40 1d ac 8 0 8 9 a b c d e f 10 11 12 13 14 15 16
17 18 19 1a 1b 1c 1d 1e 1f 20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d
2e 2f 30 31 32 33 34 35 36 37 36 7c 28 9 61 20 6c 65 6e 3a 20 30 a 68
65 61 64 20 20 3a 20 63 65 31 30 33 64 38 30 a 64 61 74 61 20 20 3a 20
63 65 31 30 33 64 38 32 a 74 61 69 6c 20 20 3a 20 63 65 31 30 33 64 62
38 a 65 6e 64 20 20 20 3a 20 63 65 31 30 33 65 30 30 a 31 63
.................

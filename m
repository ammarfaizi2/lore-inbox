Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315599AbSGAOsA>; Mon, 1 Jul 2002 10:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315606AbSGAOrz>; Mon, 1 Jul 2002 10:47:55 -0400
Received: from mm02snlnto.sandia.gov ([132.175.109.21]:29961 "HELO
	mm02snlnto.sandia.gov") by vger.kernel.org with SMTP
	id <S315599AbSGAOry>; Mon, 1 Jul 2002 10:47:54 -0400
X-Server-Uuid: 95b8ca9b-fe4b-44f7-8977-a6cb2d3025ff
Message-ID: <B51F0C636E578A4E832D3958690CD73E0BCA4D87@es04snlnt>
From: "Memon, Mazhar I" <mimemon@sandia.gov>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
cc: "'mazhar@nmt.edu'" <mazhar@nmt.edu>
Subject: Dropping skb's
Date: Mon, 1 Jul 2002 08:49:31 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-Filter-Version: 1.8 (sass2426)
X-WSS-ID: 113EB4F91081960-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From what I understand, the following 2 lines of code should unlink and
dealloc an skb; causing the packet to never be sent (or received):

	skb_unlink(skb);
	dev_kfree_skb(skb);

Instead, when trying to drop outbound skb's, they get sent anyway.  I've
already checked that skb->users drops to zero and should be deallocated when
dev_kfree_skb is called. I've also tried directly calling the
skb->destructor function and manually (and atomically) decrementing
skb->users.

Refer to the packet_handler below:

Regards,
Mazhar

static struct packet_type all_type;
static int pkt_handler(struct sk_buff *skb, struct net_device *dv, struct
packet_type *pt) { 
        switch(skb->pkt_type) {
		case PACKET_OUTGOING:
			printk("outgoing\n");	
			
			skb_unlink(skb);
			dev_kfree_skb(skb);
		
			goto destroy;
			break;
            default:
			printk("incoming\n");	
			break;
        }

pass:
        dev_kfree_skb(skb);
destroy:
        return 0;
}
... 
int init_module(void)
{
        all_type.type = htons(ETH_P_ALL);
        all_type.func = pkt_handler;

        dev_add_pack(&all_type);
        return 0;
} 





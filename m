Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129314AbQKOLMc>; Wed, 15 Nov 2000 06:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129741AbQKOLMW>; Wed, 15 Nov 2000 06:12:22 -0500
Received: from mean.netppl.fi ([195.242.208.16]:18702 "EHLO mean.netppl.fi")
	by vger.kernel.org with ESMTP id <S129314AbQKOLMM>;
	Wed, 15 Nov 2000 06:12:12 -0500
Date: Wed, 15 Nov 2000 12:42:04 +0200
From: Pekka Pietikainen <pp@evil.netppl.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] acenic driver update
Message-ID: <20001115124204.A19484@netppl.fi>
In-Reply-To: <200011140031.TAA13437@plonk.linuxcare.com> <20001114184505.X18364@esscom.com> <d3aeb1yhy8.fsf@lxplus015.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <d3aeb1yhy8.fsf@lxplus015.cern.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2000 at 05:31:27AM +0100, Jes Sorensen wrote:
> >>>>> "Val" == Val Henson <vhenson@esscom.com> writes:
> Val> Jes, I just downloaded the 0.48 acenic driver and it still has a
> Val> reproducible null dereference bug.  Anyone can oops their machine
> Val> by doing:
> 
> Bugger I think I lost your patch in the noise. Sorry about that, it'll
> be in the next version.
> 
> Val> ifconfig <gige> mtu 9000 ping -f -s 60000 <remote gige host>
> Val> ifconfig <gige> mtu 1500 ping -f -s 60000 <remote gige host>
> 
> Val> I don't have a fix for this.
> 
> Hmmm could be a firmware issue, I'll need to look at it. It is however
> a kind of bug that only root can cause deliberately. Doing ifconfig
> mtu foo ; ifconfig mtu bar is a little far from normal operation ;-)
It seems like it's caused by the driver trying to 
do things while it's still setting up the rings.

static void ace_rx_int(struct net_device *dev, u32 rxretprd, u32 rxretcsm)
{
	...
        rip = &ap->skb->rx_jumbo_skbuff[skbidx];
	...
	skb = rip->skb;
	skb_put(skb, retdesc->size); /* crash here */
	...
}

while the driver might be doing this at the same time:

	for (i = 0; i < RX_JUMBO_RING_ENTRIES; i++) { 
      	 	if (ap->skb->rx_jumbo_skbuff[i].skb) {
	    	 	ap->rx_jumbo_ring[i].size = 0;
			set_aceaddr(&ap->rx_jumbo_ring[i].addr,
			dev_kfree_skb(ap->skb->rx_jumbo_skbuff[i].skb); 
	 	 	ap->skb->rx_jumbo_skbuff[i].skb = NULL;
              	}
         }
-- 
Pekka Pietikainen



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

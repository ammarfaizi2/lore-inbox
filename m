Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbTDSCig (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 22:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263343AbTDSCig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 22:38:36 -0400
Received: from Xenon.Stanford.EDU ([171.64.66.201]:33206 "EHLO
	Xenon.Stanford.EDU") by vger.kernel.org with ESMTP id S263338AbTDSCid
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 22:38:33 -0400
Date: Fri, 18 Apr 2003 19:50:25 -0700
From: Andy Chou <acc@CS.Stanford.EDU>
To: linux-kernel@vger.kernel.org
Cc: mc@cs.stanford.edu, madan@cs.stanford.edu, wendy.cheng@falconstor.com
Subject: [CHECKER] 6 memory leaks
Message-ID: <20030419025025.GA32656@Xenon.Stanford.EDU>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following memory leaks were found by static analysis using the MC
system (aka "Stanford Checker").  This is only an incremental list of new
bugs found by an updated version of the memory leak checker.  I checked
the ipv4 and ipv6 bugs and they are still in 2.5.67.

Confirmation/rejection would be appreciated for any of these bugs.

-Andy

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=err

---------------------------------------------------------
[BUG] 
/u1/acc/linux/2.5.48/net/ipv4/netfilter/ip_queue.c:321:ipq_enqueue_packet: ERROR:LEAK:296:321:Memory leak [Allocated from: /u1/acc/linux/2.5.48/net/ipv4/netfilter/ip_queue.c:296:ipq_build_packet_message]

		entry->rt_info.tos = iph->tos;
		entry->rt_info.daddr = iph->daddr;
		entry->rt_info.saddr = iph->saddr;
	}

Start --->
	nskb = ipq_build_packet_message(entry, &status);

	... DELETED 19 lines ...

err_out_unlock:
	write_unlock_bh(&queue_lock);

err_out_free:
	kfree(entry);
Error --->
	return status;
}

static int
---------------------------------------------------------
[BUG] 
/u1/acc/linux/2.5.48/net/ipv6/netfilter/ip6_queue.c:326:ipq_enqueue_packet: ERROR:LEAK:301:326:Memory leak [Allocated from: /u1/acc/linux/2.5.48/net/ipv6/netfilter/ip6_queue.c:301:ipq_build_packet_message]


		entry->rt_info.daddr = iph->daddr;
		entry->rt_info.saddr = iph->saddr;
	}

Start --->
	nskb = ipq_build_packet_message(entry, &status);

	... DELETED 19 lines ...

err_out_unlock:
	write_unlock_bh(&queue_lock);

err_out_free:
	kfree(entry);
Error --->
	return status;
}

/*
---------------------------------------------------------
[BUG] 
/u1/acc/linux/2.5.48/net/irda/irttp.c:266:irttp_reassemble_skb: ERROR:LEAK:242:266:Memory leak [Allocated from: /u1/acc/linux/2.5.48/net/irda/irttp.c:242:dev_alloc_skb]

	ASSERT(self->magic == TTP_TSAP_MAGIC, return NULL;);

	IRDA_DEBUG(2, "%s(), self->rx_sdu_size=%d\n", __FUNCTION__,
		   self->rx_sdu_size);

Start --->
	skb = dev_alloc_skb(TTP_HEADER + self->rx_sdu_size);

	... DELETED 18 lines ...

	}
	IRDA_DEBUG(2, "%s(), frame len=%d\n",  __FUNCTION__, n);

	IRDA_DEBUG(2, "%s(), rx_sdu_size=%d\n",  __FUNCTION__,
		   self->rx_sdu_size);
Error --->
	ASSERT(n <= self->rx_sdu_size, return NULL;);

	/* Set the new length */
	skb_trim(skb, n);
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/isdn/tpam/tpam_queues.c:150:tpam_irq: ERROR:LEAK:112:150:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/isdn/tpam/tpam_queues.c:112:alloc_skb]

		
		/* get the beginning of the message (pci_mpb part) */
		copy_from_pam(card, &mpb, (void *)uploadptr, sizeof(pci_mpb));

		/* allocate the sk_buff */
Start --->
		if (!(skb = alloc_skb(sizeof(skb_header) + sizeof(pci_mpb) + 

	... DELETED 32 lines ...

			hpic = readl(card->bar0 + TPAM_HPIC_REGISTER);
			if (waiting_too_long++ > 0xfffffff) {
				spin_unlock(&card->lock);
				printk(KERN_ERR "TurboPAM(tpam_irq): "
						"waiting too long...\n");
Error --->
				return;
			}
		} while (hpic & 0x00000002);

---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/net/wan/sdla_ppp.c:1921:rx_intr: ERROR:LEAK:1830:1921:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/net/wan/sdla_ppp.c:1830:dev_alloc_skb]

	
		len  = rxbuf->length;
		ppp_priv_area = dev->priv;

		/* Allocate socket buffer */
Start --->
		skb = dev_alloc_skb(len);

	... DELETED 85 lines ...

	/* Release buffer element and calculate a pointer to the next one */
	rxbuf->flag = 0x00;
	card->rxmb = ++rxbuf;
	if ((void*)rxbuf > card->u.p.rxbuf_last)
		card->rxmb = card->u.p.rxbuf_base;
Error --->
}


void event_intr (sdla_t *card)
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/net/ax25/af_ax25.c:1294:ax25_connect: ERROR:LEAK:1168:1294:Memory leak [Allocated from: /u1/acc/linux/2.5.48/net/ax25/af_ax25.c:1168:kmalloc]

		if (fsa->fsa_ax25.sax25_ndigis < 1 || fsa->fsa_ax25.sax25_ndigis > AX25_MAX_DIGIS) {
			err = -EINVAL;
			goto out;
		}

Start --->
		if ((digi = kmalloc(sizeof(ax25_digi), GFP_KERNEL)) == NULL) {

	... DELETED 120 lines ...

	sock->state = SS_CONNECTED;

out:
	release_sock(sk);

Error --->
	return 0;
}




--MGYHOYXEY6WxJCY8--

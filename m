Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbULBXMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbULBXMx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 18:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbULBXMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 18:12:48 -0500
Received: from puma.inf.ufrgs.br ([143.54.11.5]:40611 "EHLO inf.ufrgs.br")
	by vger.kernel.org with ESMTP id S261801AbULBXMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 18:12:33 -0500
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <92A26C52-44B7-11D9-A62F-000A957B2B6C@inf.ufrgs.br>
Content-Transfer-Encoding: 7bit
X-Image-Url: http://www.inf.ufrgs.br/~drebes/drebes.tif
From: Roberto Jung Drebes <drebes@inf.ufrgs.br>
Subject: GFP_ATOMIC vs GFP_KERNEL in netfilter module
Date: Thu, 2 Dec 2004 21:12:01 -0200
To: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,

I am testing a simple netfilter module which delays every 5th IP packet 
received. I am having problems allocating the timer structure. Here is 
the netfilter hook I register:

static unsigned int
comfirm_rx_hook(unsigned int hook,
                 struct sk_buff **pskb,
                 const struct net_device *in,
                 const struct net_device *out,
                 int (*okfn) (struct sk_buff *))
{
     static int counter;
     struct timer_list *tl;
     struct cf_delay_parms *dp;

     if ((*pskb)->nfmark != CF_MAGIC) {
         counter++;

         if (!(counter % 5)) {
             dp = kmalloc(sizeof(struct cf_delay_parms), GFP_KERNEL);
             tl = kmalloc(sizeof(struct timer_list), GFP_KERNEL);
             dp->timer = tl;
             (*pskb)->nfmark = CF_MAGIC;
             dp->skb = *pskb;
             tl->data = (unsigned long) dp;
             tl->function = (void *) cf_delay_rx;
             tl->expires = jiffies + 100;
             init_timer(tl);
             add_timer(tl);
             printk("packet delayed\n");
             return NF_STOLEN;
         } else
             return NF_ACCEPT;
     } else
         return NF_ACCEPT;
}

void cf_delay_rx(struct cf_delay_parms *parms)
{
     ip_rcv(parms->skb, parms->skb->dev, NULL);
     kfree(parms->timer);
     kfree(parms);
}

If I use GFP_KERNEL with the kmallocs, I get errors like

Debug: sleeping function called from invalid context at mm/slab.c:2000
in_atomic():1[expected: 0], irqs_disabled():0
  [<0211b765>] __might_sleep+0x82/0x8c
  [<02146dbc>] kmem_cache_alloc+0x1d/0x4c
  [<2204b047>] comfirm_rx_hook+0x47/0xd8 [mymodule]
  [<022a68eb>] nf_iterate+0x40/0x89
  [<022b5d63>] ip_rcv_finish+0x0/0x1d9
  [<022a6bac>] nf_hook_slow+0x47/0xb1
  [<022b5d63>] ip_rcv_finish+0x0/0x1d9
  [<022b5be7>] ip_rcv+0x36d/0x3a1
  [<022b5d63>] ip_rcv_finish+0x0/0x1d9
  [<0229eef3>] netif_receive_skb+0x1b0/0x1dd
  [<0229ef8c>] process_backlog+0x6c/0xd9
  [<0229f056>] net_rx_action+0x5d/0xcd
  [<02122fa1>] __do_softirq+0x35/0x73
  [<02108a7b>] do_softirq+0x46/0x4d
  =======================
  [<02107e67>] do_IRQ+0x2f7/0x303
  [<021fc4c1>] acpi_processor_idle+0xd3/0x1c5
  [<0210408c>] cpu_idle+0x1f/0x34
  [<0239b6ae>] start_kernel+0x221/0x224

If I use GFP_ATOMIC, I don't get the error, but I think timers are not 
being called after the delay. I have a similar code for transmition, 
which works OK with GFP_KERNEL (delays messages) but with GFP_ATOMIC it 
does also not delay.

I test delay with ping, and I am running kernel 2.6.8-1.521 from Fedora 
Core 2.

What am I doing wrong?

TIA,

ps: Please CC me any reply from the linux-kernel mailing list.

-- 
Roberto Jung Drebes <drebes@inf.ufrgs.br>
Porto Alegre, RS - Brasil
http://www.inf.ufrgs.br/~drebes/


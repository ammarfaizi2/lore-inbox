Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbTEVFv7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 01:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbTEVFv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 01:51:59 -0400
Received: from smtp2.Stanford.EDU ([171.64.14.116]:46470 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S262498AbTEVFvw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 01:51:52 -0400
User-Agent: Microsoft-Entourage/10.1.1.2418
Date: Wed, 21 May 2003 23:04:52 -0700
Subject: [CHECKER] 12 potential leaks in kernel 2.5.69
From: Ted Kremenek <kremenek@cs.stanford.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: <mc@cs.stanford.edu>
Message-ID: <BAF1B694.8EBC%kremenek@cs.stanford.edu>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am with the Stanford Metacompilation group.  Here are some potential
memory leaks reported by one of our checkers.

Some of these (potential) leaks may be different than ones we have reported
before because they may contain functions that we never checked as being
allocator functions.  Of particular note is the skb_padto errors, and I am
not certain if they are real bugs are not.

As always, confirmation of these reports is appreciated.

Thanks.

Ted Kremenek

-------------------------------------------------------------

linux-2.5.69/net/irda/af_irda.c (lines 868-911)
[BUG/LEAK, kfree_skb not called on error path]

     * So, we will block the caller until we receive any data.
     * If the caller was waiting on select() or poll() before
     * calling us, the data is waiting for us ;-)
     * Jean II
     */
Start --->
    skb = skb_dequeue(&sk->receive_queue);

    ... DELETED 37 lines ...


    /* Now attach up the new socket */
    new->tsap = irttp_dup(self->tsap, new);
    if (!new->tsap) {
        IRDA_DEBUG(0, "%s(), dup failed!\n", __FUNCTION__);
Error --->
        return -1;
    }

    new->stsap_sel = new->tsap->stsap_sel;

-------------------------------------------------------------

linux-2.5.69/sound/pci/cs46xx/dsp_spos.c (lines 220-253)
[BUG, this function has two possible leak locations of ins, lines 242 and
253]

    return symbol;
}

dsp_spos_instance_t *  cs46xx_dsp_spos_create (cs46xx_t * chip)
{
Start --->
    dsp_spos_instance_t * ins = kmalloc(sizeof(dsp_spos_instance_t),
GFP_KERNEL);

    ... DELETED 27 lines ...

    ins->nmodules = 0;
    ins->modules = kmalloc(sizeof(dsp_module_desc_t) * DSP_MAX_MODULES,
GFP_KERNEL);

    if (ins->modules == NULL) {
        cs46xx_dsp_spos_destroy(chip);
Error --->
        return NULL;
    }

    /* default SPDIF input sample rate

-------------------------------------------------------------

linux-2.5.69/drivers/net/hp100.c (lines 1560-1610)
[BUG/LEAK: skb_padto may return new address.  Note certain what
           the exact semantics are, but skb_padto returns possibly
           a new skb.  It also may free the skb pointer passed to
           it, meaning the calling function may have a dangling reference.]


    if (skb->len <= 0)
        return 0;
        
    if (skb->len < ETH_ZLEN && lp->chip == HP100_CHIPID_SHASTA) {
Start --->
        skb = skb_padto(skb, ETH_ZLEN);

    ... DELETED 44 lines ...

                hp100_start_interface(dev);
            }
        }

        dev->trans_start = jiffies;
Error --->
        return -EAGAIN;
    }

    /*

-------------------------------------------------------------

linux-2.5.69/drivers/message/i2o/i2o_core.c (lines 1668-1722)
[BUG/LEAK: may be false positive; status appears to be leaked elsewhere in
the function on purpose]

    m=i2o_wait_message(c, "AdapterReset");
    if(m==0xFFFFFFFF)
        return -ETIMEDOUT;
    msg=(u32 *)(c->mem_offset+m);
    
Start --->
    status = pci_alloc_consistent(c->pdev, 4, &status_phys);

    ... DELETED 48 lines ...

        { 
            if((jiffies-time) >= 30*HZ)
            {
                printk(KERN_ERR "%s: Timeout waiting for IOP reset.\n",
                        c->name);
Error --->
                return -ETIMEDOUT;
            } 
            schedule();
            barrier();

-------------------------------------------------------------

linux-2.5.69/drivers/net/smc9194.c (lines 490-557)
[BUG/LEAK: skb_padto may return new address.  Note certain what
           the exact semantics are, but skb_padto returns possibly
           a new skb.  It also may free the skb pointer passed to
           it, meaning the calling function may have a dangling reference.]


    lp->saved_skb = skb;

    length = skb->len;

    if (length < ETH_ZLEN) {
Start --->
        skb = skb_padto(skb, ETH_ZLEN);

    ... DELETED 61 lines ...

              return 0;
       }
    /* or YES! I can send the packet now.. */
    smc_hardware_send_packet(dev);
    netif_wake_queue(dev);
Error --->
    return 0;
}

/*

-------------------------------------------------------------

linux-2.5.69/drivers/net/smc9194.c (lines 490-552)
[BUG/LEAK: skb_padto may return new address.  Note certain what
           the exact semantics are, but skb_padto returns possibly
           a new skb.  It also may free the skb pointer passed to
           it, meaning the calling function may have a dangling reference.]


    lp->saved_skb = skb;

    length = skb->len;

    if (length < ETH_ZLEN) {
Start --->
        skb = skb_padto(skb, ETH_ZLEN);

    ... DELETED 56 lines ...

       if ( !time_out ) {
        /* oh well, wait until the chip finds memory later */
        SMC_ENABLE_INT( IM_ALLOC_INT );
              PRINTK2((CARDNAME": memory allocation deferred. \n"));
        /* it's deferred, but I'll handle it later */
Error --->
              return 0;
       }
    /* or YES! I can send the packet now.. */
    smc_hardware_send_packet(dev);

-------------------------------------------------------------

linux-2.5.69/drivers/net/wireless/wavelan.c (lines 3012-3041)
[BUG/LEAK: skb_padto may return new address.  Note certain what
           the exact semantics are, but skb_padto returns possibly
           a new skb.  It also may free the skb pointer passed to
           it, meaning the calling function may have a dangling reference.]

    printk(KERN_DEBUG "%s: ->wavelan_packet_xmit(0x%X)\n", dev->name,
           (unsigned) skb);
#endif

    if (skb->len < ETH_ZLEN) {
Start --->
        skb = skb_padto(skb, ETH_ZLEN);

    ... DELETED 23 lines ...

        printk(KERN_INFO "skb has next\n");
#endif

    /* Write packet on the card */
    if(wv_packet_write(dev, skb->data, skb->len))
Error --->
        return 1;    /* We failed */

    dev_kfree_skb(skb);


-------------------------------------------------------------

linux-2.5.69/drivers/net/yellowfin.c (lines 883-940)
[BUG/LEAK: skb_padto may return new address.  Note certain what
           the exact semantics are, but skb_padto returns possibly
           a new skb.  It also may free the skb pointer passed to
           it, meaning the calling function may have a dangling reference.]

        int cacheline_end = ((unsigned long)skb->data + skb->len) % 32;
        /* Fix GX chipset errata. */
        if (cacheline_end > 24  || cacheline_end == 0) {
            len = skb->len + 32 - cacheline_end + 1;
            if (len != skb->len)
Start --->
                skb = skb_padto(skb, len);

    ... DELETED 51 lines ...


    if (yellowfin_debug > 4) {
        printk(KERN_DEBUG "%s: Yellowfin transmit frame #%d queued in slot
%d.\n",
               dev->name, yp->cur_tx, entry);
    }
Error --->
    return 0;
}

/* The interrupt handler does all of the Rx thread work and cleans up

-------------------------------------------------------------

linux-2.5.69/drivers/pnp/isapnp/core.c (lines 422-426)
[BUG/LEAK: simple leak of id]

 *  Parse EISA id.
 */

static void isapnp_parse_id(struct pnp_dev * dev, unsigned short vendor,
unsigned short device)
{
Start --->
    struct pnp_id * id = isapnp_alloc(sizeof(struct pnp_id));
    if (!id)
        return;
    if (!dev)
Error --->
        return;
    sprintf(id->id, "%c%c%c%x%x%x%x",
            'A' + ((vendor >> 2) & 0x3f) - 1,
            'A' + (((vendor & 3) << 3) | ((vendor >> 13) & 7)) - 1,

-------------------------------------------------------------

linux-2.5.69/net/ipv6/ndisc.c (lines 431-442)
[BUG/LEAK: rt looks allocated but may be leaked]

        struct sk_buff *skb;
    int err;

    len = sizeof(struct icmp6hdr) + sizeof(struct in6_addr);

Start --->
    rt = ip6_dst_alloc();
    if (!rt) 
        return;

    /* for anycast or proxy, solicited_addr != src_addr */
    ifp = ipv6_get_ifaddr(solicited_addr, dev);
     if (ifp) {
        src_addr = solicited_addr;
        in6_ifa_put(ifp);
    } else {
        if (ipv6_dev_get_saddr(dev, daddr, &tmpaddr, 0))
Error --->
            return;
        src_addr = &tmpaddr;
    }


-------------------------------------------------------------

linux-2.5.69/sound/isa/es18xx.c (lines 1969-1988)
[BUG/LEAK: leak on error path]

static int __devinit snd_audiodrive_pnp(int dev, struct snd_audiodrive
*acard,
                    struct pnp_card_link *card,
                    const struct pnp_card_device_id *id)
{
    struct pnp_dev *pdev;
Start --->
    struct pnp_resource_table * cfg = kmalloc(GFP_ATOMIC, sizeof(struct
pnp_resource_table));

    ... DELETED 13 lines ...

    }
    /* Control port initialization */
    err = pnp_activate_dev(acard->devc);
    if (err < 0) {
        snd_printk(KERN_ERR PFX "PnP control configure failure (out of
resources?)\n");
Error --->
        return -EAGAIN;
    }
    snd_printdd("pnp: port=0x%lx\n", pnp_port_start(acard->devc, 0));
    /* PnP initialization */

-------------------------------------------------------------

linux-2.5.69/net/ipv6/anycast.c (lines 115-180)
[BUG/LEAK: leak of pac on error path]

    int    err = 0;

    if (ipv6_addr_type(addr) & IPV6_ADDR_MULTICAST)
        return -EINVAL;

Start --->
    pac = sock_kmalloc(sk, sizeof(struct ipv6_ac_socklist), GFP_KERNEL);

    ... DELETED 59 lines ...

            dev_put(dev);
            return err;
        }
    } else if (!(ipv6_addr_type(addr) & IPV6_ADDR_ANYCAST) &&
           !capable(CAP_NET_ADMIN))
Error --->
        return -EPERM;

    err = ipv6_dev_ac_inc(dev, addr);
    if (err) {



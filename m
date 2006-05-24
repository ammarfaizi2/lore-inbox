Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932551AbWEXJ2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbWEXJ2z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 05:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbWEXJ2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 05:28:54 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:64355 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932551AbWEXJ2x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 05:28:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=C+BvnBJG5nr1BfsLONPk4VpSOf04NjASDGboUkvIcrIrE1GEQfGMLxEn3mTnip7SzK/vWbwHwTgoPUyKWCDEgPfsxF1eJy2jryuiAaLuVw8T0NttYKmXUlQUMb1/tu6gCAMFys+JOLxAMzp4Zol6aWnz2LvAain0w7YJPyBOcZg=
Message-ID: <6278d2220605240228v576dd66atdad4855b308e64bf@mail.gmail.com>
Date: Wed, 24 May 2006 10:28:52 +0100
From: "Daniel J Blueman" <daniel.blueman@gmail.com>
To: "Stephen Hemminger" <shemminger@osdl.org>
Subject: sky2 hw csum failure [was Re: sky2 large MTU problems]
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Linux Networking" <linux-net@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having done some more stress testing with sky2 1.4 (in 2.6.17-rc4) and
the latest patch, I have found problems when streaming lots of data
out of the sky2 interface (eg via samba serving a large file to GigE
client). Ultimately, the interface will stop sending.

Before this happens, I see lots of:

kernel: lan0: hw csum failure.
kernel:  [__skb_checksum_complete+86/96] __skb_checksum_complete+0x56/0x60
kernel:  [tcp_error+300/512] tcp_error+0x12c/0x200
kernel:  [poison_obj+41/96] poison_obj+0x29/0x60
kernel:  [tcp_error+0/512] tcp_error+0x0/0x200
kernel:  [ip_conntrack_in+157/1072] ip_conntrack_in+0x9d/0x430
kernel:  [kfree_skbmem+8/128] kfree_skbmem+0x8/0x80
kernel:  [arp_process+102/1408] arp_process+0x66/0x580
kernel:  [check_poison_obj+36/416] check_poison_obj+0x24/0x1a0
kernel:  [arp_process+102/1408] arp_process+0x66/0x580
kernel:  [nf_iterate+99/144] nf_iterate+0x63/0x90
kernel:  [ip_rcv_finish+0/608] ip_rcv_finish+0x0/0x260
kernel:  [nf_hook_slow+89/240] nf_hook_slow+0x59/0xf0
kernel:  [ip_rcv_finish+0/608] ip_rcv_finish+0x0/0x260
kernel:  [ip_rcv+386/1104] ip_rcv+0x182/0x450
kernel:  [ip_rcv_finish+0/608] ip_rcv_finish+0x0/0x260
kernel:  [packet_rcv_spkt+216/320] packet_rcv_spkt+0xd8/0x140
kernel:  [netif_receive_skb+476/784] netif_receive_skb+0x1dc/0x310
kernel:  [sky2_poll+879/2096] sky2_poll+0x36f/0x830
kernel:  [_spin_lock_irqsave+9/16] _spin_lock_irqsave+0x9/0x10
kernel:  [run_timer_softirq+290/416] run_timer_softirq+0x122/0x1a0
kernel:  [net_rx_action+108/256] net_rx_action+0x6c/0x100
kernel:  [__do_softirq+66/160] __do_softirq+0x42/0xa0
kernel:  [do_softirq+78/96] do_softirq+0x4e/0x60
kernel:  =======================
kernel:  [do_IRQ+90/160] do_IRQ+0x5a/0xa0
kernel:  [remove_vma+69/80] remove_vma+0x45/0x50
kernel:  [common_interrupt+26/32] common_interrupt+0x1a/0x20
kernel:  [get_offset_pmtmr+151/3584] get_offset_pmtmr+0x97/0xe00
kernel:  [do_gettimeofday+26/208] do_gettimeofday+0x1a/0xd0
kernel:  [sys_gettimeofday+26/144] sys_gettimeofday+0x1a/0x90
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

One of these was preceeded by:

kernel: sky2 lan0: rx error, status 0x977d977d length 0

This was happening with the default MTU of 1500, not just at MTU size
9000 (but it was changed down from 9000). Hardware is Yukon-EC (0xb6)
rev 1.

I'll do some more stress testing tonight without the MTU patch and
without the MTU being raised to 9000 initially and see what happens.

Thanks for all your great work so far!

On 23/05/06, Daniel J Blueman <daniel.blueman@gmail.com> wrote:
> Hi Stephen,
>
> I can confirm that I am unable to reproduce any of the problems I was
> seeing - it works as expected all the way up to the sky2 maximum MTU
> size of 9000. Fantastic!
>
> Thanks again,
>   Daniel
>
> On 22/05/06, Stephen Hemminger <shemminger@osdl.org> wrote:
> > Try this, not completely baked yet though..
> >
> > --- sky2.orig/drivers/net/sky2.c        2006-05-22 10:23:51.000000000 -0700
> > +++ sky2/drivers/net/sky2.c     2006-05-22 11:30:50.000000000 -0700
> > @@ -636,8 +636,10 @@
> >                     TX_BACK_OFF_LIM(TX_BOF_LIM_DEF));
> >
> >         /* serial mode register */
> > -       reg = DATA_BLIND_VAL(DATA_BLIND_DEF) |
> > -               GM_SMOD_VLAN_ENA | IPG_DATA_VAL(IPG_DATA_DEF);
> > +       reg = DATA_BLIND_VAL(DATA_BLIND_DEF) |IPG_DATA_VAL(IPG_DATA_DEF);
> > +#ifdef SKY2_VLAN_TAG_USED
> > +       reg |= GM_SMOD_VLAN_ENA;
> > +#endif
> >
> >         if (hw->dev[port]->mtu > ETH_DATA_LEN)
> >                 reg |= GM_SMOD_JUMBO_ENA;
> > @@ -979,6 +981,7 @@
> >         struct sky2_hw *hw = sky2->hw;
> >         unsigned rxq = rxqaddr[sky2->port];
> >         int i;
> > +       unsigned thresh;
> >
> >         sky2->rx_put = sky2->rx_next = 0;
> >         sky2_qset(hw, rxq);
> > @@ -1003,9 +1006,22 @@
> >                 sky2_rx_add(sky2, re->mapaddr);
> >         }
> >
> > -       /* Truncate oversize frames */
> > -       sky2_write16(hw, SK_REG(sky2->port, RX_GMF_TR_THR), sky2->rx_bufsize - 8);
> > -       sky2_write32(hw, SK_REG(sky2->port, RX_GMF_CTRL_T), RX_TRUNC_ON);
> > +
> > +       /*
> > +        * The receiver hangs gets stuck if it receives frames larger than the
> > +        * packet buffer. As a workaround, truncate oversize frames, but
> > +        * truncate register is to 9 bits, so if you do jumbo frames
> > +        * you better get the MTU right.
> > +        */
> > +       thresh = (ALIGN(sky2->netdev->mtu + ETH_HLEN, 4)  - 8)/4;
> > +
> > +       if (thresh > 0x1ff)
> > +               sky2_write32(hw, SK_REG(sky2->port, RX_GMF_CTRL_T), RX_TRUNC_OFF);
> > +       else {
> > +               sky2_write16(hw, SK_REG(sky2->port, RX_GMF_TR_THR), thresh);
> > +               sky2_write32(hw, SK_REG(sky2->port, RX_GMF_CTRL_T), RX_TRUNC_ON);
> > +       }
> > +
> >
> >         /* Tell chip about available buffers */
> >         sky2_write16(hw, Y2_QADDR(rxq, PREF_UNIT_PUT_IDX), sky2->rx_put);
> > @@ -1754,7 +1770,7 @@
> >   */
> >  static inline unsigned sky2_buf_size(int mtu)
> >  {
> > -       return ALIGN(mtu + ETH_HLEN + VLAN_HLEN, 8) + 8;
> > +       return ALIGN(mtu + ETH_HLEN, 8) + 8;
> >  }
> >
> >  static int sky2_change_mtu(struct net_device *dev, int new_mtu)
> > @@ -1792,8 +1808,10 @@
> >
> >         dev->mtu = new_mtu;
> >         sky2->rx_bufsize = sky2_buf_size(new_mtu);
> > -       mode = DATA_BLIND_VAL(DATA_BLIND_DEF) |
> > -               GM_SMOD_VLAN_ENA | IPG_DATA_VAL(IPG_DATA_DEF);
> > +       mode = DATA_BLIND_VAL(DATA_BLIND_DEF) |IPG_DATA_VAL(IPG_DATA_DEF);
> > +#ifdef SKY2_VLAN_TAG_USED
> > +       mode |= GM_SMOD_VLAN_ENA;
> > +#endif
> >
> >         if (dev->mtu > ETH_DATA_LEN)
> >                 mode |= GM_SMOD_JUMBO_ENA;
-- 
Daniel J Blueman

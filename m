Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbUBYIzy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 03:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbUBYIzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 03:55:54 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:19626 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262366AbUBYIzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 03:55:50 -0500
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: Manfred Spraul <manfred@colorfullife.com>
Date: Wed, 25 Feb 2004 19:55:18 +1100
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.6.3 Slab corruption: errors are triggered when memory exceeds 2.5GB (correction)
Message-ID: <20040225085518.GA23673@cse.unsw.EDU.AU>
References: <403AF155.1080305@colorfullife.com> <20040223225659.4c58c880.akpm@osdl.org> <403B8C78.2020606@colorfullife.com> <20040225005804.GE18070@cse.unsw.EDU.AU> <403C3F04.20601@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403C3F04.20601@colorfullife.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manfred

The nic is Intel e100pro onboard card.
Interestingly the following allocation that has caught
my attention is this:

static inline struct RxFD *speedo_rx_alloc(struct net_device *dev, int entry)
{
	struct speedo_private *sp = (struct speedo_private *)dev->priv;
	struct RxFD *rxf;
	struct sk_buff *skb;
	/* Get a fresh skbuff to replace the consumed one. */
	skb = dev_alloc_skb(PKT_BUF_SZ + sizeof(struct RxFD));

This allocation on ia64 is 1500 bytes, and as I have explained in
later e-mails when I use the Intel e100 driver the slab corruption
goes away.

So I am guessing that it may be in the eepro100 driver.

Darren



On Wed, 25 Feb 2004, Manfred Spraul wrote:

> Darren Williams wrote:
> 
> >Hi Manfred
> >
> >I have updated to the latest bk and new output can be found at:
> >http://quasar.cse.unsw.edu.au/~dsw/public-files/lemon-debug/
> >kern-log-bk
> >
> >Also I am quite confident that it is not a hardware problem.
> >
> >I took a look at alloc_skb(..) and there is a reference to
> >an atomic_t token with this being the most suspect
> >
> >150> atomic_set(&(skb_shinfo(skb)->dataref), 1);
> > 
> >
> I don't think so:
> The allocation that generates the error is skb->head: The cache name is 
> "size-2048", thus the allocation is a kmalloc(1000-2000, probably 1536 
> for one eth frame). The skb itself is allocated from the skbuff_head_cache.
> 
> I don't see a pattern in the virtual addresses:
> start=e000000101ee09a0, len=2048
> start=e000000101ee09a0, len=2048
> start=e000000101ee11b8, len=2048
> start=e000000101ee19d0, len=2048
> start=e000000101ee3218, len=2048
> start=e00000017eed1b90, len=2048
> start=e00000017eed23a8, len=2048
> start=e00000017eed2bc0, len=2048
> start=e00000017eed4308, len=2048
> start=e00000017eed5338, len=2048
> start=e00000017eed5338, len=2048
> start=e00000017eed5b50, len=2048
> start=e00000017eed5b50, len=2048
> start=e00000017eed6b80, len=2048
> start=e00000017eed82c8, len=2048
> start=e00000017eedc288, len=2048
> start=e00000017eedcaa0, len=2048
> start=e00000017eeddad0, len=2048
> start=e00000017eede2e8, len=2048
> start=e00000017eedeb00, len=2048
> start=e00000017ef60a60, len=2048
> start=e00000017ef61a90, len=2048
> start=e00000017ef622a8, len=2048
> start=e00000017ef62ac0, len=2048
> start=e00000017ef632d8, len=2048
> start=e00000017ef65a50, len=2048
> start=e00000017ef65a50, len=2048
> start=e00000017ef65a50, len=2048
> start=e00000017ef66a80, len=2048
> 
> That virtually rules out a bad memory chip.
> 
> But the corrupted byte is always at offset 0x620 into the allocation:
> Slab corruption: start=e00000017ef65a50, len=2048
> 620: 6a 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> --
> Slab corruption: start=e000000101ee19d0, len=2048
> 620: 6a 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> --
> Slab corruption: start=e000000101ee3218, len=2048
> 620: 6a 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> --
> Slab corruption: start=e00000017ef66a80, len=2048
> 620: 6a 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> --
> Slab corruption: start=e000000101ee11b8, len=2048
> 620: 6a 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> 
> 0x620 (1568) is behind the end of the actual eth frame. Who could modify 
> that?
> 
> Darren, which nic do you use? Could you try what happens if you reduce 
> the MTU?
> 
> --
>    Manfred
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263118AbSJCHmY>; Thu, 3 Oct 2002 03:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263173AbSJCHmY>; Thu, 3 Oct 2002 03:42:24 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:1810 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S263118AbSJCHmX>; Thu, 3 Oct 2002 03:42:23 -0400
Message-Id: <200210030743.g937hBp01523@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Francois Romieu <romieu@cogenit.fr>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cli()/sti() fix for drivers/net/depca.c
Date: Thu, 3 Oct 2002 10:37:03 -0200
X-Mailer: KMail [version 1.3.2]
References: <200210022005.g92K5Fp31816@Port.imtp.ilyichevsk.odessa.ua> <200210022133.g92LX0p32156@Port.imtp.ilyichevsk.odessa.ua> <20021003001228.A18629@fafner.intra.cogenit.fr>
In-Reply-To: <20021003001228.A18629@fafner.intra.cogenit.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 October 2002 20:12, Francois Romieu wrote:
> Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> :
> [...]
>
> > Ho to do it properly? Make a copy on stack under lock, release
> > lock, proceed with copy_to_user? That's 88 bytes at least...
>
> Please see ETHTOOL_GSTATS usage in drivers/net/8139cp.c.

This:
                tmp_stats = kmalloc(sz, GFP_KERNEL);
                if (!tmp_stats) return -ENOMEM;
                memset(tmp_stats, 0, sz);

                i = 0;
                tmp_stats[i++] = le64_to_cpu(cp->nic_stats->tx_ok);
                tmp_stats[i++] = le64_to_cpu(cp->nic_stats->rx_ok);
		...
                tmp_stats[i++] = le16_to_cpu(cp->nic_stats->tx_underrun);
                tmp_stats[i++] = cp->cp_stats.rx_frags;
                if (i != CP_NUM_STATS) BUG();

                i = copy_to_user(useraddr + sizeof(estats), tmp_stats, sz);
                kfree(tmp_stats);

kmalloc() isn't very fast, but I suppose ioctl is not that critical.

> > > - on SMP, pktStat can be updated while the copy progresses, see
> > > depca_rx().
> >
> > Should I place these pktStat updates under lp->lock?
>
> You may.
>
> depca_rx() looks strange:
> buf = skb_put(skb, len);
> [...]
> netif_rx(skb);
> [...]
> if (buf[0] & ...)

I'd say this network stuff is a bit cryptic for untrained eye :-)
What's strange with that code?

BTW, is there some (downloadable) book on Linux networking
internals?
--
vda

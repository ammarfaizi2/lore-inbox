Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbWEWVw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWEWVw2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 17:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWEWVw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 17:52:28 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:39256 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932401AbWEWVw1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 17:52:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fxXJBJUWfI41MosB4jip7nfBfM7DDWCZ4toKo1wAMUTKtwO8vsn9PmlKxaY1o0eUk/kWFkrk4lvaFc12UIQiMEiARbXScOMoG2uHd15U6ILsz5Kmdlh/y5Rckwck9g/iEiDglwj7vyk+69sU6uT354+13ECTNJEilO54AcbxheU=
Message-ID: <6278d2220605231452y48fbd4e0nf02cdf1d9c35dc84@mail.gmail.com>
Date: Tue, 23 May 2006 22:52:24 +0100
From: "Daniel J Blueman" <daniel.blueman@gmail.com>
To: "Stephen Hemminger" <shemminger@osdl.org>
Subject: Re: sky2 large MTU problems...
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Linux Networking" <linux-net@vger.kernel.org>
In-Reply-To: <20060522113545.52d74499@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6278d2220605190922v4fd3f947ia4c60f01884731e7@mail.gmail.com>
	 <6278d2220605220357p68600cc5qae86a501ccabf15d@mail.gmail.com>
	 <20060522113545.52d74499@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

I can confirm that I am unable to reproduce any of the problems I was
seeing - it works as expected all the way up to the sky2 maximum MTU
size of 9000. Fantastic!

Thanks again,
  Daniel

On 22/05/06, Stephen Hemminger <shemminger@osdl.org> wrote:
> Try this, not completely baked yet though..
>
> --- sky2.orig/drivers/net/sky2.c        2006-05-22 10:23:51.000000000 -0700
> +++ sky2/drivers/net/sky2.c     2006-05-22 11:30:50.000000000 -0700
> @@ -636,8 +636,10 @@
>                     TX_BACK_OFF_LIM(TX_BOF_LIM_DEF));
>
>         /* serial mode register */
> -       reg = DATA_BLIND_VAL(DATA_BLIND_DEF) |
> -               GM_SMOD_VLAN_ENA | IPG_DATA_VAL(IPG_DATA_DEF);
> +       reg = DATA_BLIND_VAL(DATA_BLIND_DEF) |IPG_DATA_VAL(IPG_DATA_DEF);
> +#ifdef SKY2_VLAN_TAG_USED
> +       reg |= GM_SMOD_VLAN_ENA;
> +#endif
>
>         if (hw->dev[port]->mtu > ETH_DATA_LEN)
>                 reg |= GM_SMOD_JUMBO_ENA;
> @@ -979,6 +981,7 @@
>         struct sky2_hw *hw = sky2->hw;
>         unsigned rxq = rxqaddr[sky2->port];
>         int i;
> +       unsigned thresh;
>
>         sky2->rx_put = sky2->rx_next = 0;
>         sky2_qset(hw, rxq);
> @@ -1003,9 +1006,22 @@
>                 sky2_rx_add(sky2, re->mapaddr);
>         }
>
> -       /* Truncate oversize frames */
> -       sky2_write16(hw, SK_REG(sky2->port, RX_GMF_TR_THR), sky2->rx_bufsize - 8);
> -       sky2_write32(hw, SK_REG(sky2->port, RX_GMF_CTRL_T), RX_TRUNC_ON);
> +
> +       /*
> +        * The receiver hangs gets stuck if it receives frames larger than the
> +        * packet buffer. As a workaround, truncate oversize frames, but
> +        * truncate register is to 9 bits, so if you do jumbo frames
> +        * you better get the MTU right.
> +        */
> +       thresh = (ALIGN(sky2->netdev->mtu + ETH_HLEN, 4)  - 8)/4;
> +
> +       if (thresh > 0x1ff)
> +               sky2_write32(hw, SK_REG(sky2->port, RX_GMF_CTRL_T), RX_TRUNC_OFF);
> +       else {
> +               sky2_write16(hw, SK_REG(sky2->port, RX_GMF_TR_THR), thresh);
> +               sky2_write32(hw, SK_REG(sky2->port, RX_GMF_CTRL_T), RX_TRUNC_ON);
> +       }
> +
>
>         /* Tell chip about available buffers */
>         sky2_write16(hw, Y2_QADDR(rxq, PREF_UNIT_PUT_IDX), sky2->rx_put);
> @@ -1754,7 +1770,7 @@
>   */
>  static inline unsigned sky2_buf_size(int mtu)
>  {
> -       return ALIGN(mtu + ETH_HLEN + VLAN_HLEN, 8) + 8;
> +       return ALIGN(mtu + ETH_HLEN, 8) + 8;
>  }
>
>  static int sky2_change_mtu(struct net_device *dev, int new_mtu)
> @@ -1792,8 +1808,10 @@
>
>         dev->mtu = new_mtu;
>         sky2->rx_bufsize = sky2_buf_size(new_mtu);
> -       mode = DATA_BLIND_VAL(DATA_BLIND_DEF) |
> -               GM_SMOD_VLAN_ENA | IPG_DATA_VAL(IPG_DATA_DEF);
> +       mode = DATA_BLIND_VAL(DATA_BLIND_DEF) |IPG_DATA_VAL(IPG_DATA_DEF);
> +#ifdef SKY2_VLAN_TAG_USED
> +       mode |= GM_SMOD_VLAN_ENA;
> +#endif
>
>         if (dev->mtu > ETH_DATA_LEN)
>                 mode |= GM_SMOD_JUMBO_ENA;
>
-- 
Daniel J Blueman

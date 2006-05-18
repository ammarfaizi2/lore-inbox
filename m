Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWERHCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWERHCe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 03:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWERHCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 03:02:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:61570 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751286AbWERHCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 03:02:33 -0400
Subject: RE: [PATCH/2.6.17-rc4 10/10]  bugs fix for marvell SATA on powerp
	c pl atform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Alexandre.Bounine@tundra.com,
       Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
       Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD46730626DE6E@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD46730626DE6E@zch01exm40.ap.freescale.net>
Content-Type: text/plain; charset=utf-8
Date: Thu, 18 May 2006 17:02:14 +1000
Message-Id: <1147935734.17679.93.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-18 at 12:03 +0800, Zang Roy-r61911 wrote:
> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: 2006年5月17日 21:28
> To: Zang Roy-r61911
> Cc: Paul Mackerras; linuxppc-dev list; Alexandre.Bounine@tundra.com; Yang Xin-Xin-r48390
> Subject: Re: [PATCH/2.6.17-rc4 10/10] bugs fix for marvell SATA on powerpc pl atform

Copying here the comments I already made so Jeff gets them...

> @@ -1032,6 +1032,9 @@ static inline void mv_crqb_pack_cmd(u16 
>  {
>       *cmdw = data | (addr << CRQB_CMD_ADDR_SHIFT) | CRQB_CMD_CS |
>               (last ? CRQB_CMD_LAST : 0);
> +#ifdef CONFIG_PPC
> +     *cmdw = cpu_to_le16(*cmdw);
> +#endif
>  }

Why an ifdef here ? The cpu_to_le16 should probably be unconditional.
And even if for some weird reason you wanted to ifdef it, why PPC ? and
what about other BE architectures ?
 
>  /**
> @@ -1567,13 +1570,18 @@ static void mv5_read_preamp(struct mv_ho
>  static void mv5_enable_leds(struct mv_host_priv *hpriv, void __iomem
*mmio)
>  {
>       u32 tmp;
> -
> +#ifndef CONFIG_PPC
>       writel(0, mmio + MV_GPIO_PORT_CTL);
> +#endif

You'll have to do better here too... I don't wee why when compiled on
PPC, this driver should "magically" not clear those bits... At the very
least, you should test the machine type if you want to do something
specific to your platform, but first, you'll have to convince Jeff why
this change has to be done in the first place and if there is a better
way to handle it.

>       /* FIXME: handle MV_HP_ERRATA_50XXB2 errata */
>  
>       tmp = readl(mmio + MV_PCI_EXP_ROM_BAR_CTL);
> +#ifdef CONFIG_PPC
> +     tmp &= ~(1 << 0);
> +#else        
>       tmp |= ~(1 << 0);
> +#endif
>       writel(tmp, mmio + MV_PCI_EXP_ROM_BAR_CTL);
>  }

Looks to me like the initial code was bogus, thus the #ifdef shouldn't
be necessary neither, and even if it was, an ifdef CONFIG_PPC would be
the wrong approach for what I think should be ovious enough reasons...

Ben.



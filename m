Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVFMVrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVFMVrg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 17:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVFMVrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 17:47:03 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:59829 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261436AbVFMVml
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 17:42:41 -0400
Date: Mon, 13 Jun 2005 23:39:50 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Pascal CHAPPERON <pascal.chapperon@wanadoo.fr>
Cc: Andrew Hutchings <info@a-wing.co.uk>, linux-kernel@vger.kernel.org,
       vinay kumar <b4uvin@yahoo.co.in>, jgarzik@pobox.com
Subject: Re: sis190
Message-ID: <20050613213950.GA8081@electric-eye.fr.zoreil.com>
References: <18320560.1118650748703.JavaMail.www@wwinf1518>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18320560.1118650748703.JavaMail.www@wwinf1518>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pascal CHAPPERON <pascal.chapperon@wanadoo.fr> :
[...]
> NOTE : here is something strange about base address =>
> dmesg :  sis190 at ffffc20000004c00 (IRQ: 11)
> ifconfig :          Interrupt:11 Base address:0xbeef

Don't bother: the base address in the struct netdevice is obsolete. I'll
turn it into 0xdead.

[tcpdump output]
> It seems that sis190 driver shifts 4 bytes...

Ok (it looks like a 2 bytes offset though).

> further test about autoneg, probably silly:
> be nice, as i know nothing to network drivers dev.
> i do not understand what is LPA_SLCT...

Ahem. It was not a great idea from me to convert from 31 to LPA_SLCT
as LPA_SLCT is intended to be a bitmask, not a register shift.

> # diff -puN sis190-20050611a.c sis190.c
> --- sis190-20050611a.c  2005-06-13 08:54:56.000000000 +0200
> +++ sis190.c    2005-06-13 09:41:29.000000000 +0200
[...]
> @@ -823,18 +823,17 @@ static void sis190_phy_task(void * data)
>                         u16 ctl;
>                         const char *msg;
>                 } reg31[] = {
> -                       { _1000bpsF,    0x1c01, "1000 bps Full Duplex" },
> -                       { _1000bpsH,    0x0c01, "1000 bps Half Duplex" },
> -                       { _100bpsF,     0x1801, "100 bps Full Duplex" },
> -                       { _100bpsH,     0x0801, "100 bps Half Duplex" },
> -                       { _10bpsF,      0x1401, "10 bps Full Duplex" },
> -                       { _10bpsH,      0x0401, "10 bps Half Duplex" },
> +                       { LPA_1000XFULL | LPA_SLCT,  0x1c01, "1000 bps Full Duplex" },
> +                       { LPA_1000XHALF | LPA_SLCT,  0x0c01, "1000 bps Half Duplex" },
> +                       { LPA_100FULL,  0x1801, "100 bps Full Duplex" },
> +                       { LPA_100HALF,  0x0901, "100 bps Half Duplex" },
> +                       { LPA_10FULL,   0x1401, "10 bps Full Duplex" },
> +                       { LPA_10HALF,   0x0401, "10 bps Half Duplex" },
>                         { 0,            0x0000, "unknown" }
>                 }, *p;
> -               val = mdio_read(ioaddr, LPA_SLCT) & 0x1c; // bit 4:2
> -
> +               val = mdio_read(ioaddr, MII_LPA);
>                 for (p = reg31; p->ctl; p++) {
> -                       if (val == p->val)
> +                 if ((val &  p->val) == p->val)
>                                 break;
>                 }
>                 if (p->ctl)
[and it works]

Cool. Ok, I take that and I'll sprinkle a few printks here and there.

Can you give a try at:
http://www.fr.zoreil.com/people/francois/misc/20050613-2.6.12-rc-sis190-test.patch

dmesg + ifconfig + tcpdump (please add a -e option) will be welcome as usual.

If the driver starts to behave in an usually better way, please issue
differently sized ping packets to cover the whole allowed range.

--
Ueimor

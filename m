Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280836AbRKGQEk>; Wed, 7 Nov 2001 11:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280830AbRKGQEV>; Wed, 7 Nov 2001 11:04:21 -0500
Received: from mail006.mail.bellsouth.net ([205.152.58.26]:3096 "EHLO
	imf06bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S280828AbRKGQEN>; Wed, 7 Nov 2001 11:04:13 -0500
Message-ID: <3BE95B6E.E4EB1B86@mandrakesoft.com>
Date: Wed, 07 Nov 2001 11:03:58 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        VLAN Mailing List <vlan@Scry.WANfear.com>
Subject: Re: [PATCH] 802.1q-support for 3c59x.c
In-Reply-To: <20011107165318.A15577@devcon.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Ferber wrote:
> 
> Hi,
> 
> I was very pleased that 802.1q VLAN tagging support has been included
> into the kernel recently :-)
> 
> Though this is only part of the work needed.
> 
> Let me start from the beginning, for those not familiar with 802.1q
> tagging. The tag adds an additional header field (4 Bytes) to the
> ethernet header, so that the maximum frame size is 1518 Octets instead
> of 1514 (with a standard MTU of 1500).
> 
> The problem is that most network cards by default will flag those
> frames as oversized and drop them (though /sending/ tagged frames is
> not a problem with any card I know of). There are several
> possibilities to resolve this problem:
> 
> - reduce the MTU on all servers connected to the VLAN (not always
>   possible)
> - patch the NIC driver so that it doesn't drop oversized frames
> - set the MTU on the physical interface to 1504, which is a) not
>   possible with every driver, and b) untagged frames sent via the
>   interface will be oversized now.
> 
> Below my signature you will find a patch that adds the necessary bits
> to the 3c59x.c driver. It sets up the NIC to receive VLAN tagged
> frames and (if supported by the NIC) correctly checksum them.
> 
> Newer cards (those with HW checksumming support) have a register to
> configure the maximum frame size. Older cards don't have this
> register, but they have a flag that lets the NIC receive FDDI sized
> frames (4500 Octets IIRC).
> 
> It was discussed on the VLAN mailinglist if (at least in the case of
> hardware like the old 3Com NICs where you can basically only disable
> checking the frame size) it is feasible to only enable the large
> frame receipt if VLAN tags are really used on the NIC. We have come to
> the conclusion that uncoditionally enabling it should not pose any
> performance penalties with any sane hardware implementation, so we
> decided to not introduce a VLAN enable callback into NIC drivers.
> 
> Just to be sure, the 3c59x patch only enables the new parts if 802.1q
> support has been enabled in the kernel configuration. Testing proved
> the patch quite stable (no problem reports so far).
> 
> There is no maintainer mentioned for the 3c59x driver in the
> MAINTAINERS file, so I send this directly to the list. Please consider
> the patch for kernel inclusion.
> 
> Andreas
> --
>        Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
>      ---------------------------------------------------------
>          +49 521 1365800 - af@devcon.net - www.devcon.net
> 
> --- linux.orig/drivers/net/3c59x.c      Sun Sep 30 21:26:06 2001
> +++ linux/drivers/net/3c59x.c   Wed Oct 24 21:52:10 2001
> @@ -308,6 +308,9 @@
>     code size of a per-interface flag is not worthwhile. */
>  static char mii_preamble_required;
> 
> +/* The Ethernet Type used for 802.1q tagged frames */
> +#define VLAN_ETHER_TYPE 0x8100

This needs to be ETH_P_8021Q from if_ether.h.

Have you tested this?  I should think you would need a dev->change_mtu
also.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno


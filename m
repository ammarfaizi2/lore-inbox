Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131181AbRAGSyC>; Sun, 7 Jan 2001 13:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129994AbRAGSxw>; Sun, 7 Jan 2001 13:53:52 -0500
Received: from mail.zmailer.org ([194.252.70.162]:51470 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S131795AbRAGSxe>;
	Sun, 7 Jan 2001 13:53:34 -0500
Date: Sun, 7 Jan 2001 20:53:15 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ben Greear <greearb@candelatech.com>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
Message-ID: <20010107205315.F25076@mea-ext.zmailer.org>
In-Reply-To: <3A58BD44.1381D182@candelatech.com> <E14FKDI-00033e-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E14FKDI-00033e-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Jan 07, 2001 at 06:06:37PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2001 at 06:06:37PM +0000, Alan Cox wrote:
> > Um, what about people running their box as just a VLAN router/firewall?
> > That seems to be one of the principle uses so far.  Actually, in that case
> > both VLAN and IP traffic would come through, so it would be a tie if VLAN
> > came first, but non-vlan traffic would suffer worse.
> 
> Why would someone filter between vlans when any node on each vlan can happily
> ignore the vlan partitioning

	VLANs are Level-2, that is SWITCHING.

	They have no real meaning unless you have a switching fabric,
	in which they present ways to hard-partition ports to different
	switching domains without having physically separate cabling.

	Normal hosts are connected on non-truncking ports, and only some
	rare systems are connected to 802.1Q trunks so they can access
	multiple VLANs inside the fabric.

	No ordinary hosts are able to choose at which VLANs they are.
	Truncking ports have ways to control which VLANs are allowed
	to go thru them (at least at Cisco hardware I am familiar with).

> > So, how can I make sure that it is second in the list?
> 
> Register vlan in the top level protocol hash then have that yank the header
> and feed the packets through the hash again.

	That is what the two existing VLAN codes for Linux do now.

	Better(?) way could be to have a way to have device specific
	reception vector in addition to xmit vector.  That way we could
	stack "Layer-2 protocols", like 802.1Q and (to an extent) even
	802 bridging.

	See  ftp://zmailer.org/linux/netif_rx.patch

	After all, if you have a way to plumb reception to an optional
	bridging layer, you propably would not need netif_rx() contained
	bridging code.

> > > Question: How do devices with hardware vlan support fit into your model ?
> > I don't know of any, and I'm not sure how they would be supported.
> 
> Several cards have vlan ability, but Matti reports they just lose the header
> not filter on it if I understood him

	No you didn't understand.

	Nothing is lost, it relates to hardware assisted received
	IP frame TCP/UDP checksumming by the network cards.  Some
	cards support that, some support it even in presense of
	802.1Q TAG header.

	I don't yet see any cards which have hardware assist for
	IPv6 checksumming.  VLAN tags or not.

	Reception must handle at first tearing off the VLAN header
	when receiving the frame, then return back to  netif_rx()
	to see what was inside - SNAP frame, IPv4 frame, whatever.

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

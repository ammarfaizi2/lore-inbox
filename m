Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262805AbSJWDoZ>; Tue, 22 Oct 2002 23:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262814AbSJWDoZ>; Tue, 22 Oct 2002 23:44:25 -0400
Received: from pcp470010pcs.westk01.tn.comcast.net ([68.47.207.140]:48797 "EHLO
	shed.7house.org") by vger.kernel.org with ESMTP id <S262805AbSJWDoY>;
	Tue, 22 Oct 2002 23:44:24 -0400
Message-ID: <3DB61C87.77AAE742@y12.doe.gov>
Date: Tue, 22 Oct 2002 23:50:31 -0400
From: David Dillow <dillowd@y12.doe.gov>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@rth.ninka.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3COM 3C990 NIC
References: <1035002976.3086.4.camel@maranello.interclypse.net> 
		<3DB4D9F8.F86ABA4@y12.doe.gov> <1035328421.16085.21.camel@rth.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> On Mon, 2002-10-21 at 21:54, David Dillow wrote:
> > It will support zero-copy TCP, TCP segmentation offload, and when DaveM's
> > IPSEC is in, I'll be able to do hardware offload for that as well.
> 
> Please tell me what the interface is to offload IPSEC transformations
> to the card.  What information does the card need to properly transform
> the packet and what transforms are supported?

The card was designed with NDIS 5.0 task offloading in mind. The documents for
that (in the NT DDK) will give you an overview of where they're going; I'll
try to provide more detail here.

The cards support varying levels of encryption, depending on the model. Some
support no encryption, some only DES, and some Triple DES. We can query the
card to determine what it supports. Those cards that support DES or 3DES
support the MD5 and SHA1 hashes.

The cards support IPSEC packets in the following modes:
1. [IP1][AH][payload]
2. [IP1][ESP][payload]
3. [IP1][AH][ESP][payload]
4. [IP2][AH][IP1][payload]
5. [IP2][AH][IP1][payload]
6. [IP2][AH][ESP][payload]

where payload can be any type of data, including more nested levels of IPSEC,
as long as they have been encrpyted/hashed by the host.

There may be other modes supported; the documentation I have for the cards is
inconsistent in some places, and flat out wrong in others. Experimentation is
needed to be sure of what is supported beyond the above.

Only IPv4 is supported at this time, IPv6 is not supported (maybe in a later
firmware). IP options are supported, while fragments are not. They will be
passed through without processing. The adapter can do scatter gather,
checksumming, TSO, VLAN insertion, and IPSEC on the same packet.

The IPSEC engine must register a Security Association with the card before we
can offload the crypto. While NDIS supports a fair number of selectors for
SA's, the Typhoon cards only key off of the destination address and SPI for
inbound packets. For Tx processing, an opaque handle must be passed to the
adapter identifying the SA to be used to process the packet.

Once again, future releases of the firmware may be able to do more for us, but
I wouldn't count on it, nor would it necessarily be desirable.

On Tx, we must add space for the AH and/or ESP headers and any needed padding,
and fill in the SPI and Next Header fields. For ESP, the adapter will fill in
the IV from its hardware random number generator (this feature may be
selectable.)

To register an SA, we need to provide the adapter with the protocol (NULL, AH,
or ESP), the hash type (MD5 or SHA1), the direction for this SA (Tx or Rx),
the encryption type (None, DES, 2 key 3DES, 3 key 3DES, ECB or CBC), the SPI,
the dest address and mask, and the keying material. The card will give us a 16
bit handle. If we are to nest as in mode 3 or 6 above, we pass in both SA's to
the driver, which will return a 32 bit handle. The handle will be zero if a
problem occurs. We can query the maximum number of SA's supported. To delete
an SA, we give the card the handle it gave us. For Tx, we must pass the handle
in as part of the Tx descriptor.

On Rx, the card will lookup the destination/mask and SPI in its tables, and if
it finds an SA for the packet, will attempt to decrypt it and verify the hash.
It will put the results of this processing in the Rx descriptor it passes to
the host.

> Currently there are no plans for an offload strategy, because we lack
> knowledge in the area of exactly what cards provide.

Hopefully, the above will help. The NDIS docs have been pretty useful as well.

Dave

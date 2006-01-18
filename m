Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030381AbWARQcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030381AbWARQcu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 11:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030382AbWARQct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 11:32:49 -0500
Received: from rrcs-24-73-230-86.se.biz.rr.com ([24.73.230.86]:4796 "EHLO
	shaft.shaftnet.org") by vger.kernel.org with ESMTP id S1030381AbWARQcs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 11:32:48 -0500
Date: Wed, 18 Jan 2006 11:32:07 -0500
From: Stuffed Crust <pizza@shaftnet.org>
To: Stefan Rompf <stefan@loplof.de>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       "John W. Linville" <linville@tuxdriver.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues (other issues / fake ethernet)
Message-ID: <20060118163207.GB27180@shaftnet.org>
Mail-Followup-To: Stefan Rompf <stefan@loplof.de>,
	Jeff Garzik <jgarzik@pobox.com>,
	"John W. Linville" <linville@tuxdriver.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060113195723.GB16166@tuxdriver.com> <43C97693.7000109@pobox.com> <20060115153920.GB1722@shaftnet.org> <200601180036.10500.stefan@loplof.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline
In-Reply-To: <200601180036.10500.stefan@loplof.de>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.0.2 (shaft.shaftnet.org [127.0.0.1]); Wed, 18 Jan 2006 11:32:08 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2006 at 12:36:09AM +0100, Stefan Rompf wrote:
> prism2 usb is even worse - the urb is build of some control structure, th=
e=20
> 802.11 3 address header, a 802.3 header and the 802.11 data part. Some bi=
ts=20
> in the control structure decide whether the 802.11 or the 802.3 header is=
=20
> used to create the frame sent to the air.

I actually maintain a prism2 usb driver.  It's host interface is truly
fscked, and then there are the unfixable hardware bugs... But back to
your point -- It's actually true of all prism2 devices.  You can use one
header or the other, but space for both is part of the fixed packet
structure.=20

Meanwhile, I've only seen one wireless chipset that *requires* 802.3
headers, and that is the prism54/prismGT/Indigo/Duette (FullMAC mode).=20
Those adapters (except for the Indigo, which never made it into=20
production anyway) can run in a softmac mode, which uses regular 802.11=20
headers.

It's actually fairly common that hardware devices have the 802.11 header=20
separated from the 802.11 payload slightly, if for no other reason that=20
they need space to add the encryption headers.  You can't make any=20
assumptions.
=20
> Fortunately, a driver should be able to specify it's additional memory ne=
ed at=20
> the front of the frame via hard_header_len. Some drivers will need to do =
some=20
> ugly memmove()s at the packet begin then.

This amount also varies with different encryption modes.  And don't
forget you also need space for an LLC+SNAP header and finally, you need
a frame footer for encryption as well.=20

> .. and it gets even worse as soon as we start encrypting packets. I think=
 we=20
> should start using the netdev wiki at http://linux-net.osdl.org/ to colle=
ct=20
> information. For this part of the discussion, we need to know what transm=
it=20
> frame formats different hardware needs.

They're all over the map, yes.. there's no guarantee that the frame will
be contiguious.  It's annoying.. They also vary depending on encrpytion
mode.  Keep the 802.11 stack generic; split the packet into its logical
block.

On a per-frame basis, you have:

 - 802.11 header (variable length)
 - Encryption header (variable length)
 - LLC+SNAP header on payload (which we may need to add)
   - actual payload
 - Encryption footer (variable length)

How's this strawman proposal:

wiphy_frame_xmit (struct wiphy_dev *dev, struct sk_buff *skb);

skb->data points to the raw payload, with LLC+SNAP header.
skb->cb points to a structure that has, among other things:
  - 802.11 header + length
  - encryption header + length
  - encryption footer + length
  - desired data rate(s), antenna, rts/cts, and other tx params.
  - hw/sw encryption flag, and the key needed to encrypt.

Given that I haven't seen two chipsets that do thigns the same way,
there's little point in making the stack generic enough to rearrange
these bits in the correct places. That said, we could provide a generic
coalesce method for the general swcrypto+payload case, where the
hardware would presumably treat it as an opaque payload.

Each driver would be responsible for rearranging these chunks as
appropriate, ideally using scatter-gather DMA.  That's why the chunks
are all specified as chunk+len; the driver can blindly copy the chunks
without worrying about their contents.

Chipsets that require payload padding when using crypto can tell the
802.11 stack of this requirement, and the stack will pass the
appropriate pads in via the crypt_header and crypt_footer.

I've put this stuff on the wiki, for what it's worth.

 - Solomon=20
--=20
Solomon Peachy        				 ICQ: 1318344
Melbourne, FL 					=20
Quidquid latine dictum sit, altum viditur.

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDzm2HPuLgii2759ARArr1AKDW2mstKSWRHkmFVM8GpeD+bDoz5gCeLYLS
haFIBKisUF0HF/ogey1wjPE=
=ohI2
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--

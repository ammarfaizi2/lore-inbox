Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWJJN3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWJJN3s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 09:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWJJN3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 09:29:48 -0400
Received: from orca.ele.uri.edu ([131.128.51.63]:26553 "EHLO orca.ele.uri.edu")
	by vger.kernel.org with ESMTP id S1750739AbWJJN3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 09:29:47 -0400
Date: Tue, 10 Oct 2006 09:29:43 -0400
From: Will Simoneau <simoneau@ele.uri.edu>
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [sparc64] 2.6.18 unaligned accesses in eth1394
Message-ID: <20061010132943.GB18539@ele.uri.edu>
Mail-Followup-To: David Miller <davem@davemloft.net>,
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20061005211543.GA18539@ele.uri.edu> <20061009.183607.63736982.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <20061009.183607.63736982.davem@davemloft.net>
User-Agent: Mutt/1.5.13 [Linux 2.6.18 sparc64]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18:36 Mon 09 Oct     , David Miller wrote:
> From: Will Simoneau <simoneau@ele.uri.edu>
> Date: Thu, 5 Oct 2006 17:15:44 -0400
>=20
> > The first one I seem to be able to fix by adding a get_unaligned() at
> > lines 1679-1680 of eth1394.c around eth->h_dest; the second one seems to
> > be triggered by this code:
>=20
> Right.
>=20
> > (gdb) list *ether1394_data_handler+0x914
> > 0xc94 is in ether1394_data_handler (drivers/ieee1394/eth1394.c:1264).
> > 1259        priv->stats.rx_dropped++;
> > 1260        dev_kfree_skb_any(skb);
> > 1261        goto bad_proto;
> > 1262     }
> > 1263 =20
> > 1264     if (netif_rx(skb) =3D=3D NET_RX_DROP) {
> > 1265        priv->stats.rx_errors++;
> > 1266        priv->stats.rx_dropped++;
> > 1267        goto bad_proto;
> > 1268     }
>=20
> Actually, I think this one is in eth1394_parse_encap().
>=20
> Can you test this patch and tell me if it makes both unaligned
> access problems go away?  Thanks.
>=20
> diff --git a/drivers/ieee1394/eth1394.c b/drivers/ieee1394/eth1394.c
> index 8a7b8fa..78abb9b 100644
> --- a/drivers/ieee1394/eth1394.c
> +++ b/drivers/ieee1394/eth1394.c
> @@ -64,6 +64,7 @@ #include <linux/bitops.h>
>  #include <linux/ethtool.h>
>  #include <asm/uaccess.h>
>  #include <asm/delay.h>
> +#include <asm/unaligned.h>
>  #include <net/arp.h>
> =20
>  #include "config_roms.h"
> @@ -894,6 +895,7 @@ static inline u16 ether1394_parse_encap(
>  		u16 maxpayload;
>  		struct eth1394_node_ref *node;
>  		struct eth1394_node_info *node_info;
> +		__be64 guid;
> =20
>  		/* Sanity check. MacOSX seems to be sending us 131 in this
>  		 * field (atleast on my Panther G5). Not sure why. */
> @@ -902,8 +904,9 @@ static inline u16 ether1394_parse_encap(
> =20
>  		maxpayload =3D min(eth1394_speedto_maxpayload[sspd], (u16)(1 << (max_r=
ec + 1)));
> =20
> +		guid =3D get_unaligned(&arp1394->s_uniq_id);
>  		node =3D eth1394_find_node_guid(&priv->ip_node_list,
> -					      be64_to_cpu(arp1394->s_uniq_id));
> +					      be64_to_cpu(guid));
>  		if (!node) {
>  			return 0;
>  		}
> @@ -1675,8 +1678,9 @@ #endif
>  		if (max_payload < dg_size + hdr_type_len[ETH1394_HDR_LF_UF])
>  			priv->bc_dgl++;
>  	} else {
> +		__be64 guid =3D get_unaligned((u64 *)eth->h_dest);
>  		node =3D eth1394_find_node_guid(&priv->ip_node_list,
> -					      be64_to_cpu(*(u64*)eth->h_dest));
> +					      be64_to_cpu(guid));
>  		if (!node) {
>  			ret =3D -EAGAIN;
>  			goto fail;


I still get:

Kernel unaligned access at TPC[10162164] ether1394_reset_priv+0x2c/0xe0 [et=
h1394]
Kernel unaligned access at TPC[10163148] ether1394_data_handler+0xdd0/0x106=
0 [eth1394]

The second one triggers on every packet received, the first only triggers o=
nce in a while.

If you want more gdb info or a disassembly just ask.

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFK6BHLYBaX8VDLLURAou4AKCP+dLhhxIaieQcDMwDJPZnYcmJBACeMYGl
tsDKdm5RNpEYetPwM7NjC4s=
=kMBq
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--

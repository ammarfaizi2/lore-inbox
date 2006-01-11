Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbWAKIgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWAKIgE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 03:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWAKIgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 03:36:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25032 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751385AbWAKIgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 03:36:02 -0500
Message-ID: <43C4C37B.9020801@redhat.com>
Date: Wed, 11 Jan 2006 00:36:11 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mail/News 1.5 (X11/20060103)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: ntohs/ntohl and bitops
References: <43C42F0C.10008@redhat.com>	 <20060111.000020.25886635.davem@davemloft.net> <1136967192.2929.6.camel@laptopd505.fenrus.org>
In-Reply-To: <1136967192.2929.6.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.93.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF74EA122520493701AFAE019"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF74EA122520493701AFAE019
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arjan van de Ven wrote:
> why this __constant_htons and not just plain htons ??
> htons() gets auto-remapped to that anyway via the builtin "is this a
> constant" thing...... and to be honest htons() is more readable.

Indeed, why the need for the uglification?

Anyway, candidates for this kind of transformation:

net/ipx/af_ipx.c:1450:  if (ntohs(addr->sipx_port) <
IPX_MIN_EPHEMERAL_SOCKET &&
net/atm/br2684.c:308:   if (ntohs(eth->h_proto) >=3D 1536)
net/ipv6/netfilter/ip6t_LOG.c:114:                      if
(ntohs(fh->frag_off) & 0xFFF8)
net/ipv6/exthdrs_core.c:89:                     if (ntohs(*fp) & ~0x7)
net/ipv4/ipmr.c:1182:   if (skb->len+encap > dst_mtu(&rt->u.dst) &&
(ntohs(iph->frag_off) & IP_DF)) {
net/ipv4/netfilter/ip_conntrack_helper_pptp.c:710:      if
(ntohs(pptph->packetType) !=3D PPTP_PACKET_CONTROL ||
net/ipv4/netfilter/ipt_LOG.c:70:        if (ntohs(ih->frag_off) & IP_CE)
net/ipv4/netfilter/ipt_LOG.c:72:        if (ntohs(ih->frag_off) & IP_DF)
net/ipv4/netfilter/ipt_LOG.c:74:        if (ntohs(ih->frag_off) & IP_MF)
net/ipv4/netfilter/ipt_LOG.c:78:        if (ntohs(ih->frag_off) & IP_OFFS=
ET)
net/ipv4/netfilter/ipt_LOG.c:108:               if (ntohs(ih->frag_off)
& IP_OFFSET)
net/ipv4/netfilter/ipt_LOG.c:180:               if (ntohs(ih->frag_off)
& IP_OFFSET)
net/ipv4/netfilter/ipt_LOG.c:221:               if (ntohs(ih->frag_off)
& IP_OFFSET)
net/ipv4/netfilter/ipt_LOG.c:286:               if (ntohs(ih->frag_off)
& IP_OFFSET)
net/ipv4/netfilter/ipt_LOG.c:311:               if (ntohs(ih->frag_off)
& IP_OFFSET)
net/bridge/netfilter/ebt_ip.c:55:               if (ntohs(ih->frag_off)
& IP_OFFSET)
net/sunrpc/auth_gss/svcauth_gss.c:793:  if (ntohl(svc_getu32(argv)) !=3D
RPC_GSS_VERSION)
net/sunrpc/auth_gss/svcauth_gss.c:823:          if
(ntohl(svc_getu32(argv)) !=3D RPC_AUTH_NULL)
net/sunrpc/auth_gss/svcauth_gss.c:825:          if
(ntohl(svc_getu32(argv)) !=3D 0)
net/bluetooth/bnep/core.c:343:  if (ntohs(s->eh.h_proto) =3D=3D 0x8100) {=



(svcauth_gss.c:825 is a good one).



For consistency reasons, ntohs should be changed to htons here:

net/ipv6/netfilter/ip6t_eui64.c:43:    if (eth_hdr(skb)->h_proto =3D=3D
ntohs(ETH_P_IPV6)) {


Around net/ipv4/ipconfig.c:376 you might want to store the transformed
ic_myaddr in a variable instead of repeating the ntohl call.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enigF74EA122520493701AFAE019
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDxMN72ijCOnn/RHQRAuxVAKCHnuRR4utHlpOLyW6SsjC59zAezwCdGtjo
0PTXnSPRHyTSkBk+Z2PAo6Q=
=yB+h
-----END PGP SIGNATURE-----

--------------enigF74EA122520493701AFAE019--

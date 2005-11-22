Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030249AbVKVXdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbVKVXdE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 18:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbVKVXdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 18:33:02 -0500
Received: from bizon.gios.gov.pl ([212.244.124.8]:48514 "EHLO
	bizon.gios.gov.pl") by vger.kernel.org with ESMTP id S1030249AbVKVXdA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 18:33:00 -0500
Date: Wed, 23 Nov 2005 00:31:55 +0100 (CET)
From: Krzysztof Oledzki <ole@ans.pl>
X-X-Sender: ole@bizon.gios.gov.pl
To: Chris Wright <chrisw@osdl.org>
cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Harald Welte <laforge@netfilter.org>,
       Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [patch 13/23] [PATCH] [NETFILTER] ctnetlink: Fix oops when no
 ICMP ID info in message
In-Reply-To: <20051122210804.GN28140@shell0.pdx.osdl.net>
Message-ID: <Pine.LNX.4.64.0511230023310.15479@bizon.gios.gov.pl>
References: <20051122205223.099537000@localhost.localdomain>
 <20051122210804.GN28140@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-187430788-469544116-1132702315=:15479"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---187430788-469544116-1132702315=:15479
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Tue, 22 Nov 2005, Chris Wright wrote:

> -stable review patch.  If anyone has any objections, please let us know.

It seems we have two different patches here.

> ------------------
>
> This patch fixes an userspace triggered oops. If there is no ICMP_ID
> info the reference to attr will be NULL.
>
> Signed-off-by: Krzysztof Piotr Oledzki <ole@ans.pl>
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> Signed-off-by: Harald Welte <laforge@netfilter.org>
> Signed-off-by: Chris Wright <chrisw@osdl.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> ---
> net/ipv4/netfilter/ip_conntrack_proto_icmp.c |   13 +++++++------
> 1 file changed, 7 insertions(+), 6 deletions(-)

First - "stop tracking ICMP(v6) error at early point" by Yasuyuki Kozakai:
> --- linux-2.6.14.2.orig/net/ipv4/netfilter/ip_conntrack_proto_icmp.c
> +++ linux-2.6.14.2/net/ipv4/netfilter/ip_conntrack_proto_icmp.c
> @@ -151,13 +151,13 @@ icmp_error_message(struct sk_buff *skb,
> =09/* Not enough header? */
> =09inside =3D skb_header_pointer(skb, skb->nh.iph->ihl*4, sizeof(_in), &_=
in);
> =09if (inside =3D=3D NULL)
> -=09=09return NF_ACCEPT;
> +=09=09return -NF_ACCEPT;
>
> =09/* Ignore ICMP's containing fragments (shouldn't happen) */
> =09if (inside->ip.frag_off & htons(IP_OFFSET)) {
> =09=09DEBUGP("icmp_error_track: fragment of proto %u\n",
> =09=09       inside->ip.protocol);
> -=09=09return NF_ACCEPT;
> +=09=09return -NF_ACCEPT;
> =09}
>
> =09innerproto =3D ip_conntrack_proto_find_get(inside->ip.protocol);
> @@ -166,7 +166,7 @@ icmp_error_message(struct sk_buff *skb,
> =09if (!ip_ct_get_tuple(&inside->ip, skb, dataoff, &origtuple, innerproto=
)) {
> =09=09DEBUGP("icmp_error: ! get_tuple p=3D%u", inside->ip.protocol);
> =09=09ip_conntrack_proto_put(innerproto);
> -=09=09return NF_ACCEPT;
> +=09=09return -NF_ACCEPT;
> =09}
>
> =09/* Ordinarily, we'd expect the inverted tupleproto, but it's
> @@ -174,7 +174,7 @@ icmp_error_message(struct sk_buff *skb,
> =09if (!ip_ct_invert_tuple(&innertuple, &origtuple, innerproto)) {
> =09=09DEBUGP("icmp_error_track: Can't invert tuple\n");
> =09=09ip_conntrack_proto_put(innerproto);
> -=09=09return NF_ACCEPT;
> +=09=09return -NF_ACCEPT;
> =09}
> =09ip_conntrack_proto_put(innerproto);
>
> @@ -190,7 +190,7 @@ icmp_error_message(struct sk_buff *skb,
>
> =09=09if (!h) {
> =09=09=09DEBUGP("icmp_error_track: no match\n");
> -=09=09=09return NF_ACCEPT;
> +=09=09=09return -NF_ACCEPT;
> =09=09}
> =09=09/* Reverse direction from that found */
> =09=09if (DIRECTION(h) !=3D IP_CT_DIR_REPLY)


Second - "Fix oops when no ICMP ID info in message":
> @@ -296,7 +296,8 @@ static int icmp_nfattr_to_tuple(struct n
> =09=09=09=09struct ip_conntrack_tuple *tuple)
> {
> =09if (!tb[CTA_PROTO_ICMP_TYPE-1]
> -=09    || !tb[CTA_PROTO_ICMP_CODE-1])
> +=09    || !tb[CTA_PROTO_ICMP_CODE-1]
> +=09    || !tb[CTA_PROTO_ICMP_ID-1])
> =09=09return -1;
>
> =09tuple->dst.u.icmp.type =3D
>


Best regards,

 =09=09=09=09Krzysztof Ol=EAdzki
---187430788-469544116-1132702315=:15479--

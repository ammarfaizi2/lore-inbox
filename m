Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272312AbTGYVUA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 17:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272334AbTGYVUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 17:20:00 -0400
Received: from coruscant.franken.de ([193.174.159.226]:50066 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S272312AbTGYUjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 16:39:40 -0400
Date: Fri, 25 Jul 2003 22:52:07 +0200
From: Harald Welte <laforge@netfilter.org>
To: David Miller <davem@redhat.com>
Cc: Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] re-sync ipt_REJECT with 2.4.x
Message-ID: <20030725205207.GX3244@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	David Miller <davem@redhat.com>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pU61X8j5lbVWa/m1"
Content-Disposition: inline
X-Operating-system: Linux sunbeam 2.6.0-test1-nftest
X-Date: Today is Prickle-Prickle, the 53rd day of Confusion in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pU61X8j5lbVWa/m1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave!

While merging the recent 2.4. patches into 2.6, I have detected that
2.6 ipt_MIRROR has become way out of sync.

The patch below brings ipt_REJECT 2.6.0-test1 in sync with the 2.4.21
version.  You will receive the merge of the ipt_REJECt rp_filter fix as
an incrmental patch to this re-sync.

--- linux-2.6.0-test1/net/ipv4/netfilter/ipt_REJECT.c	2003-07-19 12:35:52.0=
00000000 +0200
+++ linux-2.6.0-test1-nftest/net/ipv4/netfilter/ipt_REJECT.c	2003-07-19 14:=
14:23.000000000 +0200
@@ -36,133 +36,148 @@
 }
=20
 /* Send RST reply */
-static unsigned int send_reset(struct sk_buff **pskb, int local)
+static void send_reset(struct sk_buff *oldskb, int local)
 {
-	struct tcphdr tcph;
+	struct sk_buff *nskb;
+	struct tcphdr *otcph, *tcph;
 	struct rtable *rt;
+	unsigned int otcplen;
 	u_int16_t tmp_port;
 	u_int32_t tmp_addr;
-	int needs_ack, hh_len, datalen;
-	struct nf_ct_info *oldnfct;
+	int needs_ack;
+	int hh_len;
=20
-	/* No RSTs for fragments. */
-	if ((*pskb)->nh.iph->frag_off & htons(IP_OFFSET))
-		return NF_DROP;
+	/* IP header checks: fragment, too short. */
+	if (oldskb->nh.iph->frag_off & htons(IP_OFFSET)
+	    || oldskb->len < (oldskb->nh.iph->ihl<<2) + sizeof(struct tcphdr))
+		return;
=20
-	if (skb_copy_bits(*pskb, (*pskb)->nh.iph->ihl*4,
-			  &tcph, sizeof(tcph)) < 0)
-		return NF_DROP;
+	otcph =3D (struct tcphdr *)((u_int32_t*)oldskb->nh.iph + oldskb->nh.iph->=
ihl);
+	otcplen =3D oldskb->len - oldskb->nh.iph->ihl*4;
+
+	if (skb_copy_bits(oldskb, oldskb->nh.iph->ihl*4,
+			  otcph, sizeof(*otcph)) < 0)
+		return;
=20
 	/* No RST for RST. */
-	if (tcph.rst)
-		return NF_DROP;
+	if (otcph->rst)
+		return;
+
+	/* Check checksum. */
+	if (tcp_v4_check(otcph, otcplen, oldskb->nh.iph->saddr,
+			 oldskb->nh.iph->daddr,
+			 csum_partial((char *)otcph, otcplen, 0)) !=3D 0)
+		return;
=20
-	/* FIXME: Check checksum. */
 	{
 		struct flowi fl =3D { .nl_u =3D { .ip4_u =3D
-					      { .daddr =3D (*pskb)->nh.iph->saddr,
+					      { .daddr =3D oldskb->nh.iph->saddr,
 						.saddr =3D (local ?
-							  (*pskb)->nh.iph->daddr :
+							  oldskb->nh.iph->daddr :
 							  0),
-						.tos =3D RT_TOS((*pskb)->nh.iph->tos) } } };
-
-		/* Routing: if not headed for us, route won't like source */
-		if (ip_route_output_key(&rt, &fl))
-			return NF_DROP;
+						.tos =3D RT_TOS(oldskb->nh.iph->tos) } } };
=20
-		hh_len =3D (rt->u.dst.dev->hard_header_len + 15)&~15;
-	}
+	/* Routing: if not headed for us, route won't like source */
+	if (ip_route_output_key(&rt, &fl))
+		return;
+	}	=09
+	hh_len =3D (rt->u.dst.dev->hard_header_len + 15)&~15;
=20
-	/* We're going to flip the header around, drop options and data. */
-	if (!skb_ip_make_writable(pskb, (*pskb)->nh.iph->ihl*4+sizeof(tcph))) {
-		ip_rt_put(rt);
-		return NF_DROP;
+	/* Copy skb (even if skb is about to be dropped, we can't just
+           clone it because there may be other things, such as tcpdump,
+           interested in it). We also need to expand headroom in case
+	   hh_len of incoming interface < hh_len of outgoing interface */
+	nskb =3D skb_copy_expand(oldskb, hh_len, skb_tailroom(oldskb),
+			       GFP_ATOMIC);
+	if (!nskb) {
+		dst_release(&rt->u.dst);
+		return;
 	}
=20
-	(*pskb)->h.th =3D (void *)(*pskb)->nh.iph + sizeof(tcph);
-	datalen =3D (*pskb)->len - (*pskb)->nh.iph->ihl*4 - tcph.doff*4;
-
-	/* Change over route. */
-	dst_release((*pskb)->dst);
-	(*pskb)->dst =3D &rt->u.dst;
+	dst_release(nskb->dst);
+	nskb->dst =3D &rt->u.dst;
=20
 	/* This packet will not be the same as the other: clear nf fields */
-	(*pskb)->nfcache =3D 0;
+	nf_conntrack_put(nskb->nfct);
+	nskb->nfct =3D NULL;
+	nskb->nfcache =3D 0;
 #ifdef CONFIG_NETFILTER_DEBUG
-	(*pskb)->nf_debug =3D 0;
+	nskb->nf_debug =3D 0;
 #endif
-	(*pskb)->nfmark =3D 0;
+	nskb->nfmark =3D 0;
+
+	tcph =3D (struct tcphdr *)((u_int32_t*)nskb->nh.iph + nskb->nh.iph->ihl);
=20
 	/* Swap source and dest */
-	tmp_addr =3D (*pskb)->nh.iph->saddr;
-	(*pskb)->nh.iph->saddr =3D (*pskb)->nh.iph->daddr;
-	(*pskb)->nh.iph->daddr =3D tmp_addr;
-	tmp_port =3D (*pskb)->h.th->source;
-	(*pskb)->h.th->source =3D (*pskb)->h.th->dest;
-	(*pskb)->h.th->dest =3D tmp_port;
+	tmp_addr =3D nskb->nh.iph->saddr;
+	nskb->nh.iph->saddr =3D nskb->nh.iph->daddr;
+	nskb->nh.iph->daddr =3D tmp_addr;
+	tmp_port =3D tcph->source;
+	tcph->source =3D tcph->dest;
+	tcph->dest =3D tmp_port;
=20
 	/* Truncate to length (no data) */
-	(*pskb)->h.th->doff =3D sizeof(struct tcphdr)/4;
-	skb_trim(*pskb, (*pskb)->nh.iph->ihl*4 + sizeof(struct tcphdr));
-	(*pskb)->nh.iph->tot_len =3D htons((*pskb)->len);
+	tcph->doff =3D sizeof(struct tcphdr)/4;
+	skb_trim(nskb, nskb->nh.iph->ihl*4 + sizeof(struct tcphdr));
+	nskb->nh.iph->tot_len =3D htons(nskb->len);
=20
-	if ((*pskb)->h.th->ack) {
+	if (tcph->ack) {
 		needs_ack =3D 0;
-		(*pskb)->h.th->seq =3D tcph.ack_seq;
-		(*pskb)->h.th->ack_seq =3D 0;
+		tcph->seq =3D otcph->ack_seq;
+		tcph->ack_seq =3D 0;
 	} else {
 		needs_ack =3D 1;
-		(*pskb)->h.th->ack_seq =3D htonl(ntohl(tcph.seq)
-						 + tcph.syn + tcph.fin
-						 + datalen);
-		(*pskb)->h.th->seq =3D 0;
+		tcph->ack_seq =3D htonl(ntohl(otcph->seq) + otcph->syn + otcph->fin
+				      + otcplen - (otcph->doff<<2));
+		tcph->seq =3D 0;
 	}
=20
 	/* Reset flags */
-	memset((*pskb)->h.raw + 13, 0, 1);
-	(*pskb)->h.th->rst =3D 1;
-	(*pskb)->h.th->ack =3D needs_ack;
+	((u_int8_t *)tcph)[13] =3D 0;
+	tcph->rst =3D 1;
+	tcph->ack =3D needs_ack;
=20
-	(*pskb)->h.th->window =3D 0;
-	(*pskb)->h.th->urg_ptr =3D 0;
+	tcph->window =3D 0;
+	tcph->urg_ptr =3D 0;
=20
 	/* Adjust TCP checksum */
-	(*pskb)->h.th->check =3D 0;
-	(*pskb)->h.th->check
-		=3D tcp_v4_check((*pskb)->h.th,
-			       sizeof(struct tcphdr),
-			       (*pskb)->nh.iph->saddr,
-			       (*pskb)->nh.iph->daddr,
-			       csum_partial((*pskb)->h.raw,
-					    sizeof(struct tcphdr), 0));
+	tcph->check =3D 0;
+	tcph->check =3D tcp_v4_check(tcph, sizeof(struct tcphdr),
+				   nskb->nh.iph->saddr,
+				   nskb->nh.iph->daddr,
+				   csum_partial((char *)tcph,
+						sizeof(struct tcphdr), 0));
=20
 	/* Adjust IP TTL, DF */
-	(*pskb)->nh.iph->ttl =3D MAXTTL;
+	nskb->nh.iph->ttl =3D MAXTTL;
 	/* Set DF, id =3D 0 */
-	(*pskb)->nh.iph->frag_off =3D htons(IP_DF);
-	(*pskb)->nh.iph->id =3D 0;
+	nskb->nh.iph->frag_off =3D htons(IP_DF);
+	nskb->nh.iph->id =3D 0;
=20
 	/* Adjust IP checksum */
-	(*pskb)->nh.iph->check =3D 0;
-	(*pskb)->nh.iph->check =3D ip_fast_csum((*pskb)->nh.raw,=20
-					      (*pskb)->nh.iph->ihl);
+	nskb->nh.iph->check =3D 0;
+	nskb->nh.iph->check =3D ip_fast_csum((unsigned char *)nskb->nh.iph,=20
+					   nskb->nh.iph->ihl);
=20
 	/* "Never happens" */
-	if ((*pskb)->len > dst_pmtu((*pskb)->dst))
-		return NF_DROP;
+	if (nskb->len > dst_pmtu(nskb->dst))
+		goto free_nskb;
=20
-	/* Related to old connection. */
-	oldnfct =3D (*pskb)->nfct;
-	connection_attach(*pskb, oldnfct);
-	nf_conntrack_put(oldnfct);
+	connection_attach(nskb, oldskb->nfct);
=20
-	NF_HOOK(PF_INET, NF_IP_LOCAL_OUT, *pskb, NULL, (*pskb)->dst->dev,
+	NF_HOOK(PF_INET, NF_IP_LOCAL_OUT, nskb, NULL, nskb->dst->dev,
 		ip_finish_output);
-	return NF_STOLEN;
+	return;
+
+ free_nskb:
+	kfree_skb(nskb);
 }
=20
-static void send_unreach(const struct sk_buff *skb_in, int code)
+static void send_unreach(struct sk_buff *skb_in, int code)
 {
+	struct iphdr *iph;
+	struct udphdr *udph;
+	struct icmphdr *icmph;
 	struct sk_buff *nskb;
 	u32 saddr;
 	u8 tos;
@@ -177,6 +192,8 @@
 	if (!xrlim_allow(&rt->u.dst, 1*HZ))
 		return;
=20
+	iph =3D skb_in->nh.iph;
+
 	/* No replies to physical multicast/broadcast */
 	if (skb_in->pkt_type!=3DPACKET_HOST)
 		return;
@@ -186,38 +203,52 @@
 		return;
=20
 	/* Only reply to fragment 0. */
-	if (skb_in->nh.iph->frag_off&htons(IP_OFFSET))
+	if (iph->frag_off&htons(IP_OFFSET))
 		return;
=20
 	/* Ensure we have at least 8 bytes of proto header. */
 	if (skb_in->len < skb_in->nh.iph->ihl*4 + 8)
 		return;
=20
+	/* if UDP checksum is set, verify it's correct */
+	if (iph->protocol =3D=3D IPPROTO_UDP
+	    && skb_in->tail-(u8*)iph >=3D sizeof(struct udphdr)) {
+		int datalen =3D skb_in->len - (iph->ihl<<2);
+		udph =3D (struct udphdr *)((char *)iph + (iph->ihl<<2));
+		if (udph->check
+		    && csum_tcpudp_magic(iph->saddr, iph->daddr,
+		                         datalen, IPPROTO_UDP,
+		                         csum_partial((char *)udph, datalen,
+		                                      0)) !=3D 0)
+			return;
+	}
+
 	/* If we send an ICMP error to an ICMP error a mess would result.. */
-	if (skb_in->nh.iph->protocol =3D=3D IPPROTO_ICMP) {
-		struct icmphdr icmph;
+	if (iph->protocol =3D=3D IPPROTO_ICMP
+	    && skb_in->tail-(u8*)iph >=3D sizeof(struct icmphdr)) {
+		icmph =3D (struct icmphdr *)((char *)iph + (iph->ihl<<2));
=20
 		if (skb_copy_bits(skb_in, skb_in->nh.iph->ihl*4,
-				  &icmph, sizeof(icmph)) < 0)
+				  icmph, sizeof(*icmph)) < 0)
 			return;
=20
 		/* Between echo-reply (0) and timestamp (13),
 		   everything except echo-request (8) is an error.
 		   Also, anything greater than NR_ICMP_TYPES is
 		   unknown, and hence should be treated as an error... */
-		if ((icmph.type < ICMP_TIMESTAMP
-		     && icmph.type !=3D ICMP_ECHOREPLY
-		     && icmph.type !=3D ICMP_ECHO)
-		    || icmph.type > NR_ICMP_TYPES)
+		if ((icmph->type < ICMP_TIMESTAMP
+		     && icmph->type !=3D ICMP_ECHOREPLY
+		     && icmph->type !=3D ICMP_ECHO)
+		    || icmph->type > NR_ICMP_TYPES)
 			return;
 	}
=20
-	saddr =3D skb_in->nh.iph->daddr;
+	saddr =3D iph->daddr;
 	if (!(rt->rt_flags & RTCF_LOCAL))
 		saddr =3D 0;
=20
-	tos =3D (skb_in->nh.iph->tos & IPTOS_TOS_MASK)
-		| IPTOS_PREC_INTERNETCONTROL;
+	tos =3D (iph->tos & IPTOS_TOS_MASK) | IPTOS_PREC_INTERNETCONTROL;
+
 	{
 		struct flowi fl =3D { .nl_u =3D { .ip4_u =3D
 					      { .daddr =3D skb_in->nh.iph->saddr,
@@ -247,38 +278,41 @@
 	skb_reserve(nskb, hh_len);
=20
 	/* Set up IP header */
-	nskb->nh.iph =3D (struct iphdr *)skb_put(nskb, sizeof(struct iphdr));
-	nskb->nh.iph->version=3D4;
-	nskb->nh.iph->ihl=3D5;
-	nskb->nh.iph->tos=3Dtos;
-	nskb->nh.iph->tot_len =3D htons(length);
+	iph =3D nskb->nh.iph
+		=3D (struct iphdr *)skb_put(nskb, sizeof(struct iphdr));
+	iph->version=3D4;
+	iph->ihl=3D5;
+	iph->tos=3Dtos;
+	iph->tot_len =3D htons(length);
=20
 	/* PMTU discovery never applies to ICMP packets. */
-	nskb->nh.iph->frag_off =3D 0;
+	iph->frag_off =3D 0;
=20
-	nskb->nh.iph->ttl =3D MAXTTL;
-	ip_select_ident(nskb->nh.iph, &rt->u.dst, NULL);
-	nskb->nh.iph->protocol=3DIPPROTO_ICMP;
-	nskb->nh.iph->saddr=3Drt->rt_src;
-	nskb->nh.iph->daddr=3Drt->rt_dst;
-	nskb->nh.iph->check=3D0;
-	nskb->nh.iph->check =3D ip_fast_csum(nskb->nh.raw,
-					   nskb->nh.iph->ihl);
+	iph->ttl =3D MAXTTL;
+	ip_select_ident(iph, &rt->u.dst, NULL);
+	iph->protocol=3DIPPROTO_ICMP;
+	iph->saddr=3Drt->rt_src;
+	iph->daddr=3Drt->rt_dst;
+	iph->check=3D0;
+	iph->check =3D ip_fast_csum((unsigned char *)iph, iph->ihl);
=20
 	/* Set up ICMP header. */
-	nskb->h.icmph =3D (struct icmphdr *)skb_put(nskb,sizeof(struct icmphdr));
-	nskb->h.icmph->type =3D ICMP_DEST_UNREACH;
-	nskb->h.icmph->code =3D code;=09
-	nskb->h.icmph->un.gateway =3D 0;
-	nskb->h.icmph->checksum =3D 0;
+	icmph =3D nskb->h.icmph
+		=3D (struct icmphdr *)skb_put(nskb, sizeof(struct icmphdr));
+	icmph->type =3D ICMP_DEST_UNREACH;
+	icmph->code =3D code;=09
+	icmph->un.gateway =3D 0;
+	icmph->checksum =3D 0;
 =09
 	/* Copy as much of original packet as will fit */
 	data =3D skb_put(nskb,
 		       length - sizeof(struct iphdr) - sizeof(struct icmphdr));
+
 	skb_copy_bits(skb_in, 0, data,
 		      length - sizeof(struct iphdr) - sizeof(struct icmphdr));
-	nskb->h.icmph->checksum =3D ip_compute_csum(nskb->h.raw,
-						  length-sizeof(struct iphdr));
+
+	icmph->checksum =3D ip_compute_csum((unsigned char *)icmph,
+					  length - sizeof(struct iphdr));
=20
 	connection_attach(nskb, skb_in->nfct);
=20
@@ -323,7 +357,7 @@
     		send_unreach(*pskb, ICMP_HOST_ANO);
     		break;
 	case IPT_TCP_RESET:
-		return send_reset(pskb, hooknum =3D=3D NF_IP_LOCAL_IN);
+		send_reset(*pskb, hooknum =3D=3D NF_IP_LOCAL_IN);
 	case IPT_ICMP_ECHOREPLY:
 		/* Doesn't happen. */
 		break;
--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--pU61X8j5lbVWa/m1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/IZh3XaXGVTD0i/8RAuajAJ9T+BezSkUoEf0fnUY8DjMvbF0O+gCgmeDc
qcjeyPFxbNn7Gml9Mk5itNg=
=Arqv
-----END PGP SIGNATURE-----

--pU61X8j5lbVWa/m1--

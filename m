Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbTEKWXy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 18:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbTEKWXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 18:23:54 -0400
Received: from rth.ninka.net ([216.101.162.244]:30852 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261324AbTEKWXr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 18:23:47 -0400
Subject: Re: Slab corruption mm3 + davem fixes
From: "David S. Miller" <davem@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: tomlins@cam.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, laforge@netfilter.org
In-Reply-To: <20030511151506.172eee58.akpm@digeo.com>
References: <20030511031940.97C24251B@oscar.casa.dyndns.org>
	 <200305111221.26048.tomlins@cam.org>
	 <1052690490.4471.2.camel@rth.ninka.net>
	 <20030511151506.172eee58.akpm@digeo.com>
Content-Type: multipart/mixed; boundary="=-wjuXFaf/UpLtO/8NZFbA"
Organization: 
Message-Id: <1052692449.4471.4.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 May 2003 15:34:10 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wjuXFaf/UpLtO/8NZFbA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2003-05-11 at 15:15, Andrew Morton wrote:
> "David S. Miller" <davem@redhat.com> wrote:
> >
> > On Sun, 2003-05-11 at 09:21, Ed Tomlinson wrote:
> > > I am also seeing this on 69-bk (as of Sunday morning)
> > ...
> > > On May 10, 2003 11:19 pm, Ed Tomlinson wrote:
> > > > I looked at my logs and found the following error in it.  My kernel is
> > > > 69-mm3 with two davem fixes on it.
> > ...
> > > > May 10 22:41:06 oscar kernel: Call Trace:
> > > > May 10 22:41:06 oscar kernel:  [__slab_error+30/32] __slab_error+0x1e/0x20
> > > > May 10 22:41:06 oscar kernel:  [check_poison_obj+376/384]
> > > > check_poison_obj+0x178/0x180 May 10 22:41:06 oscar kernel: 
> > > > [kmalloc+221/392] kmalloc+0xdd/0x188 May 10 22:41:06 oscar kernel: 
> > > > [alloc_skb+64/240] alloc_skb+0x40/0xf0 May 10 22:41:06 oscar kernel: 
> > 
> > Yeah, more bugs in the NAT netfilter changes.  Debugging this one
> > patch is becomming a full time job :-(
> > 
> > This should fix it.  Rusty, you're computing checksums and mangling
> > src/dst using header pointers potentially pointing to free'd skbs.
> > 
> 
> Did you mean to send a one megabyte diff?

Let's try this again, here is the correct patch :-)



-- 
David S. Miller <davem@redhat.com>

--=-wjuXFaf/UpLtO/8NZFbA
Content-Disposition: attachment; filename=diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=diff; charset=UTF-8

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher=
.
# This patch includes the following deltas:
#	           ChangeSet	1.1105  -> 1.1106=20
#	net/ipv4/netfilter/ip_nat_core.c	1.25    -> 1.26  =20
#	net/ipv4/netfilter/ip_fw_compat_masq.c	1.8     -> 1.9   =20
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/11	davem@nuts.ninka.net	1.1106
# [NETFILTER]: Fix stale skb data pointer usage in ipv4 NAT.
# --------------------------------------------
#
diff -Nru a/net/ipv4/netfilter/ip_fw_compat_masq.c b/net/ipv4/netfilter/ip_=
fw_compat_masq.c
--- a/net/ipv4/netfilter/ip_fw_compat_masq.c	Sun May 11 15:31:41 2003
+++ b/net/ipv4/netfilter/ip_fw_compat_masq.c	Sun May 11 15:31:41 2003
@@ -35,16 +35,15 @@
 unsigned int
 do_masquerade(struct sk_buff **pskb, const struct net_device *dev)
 {
-	struct iphdr *iph =3D (*pskb)->nh.iph;
 	struct ip_nat_info *info;
 	enum ip_conntrack_info ctinfo;
 	struct ip_conntrack *ct;
 	unsigned int ret;
=20
 	/* Sorry, only ICMP, TCP and UDP. */
-	if (iph->protocol !=3D IPPROTO_ICMP
-	    && iph->protocol !=3D IPPROTO_TCP
-	    && iph->protocol !=3D IPPROTO_UDP)
+	if ((*pskb)->nh.iph->protocol !=3D IPPROTO_ICMP
+	    && (*pskb)->nh.iph->protocol !=3D IPPROTO_TCP
+	    && (*pskb)->nh.iph->protocol !=3D IPPROTO_UDP)
 		return NF_DROP;
=20
 	/* Feed it to connection tracking; in fact we're in NF_IP_FORWARD,
@@ -68,7 +67,7 @@
 	/* Setup the masquerade, if not already */
 	if (!info->initialized) {
 		u_int32_t newsrc;
-		struct flowi fl =3D { .nl_u =3D { .ip4_u =3D { .daddr =3D iph->daddr } }=
 };
+		struct flowi fl =3D { .nl_u =3D { .ip4_u =3D { .daddr =3D (*pskb)->nh.ip=
h->daddr } } };
 		struct rtable *rt;
 		struct ip_nat_multi_range range;
=20
@@ -124,19 +123,18 @@
 check_for_demasq(struct sk_buff **pskb)
 {
 	struct ip_conntrack_tuple tuple;
-	struct iphdr *iph =3D (*pskb)->nh.iph;
 	struct ip_conntrack_protocol *protocol;
 	struct ip_conntrack_tuple_hash *h;
 	enum ip_conntrack_info ctinfo;
 	struct ip_conntrack *ct;
 	int ret;
=20
-	protocol =3D ip_ct_find_proto(iph->protocol);
+	protocol =3D ip_ct_find_proto((*pskb)->nh.iph->protocol);
=20
 	/* We don't feed packets to conntrack system unless we know
            they're part of an connection already established by an
            explicit masq command. */
-	switch (iph->protocol) {
+	switch ((*pskb)->nh.iph->protocol) {
 	case IPPROTO_ICMP:
 		/* ICMP errors. */
 		ct =3D icmp_error_track(*pskb, &ctinfo, NF_IP_PRE_ROUTING);
@@ -146,12 +144,6 @@
 			   server here (=3D=3D DNAT).  Do SNAT icmp manips
 			   in POST_ROUTING handling. */
 			if (CTINFO2DIR(ctinfo) =3D=3D IP_CT_DIR_REPLY) {
-				/* FIXME: Remove once NAT handled non-linear.
-				 */
-				if (skb_is_nonlinear(*pskb)
-				    && skb_linearize(*pskb, GFP_ATOMIC) !=3D 0)
-					return NF_DROP;
-
 				icmp_reply_translation(pskb, ct,
 						       NF_IP_PRE_ROUTING,
 						       CTINFO2DIR(ctinfo));
@@ -166,7 +158,7 @@
 	case IPPROTO_UDP:
 		IP_NF_ASSERT(((*pskb)->nh.iph->frag_off & htons(IP_OFFSET)) =3D=3D 0);
=20
-		if (!get_tuple(iph, *pskb, iph->ihl*4, &tuple, protocol)) {
+		if (!get_tuple((*pskb)->nh.iph, *pskb, (*pskb)->nh.iph->ihl*4, &tuple, p=
rotocol)) {
 			if (net_ratelimit())
 				printk("ip_fw_compat_masq: Can't get tuple\n");
 			return NF_ACCEPT;
diff -Nru a/net/ipv4/netfilter/ip_nat_core.c b/net/ipv4/netfilter/ip_nat_co=
re.c
--- a/net/ipv4/netfilter/ip_nat_core.c	Sun May 11 15:31:41 2003
+++ b/net/ipv4/netfilter/ip_nat_core.c	Sun May 11 15:31:41 2003
@@ -717,10 +717,13 @@
 	iph =3D (void *)(*pskb)->data + iphdroff;
=20
 	/* Manipulate protcol part. */
-	if (!find_nat_proto(proto)->manip_pkt(pskb, iphdroff + iph->ihl*4,
+	if (!find_nat_proto(proto)->manip_pkt(pskb,
+					      iphdroff + iph->ihl*4,
 					      manip, maniptype))
 		return 0;
=20
+	iph =3D (void *)(*pskb)->data + iphdroff;
+
 	if (maniptype =3D=3D IP_NAT_MANIP_SRC) {
 		iph->check =3D ip_nat_cheat_check(~iph->saddr, manip->ip,
 						iph->check);
@@ -952,6 +955,8 @@
 	READ_UNLOCK(&ip_nat_lock);
=20
 	hdrlen =3D (*pskb)->nh.iph->ihl * 4;
+
+	inside =3D (void *)(*pskb)->data + (*pskb)->nh.iph->ihl*4;
=20
 	inside->icmp.checksum =3D 0;
 	inside->icmp.checksum =3D csum_fold(skb_checksum(*pskb, hdrlen,

--=-wjuXFaf/UpLtO/8NZFbA--

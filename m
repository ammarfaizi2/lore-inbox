Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129807AbRBYDuf>; Sat, 24 Feb 2001 22:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129811AbRBYDuZ>; Sat, 24 Feb 2001 22:50:25 -0500
Received: from sith.mimuw.edu.pl ([193.0.97.1]:2054 "HELO sith.mimuw.edu.pl")
	by vger.kernel.org with SMTP id <S129807AbRBYDuX>;
	Sat, 24 Feb 2001 22:50:23 -0500
Date: Sun, 25 Feb 2001 04:54:20 +0100
From: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
To: Chris Wedgwood <cw@f00f.org>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: [UPDATE] zerocopy BETA 3
Message-ID: <20010225045420.B10281@sith.mimuw.edu.pl>
Mail-Followup-To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>,
	Chris Wedgwood <cw@f00f.org>, "David S. Miller" <davem@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <14998.2628.144784.585248@pizda.ninka.net> <20010223114249.A27608@sith.mimuw.edu.pl> <20010225163836.A12173@metastasis.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010225163836.A12173@metastasis.f00f.org>; from cw@f00f.org on Sun, Feb 25, 2001 at 04:38:36PM +1300
X-Operating-System: Linux 2.4.2-pre4 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Feb 2001, Chris Wedgwood wrote:

> On Fri, Feb 23, 2001 at 11:42:49AM +0100, Jan Rekorajski wrote:
>     
>     Could you please make a patch with this fix only? Or is it
>     available somewhere?
> 
[cut incomplete patch ;)]

There are more changes, I hacked'em out of vger CVS:

diff -urN linux/include/net/ip.h linux.fixed/include/net/ip.h
--- linux/include/net/ip.h	Thu Feb 22 01:10:38 2001
+++ linux.fixed/include/net/ip.h	Fri Feb 23 14:40:40 2001
@@ -188,11 +188,16 @@
 
 extern void __ip_select_ident(struct iphdr *iph, struct dst_entry *dst);
 
-static inline void ip_select_ident(struct iphdr *iph, struct dst_entry *dst)
+static inline void ip_select_ident(struct iphdr *iph, struct dst_entry *dst, struct sock *sk)
 {
-	if (iph->frag_off&__constant_htons(IP_DF))
-		iph->id = 0;
-	else
+	if (iph->frag_off&__constant_htons(IP_DF)) {
+		/* This is only to work around buggy Windows95/2000
+		 * VJ compression implementations.  If the ID field
+		 * does not change, they drop every other packet in
+		 * a TCP stream using header compression.
+		 */
+		iph->id = (sk ? sk->protinfo.af_inet.id++ : 0);
+	} else
 		__ip_select_ident(iph, dst);
 }
 
diff -urN linux/include/net/ipip.h linux.fixed/include/net/ipip.h
--- linux/include/net/ipip.h	Sat Aug  5 03:18:49 2000
+++ linux.fixed/include/net/ipip.h	Fri Feb 23 14:40:43 2001
@@ -30,7 +30,7 @@
 	int pkt_len = skb->len;						\
 									\
 	iph->tot_len = htons(skb->len);					\
-	ip_select_ident(iph, &rt->u.dst);				\
+	ip_select_ident(iph, &rt->u.dst, NULL);				\
 	ip_send_check(iph);						\
 									\
 	err = NF_HOOK(PF_INET, NF_IP_LOCAL_OUT, skb, NULL, rt->u.dst.dev, do_ip_send); \
diff -urN linux/include/net/sock.h linux.fixed/include/net/sock.h
--- linux/include/net/sock.h	Thu Feb 22 01:10:24 2001
+++ linux.fixed/include/net/sock.h	Fri Feb 23 14:40:49 2001
@@ -204,6 +204,7 @@
 	__u8			mc_loop;		/* Loopback */
 	unsigned		recverr : 1,
 				freebind : 1;
+	__u16			id;			/* ID counter for DF pkts */
 	__u8			pmtudisc;
 	int			mc_index;		/* Multicast device index */
 	__u32			mc_addr;
diff -urN linux/net/ipv4/af_inet.c linux.fixed/net/ipv4/af_inet.c
--- linux/net/ipv4/af_inet.c	Fri Dec 29 23:07:24 2000
+++ linux.fixed/net/ipv4/af_inet.c	Fri Feb 23 14:40:34 2001
@@ -355,6 +355,8 @@
 	else
 		sk->protinfo.af_inet.pmtudisc = IP_PMTUDISC_WANT;
 
+	sk->protinfo.af_inet.id = 0;
+
 	sock_init_data(sock,sk);
 
 	sk->destruct = inet_sock_destruct;
diff -urN linux/net/ipv4/igmp.c linux.fixed/net/ipv4/igmp.c
--- linux/net/ipv4/igmp.c	Tue Jan  9 19:54:57 2001
+++ linux.fixed/net/ipv4/igmp.c	Fri Feb 23 14:40:38 2001
@@ -235,7 +235,7 @@
 	iph->saddr    = rt->rt_src;
 	iph->protocol = IPPROTO_IGMP;
 	iph->tot_len  = htons(IGMP_SIZE);
-	ip_select_ident(iph, &rt->u.dst);
+	ip_select_ident(iph, &rt->u.dst, NULL);
 	((u8*)&iph[1])[0] = IPOPT_RA;
 	((u8*)&iph[1])[1] = 4;
 	((u8*)&iph[1])[2] = 0;
diff -urN linux/net/ipv4/ip_output.c linux.fixed/net/ipv4/ip_output.c
--- linux/net/ipv4/ip_output.c	Fri Oct 27 20:03:14 2000
+++ linux.fixed/net/ipv4/ip_output.c	Fri Feb 23 14:54:17 2001
@@ -141,7 +141,7 @@
 	iph->saddr    = rt->rt_src;
 	iph->protocol = sk->protocol;
 	iph->tot_len  = htons(skb->len);
-	ip_select_ident(iph, &rt->u.dst);
+	ip_select_ident(iph, &rt->u.dst, sk);
 	skb->nh.iph   = iph;
 
 	if (opt && opt->optlen) {
@@ -307,7 +307,7 @@
 	if (ip_dont_fragment(sk, &rt->u.dst))
 		iph->frag_off |= __constant_htons(IP_DF);
 
-	ip_select_ident(iph, &rt->u.dst);
+	ip_select_ident(iph, &rt->u.dst, sk);
 
 	/* Add an IP checksum. */
 	ip_send_check(iph);
@@ -328,7 +328,7 @@
 		kfree_skb(skb);
 		return -EMSGSIZE;
 	}
-	ip_select_ident(iph, &rt->u.dst);
+	ip_select_ident(iph, &rt->u.dst, sk);
 	return ip_fragment(skb, skb->dst->output);
 }
 
@@ -425,7 +425,7 @@
 	int err;
 	int offset, mf;
 	int mtu;
-	u16 id = 0;
+	u16 id;
 
 	int hh_len = (rt->u.dst.dev->hard_header_len + 15)&~15;
 	int nfrags=0;
@@ -495,6 +495,8 @@
 	 *	Begin outputting the bytes.
 	 */
 
+	id = (sk ? sk->protinfo.af_inet.id++ : 0);
+
 	do {
 		char *data;
 		struct sk_buff * skb;
@@ -677,7 +679,7 @@
 		iph->tot_len = htons(length);
 		iph->frag_off = df;
 		iph->ttl=sk->protinfo.af_inet.mc_ttl;
-		ip_select_ident(iph, &rt->u.dst);
+		ip_select_ident(iph, &rt->u.dst, sk);
 		if (rt->rt_type != RTN_MULTICAST)
 			iph->ttl=sk->protinfo.af_inet.ttl;
 		iph->protocol=sk->protocol;
diff -urN linux/net/ipv4/ipmr.c linux.fixed/net/ipv4/ipmr.c
--- linux/net/ipv4/ipmr.c	Wed Nov 29 06:53:45 2000
+++ linux.fixed/net/ipv4/ipmr.c	Fri Feb 23 14:40:45 2001
@@ -1092,7 +1092,7 @@
 	iph->protocol	=	IPPROTO_IPIP;
 	iph->ihl	=	5;
 	iph->tot_len	=	htons(skb->len);
-	ip_select_ident(iph, skb->dst);
+	ip_select_ident(iph, skb->dst, NULL);
 	ip_send_check(iph);
 
 	skb->h.ipiph = skb->nh.iph;
diff -urN linux/net/ipv4/raw.c linux.fixed/net/ipv4/raw.c
--- linux/net/ipv4/raw.c	Fri Feb  9 20:29:44 2001
+++ linux.fixed/net/ipv4/raw.c	Fri Feb 23 14:40:47 2001
@@ -296,7 +296,7 @@
 	 	 *	ip_build_xmit clean (well less messy).
 		 */
 		if (!iph->id)
-			ip_select_ident(iph, rfh->dst);
+			ip_select_ident(iph, rfh->dst, NULL);
 		iph->check=ip_fast_csum((unsigned char *)iph, iph->ihl);
 	}
 	return 0;

> FWIW; I am still seeing _really_ bad throughput on a 10M ethernet
> segment between 2.4.2+zc-2 and Windows98 SE. Nobody else has
> complained so I guess it is something local (mii-tool for Windows
> wouldn't be a bad idea), but if the above doesn't work for you I'd
> been keen to know about it.

I hadn't the time to test it fully yet, but DaveM's quick and dirty patch
for this cured my problems.

Jan
-- 
Jan Rêkorajski            |  ALL SUSPECTS ARE GUILTY. PERIOD!
baggins<at>mimuw.edu.pl   |  OTHERWISE THEY WOULDN'T BE SUSPECTS, WOULD THEY?
BOFH, MANIAC              |                   -- TROOPS by Kevin Rubio

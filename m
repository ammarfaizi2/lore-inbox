Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317051AbSFKOAR>; Tue, 11 Jun 2002 10:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317054AbSFKOAQ>; Tue, 11 Jun 2002 10:00:16 -0400
Received: from fortress.mirotel.net ([194.125.225.117]:30212 "EHLO
	fortress.mirotel.net") by vger.kernel.org with ESMTP
	id <S317051AbSFKOAP>; Tue, 11 Jun 2002 10:00:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Lev V. Vanyan" <remedy@mirotel.net>
Reply-To: remedy@mirotel.net
Organization: Mirotel LTD
To: linux-kernel@vger.kernel.org
Subject: net.ipv4.icmp_default_ttl
Date: Tue, 11 Jun 2002 17:00:44 +0300
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <02061117004401.01217@fortress.mirotel.net>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----

forgot to send diffed sysctl.h changes. here is full diff text:

- --- linux/net/ipv4/sysctl_net_ipv4.c	Wed Oct 31 01:08:12 2001
+++ linux-2.4.18/net/ipv4/sysctl_net_ipv4.c	Mon Jun 10 21:51:08 2002
@@ -22,6 +22,7 @@
 extern int sysctl_icmp_echo_ignore_all;
 extern int sysctl_icmp_echo_ignore_broadcasts;
 extern int sysctl_icmp_ignore_bogus_error_responses;
+extern int sysctl_icmp_default_ttl;
 
 /* From ip_fragment.c */
 extern int sysctl_ipfrag_low_thresh;
@@ -176,6 +177,9 @@
 	{NET_IPV4_ICMP_IGNORE_BOGUS_ERROR_RESPONSES, 
"icmp_ignore_bogus_error_responses",
 	 &sysctl_icmp_ignore_bogus_error_responses, sizeof(int), 0644, NULL,
 	 &proc_dointvec},
+	{NET_IPV4_ICMP_DEFAULT_TTL, "icmp_default_ttl",
+	&sysctl_icmp_default_ttl,sizeof(int), 0644,NULL,
+	&proc_dointvec},
 	{NET_IPV4_ROUTE, "route", NULL, 0, 0555, ipv4_route_table},
 #ifdef CONFIG_IP_MULTICAST
 	{NET_IPV4_IGMP_MAX_MEMBERSHIPS, "igmp_max_memberships",
- --- linux/net/ipv4/ip_output.c	Thu Oct 18 00:16:39 2001
+++ linux-2.4.18/net/ipv4/ip_output.c	Tue Jun 11 15:58:07 2002
@@ -84,6 +84,9 @@
 
 int sysctl_ip_dynaddr = 0;
 int sysctl_ip_default_ttl = IPDEFTTL;
+#ifdef CONFIG_SYSCTL
+extern int sysctl_icmp_default_ttl;
+#endif
 
 /* Generate a checksum for an outgoing IP datagram. */
 __inline__ void ip_send_check(struct iphdr *iph)
@@ -572,10 +575,17 @@
 				 */
 				mf = htons(IP_MF);
 			}
- -			if (rt->rt_type == RTN_MULTICAST)
- -				iph->ttl = sk->protinfo.af_inet.mc_ttl;
- -			else
- -				iph->ttl = sk->protinfo.af_inet.ttl;
+#ifdef CONFIG_SYSCTL
+			if(sk->protocol != IPPROTO_ICMP) {
+#endif
+				if (rt->rt_type == RTN_MULTICAST) 
+					iph->ttl = sk->protinfo.af_inet.mc_ttl;
+				else
+					iph->ttl = sk->protinfo.af_inet.ttl;
+#ifdef CONFIG_SYSCTL			
+			}
+				else iph->ttl = sysctl_icmp_default_ttl;
+#endif
 			iph->protocol = sk->protocol;
 			iph->check = 0;
 			iph->saddr = rt->rt_src;
@@ -693,10 +703,19 @@
 		iph->tos=sk->protinfo.af_inet.tos;
 		iph->tot_len = htons(length);
 		iph->frag_off = df;
- -		iph->ttl=sk->protinfo.af_inet.mc_ttl;
+		/* set TTL for ICMP packets */
+#ifdef	CONFIG_SYSCTL
+		if(iph->protocol == IPPROTO_ICMP)
+			iph->ttl = sysctl_icmp_default_ttl;
+		else {
+#endif
+			if(rt->rt_type != RTN_MULTICAST)
+				iph->ttl = sk->protinfo.af_inet.ttl;
+			else iph->ttl = sk->protinfo.af_inet.mc_ttl;
+#ifdef CONFIG_SYSCTL
+		}
+#endif
 		ip_select_ident(iph, &rt->u.dst, sk);
- -		if (rt->rt_type != RTN_MULTICAST)
- -			iph->ttl=sk->protinfo.af_inet.ttl;
 		iph->protocol=sk->protocol;
 		iph->saddr=rt->rt_src;
 		iph->daddr=rt->rt_dst;
- --- linux/net/ipv4/icmp.c	Mon Feb 25 21:38:14 2002
+++ linux-2.4.18/net/ipv4/icmp.c	Tue Jun 11 15:36:36 2002
@@ -143,6 +143,9 @@
 int sysctl_icmp_echo_ignore_all;
 int sysctl_icmp_echo_ignore_broadcasts;
 
+/* Control max icmp ttl. */
+int sysctl_icmp_default_ttl = 255;
+
 /* Control parameter - ignore bogus broadcast responses? */
 int sysctl_icmp_ignore_bogus_error_responses;
 
- --- /usr/src/linux/include/linux/sysctl.h	Mon Nov 26 15:29:17 2001
+++ /usr/src/linux-2.4.18/include/linux/sysctl.h	Mon Jun 10 21:50:50 2002
@@ -289,7 +289,8 @@
 	NET_TCP_ADV_WIN_SCALE=87,
 	NET_IPV4_NONLOCAL_BIND=88,
 	NET_IPV4_ICMP_RATELIMIT=89,
- -	NET_IPV4_ICMP_RATEMASK=90
+	NET_IPV4_ICMP_RATEMASK=90,
+	NET_IPV4_ICMP_DEFAULT_TTL=91
 };
 
 enum {


- -- 
Lev V. Vanyan                    Software Engineer
Mirotel ISP                      nic-hdl: VL1580-RIPE, LV2560-NIC
mailto: remedy@mirotel.net
-----BEGIN PGP SIGNATURE-----
Version: 2.6.3a
Charset: noconv

iQB1AwUBPQYCjM9Sz223N4s1AQF+5gL9Eud0HFe2cRtZKujDJRwQoUJE6RAGEJrY
mR/ZleJQ/Wc8TjcQn/wFHUNQqKVmZeZNk4wGZl/pr3ynq5iAaNgkpVcM84YvzbVo
Ia7Vv1yruHQPOiaNazIDlVv+FH8htTTb
=5mdT
-----END PGP SIGNATURE-----

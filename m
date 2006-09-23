Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWIWMVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWIWMVH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 08:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWIWMVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 08:21:07 -0400
Received: from ironport-c10.fh-zwickau.de ([141.32.72.200]:10543 "EHLO
	ironport-c10.fh-zwickau.de") by vger.kernel.org with ESMTP
	id S1750771AbWIWMVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 08:21:05 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAIrDFEWLcAIN
X-IronPort-AV: i="4.09,207,1157320800"; 
   d="scan'208"; a="3399387:sNHT51122124"
Date: Sat, 23 Sep 2006 14:20:36 +0200
From: Joerg Roedel <joro-lkml@zlug.org>
To: Patrick McHardy <kaber@trash.net>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 03/03][IPROUTE2] EtherIP tunnel and device support for iproute2
Message-ID: <20060923122036.GD32284@zlug.org>
References: <20060923120704.GA32284@zlug.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="veXX9dWIonWZEC6h"
Content-Disposition: inline
In-Reply-To: <20060923120704.GA32284@zlug.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch adds support for EtherIP tunnels and devices to the iproute2
userspace software package.

Signed-off-by: Joerg Roedel <joro-lkml@zlug.org>

--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch_iproute2

diff -urp iproute2-2.6.16-060323.orig/ip/iptunnel.c iproute2-2.6.16-060323/ip/iptunnel.c
--- iproute2-2.6.16-060323.orig/ip/iptunnel.c	2005-02-10 19:31:18.000000000 +0100
+++ iproute2-2.6.16-060323/ip/iptunnel.c	2006-09-20 22:35:30.000000000 +0200
@@ -44,7 +44,7 @@ static void usage(void) __attribute__((n
 static void usage(void)
 {
 	fprintf(stderr, "Usage: ip tunnel { add | change | del | show } [ NAME ]\n");
-	fprintf(stderr, "          [ mode { ipip | gre | sit } ] [ remote ADDR ] [ local ADDR ]\n");
+	fprintf(stderr, "          [ mode { ipip | gre | sit | etherip } ] [ remote ADDR ] [ local ADDR ]\n");
 	fprintf(stderr, "          [ [i|o]seq ] [ [i|o]key KEY ] [ [i|o]csum ]\n");
 	fprintf(stderr, "          [ ttl TTL ] [ tos TOS ] [ [no]pmtudisc ] [ dev PHYS_DEV ]\n");
 	fprintf(stderr, "\n");
@@ -202,6 +202,12 @@ static int parse_args(int argc, char **a
 					exit(-1);
 				}
 				p->iph.protocol = IPPROTO_IPV6;
+			} else if (strcmp(*argv, "etherip") == 0) {
+				if (p->iph.protocol && p->iph.protocol != IPPROTO_ETHERIP) {
+					fprintf(stderr,"You managed to ask for more than one tunnel mode.\n");
+					exit(-1);
+				}
+				p->iph.protocol = IPPROTO_ETHERIP;
 			} else {
 				fprintf(stderr,"Cannot guess tunnel mode.\n");
 				exit(-1);
@@ -324,11 +330,15 @@ static int parse_args(int argc, char **a
 			p->iph.protocol = IPPROTO_IPIP;
 		else if (memcmp(p->name, "sit", 3) == 0)
 			p->iph.protocol = IPPROTO_IPV6;
+		else if (memcmp(p->name, "ethip", 5) == 0)
+			p->iph.protocol = IPPROTO_ETHERIP;
 	}
 
-	if (p->iph.protocol == IPPROTO_IPIP || p->iph.protocol == IPPROTO_IPV6) {
+	if (p->iph.protocol == IPPROTO_IPIP || 
+	    p->iph.protocol == IPPROTO_IPV6 ||
+	    p->iph.protocol == IPPROTO_ETHERIP) {
 		if ((p->i_flags & GRE_KEY) || (p->o_flags & GRE_KEY)) {
-			fprintf(stderr, "Keys are not allowed with ipip and sit.\n");
+			fprintf(stderr, "Keys are not allowed with ipip, sit or etherip.\n");
 			return -1;
 		}
 	}
@@ -351,6 +361,21 @@ static int parse_args(int argc, char **a
 		fprintf(stderr, "Broadcast tunnel requires a source address.\n");
 		return -1;
 	}
+
+	if (p->iph.protocol == IPPROTO_ETHERIP) {
+		if ((cmd == SIOCADDTUNNEL || cmd == SIOCCHGTUNNEL) && !p->iph.daddr) {
+			fprintf(stderr, "EtherIP tunnel requires a "
+					"destination address.\n");
+			return -1;
+		}
+
+		/*
+		if (cmd != SIOCDELTUNNEL && p->iph.frag_off & htons(IP_DF)) {
+			fprintf(stderr, "Warning: [no]pmtudisc is ignored on"
+					" EtherIP tunnels\n");
+		}
+		*/
+	}
 	return 0;
 }
 
@@ -374,6 +399,8 @@ static int do_add(int cmd, int argc, cha
 		return do_add_ioctl(cmd, "gre0", &p);
 	case IPPROTO_IPV6:
 		return do_add_ioctl(cmd, "sit0", &p);
+	case IPPROTO_ETHERIP:
+		return do_add_ioctl(cmd, "ethip0", &p);
 	default:	
 		fprintf(stderr, "cannot determine tunnel mode (ipip, gre or sit)\n");
 		return -1;
@@ -395,6 +422,8 @@ int do_del(int argc, char **argv)
 		return do_del_ioctl("gre0", &p);
 	case IPPROTO_IPV6:
 		return do_del_ioctl("sit0", &p);
+	case IPPROTO_ETHERIP:
+		return do_del_ioctl("ethip0", &p);
 	default:	
 		return do_del_ioctl(p.name, &p);
 	}
@@ -418,7 +447,8 @@ void print_tunnel(struct ip_tunnel_parm 
 	       p->name,
 	       p->iph.protocol == IPPROTO_IPIP ? "ip" :
 	       (p->iph.protocol == IPPROTO_GRE ? "gre" :
-		(p->iph.protocol == IPPROTO_IPV6 ? "ipv6" : "unknown")),
+	       (p->iph.protocol == IPPROTO_ETHERIP ? "etherip" :
+		(p->iph.protocol == IPPROTO_IPV6 ? "ipv6" : "unknown"))),
 	       p->iph.daddr ? format_host(AF_INET, 4, &p->iph.daddr, s1, sizeof(s1))  : "any",
 	       p->iph.saddr ? rt_addr_n2a(AF_INET, 4, &p->iph.saddr, s2, sizeof(s2)) : "any");
 
@@ -431,19 +461,19 @@ void print_tunnel(struct ip_tunnel_parm 
 	if (p->iph.ttl)
 		printf(" ttl %d ", p->iph.ttl);
 	else
-		printf(" ttl inherit ");
+		printf(" ttl %s", p->iph.protocol != IPPROTO_ETHERIP ? "inherit " : "default");
 	
 	if (p->iph.tos) {
 		SPRINT_BUF(b1);
 		printf(" tos");
 		if (p->iph.tos&1)
-			printf(" inherit");
+			printf(" %s", p->iph.protocol != IPPROTO_ETHERIP ? "inherit" : "default");
 		if (p->iph.tos&~1)
 			printf("%c%s ", p->iph.tos&1 ? '/' : ' ',
 			       rtnl_dsfield_n2a(p->iph.tos&~1, b1, sizeof(b1)));
 	}
 
-	if (!(p->iph.frag_off&htons(IP_DF)))
+	if (p->iph.protocol != IPPROTO_ETHERIP && !(p->iph.frag_off&htons(IP_DF)))
 		printf(" nopmtudisc");
 
 	if ((p->i_flags&GRE_KEY) && (p->o_flags&GRE_KEY) && p->o_key == p->i_key)
@@ -506,8 +536,13 @@ static int do_tunnels_list(struct ip_tun
 			fprintf(stderr, "Failed to get type of [%s]\n", name);
 			continue;
 		}
-		if (type != ARPHRD_TUNNEL && type != ARPHRD_IPGRE && type != ARPHRD_SIT)
+
+		if (type != ARPHRD_TUNNEL &&
+		    type != ARPHRD_IPGRE &&
+		    type != ARPHRD_SIT &&
+		    type != ARPHRD_ETHERIP)
 			continue;
+
 		memset(&p1, 0, sizeof(p1));
 		if (do_get_ioctl(name, &p1))
 			continue;
diff -urp iproute2-2.6.16-060323.orig/lib/ll_types.c iproute2-2.6.16-060323/lib/ll_types.c
--- iproute2-2.6.16-060323.orig/lib/ll_types.c	2005-02-09 23:07:24.000000000 +0100
+++ iproute2-2.6.16-060323/lib/ll_types.c	2006-09-23 13:19:16.000000000 +0200
@@ -118,6 +118,9 @@ __PF(IEEE802_TR,tr)
 #ifdef ARPHRD_IEEE80211
 __PF(IEEE80211,ieee802.11)
 #endif
+#ifdef ARPHRD_ETHERIP
+__PF(ETHERIP, etherip)
+#endif
 #ifdef ARPHRD_VOID
 __PF(VOID,void)
 #endif

--veXX9dWIonWZEC6h--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264089AbRFSJ3L>; Tue, 19 Jun 2001 05:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264096AbRFSJ3C>; Tue, 19 Jun 2001 05:29:02 -0400
Received: from juicer14.bigpond.com ([139.134.6.23]:14578 "EHLO
	mailin2.email.bigpond.com") by vger.kernel.org with ESMTP
	id <S264089AbRFSJ25>; Tue, 19 Jun 2001 05:28:57 -0400
Message-Id: <m15CHtu-001UIzC@mozart>
From: Rusty Russell <rusty@rustcorp.com.au>
To: =?ISO-8859-2?Q?Kajt=E1r_Zsolt?= <soci@firewall.sch.bme.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Iptables ipt_unclean bug? 
In-Reply-To: Your message of "Tue, 19 Jun 2001 01:26:17 +0200."
             <Pine.LNX.4.21.0106190104020.414-100000@firewall.sch.bme.hu> 
Date: Tue, 19 Jun 2001 19:34:22 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.21.0106190104020.414-100000@firewall.sch.bme.hu> you wri
te:
> 
> Hi all!
> 
> I think it's possible to hang the kernel useing isic 0.05
> (www.packetfactory.net/Projects/ISIC/), when there's a unclean match in
> iptables rules.

Thanks for the bug report.  I've just done an audit of the unclean
code: patch against 2.4.5 is below.  There were some bad thinkos
there, two fatal.

It'd be nice if someone else audits it, as I wrote it in the first
place...

Untested, please report back.

Cheers,
Rusty.
--
Premature optmztion is rt of all evl. --DK

--- linux-2.4.5-official/net/ipv4/netfilter/ipt_unclean.c	Fri Apr 28 08:43:15 2000
+++ working-2.4.5-hotplug/net/ipv4/netfilter/ipt_unclean.c	Tue Jun 19 19:30:32 2001
@@ -76,7 +76,7 @@
 		    = { 12, 12, ICMP_NOT_ERROR, 0, 0 } };
 
 	/* Can't do anything if it's a fragment. */
-	if (!offset)
+	if (offset)
 		return 1;
 
 	/* Must cover type and code. */
@@ -87,7 +87,7 @@
 
 	/* If not embedded. */
 	if (!embedded) {
-		/* Bad checksum?  Don't print, just drop. */
+		/* Bad checksum?  Don't print, just ignore. */
 		if (!more_frags
 		    && ip_compute_csum((unsigned char *) icmph, datalen) != 0)
 			return 0;
@@ -108,6 +108,8 @@
 			   length of iph + 8 bytes. */
 			struct iphdr *inner = (void *)icmph + 8;
 
+			/* datalen > 8 since all ICMP_IS_ERROR types
+                           have min length > 8 */
 			if (datalen - 8 < sizeof(struct iphdr)) {
 				limpk("ICMP error internal way too short\n");
 				return 0;
@@ -155,6 +157,8 @@
 		u_int32_t arg = ntohl(icmph->un.gateway);
 
 		if (icmph->code == 0) {
+			/* Code 0 means that upper 8 bits is pointer
+                           to problem. */
 			if ((arg >> 24) >= iph->ihl*4) {
 				limpk("ICMP PARAMETERPROB ptr = %u\n",
 				      ntohl(icmph->un.gateway) >> 24);
@@ -196,7 +200,7 @@
 	  int embedded)
 {
 	/* Can't do anything if it's a fragment. */
-	if (!offset)
+	if (offset)
 		return 1;
 
 	/* CHECK: Must cover UDP header. */
@@ -205,7 +209,7 @@
 		return 0;
 	}
 
-	/* Bad checksum?  Don't print, just drop. */
+	/* Bad checksum?  Don't print, just say it's unclean. */
 	/* FIXME: SRC ROUTE packets won't match checksum --RR */
 	if (!more_frags && !embedded
 	    && csum_tcpudp_magic(iph->saddr, iph->daddr, datalen, IPPROTO_UDP,
@@ -272,7 +276,7 @@
 	/* In fact, this is caught below (offset < 516). */
 
 	/* Can't do anything if it's a fragment. */
-	if (!offset)
+	if (offset)
 		return 1;
 
 	/* CHECK: Smaller than minimal TCP hdr. */
@@ -281,7 +285,8 @@
 			limpk("Packet length %u < TCP header.\n", datalen);
 			return 0;
 		}
-		/* Must have ports available (datalen >= 8). */
+		/* Must have ports available (datalen >= 8), from
+                   check_icmp which set embedded = 1 */
 		/* CHECK: TCP ports inside ICMP error */
 		if (!tcph->source || !tcph->dest) {
 			limpk("Zero TCP ports %u/%u.\n",
@@ -301,7 +306,7 @@
 			return 1;
 	}
 
-	/* Bad checksum?  Don't print, just drop. */
+	/* Bad checksum?  Don't print, just say it's unclean. */
 	/* FIXME: SRC ROUTE packets won't match checksum --RR */
 	if (!more_frags && !embedded
 	    && csum_tcpudp_magic(iph->saddr, iph->daddr, datalen, IPPROTO_TCP,
@@ -373,6 +378,8 @@
 				      (unsigned int) opt[i], i);
 				return 0;
 			}
+			/* Move to next option */
+			i += opt[i+1];
 		}
 	}
 
@@ -442,6 +449,8 @@
 				      opt[i], i);
 				return 0;
 			}
+			/* Move to next option */
+			i += opt[i+1];
 		}
 	}
 
@@ -495,10 +504,10 @@
 		return 0;
 	}
 
-	/* CHECK: Min offset of frag = 128 - 60 (max IP hdr len). */
-	if (offset && offset * 8 < MIN_LIKELY_MTU - 60) {
+	/* CHECK: Min offset of frag = 128 - IP hdr len. */
+	if (offset && offset * 8 < MIN_LIKELY_MTU - iph->ihl * 4) {
 		limpk("Fragment starts at %u < %u\n", offset * 8,
-		      MIN_LIKELY_MTU-60);
+		      MIN_LIKELY_MTU - iph->ihl * 4);
 		return 0;
 	}
 

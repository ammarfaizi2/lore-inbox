Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269464AbRGaUQv>; Tue, 31 Jul 2001 16:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269463AbRGaUQo>; Tue, 31 Jul 2001 16:16:44 -0400
Received: from [62.116.8.197] ([62.116.8.197]:1408 "HELO ghanima.endorphin.org")
	by vger.kernel.org with SMTP id <S269457AbRGaUQe>;
	Tue, 31 Jul 2001 16:16:34 -0400
Date: Tue, 31 Jul 2001 22:16:35 +0200
From: clemens <therapy@endorphin.org>
To: kuznet@ms2.inr.ac.ru
Cc: pekkas@netcore.fi, cw@f00f.org, netdev@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: missing icmp errors for udp packets
Message-ID: <20010731221635.A471@ghanima.endorphin.org>
In-Reply-To: <200107311857.WAA10162@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <200107311857.WAA10162@ms2.inr.ac.ru>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 31, 2001 at 10:57:34PM +0400, kuznet@ms2.inr.ac.ru wrote:
> > consequently since there is only one token bucket, there can only be one
> > icmp rate limit. we can add a icmp type mask to enable/disable rate limiting 
> > for certain types.
> Yes. Logically this is 100% right. Also, see below.
> 

please give this draft-like patch a try.
here at my box it does correct limiting and omits limiting for unfiltered
types like echo-reply.

clemens

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="icmp-global-rate.patch"

diff -u linux-sane/net/ipv4/icmp.c linux/net/ipv4/icmp.c
--- linux-sane/net/ipv4/icmp.c	Thu Jun 21 06:00:55 2001
+++ linux/net/ipv4/icmp.c	Tue Jul 31 22:01:13 2001
@@ -16,6 +16,9 @@
  *	Other than that this module is a complete rewrite.
  *
  *	Fixes:
+ *	Clemens Fruhwirth	:	introduce global icmp rate limiting
+ *					with filter mask ability instead
+ *					of unclean mixed icmp timeouts.
  *		Mike Shaver	:	RFC1122 checks.
  *		Alan Cox	:	Multicast ping reply as self.
  *		Alan Cox	:	Fix atomicity lockup in ip_build_xmit 
@@ -145,6 +148,20 @@
 /* Control parameter - ignore bogus broadcast responses? */
 int sysctl_icmp_ignore_bogus_error_responses;
 
+/* 
+ * 	Configurable rate limits.
+ *	Someone should check if these default values are correct.
+ *	Note that these values interact with the routing cache GC timeout.
+ *	If you chose them too high they won't take effect, because the
+ *	dst_entry gets expired too early. The same should happen when
+ *	the cache grows too big.
+ */
+//int sysctl_icmp_destunreach_time = 1*HZ;
+//int sysctl_icmp_timeexceed_time = 1*HZ;
+//int sysctl_icmp_paramprob_time = 1*HZ;
+//int sysctl_icmp_echoreply_time; /* don't limit it per default. */
+int sysctl_icmp_ratelimit = 1*HZ;
+
 /*
  *	ICMP control array. This specifies what to do with each ICMP.
  */
@@ -155,7 +172,7 @@
 	unsigned long *input;		/* Address to increment on input */
 	void (*handler)(struct sk_buff *skb);
 	short	error;		/* This ICMP is classed as an error message */
-	int *timeout; /* Rate limit */
+//	int *timeout; /* Rate limit */
 };
 
 static struct icmp_control icmp_pointers[NR_ICMP_TYPES+1];
@@ -257,7 +270,7 @@
 {
 	struct dst_entry *dst = &rt->u.dst; 
 
-	if (type > NR_ICMP_TYPES || !icmp_pointers[type].timeout)
+	if (type > NR_ICMP_TYPES)
 		return 1;
 
 	/* Don't limit PMTU discovery. */
@@ -272,7 +285,15 @@
 	if (dst->dev && (dst->dev->flags&IFF_LOOPBACK))
  		return 1;
 
-	return xrlim_allow(dst, *(icmp_pointers[type].timeout));
+#define sysctl_icmp_filtermask 0x1818
+
+// filters destunreach (0x03), source quench (0x04)
+// time exceed (0x11), paraprob (0x12)
+
+	if((1 << type) & sysctl_icmp_filtermask)
+	 return xrlim_allow(dst,sysctl_icmp_ratelimit);
+	else
+	 return 1;
 }
 
 /*
@@ -929,18 +950,7 @@
 }
 
 
-/* 
- * 	Configurable rate limits.
- *	Someone should check if these default values are correct.
- *	Note that these values interact with the routing cache GC timeout.
- *	If you chose them too high they won't take effect, because the
- *	dst_entry gets expired too early. The same should happen when
- *	the cache grows too big.
- */
-int sysctl_icmp_destunreach_time = 1*HZ;
-int sysctl_icmp_timeexceed_time = 1*HZ;
-int sysctl_icmp_paramprob_time = 1*HZ;
-int sysctl_icmp_echoreply_time; /* don't limit it per default. */
+
 
 /*
  *	This table is the definition of how we handle ICMP.
@@ -948,37 +958,37 @@
  
 static struct icmp_control icmp_pointers[NR_ICMP_TYPES+1] = {
 /* ECHO REPLY (0) */
- { &icmp_statistics[0].IcmpOutEchoReps, &icmp_statistics[0].IcmpInEchoReps, icmp_discard, 0, &sysctl_icmp_echoreply_time},
- { &icmp_statistics[0].dummy, &icmp_statistics[0].IcmpInErrors, icmp_discard, 1, },
- { &icmp_statistics[0].dummy, &icmp_statistics[0].IcmpInErrors, icmp_discard, 1, },
+ { &icmp_statistics[0].IcmpOutEchoReps, &icmp_statistics[0].IcmpInEchoReps, icmp_discard, 0 },
+ { &icmp_statistics[0].dummy, &icmp_statistics[0].IcmpInErrors, icmp_discard, 1 },
+ { &icmp_statistics[0].dummy, &icmp_statistics[0].IcmpInErrors, icmp_discard, 1 },
 /* DEST UNREACH (3) */
- { &icmp_statistics[0].IcmpOutDestUnreachs, &icmp_statistics[0].IcmpInDestUnreachs, icmp_unreach, 1, &sysctl_icmp_destunreach_time },
+ { &icmp_statistics[0].IcmpOutDestUnreachs, &icmp_statistics[0].IcmpInDestUnreachs, icmp_unreach, 1 },
 /* SOURCE QUENCH (4) */
- { &icmp_statistics[0].IcmpOutSrcQuenchs, &icmp_statistics[0].IcmpInSrcQuenchs, icmp_unreach, 1, },
+ { &icmp_statistics[0].IcmpOutSrcQuenchs, &icmp_statistics[0].IcmpInSrcQuenchs, icmp_unreach, 1 },
 /* REDIRECT (5) */
- { &icmp_statistics[0].IcmpOutRedirects, &icmp_statistics[0].IcmpInRedirects, icmp_redirect, 1, },
- { &icmp_statistics[0].dummy, &icmp_statistics[0].IcmpInErrors, icmp_discard, 1, },
- { &icmp_statistics[0].dummy, &icmp_statistics[0].IcmpInErrors, icmp_discard, 1, },
+ { &icmp_statistics[0].IcmpOutRedirects, &icmp_statistics[0].IcmpInRedirects, icmp_redirect, 1 },
+ { &icmp_statistics[0].dummy, &icmp_statistics[0].IcmpInErrors, icmp_discard, 1 },
+ { &icmp_statistics[0].dummy, &icmp_statistics[0].IcmpInErrors, icmp_discard, 1 },
 /* ECHO (8) */
- { &icmp_statistics[0].IcmpOutEchos, &icmp_statistics[0].IcmpInEchos, icmp_echo, 0, },
- { &icmp_statistics[0].dummy, &icmp_statistics[0].IcmpInErrors, icmp_discard, 1, },
- { &icmp_statistics[0].dummy, &icmp_statistics[0].IcmpInErrors, icmp_discard, 1, },
+ { &icmp_statistics[0].IcmpOutEchos, &icmp_statistics[0].IcmpInEchos, icmp_echo, 0 },
+ { &icmp_statistics[0].dummy, &icmp_statistics[0].IcmpInErrors, icmp_discard, 1 },
+ { &icmp_statistics[0].dummy, &icmp_statistics[0].IcmpInErrors, icmp_discard, 1 },
 /* TIME EXCEEDED (11) */
- { &icmp_statistics[0].IcmpOutTimeExcds, &icmp_statistics[0].IcmpInTimeExcds, icmp_unreach, 1, &sysctl_icmp_timeexceed_time },
+ { &icmp_statistics[0].IcmpOutTimeExcds, &icmp_statistics[0].IcmpInTimeExcds, icmp_unreach, 1 },
 /* PARAMETER PROBLEM (12) */
- { &icmp_statistics[0].IcmpOutParmProbs, &icmp_statistics[0].IcmpInParmProbs, icmp_unreach, 1, &sysctl_icmp_paramprob_time },
+ { &icmp_statistics[0].IcmpOutParmProbs, &icmp_statistics[0].IcmpInParmProbs, icmp_unreach, 1 },
 /* TIMESTAMP (13) */
- { &icmp_statistics[0].IcmpOutTimestamps, &icmp_statistics[0].IcmpInTimestamps, icmp_timestamp, 0,  },
+ { &icmp_statistics[0].IcmpOutTimestamps, &icmp_statistics[0].IcmpInTimestamps, icmp_timestamp, 0 },
 /* TIMESTAMP REPLY (14) */
- { &icmp_statistics[0].IcmpOutTimestampReps, &icmp_statistics[0].IcmpInTimestampReps, icmp_discard, 0, },
+ { &icmp_statistics[0].IcmpOutTimestampReps, &icmp_statistics[0].IcmpInTimestampReps, icmp_discard, 0 },
 /* INFO (15) */
- { &icmp_statistics[0].dummy, &icmp_statistics[0].dummy, icmp_discard, 0, },
+ { &icmp_statistics[0].dummy, &icmp_statistics[0].dummy, icmp_discard, 0 },
 /* INFO REPLY (16) */
- { &icmp_statistics[0].dummy, &icmp_statistics[0].dummy, icmp_discard, 0, },
+ { &icmp_statistics[0].dummy, &icmp_statistics[0].dummy, icmp_discard, 0 },
 /* ADDR MASK (17) */
- { &icmp_statistics[0].IcmpOutAddrMasks, &icmp_statistics[0].IcmpInAddrMasks, icmp_address, 0,  },
+ { &icmp_statistics[0].IcmpOutAddrMasks, &icmp_statistics[0].IcmpInAddrMasks, icmp_address, 0 },
 /* ADDR MASK REPLY (18) */
- { &icmp_statistics[0].IcmpOutAddrMaskReps, &icmp_statistics[0].IcmpInAddrMaskReps, icmp_address_reply, 0, }
+ { &icmp_statistics[0].IcmpOutAddrMaskReps, &icmp_statistics[0].IcmpInAddrMaskReps, icmp_address_reply, 0 }
 };
 
 void __init icmp_init(struct net_proto_family *ops)
Common subdirectories: linux-sane/net/ipv4/netfilter and linux/net/ipv4/netfilter
diff -u linux-sane/net/ipv4/sysctl_net_ipv4.c linux/net/ipv4/sysctl_net_ipv4.c
--- linux-sane/net/ipv4/sysctl_net_ipv4.c	Mon Mar 26 04:14:25 2001
+++ linux/net/ipv4/sysctl_net_ipv4.c	Tue Jul 31 21:44:56 2001
@@ -32,10 +32,14 @@
 extern int sysctl_ip_dynaddr;
 
 /* From icmp.c */
+/*
 extern int sysctl_icmp_destunreach_time;
 extern int sysctl_icmp_timeexceed_time;
 extern int sysctl_icmp_paramprob_time;
 extern int sysctl_icmp_echoreply_time;
+*/
+extern int sysctl_icmp_ratelimit;
+extern int sysctl_icmp_filtermask;
 
 /* From igmp.c */
 extern int sysctl_igmp_max_memberships;
@@ -178,6 +182,7 @@
 	{NET_IPV4_ICMP_IGNORE_BOGUS_ERROR_RESPONSES, "icmp_ignore_bogus_error_responses",
 	 &sysctl_icmp_ignore_bogus_error_responses, sizeof(int), 0644, NULL,
 	 &proc_dointvec},
+/*
 	{NET_IPV4_ICMP_DESTUNREACH_RATE, "icmp_destunreach_rate",
 	 &sysctl_icmp_destunreach_time, sizeof(int), 0644, NULL, &proc_dointvec},
 	{NET_IPV4_ICMP_TIMEEXCEED_RATE, "icmp_timeexceed_rate",
@@ -187,6 +192,7 @@
 	{NET_IPV4_ICMP_ECHOREPLY_RATE, "icmp_echoreply_rate",
 	 &sysctl_icmp_echoreply_time, sizeof(int), 0644, NULL, &proc_dointvec},
 	{NET_IPV4_ROUTE, "route", NULL, 0, 0555, ipv4_route_table},
+*/
 #ifdef CONFIG_IP_MULTICAST
 	{NET_IPV4_IGMP_MAX_MEMBERSHIPS, "igmp_max_memberships",
 	 &sysctl_igmp_max_memberships, sizeof(int), 0644, NULL, &proc_dointvec},

--2oS5YaxWCcQjTEyO--

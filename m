Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316789AbSFKWW7>; Tue, 11 Jun 2002 18:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316803AbSFKWW6>; Tue, 11 Jun 2002 18:22:58 -0400
Received: from mail2.mail.iol.ie ([194.125.2.193]:25552 "EHLO
	mail2.mail.iol.ie") by vger.kernel.org with ESMTP
	id <S316789AbSFKWW4>; Tue, 11 Jun 2002 18:22:56 -0400
Message-ID: <3D06785F.3090909@antefacto.com>
Date: Tue, 11 Jun 2002 23:23:27 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] ip-sysctl.txt
In-Reply-To: <02061117004401.01217@fortress.mirotel.net>	<3D06051C.3030305@antefacto.com> <20020611.071225.65985367.davem@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------070007040708050007030503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070007040708050007030503
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David S. Miller wrote:
>    From: Padraig Brady <padraig@antefacto.com>
>    Date: Tue, 11 Jun 2002 15:11:40 +0100
> 
>    /proc/sys/net/ipv4/conf/../{arp_filter,tag}
>    are not documented.
>    
> Nobody had time to document them, that is all.

Patch (against 2.5.21) attached to add this documentation
and fix other bits.

>    /proc/sys/net/ipv4/icmp_rate_limit is jiffies.
>    Shouldn't this be HZ, i.e. jiffies shouldn't
>    be exported to userspace as it's non portable?
> 
> What if you want to specify value smaller than HZ?
> That is the most typical for this setting.
> 

I didn't touch this as there were other sysctls
specified in jiffies, and also it would break
compatability with existing config. I still think
jiffies should be hidden from userspace.

cheers,
Padraig.

--------------070007040708050007030503
Content-Type: text/plain;
 name="ip-sysctl.txt-2.5.21.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ip-sysctl.txt-2.5.21.diff"

--- linux-2.5.21/Documentation/networking/ip-sysctl.txt	Sun Jun  9 06:29:26 2002
+++ linux-2.5.21/Documentation/networking/ip-sysctl-pb.txt	Tue Jun 11 23:14:55 2002
@@ -43,23 +43,23 @@
 	Minimum time-to-live of entries.  Should be enough to cover fragment
 	time-to-live on the reassembling side.  This minimum time-to-live  is
 	guaranteed if the pool size is less than inet_peer_threshold.
-	Measured in jiffies.
+	Measured in jiffies(1).
 
 inet_peer_maxttl - INTEGER
 	Maximum time-to-live of entries.  Unused entries will expire after
 	this period of time if there is no memory pressure on the pool (i.e.
 	when the number of entries in the pool is very small).
-	Measured in jiffies.
+	Measured in jiffies(1).
 
 inet_peer_gc_mintime - INTEGER
 	Minimum interval between garbage collection passes.  This interval is
 	in effect under high memory pressure on the pool.
-	Measured in jiffies.
+	Measured in jiffies(1).
 
 inet_peer_gc_maxtime - INTEGER
 	Minimum interval between garbage collection passes.  This interval is
 	in effect under low (or absent) memory pressure on the pool.
-	Measured in jiffies.
+	Measured in jiffies(1).
 
 TCP variables: 
 
@@ -81,7 +81,7 @@
 	How many keepalive probes TCP sends out, until it decides that the
 	connection is broken. Default value: 9.
 
-tcp_keepalive_interval - INTEGER
+tcp_keepalive_intvl - INTEGER
 	How frequently the probes are send out. Multiplied by
 	tcp_keepalive_probes it is time to kill not responding connection,
 	after probes started. Default value: 75sec i.e. connection
@@ -316,28 +316,37 @@
 	Limit the maximal rates for sending ICMP packets whose type matches
 	icmp_ratemask (see below) to specific targets.
 	0 to disable any limiting, otherwise the maximal rate in jiffies(1)
-	Default: 1
+	Default: 100
 
 icmp_ratemask - INTEGER
 	Mask made of ICMP types for which rates are being limited.
-	Default: 6168
-	Note: 6168 = 0x1818 = 1<<ICMP_DEST_UNREACH + 1<<ICMP_SOURCE_QUENCH +
-	      1<<ICMP_TIME_EXCEEDED + 1<<ICMP_PARAMETERPROB, which means
-	      dest unreachable (3), source quench (4), time exceeded (11)
-	      and parameter problem (12) ICMP packets are rate limited
-	      (check values in icmp.h)
+	Significant bits: IHGFEDCBA9876543210
+	Default mask:     0000001100000011000 (6168)
+
+	Bit definitions (see include/linux/icmp.h):
+		0 Echo Reply
+		3 Destination Unreachable *
+		4 Source Quench *
+		5 Redirect
+		8 Echo Request
+		B Time Exceeded *
+		C Parameter Problem *
+		D Timestamp Request
+		E Timestamp Reply
+		F Info Request
+		G Info Reply
+		H Address Mask Request
+		I Address Mask Reply
+
+	* These are rate limited by default (see default mask above)
 
 icmp_ignore_bogus_error_responses - BOOLEAN
-	Some routers violate RFC 1122 by sending bogus responses to broadcast
+	Some routers violate RFC1122 by sending bogus responses to broadcast
 	frames.  Such violations are normally logged via a kernel warning.
 	If this is set to TRUE, the kernel will not give such warnings, which
 	will avoid log file clutter.
 	Default: FALSE
 
-(1) Jiffie: internal timeunit for the kernel. On the i386 1/100s, on the
-Alpha 1/1024s. See the HZ define in /usr/include/asm/param.h for the exact
-value on your system. 
-
 igmp_max_memberships - INTEGER
 	Change the maximum number of multicast groups we can subscribe to.
 	Default: 20
@@ -411,7 +420,30 @@
 	0 - No source validation. 
 
 	Default value is 0. Note that some distributions enable it
-	in startip scripts.
+	in startup scripts.
+
+arp_filter - BOOLEAN
+	1 - Allows you to have multiple network interfaces on the same
+	subnet, and have the ARPs for each interface be answered
+	based on whether or not the kernel would route a packet from
+	the ARP'd IP out that interface (therefore you must use source
+	based routing for this to work). In other words it allows control
+	of which cards (usually 1) will respond to an arp request.
+
+	0 - (default) The kernel can respond to arp requests with addresses
+	from other interfaces. This may seem wrong but it usually makes
+	sense, because it increases the chance of successful communication.
+	IP addresses are owned by the complete host on Linux, not by
+	particular interfaces. Only for more complex setups like load-
+	balancing, does this behaviour cause problems.
+
+tag - INTEGER
+	Allows you to write a number, which can be used as required.
+	Default value is 0.
+
+(1) Jiffie: internal timeunit for the kernel. On the i386 1/100s, on the
+Alpha 1/1024s. See the HZ define in /usr/include/asm/param.h for the exact
+value on your system. 
 
 Alexey Kuznetsov.
 kuznet@ms2.inr.ac.ru

--------------070007040708050007030503--


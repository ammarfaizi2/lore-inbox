Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264290AbUARXeq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 18:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264291AbUARXeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 18:34:46 -0500
Received: from mail1.slu.se ([130.238.96.11]:55711 "EHLO mail1.slu.se")
	by vger.kernel.org with ESMTP id S264290AbUARXel convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 18:34:41 -0500
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16395.5021.616055.384516@robur.slu.se>
Date: Mon, 19 Jan 2004 00:15:41 +0100
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Lennert Buytenhek <buytenh@gnu.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: [PATCH] Re: [2.6.0, pktgen] divide-by-zero
In-Reply-To: <20040118154802.GE10397@wohnheim.fh-wedel.de>
References: <20031231111316.GA10218@gnu.org>
	<20040118154802.GE10397@wohnheim.fh-wedel.de>
X-Mailer: VM 7.17 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello!

Jörn Engel writes:
 > On Wed, 31 December 2003 06:13:16 -0500, Lennert Buytenhek wrote:
 > > 
 > > When generating packets with pktgen with count=10, I get a divide-by-zero
 > > oops in inject().
 > > 
 > > Line 273 in net/core/pktgen.c seems unsafe:
 > > 	__u64 pps = (__u32)(info->sofar * 1000) / ((__u32)(total) / 1000);
 > > 
 > > What if total < 1000 ?
 > 
 > Since noone else seemed to care, try this patch.  Against -test11,
 > yeah, I'm lazy again.


 Sorry I missed Lennerts original posting... 

 I suggest the patch below to get integer precision at very short time 
 intervals too.


--- linux-2.6.1/net/core/pktgen.c.orig	Sun Jan 18 21:56:56 2004
+++ linux-2.6.1/net/core/pktgen.c	Sun Jan 18 23:15:03 2004
@@ -88,7 +88,7 @@
 #define cycles()	((u32)get_cycles())
 
 
-#define VERSION "pktgen version 1.3"
+#define VERSION "pktgen version 1.31"
 static char version[] __initdata = 
   "pktgen.c: v1.3: Packet Generator for packet performance testing.\n";
 
@@ -720,8 +720,18 @@
 
 	{
 		char *p = info->result;
-		__u64 pps = (__u32)(info->sofar * 1000) / ((__u32)(total) / 1000);
-		__u64 bps = pps * 8 * (info->pkt_size + 4); /* take 32bit ethernet CRC into account */
+		__u64 bps, pps = 0;
+
+		if (total > 1000)
+			pps = (__u32)(info->sofar * 1000) / ((__u32)(total) / 1000);
+		else if(total > 100)
+			pps = (__u32)(info->sofar * 10000) / ((__u32)(total) / 100);
+		else if(total > 10)
+			pps = (__u32)(info->sofar * 100000) / ((__u32)(total) / 10);
+		else if(total > 1)
+			pps = (__u32)(info->sofar * 1000000) / (__u32)total;
+
+		bps = pps * 8 * (info->pkt_size + 4); /* take 32bit ethernet CRC into account */
 		p += sprintf(p, "OK: %llu(c%llu+d%llu) usec, %llu (%dbyte,%dfrags) %llupps %lluMb/sec (%llubps)  errors: %llu",
 			     (unsigned long long) total,
 			     (unsigned long long) (total - idle),



Cheers.
						--ro

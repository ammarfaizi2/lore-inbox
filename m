Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbUARPs2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 10:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbUARPs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 10:48:28 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:6617 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S261877AbUARPs0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 10:48:26 -0500
Date: Sun, 18 Jan 2004 16:48:02 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Lennert Buytenhek <buytenh@gnu.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [PATCH] Re: [2.6.0, pktgen] divide-by-zero
Message-ID: <20040118154802.GE10397@wohnheim.fh-wedel.de>
References: <20031231111316.GA10218@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031231111316.GA10218@gnu.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 December 2003 06:13:16 -0500, Lennert Buytenhek wrote:
> 
> When generating packets with pktgen with count=10, I get a divide-by-zero
> oops in inject().
> 
> Line 273 in net/core/pktgen.c seems unsafe:
> 	__u64 pps = (__u32)(info->sofar * 1000) / ((__u32)(total) / 1000);
> 
> What if total < 1000 ?

Since noone else seemed to care, try this patch.  Against -test11,
yeah, I'm lazy again.

Jörn

-- 
Time? What's that? Time is only worth what you do with it.
-- Theo de Raadt

--- old/net/core/pktgen.c	2003-11-26 21:44:47.000000000 +0100
+++ new/net/core/pktgen.c	2004-01-18 16:27:10.000000000 +0100
@@ -720,7 +720,9 @@
 
 	{
 		char *p = info->result;
-		__u64 pps = (__u32)(info->sofar * 1000) / ((__u32)(total) / 1000);
+		__u32 safe_total = (__u32)(total) / 1000;
+		safe_total += 1 - (!!safe_total); /* avoid divide-by-zero */
+		__u64 pps = (__u32)(info->sofar * 1000) / safe_total;
 		__u64 bps = pps * 8 * (info->pkt_size + 4); /* take 32bit ethernet CRC into account */
 		p += sprintf(p, "OK: %llu(c%llu+d%llu) usec, %llu (%dbyte,%dfrags) %llupps %lluMb/sec (%llubps)  errors: %llu",
 			     (unsigned long long) total,

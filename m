Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUB1DzQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 22:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263113AbUB1DzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 22:55:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:4243 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263117AbUB1DzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 22:55:08 -0500
Date: Fri, 27 Feb 2004 19:55:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Anton Blanchard <anton@samba.org>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, davem@redhat.com,
       kenneth.w.chen@intel.com, olof@austin.ibm.com
Subject: Re: [PATCH] performance problem with established hash
Message-Id: <20040227195548.210f7204.akpm@osdl.org>
In-Reply-To: <20040228022537.GR5801@krispykreme>
References: <20040228022537.GR5801@krispykreme>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> wrote:
>
> -		goal = min(10UL, goal);
>  +		goal = min(1UL << 10, goal);

oops.  Better fix the route cache too.

I'm not sure what went wrong in there, sorry for letting that slip through.
Obviously, doing

	if (a)
		foo = bar;
	else
		foo = zot;

	if (b)
		foo = rab;
	else
		foo = toz;

does not make a ton of sense.

This should fix it up.  We keep the table sizing identical to that which
we had in 2.6.earlier, with a boot option override.


 net/ipv4/route.c |    4 +---
 net/ipv4/tcp.c   |    4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff -puN net/ipv4/route.c~ip_rt_init-sizing-fix net/ipv4/route.c
--- 25/net/ipv4/route.c~ip_rt_init-sizing-fix	2004-02-27 19:43:01.000000000 -0800
+++ 25-akpm/net/ipv4/route.c	2004-02-27 19:51:02.000000000 -0800
@@ -2753,9 +2753,7 @@ int __init ip_rt_init(void)
 		panic("IP: failed to allocate ip_dst_cache\n");
 
 	goal = num_physpages >> (26 - PAGE_SHIFT);
-	if (!rhash_entries)
-		goal = min(10, goal);
-	else
+	if (rhash_entries)
 		goal = (rhash_entries * sizeof(struct rt_hash_bucket)) >> PAGE_SHIFT;
 	for (order = 0; (1UL << order) < goal; order++)
 		/* NOTHING */;
diff -puN net/ipv4/tcp.c~ip_rt_init-sizing-fix net/ipv4/tcp.c
--- 25/net/ipv4/tcp.c~ip_rt_init-sizing-fix	2004-02-27 19:51:40.000000000 -0800
+++ 25-akpm/net/ipv4/tcp.c	2004-02-27 19:52:27.000000000 -0800
@@ -2621,9 +2621,7 @@ void __init tcp_init(void)
 	else
 		goal = num_physpages >> (23 - PAGE_SHIFT);
 
-	if (!thash_entries)
-		goal = min(10UL, goal);
-	else
+	if (thash_entries)
 		goal = (thash_entries * sizeof(struct tcp_ehash_bucket)) >> PAGE_SHIFT;
 	for (order = 0; (1UL << order) < goal; order++)
 		;

_


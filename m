Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbULIQ1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbULIQ1A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 11:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbULIQ07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 11:26:59 -0500
Received: from oss.sgi.com ([192.48.159.27]:37279 "EHLO oss.sgi.com")
	by vger.kernel.org with ESMTP id S261543AbULIQ05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 11:26:57 -0500
Date: Thu, 9 Dec 2004 08:25:37 -0800
From: Robin Holt <holt@oss.sgi.com>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Limit the route hash size.
Message-ID: <20041209082537.A1262@oss.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got the following from the boot of one of our really large machines:
IP: routing cache hash table of 33554432 buckets, 524288Kbytes

I have done a lot of testing with the rt_hash_table.  I would like to
propose that for the overwhelming majority of machines, the default size
is wrong.

It is currently based on numphyspages().  I would suggest that the
majority of machines will never need more than a single page of memory
for this hash.  In my testing, I found a single 16k page would only get an
11% fill in a fairly heavily used production machine on a large network.

The only place where the large route cache seems to make sense is for
larger servers that are servicing internet connections from many sites.
Since the cache is completely flushed every 10 minutes by default, the
above machine would have to be adding 55,924 routes per second that were
ideally distrbuted throughout the hash space to even fill every bucket.

The patch I am proposing is as follows.  For the sites that need larger
route hashes, they can use the rhash_entries command line option to set
it as desired.

Signed-off-by: Robin Holt <holt@sgi.com>


diff -Naur linux-orig/net/ipv4/route.c linux/net/ipv4/route.c
--- linux-orig/net/ipv4/route.c	2004-12-09 09:00:06 -06:00
+++ linux/net/ipv4/route.c	2004-12-09 08:56:33 -06:00
@@ -2728,7 +2728,7 @@
 	if (!ipv4_dst_ops.kmem_cachep)
 		panic("IP: failed to allocate ip_dst_cache\n");
 
-	goal = num_physpages >> (26 - PAGE_SHIFT);
+	goal = 0;
 	if (rhash_entries)
 		goal = (rhash_entries * sizeof(struct rt_hash_bucket)) >> PAGE_SHIFT;
 	for (order = 0; (1UL << order) < goal; order++)

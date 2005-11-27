Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbVK0XV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbVK0XV1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 18:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVK0XV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 18:21:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50057 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751172AbVK0XVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 18:21:25 -0500
Date: Sun, 27 Nov 2005 15:21:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: kas@fi.muni.cz, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       bharata@in.ibm.com
Subject: Re: 2.6.14 kswapd eating too much CPU
Message-Id: <20051127152108.11f58f9c.akpm@osdl.org>
In-Reply-To: <20051127160207.GE21383@logos.cnet>
References: <20051123010122.GA7573@fi.muni.cz>
	<4383D1CC.4050407@yahoo.com.au>
	<20051123051358.GB7573@fi.muni.cz>
	<20051123131417.GH24091@fi.muni.cz>
	<20051123110241.528a0b37.akpm@osdl.org>
	<20051123202438.GE28142@fi.muni.cz>
	<20051123123531.470fc804.akpm@osdl.org>
	<20051124083141.GJ28142@fi.muni.cz>
	<20051127084231.GC20701@logos.cnet>
	<20051127203924.GE27805@fi.muni.cz>
	<20051127160207.GE21383@logos.cnet>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> It does seem to scan SLABs intensively:
>

It might be worth trying the below.  Mainly for the debugging check.


From: Andrea Arcangeli <andrea@suse.de>

Greg Edwards found some deadlock in the icache shrinker.

I believe the major bug is that the VM is currently potentially setting nr
= LONG_MAX before shrinking the icache (and the icache shrinker never
returns -1, which means the api doesn't currently require shrinkers to
return -1 when they're finished).

The below is the most obviously safe way I could address this problem
(still untested).

This is not necessairly the way we want to fix it in mainline, but it at
least shows what I believe to be the major cuplrit in the code (i.e.  nr
growing insane ;).

Signed-off-by: Andrea Arcangeli <andrea@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 mm/vmscan.c |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff -puN mm/vmscan.c~shrinker-nr-=-long_max-means-deadlock-for-icache mm/vmscan.c
--- devel/mm/vmscan.c~shrinker-nr-=-long_max-means-deadlock-for-icache	2005-11-19 02:53:18.000000000 -0800
+++ devel-akpm/mm/vmscan.c	2005-11-19 03:00:25.000000000 -0800
@@ -201,13 +201,25 @@ static int shrink_slab(unsigned long sca
 	list_for_each_entry(shrinker, &shrinker_list, list) {
 		unsigned long long delta;
 		unsigned long total_scan;
+		unsigned long max_pass = (*shrinker->shrinker)(0, gfp_mask);
 
 		delta = (4 * scanned) / shrinker->seeks;
-		delta *= (*shrinker->shrinker)(0, gfp_mask);
+		delta *= max_pass;
 		do_div(delta, lru_pages + 1);
 		shrinker->nr += delta;
-		if (shrinker->nr < 0)
-			shrinker->nr = LONG_MAX;	/* It wrapped! */
+		if (shrinker->nr < 0) {
+			printk(KERN_ERR "%s: nr=%ld\n",
+					__FUNCTION__, shrinker->nr);
+			shrinker->nr = max_pass;
+		}
+
+		/*
+		 * Avoid risking looping forever due to too large nr value:
+		 * never try to free more than twice the estimate number of
+		 * freeable entries.
+		 */
+		if (shrinker->nr > max_pass * 2)
+			shrinker->nr = max_pass * 2;
 
 		total_scan = shrinker->nr;
 		shrinker->nr = 0;
_


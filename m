Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVDDBLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVDDBLs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 21:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVDDBLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 21:11:48 -0400
Received: from fmr24.intel.com ([143.183.121.16]:21954 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261817AbVDDBLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 21:11:46 -0400
Message-Id: <200504040111.j341BUg31885@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>, "Paul Jackson" <pj@engr.sgi.com>
Cc: <torvalds@osdl.org>, <nickpiggin@yahoo.com.au>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [patch] sched: auto-tune migration costs [was: Re: Industry db benchmark result on recent 2.6 kernels]
Date: Sun, 3 Apr 2005 18:11:29 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcU4HaQb+gwhvdumQh+m9fFE306w0QAlIIrQ
In-Reply-To: <20050403070415.GA18893@elte.hu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote on Saturday, April 02, 2005 11:04 PM
> the default on ia64 (32MB) was way too large and caused the search to
> start from 64MB. That can take a _long_ time.
>
> i've attached a new patch with your changes included, and a couple of
> new things added:
>
>  - removed the 32MB max_cache_size hack from ia64 - it should now fall
>    back to the default 5MB and do a search from 10MB downwards. This
>    should speed up the search.

The cache size information on ia64 is already available at the finger tip.
Here is a patch that I whipped up to set max_cache_size for ia64.


--- linux-2.6.12-rc1/arch/ia64/kernel/setup.c.orig	2005-04-03 17:14:40.000000000 -0700
+++ linux-2.6.12-rc1/arch/ia64/kernel/setup.c	2005-04-03 17:55:46.000000000 -0700
@@ -561,6 +561,7 @@ static void
 get_max_cacheline_size (void)
 {
 	unsigned long line_size, max = 1;
+	unsigned int cache_size = 0;
 	u64 l, levels, unique_caches;
         pal_cache_config_info_t cci;
         s64 status;
@@ -585,8 +586,11 @@ get_max_cacheline_size (void)
 		line_size = 1 << cci.pcci_line_size;
 		if (line_size > max)
 			max = line_size;
+		if (cache_size < cci.pcci_cache_size)
+			cache_size = cci.pcci_cache_size;
         }
   out:
+	max_cache_size = max(max_cache_size, cache_size);
 	if (max > ia64_max_cacheline_size)
 		ia64_max_cacheline_size = max;
 }




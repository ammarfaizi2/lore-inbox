Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270658AbTHCFNz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 01:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270810AbTHCFNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 01:13:54 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:3205
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S270658AbTHCFNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 01:13:44 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Scott L. Burson" <gyro@zeta-soft.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SMP performance problem in 2.4 (was: Athlon spinlock performance)
Date: Sun, 3 Aug 2003 15:18:45 +1000
User-Agent: KMail/1.5.3
Cc: Mathieu.Malaterre@creatis.insa-lyon.fr, Andrew Morton <akpm@osdl.org>
References: <16171.31418.271319.316382@kali.zeta-soft.com>
In-Reply-To: <16171.31418.271319.316382@kali.zeta-soft.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308031518.45625.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Scott

On Sun, 3 Aug 2003 06:03, Scott L. Burson wrote:
> In one approximately 60-second period with the problematic workload
> running, `try_to_free_pages' was called 511 times.  It made 2597 calls to
> `shrink_caches', which made 2592 calls to `shrink_cache' (i.e. it was very
> rare for `kmem_cache_reap' to release enough pages itself).  The main loop
> of `shrink_cache' was executed -- brace yourselves -- 189 million times!
> During that time it called `page_cache_release' on only 31265 pages.

I noticed a curly section of the vm code when I was playing around with some 
hacks that are in the -ck kernel and this section might be helpful as it 
wasn't a hack so much as a fix in mm/vmscan.c around line 600. The problem
is when the priority drops to 1 it should do the most cache reaping but
instead bypasses some of it.
You could try this modification and see if it helps.

This isn't a real patch but you should get the idea. 

Con

 	nr_pages -= kmem_cache_reap(gfp_mask);
-	if (nr_pages <= 0)
-		return 0;
+	if (nr_pages < 1)
+		goto shrinkcheck;

 	nr_pages = chunk_size;
 	/* try to keep the active list 2/3 of the size of the cache */
 	ratio = (unsigned long) nr_pages * nr_active_pages / ((nr_inactive_pages + 1) * 2);
 	refill_inactive(ratio);
 
 	nr_pages = shrink_cache(nr_pages, classzone, gfp_mask, priority);
-	if (nr_pages <= 0)
-		return 0;
+	/*
+	 * Will return if nr_pages have been freed unless the
+	 * priority managed to reach 1. If the vm is under this much
+	 * pressure then shrink the d/i/dqcaches regardless. CK 2003
+	 */
+shrinkcheck:
+	if (nr_pages < 1){
+		if (priority > 1)
+			return 0;
+		else
+			nr_pages = 0;
+		}
+

 	shrink_dcache_memory(priority, gfp_mask);
 	shrink_icache_memory(priority, gfp_mask);


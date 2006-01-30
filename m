Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWA3TYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWA3TYG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 14:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWA3TYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 14:24:06 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:19353 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932376AbWA3TYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 14:24:04 -0500
Date: Mon, 30 Jan 2006 20:24:38 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Ingo Molnar <mingo@redhat.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: boot-time slowdown for measure_migration_cost
Message-ID: <20060130192438.GA29129@elte.hu>
References: <200601271403.27065.bjorn.helgaas@hp.com> <20060130172140.GB11793@elte.hu> <20060130185301.GA4622@agluck-lia64.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060130185301.GA4622@agluck-lia64.sc.intel.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Luck, Tony <tony.luck@intel.com> wrote:

> Doing this drops the time to compute the value from 15.58s to 10.39s, 
> while the value of migration_cost changes from 10112 to 9909.
>
> > - in kernel/sched.c, change this line:
> >                 size = size * 20 / 19;
> >   to:
> >                 size = size * 10 / 9;
>
> Doing this instead of changing ITERATIONS makes the computation take 
> 7.79s and the computed migration_cost is 9987.
>
> Doing both gets the time down to 5.20s, and the migration_cost=9990.

ok, that's good enough i think - we could certainly do the patch below 
in v2.6.16.

> On the plus side Prarit's results show that this time isn't scaling 
> with NR_CPUS ... apparently just cache size and number of domains are 
> significant in the time to compute.

yes, this comes from the algorithm, it only computes once per distance 
(and uses the cached value from then on), independently of the number of 
CPUs.

	Ingo

---
reduce the amount of time the migration cost calculations cost during 
bootup.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -5141,7 +5141,7 @@ static void init_sched_build_groups(stru
 #define SEARCH_SCOPE		2
 #define MIN_CACHE_SIZE		(64*1024U)
 #define DEFAULT_CACHE_SIZE	(5*1024*1024U)
-#define ITERATIONS		2
+#define ITERATIONS		1
 #define SIZE_THRESH		130
 #define COST_THRESH		130
 
@@ -5480,9 +5480,9 @@ static unsigned long long measure_migrat
 				break;
 			}
 		/*
-		 * Increase the cachesize in 5% steps:
+		 * Increase the cachesize in 10% steps:
 		 */
-		size = size * 20 / 19;
+		size = size * 10 / 9;
 	}
 
 	if (migration_debug)

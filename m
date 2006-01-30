Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbWA3UAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbWA3UAs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 15:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWA3UAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 15:00:48 -0500
Received: from fmr21.intel.com ([143.183.121.13]:47274 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S964934AbWA3UAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 15:00:47 -0500
Date: Mon, 30 Jan 2006 12:00:26 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Ingo Molnar <mingo@redhat.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: boot-time slowdown for measure_migration_cost
Message-ID: <20060130200026.GA5081@agluck-lia64.sc.intel.com>
References: <200601271403.27065.bjorn.helgaas@hp.com> <20060130172140.GB11793@elte.hu> <20060130185301.GA4622@agluck-lia64.sc.intel.com> <20060130192438.GA29129@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060130192438.GA29129@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2006 at 08:24:38PM +0100, Ingo Molnar wrote:
> > Doing both gets the time down to 5.20s, and the migration_cost=9990.
> 
> ok, that's good enough i think - we could certainly do the patch below 
> in v2.6.16.

Might it be wise to see whether the 2% variation that I saw can be
repeated on some other architecture?  Bjorn's initial post was just
questioning whether we need to spend this much time during boot to acquire
this data.  Now we have *one* data point that on an ia64 with four cpus
with 9MB cache in a single domain that we can speed the calculation by
a factor of three with only a 2% loss of accuracy.  Can someone else try
this patch and post the before/after values for migration_cost from dmesg?

-Tony

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

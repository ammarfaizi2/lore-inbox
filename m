Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317768AbSGKFL1>; Thu, 11 Jul 2002 01:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317769AbSGKFL0>; Thu, 11 Jul 2002 01:11:26 -0400
Received: from holomorphy.com ([66.224.33.161]:4756 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317768AbSGKFKF>;
	Thu, 11 Jul 2002 01:10:05 -0400
Date: Wed, 10 Jul 2002 22:11:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: lazy_buddy-2.5.25-1
Message-ID: <20020711051152.GD27093@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20020710085917.GP25360@holomorphy.com> <20020711044956.GB27093@holomorphy.com> <20020711050221.GC27093@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020711050221.GC27093@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2002 at 10:02:21PM -0700, William Lee Irwin III wrote:
> Even worse, I spotted another (thankfully more minor) bug while still
> peeking at this... okay, back to more urgent things.

I'm *not* having a good day. One parting shot and I really go back to
the other stuff:

> @@ -739,8 +739,8 @@
>  	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->node_next) {
>  		node_zones = pgdat->node_zones;
>  		for (i = 0; i < MAX_NR_ZONES; ++i) {
> -			for (order = 0; order < MAX_ORDER; ++order)
> -				pages += node_zones[i].free_area[order].locally_free;
> +			for (order = MAX_ORDER; order >= 0; --order)
> +				pages = 2*pages + node_zones[i].free_area[order].locally_free;
>  		}
>  	}
>  	return pages;

forgets to start from 0 pages for each zone. Don't bother trying to be
smart and let the compiler figure it out, it's for /proc/meminfo anyway:

Cheers,
Bill


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.633   -> 1.634  
#	     mm/page_alloc.c	1.128   -> 1.129  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/10	wli@tisifone.holomorphy.com	1.634
# page_alloc.c:
#   Correct nr_deferred_pages() calculation.
# --------------------------------------------
#
diff --minimal -Nru a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c	Wed Jul 10 22:12:14 2002
+++ b/mm/page_alloc.c	Wed Jul 10 22:12:14 2002
@@ -740,7 +740,7 @@
 		node_zones = pgdat->node_zones;
 		for (i = 0; i < MAX_NR_ZONES; ++i) {
 			for (order = 0; order < MAX_ORDER; ++order)
-				pages += node_zones[i].free_area[order].locally_free;
+				pages += node_zones[i].free_area[order].locally_free << order;
 		}
 	}
 	return pages;

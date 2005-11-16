Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030318AbVKPNRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbVKPNRV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 08:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbVKPNRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 08:17:21 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:16594 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030318AbVKPNRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 08:17:20 -0500
Subject: Re: [Lhms-devel] Re: 2.6.14-mm2
From: Dave Hansen <haveblue@us.ibm.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
In-Reply-To: <437B2C82.6020803@jp.fujitsu.com>
References: <20051110203544.027e992c.akpm@osdl.org>
	 <437B2C82.6020803@jp.fujitsu.com>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 14:17:16 +0100
Message-Id: <1132147036.7915.19.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 21:56 +0900, KAMEZAWA Hiroyuki wrote:
> Index: linux-2.6.14-mm2/mm/page_alloc.c
> ===================================================================
> --- linux-2.6.14-mm2.orig/mm/page_alloc.c
> +++ linux-2.6.14-mm2/mm/page_alloc.c
> @@ -2054,11 +2054,11 @@ static void __init free_area_init_core(s
>   		zone->nr_active = 0;
>   		zone->nr_inactive = 0;
>   		atomic_set(&zone->reclaim_in_progress, 0);
> +		init_currently_empty_zone(zone, zone_start_pfn, size);
>   		if (!size)
>   			continue;
> 
>   		zonetable_add(zone, nid, j, zone_start_pfn, size);
> -		init_currently_empty_zone(zone, zone_start_pfn, size);
>   		zone_start_pfn += size;
>   	}
>   }

Can you explain in a little bit more detail why this matters, and
exactly how it fixes your problem.  I'm not sure it's correct.

"init_currently_empty_zone" could more properly be called something like
"init currently empty zone to now have memory".  There's no reason to
call it, unless you have an empty zone *AND* you some memory to put in
it now.  If you call it with a size of 0, the things like memmap_init
inside of it don't make any sense.

Also, if you're doing hot-adds of _new_ zones at runtime, you need to do
something fancy with the zonelist locking that I never got around to
because nobody needs it yet.  See something along these lines:

http://www.sr71.net/patches/2.6.14/2.6.14-rc2-git8-mhp1/broken-out/E2-for-debugging-handle-add-to-empty-zone.patch

-- Dave


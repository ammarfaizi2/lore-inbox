Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317761AbSGKEsM>; Thu, 11 Jul 2002 00:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317762AbSGKEsL>; Thu, 11 Jul 2002 00:48:11 -0400
Received: from holomorphy.com ([66.224.33.161]:65427 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317761AbSGKEsJ>;
	Thu, 11 Jul 2002 00:48:09 -0400
Date: Wed, 10 Jul 2002 21:49:56 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: lazy_buddy-2.5.25-1
Message-ID: <20020711044956.GB27093@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20020710085917.GP25360@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020710085917.GP25360@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2002 at 01:59:17AM -0700, William Lee Irwin III wrote:
> This patch implements deferred coalescing for the Linux page-level
> allocator, or the lazy buddy algorithm. This appears to reduce the
> allocator overhead in some AF_UNIX and local TCP connection scenarios
> according to LMbench (hopefully I can follow up with numbers soon).
> This is a simple forward port of the 2.5.23-based version decoupled
> from some of the cleanups previously bundled with it.

Ugh, forward port breakage. Ran into this in a different patch but
realized it was broken here too. Sorry folks. You'll need this on
top of the prior post.


Cheers,
Bill


===== mm/page_alloc.c 1.125 vs edited =====
--- 1.125/mm/page_alloc.c	Tue Jul  9 14:50:43 2002
+++ edited/mm/page_alloc.c	Wed Jul 10 20:33:03 2002
@@ -312,7 +312,6 @@
 
 			if (bad_range(zone, page))
 				BUG();
-			prep_new_page(page);
 			return page;	
 		}
 		curr_order++;
@@ -394,7 +393,7 @@
 		page = buddy_alloc(zone, order);
 	if (unlikely(!page))
 		goto out;
-	set_page_count(page, 1);
+	prep_new_page(page);
 	area->active++;
 	zone->free_pages -= 1UL << order;
 out:

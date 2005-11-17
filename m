Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbVKQVB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbVKQVB5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 16:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbVKQVB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 16:01:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63919 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964864AbVKQVBz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 16:01:55 -0500
Date: Thu, 17 Nov 2005 13:02:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, rohit.seth@intel.com
Subject: Re: 2.6.15-rc1-git crashes in kswapd
Message-Id: <20051117130215.33889990.akpm@osdl.org>
In-Reply-To: <20051117160624.GR7787@suse.de>
References: <20051117154754.GP7787@suse.de>
	<20051117160624.GR7787@suse.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> does zonelist->zones change further down the path
> and we need the revalidation before after restarting?
> 

err, yeah.   Like this, I think?



We modify local variable `z' while walking across the zones.  So we need to
restore it if we do the `goto restart' thing in the rare case where the
oom-killer was called.


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 mm/page_alloc.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff -puN mm/page_alloc.c~alloc_pages-oops-fix mm/page_alloc.c
--- 25/mm/page_alloc.c~alloc_pages-oops-fix	Thu Nov 17 12:58:38 2005
+++ 25-akpm/mm/page_alloc.c	Thu Nov 17 12:59:19 2005
@@ -845,13 +845,12 @@ __alloc_pages(gfp_t gfp_mask, unsigned i
 
 	might_sleep_if(wait);
 
-	z = zonelist->zones;  /* the list of zones suitable for gfp_mask */
+restart:
+	z = zonelist->zones;	  /* the list of zones suitable for gfp_mask */
 
-	if (unlikely(*z == NULL)) {
-		/* Should this ever happen?? */
+	if (unlikely(*z == NULL)) /* Should this ever happen?? */
 		return NULL;
-	}
-restart:
+
 	page = get_page_from_freelist(gfp_mask|__GFP_HARDWALL, order,
 				zonelist, ALLOC_CPUSET);
 	if (page)
_


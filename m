Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265910AbUJEV2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265910AbUJEV2O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 17:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266009AbUJEV2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 17:28:14 -0400
Received: from gprs214-120.eurotel.cz ([160.218.214.120]:12167 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265910AbUJEV2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 17:28:11 -0400
Date: Tue, 5 Oct 2004 23:27:58 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc3[+recent swsusp patches]: swsusp kernel-preemption-unfriendly?
Message-ID: <20041005212757.GB5763@elf.ucw.cz>
References: <200410052314.25253.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410052314.25253.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> It looks like there's a probel with the kernel preemption vs swsusp:

It is not in kernel preemption, see that NULL pointer dereference? Try
this one...

								Pavel

--- clean-suse/kernel/power/swsusp.c	2004-10-05 11:36:23.000000000 +0200
+++ linux-suse/kernel/power/swsusp.c	2004-10-05 22:35:21.000000000 +0200
@@ -568,6 +568,7 @@
 	struct zone *zone;
 	unsigned long zone_pfn;
 	struct pbe * pbe = pagedir_nosave;
+	int pages_copied = 0;
 	
 	for_each_zone(zone) {
 		if (is_highmem(zone))
@@ -576,13 +577,17 @@
 			if (saveable(zone, &zone_pfn)) {
 				struct page * page;
 				page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
+
 				pbe->orig_address = (long) page_address(page);
 				/* copy_page is no usable for copying task structs. */
 				memcpy((void *)pbe->address, (void *)pbe->orig_address, PAGE_SIZE);
 				pbe++;
+				pages_copied++;
 			}
 		}
 	}
+	BUG_ON(pages_copied > nr_copy_pages);
+	nr_copy_pages = pages_copied;
 }
 
 
@@ -863,7 +868,7 @@
 
 asmlinkage int swsusp_restore(void)
 {
-	BUG_ON (nr_copy_pages_check != nr_copy_pages);
+//	BUG_ON (nr_copy_pages_check != nr_copy_pages);
 	BUG_ON (pagedir_order_check != pagedir_order);
 	
 	/* Even mappings of "global" things (vmalloc) need to be fixed */
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

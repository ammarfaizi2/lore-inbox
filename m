Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263186AbVCKGKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263186AbVCKGKq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 01:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbVCKGKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 01:10:46 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:8710
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S263186AbVCKGKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 01:10:37 -0500
Date: Fri, 11 Mar 2005 07:10:35 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: 2.4 fix for write throttling on x86 >1G
Message-ID: <20050311061035.GZ26348@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marcelo,

I've got a fix for you on 2.4. I got reports of stalls with heavy writes
on 2.4. There was a mistake in nr_free_buffer_pages. That function is
definitely meant _not_ to take highmem into account (dirty cache cannot
spread over highmem in 2.4 [even when on top of fs]). For unknown
reasons it was actually taking highmem into account. The code was
obviously meant to not take inot account see the GFP_USER and zonelist,
except it wasn't using the zonelist. That is a severe problem because
there will be no write throttling at all, and no bdflush wakeup either.

This should fix it, though my compiler fails to compile 2.4, so it's not
immediate to verify it. If any problem showup I'll post a followup.

This is a noop for all systems <800M (1G shouldn't be noticeable
either). This is why most people can't notice.

Thanks.

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

--- 2.4.23aa3/mm/page_alloc.c.~1~	2004-07-04 02:09:42.000000000 +0200
+++ 2.4.23aa3/mm/page_alloc.c	2005-03-11 07:00:23.000000000 +0100
@@ -656,7 +656,7 @@ unsigned int nr_free_buffer_pages (void)
 		class_idx = zone_idx(zone);
 
 		sum += zone->nr_cache_pages;
-		for (zone = pgdat->node_zones; zone < pgdat->node_zones + MAX_NR_ZONES; zone++) {
+		for (; zone; zone = *zonep++) {
 			int free = zone->free_pages - zone->watermarks[class_idx].high;
 			if (free <= 0)
 				continue;

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264021AbUDQTi7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 15:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264024AbUDQTi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 15:38:59 -0400
Received: from holomorphy.com ([207.189.100.168]:30860 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264021AbUDQTiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 15:38:55 -0400
Date: Sat, 17 Apr 2004 12:38:55 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, elf@buici.com
Subject: vmscan.c heuristic adjustment for smaller systems
Message-ID: <20040417193855.GP743@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, elf@buici.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Singer reported an issue where an embedded ARM system performed
poorly due to page replacement potentially prematurely replacing
mapped memory where there was very little mapped pagecache in use to
begin with.

The following patch attempts to address the issue by using the
_maximum_ of vm_swappiness and distress to add to the mapped ratio, so
that distress doesn't contribute to swap_tendency until it exceeds
vm_swappiness, and afterward the effect is not cumulative.

The intended effect is that swap_tendency should vary in a more jagged
way, and not be elevated by distress beyond vm_swappiness until distress
exceeds vm_swappiness. For instance, since distress is 100 >>
zone->prev_priority, no distinction is made between a vm_swappiness of
50 or a vm_swappiness of 90 given the same mapped_ratio.

Marc Singer has results where this is an improvement, and hopefully can
clarify as-needed. Help determining whether this policy change is an
improvement for a broader variety of systems would be appreciated.


-- wli


Index: singer-2.6.5-mm6/mm/vmscan.c
===================================================================
--- singer-2.6.5-mm6.orig/mm/vmscan.c	2004-04-14 23:21:19.000000000 -0700
+++ singer-2.6.5-mm6/mm/vmscan.c	2004-04-17 11:09:35.000000000 -0700
@@ -636,7 +636,7 @@
 	 *
 	 * A 100% value of vm_swappiness overrides this algorithm altogether.
 	 */
-	swap_tendency = mapped_ratio / 2 + distress + vm_swappiness;
+	swap_tendency = mapped_ratio / 2 + max(distress, vm_swappiness);
 
 	/*
 	 * Now use this metric to decide whether to start moving mapped memory

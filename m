Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265833AbTGIIhu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 04:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265818AbTGIIfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 04:35:11 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:54442 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265830AbTGIIc6
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 9 Jul 2003 04:32:58 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16139.54951.18108.338103@laputa.namesys.com>
Date: Wed, 9 Jul 2003 12:47:35 +0400
To: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: [PATCH] 5/5 VM changes: reclaim_mapped-pressure.patch
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use zone->pressure (rathar than scanning priority) to determine when to start
reclaiming mapped pages in refill_inactive_zone(). When using priority every
call to try_to_free_pages() starts with scanning parts of active list and
skipping mapped pages (because reclaim_mapped evaluates to 0 on low
priorities) no matter how high memory pressure is.



diff -puN mm/vmscan.c~reclaim_mapped-pressure mm/vmscan.c
--- i386/mm/vmscan.c~reclaim_mapped-pressure	Wed Jul  9 12:24:53 2003
+++ i386-god/mm/vmscan.c	Wed Jul  9 12:24:53 2003
@@ -95,6 +95,11 @@ static void zone_adj_pressure(struct zon
 	zone->pressure = expavg(zone->pressure, pass << 10, 1);
 }
 
+static int pressure_to_priority(int pressure)
+{
+	return DEF_PRIORITY - (pressure >> 10);
+}
+
 /*
  * The list of shrinker callbacks used by to apply pressure to
  * ageable caches.
@@ -685,7 +690,7 @@ refill_inactive_zone(struct zone *zone, 
 	 * `distress' is a measure of how much trouble we're having reclaiming
 	 * pages.  0 -> no problems.  100 -> great trouble.
 	 */
-	distress = 100 >> priority;
+	distress = 100 >> pressure_to_priority(zone->pressure);
 
 	/*
 	 * The point of this algorithm is to decide when to start reclaiming

_

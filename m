Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWINNbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWINNbB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 09:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWINNbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 09:31:00 -0400
Received: from jaguar.mkp.net ([192.139.46.146]:12417 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S1750706AbWINNa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 09:30:59 -0400
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: [RFC - Patch] Condense output of show_free_areas()
From: Jes Sorensen <jes@sgi.com>
Date: 14 Sep 2006 09:30:58 -0400
Message-ID: <yq0mz92efsd.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On larger systems, the amount of output dumped on the console when you
do SysRq-M is beyond insane. This patch is trying to reduce it
somewhat as even with the smaller NUMA systems that have hit the
desktop this seems to be a fair thing to do.

The philosophy I have taken is as follows:
 1) If a zone is empty, don't tell, we don't need yet another line
    telling us so. The information is available since one can look up
    the fact how many zones were initialized in the first place.
 2) Put as much information on a line is possible, if it can be done
    in one line, rahter than two, then do it in one. I tried to format
    the temperature stuff for easy reading.

Comments?

Cheers,
Jes

Change show_free_areas() to not print lines for empty zones. If no zone
output is printed, the zone is empty. This reduces the number of lines
dumped to the console in sysrq on a large system by several thousand
lines.

Change the zone temperature printouts to use one line per CPU instead
of two lines (one hot, one cold). On a 1024 CPU, 1024 node system, this
reduces the console output by over a million lines of output.

While this is a bigger problem on large NUMA systems, it is also
applicable to smaller desktop sized and mid range NUMA systems.

Signed-off-by: Jes Sorensen <jes@sgi.com>


---
 mm/page_alloc.c |   36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -1249,34 +1249,30 @@ void si_meminfo_node(struct sysinfo *val
  */
 void show_free_areas(void)
 {
-	int cpu, temperature;
+	int cpu;
 	unsigned long active;
 	unsigned long inactive;
 	unsigned long free;
 	struct zone *zone;
 
 	for_each_zone(zone) {
-		show_node(zone);
-		printk("%s per-cpu:", zone->name);
-
-		if (!populated_zone(zone)) {
-			printk(" empty\n");
+		if (!populated_zone(zone))
 			continue;
-		} else
-			printk("\n");
+
+		show_node(zone);
+		printk("%s per-cpu:\n", zone->name);
 
 		for_each_online_cpu(cpu) {
 			struct per_cpu_pageset *pageset;
 
 			pageset = zone_pcp(zone, cpu);
 
-			for (temperature = 0; temperature < 2; temperature++)
-				printk("cpu %d %s: high %d, batch %d used:%d\n",
-					cpu,
-					temperature ? "cold" : "hot",
-					pageset->pcp[temperature].high,
-					pageset->pcp[temperature].batch,
-					pageset->pcp[temperature].count);
+			printk("CPU %4d: Hot: hi:%5d, btch:%4d usd:%4d   "
+			       "Cold: hi:%5d, btch:%4d usd:%4d\n",
+			       cpu, pageset->pcp[0].high,
+			       pageset->pcp[0].batch, pageset->pcp[0].count,
+			       pageset->pcp[1].high, pageset->pcp[1].batch,
+			       pageset->pcp[1].count);
 		}
 	}
 
@@ -1301,6 +1297,9 @@ void show_free_areas(void)
 	for_each_zone(zone) {
 		int i;
 
+		if (!populated_zone(zone))
+			continue;
+
 		show_node(zone);
 		printk("%s"
 			" free:%lukB"
@@ -1333,12 +1332,11 @@ void show_free_areas(void)
 	for_each_zone(zone) {
  		unsigned long nr[MAX_ORDER], flags, order, total = 0;
 
+		if (!populated_zone(zone))
+			continue;
+
 		show_node(zone);
 		printk("%s: ", zone->name);
-		if (!populated_zone(zone)) {
-			printk("empty\n");
-			continue;
-		}
 
 		spin_lock_irqsave(&zone->lock, flags);
 		for (order = 0; order < MAX_ORDER; order++) {

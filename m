Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933166AbWFZX36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933166AbWFZX36 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933156AbWFZWfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:35:13 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:33695 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933123AbWFZWez
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:34:55 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 02/20] [Suspend2] Get number of pcp pages.
Date: Tue, 27 Jun 2006 08:34:53 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223451.4050.1806.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
References: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Return the number of pages currently in the pcp lists.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/prepare_image.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/kernel/power/prepare_image.c b/kernel/power/prepare_image.c
index 9e13418..9f6e96d 100644
--- a/kernel/power/prepare_image.c
+++ b/kernel/power/prepare_image.c
@@ -40,3 +40,36 @@ static long storage_allocated = 0;
 static long storage_available = 0;
 long extra_pd1_pages_allowance = MIN_EXTRA_PAGES_ALLOWANCE;
 
+/*
+ * num_pcp_pages: Count pcp pages.
+ */
+static long num_pcp_pages(void)
+{
+	struct zone *zone;
+	long result = 0, i = 0;
+
+	/* PCP lists */
+	for_each_zone(zone) {
+		struct per_cpu_pageset *pset;
+		int cpu;
+		
+		if (!zone->present_pages)
+			continue;
+		
+		for (cpu = 0; cpu < NR_CPUS; cpu++) {
+			if (!cpu_possible(cpu))
+				continue;
+
+			pset = zone_pcp(zone, cpu);
+
+			for (i = 0; i < ARRAY_SIZE(pset->pcp); i++) {
+				struct per_cpu_pages *pcp;
+
+				pcp = &(pset->pcp[i]);
+				result += pcp->count;
+			}
+		}
+	}
+	return result;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

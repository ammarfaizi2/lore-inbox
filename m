Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965040AbWFHXC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbWFHXC5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 19:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbWFHXC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 19:02:57 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:45499 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965040AbWFHXC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 19:02:56 -0400
Date: Thu, 8 Jun 2006 16:02:50 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060608230250.25121.93819.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
References: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 02/14] Include per zone counters in /proc/vmstat
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add zoned counters to /proc/vmstat

This makes vmstat print counters from a combined array of zoned counters
plus the current page_state (which will be later be replaced by the
event counter patchset).

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc6-mm1/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/page_alloc.c	2006-06-08 13:51:16.145258328 -0700
+++ linux-2.6.17-rc6-mm1/mm/page_alloc.c	2006-06-08 13:53:18.336915650 -0700
@@ -2800,6 +2800,9 @@ struct seq_operations zoneinfo_op = {
 };
 
 static char *vmstat_text[] = {
+	/* Zoned VM counters */
+
+	/* Page state */
 	"nr_dirty",
 	"nr_writeback",
 	"nr_unstable",
@@ -2857,19 +2860,25 @@ static char *vmstat_text[] = {
 
 static void *vmstat_start(struct seq_file *m, loff_t *pos)
 {
+	unsigned long *v;
 	struct page_state *ps;
+	int i;
 
 	if (*pos >= ARRAY_SIZE(vmstat_text))
 		return NULL;
 
-	ps = kmalloc(sizeof(*ps), GFP_KERNEL);
-	m->private = ps;
-	if (!ps)
+	v = kmalloc(NR_STAT_ITEMS * sizeof(unsigned long)
+			+ sizeof(struct page_state), GFP_KERNEL);
+	m->private = v;
+	if (!v)
 		return ERR_PTR(-ENOMEM);
+	for (i = 0; i < NR_STAT_ITEMS; i++)
+		v[i] = global_page_state(i);
+	ps = (struct page_state *)(v + NR_STAT_ITEMS);
 	get_full_page_state(ps);
 	ps->pgpgin /= 2;		/* sectors -> kbytes */
 	ps->pgpgout /= 2;
-	return (unsigned long *)ps + *pos;
+	return v + *pos;
 }
 
 static void *vmstat_next(struct seq_file *m, void *arg, loff_t *pos)

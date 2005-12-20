Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbVLTWDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbVLTWDF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 17:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbVLTWCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 17:02:41 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:35972 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932166AbVLTWCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 17:02:12 -0500
Date: Tue, 20 Dec 2005 14:02:06 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Andi Kleen <ak@suse.de>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051220220206.30326.8483.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051220220151.30326.98563.sendpatchset@schroedinger.engr.sgi.com>
References: <20051220220151.30326.98563.sendpatchset@schroedinger.engr.sgi.com>
Subject: Zoned counters V1 [ 3/14]: Include zoned counters in /proc/vmstat
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make /proc/vmstat include zoned couters

This makes vmstat print counters from a combined array of zoned counters
plus the current page_state (which will be later converted by the
event counter patchset).

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5-mm3/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/page_alloc.c	2005-12-20 12:05:56.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/page_alloc.c	2005-12-20 12:19:01.000000000 -0800
@@ -2673,6 +2673,9 @@ struct seq_operations zoneinfo_op = {
 };
 
 static char *vmstat_text[] = {
+	/* Zoned VM counters */
+
+	/* Page state */
 	"nr_dirty",
 	"nr_writeback",
 	"nr_unstable",
@@ -2730,19 +2733,25 @@ static char *vmstat_text[] = {
 
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

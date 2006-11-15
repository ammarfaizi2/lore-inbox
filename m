Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030831AbWKOSh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030831AbWKOSh3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030836AbWKOSh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:37:29 -0500
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:56720 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1030831AbWKOSh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:37:28 -0500
Date: Wed, 15 Nov 2006 19:34:37 +0100
From: Christian Krafft <krafft@de.ibm.com>
To: Christian Krafft <krafft@de.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [patch 2/2] enables booting a NUMA system where some nodes have no
 memory
Message-ID: <20061115193437.25cdc371@localhost>
In-Reply-To: <20061115193049.3457b44c@localhost>
References: <20061115193049.3457b44c@localhost>
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When booting a NUMA system with nodes that have no memory (eg by limiting memory),
bootmem_alloc_core tried to find pages in an uninitialized bootmem_map.
This caused a null pointer access.
This fix adds a check, so that NULL is returned.
That will enable the caller (bootmem_alloc_nopanic)
to alloc memory on other without a panic.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>

Index: linux/mm/bootmem.c
===================================================================
--- linux.orig/mm/bootmem.c
+++ linux/mm/bootmem.c
@@ -196,6 +196,10 @@ __alloc_bootmem_core(struct bootmem_data
 	if (limit && bdata->node_boot_start >= limit)
 		return NULL;
 
+	/* on nodes without memory - bootmem_map is NULL */
+	if(!bdata->node_bootmem_map)
+		return NULL;
+
 	end_pfn = bdata->node_low_pfn;
 	limit = PFN_DOWN(limit);
 	if (limit && end_pfn > limit)

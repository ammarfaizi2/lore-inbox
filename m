Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030815AbWKOSf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030815AbWKOSf3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030828AbWKOSf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:35:29 -0500
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:849 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1030815AbWKOSf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:35:27 -0500
Date: Wed, 15 Nov 2006 19:32:38 +0100
From: Christian Krafft <krafft@de.ibm.com>
To: Christian Krafft <krafft@de.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [patch 1/2] fix call to alloc_bootmem after bootmem has been freed
Message-ID: <20061115193238.4d23900c@localhost>
In-Reply-To: <20061115193049.3457b44c@localhost>
References: <20061115193049.3457b44c@localhost>
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases it might happen, that alloc_bootmem is beeing called
after bootmem pages have been freed. This is, because the condition
SYSTEM_BOOTING is still true after bootmem has been freed.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>

Index: linux/mm/page_alloc.c
===================================================================
--- linux.orig/mm/page_alloc.c
+++ linux/mm/page_alloc.c
@@ -1931,7 +1931,7 @@ int zone_wait_table_init(struct zone *zo
 	alloc_size = zone->wait_table_hash_nr_entries
 					* sizeof(wait_queue_head_t);
 
- 	if (system_state == SYSTEM_BOOTING) {
+	if (!slab_is_available()) {
 		zone->wait_table = (wait_queue_head_t *)
 			alloc_bootmem_node(pgdat, alloc_size);
 	} else {

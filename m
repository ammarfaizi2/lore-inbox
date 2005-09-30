Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030351AbVI3T0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbVI3T0N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 15:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbVI3T0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 15:26:12 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:34517
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932589AbVI3T0M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 15:26:12 -0400
Subject: [PATCH] Revert [PATCH] x86-64: Reverse order of bootmem lists
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Russell King <linux@arm.linux.org.uk>
Content-Type: text/plain
Organization: linutronix
Date: Fri, 30 Sep 2005 21:27:00 +0200
Message-Id: <1128108420.15115.409.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please revert the patch 

http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=5d3d0f7704ed0bc7eaca0501eeae3e5da1ea6c87

as it breaks a couple of ARM boards, which depend on the historical
bootmem allocation order. AFAIK there is a cleaner solution around to
remove the pgdat list completely, but this is a topic for post 2.6.14

Andi signalled ACK already.


tglx



Index: linux-2.6.14-rc2-genirq/mm/bootmem.c
===================================================================
--- linux-2.6.14-rc2-genirq.orig/mm/bootmem.c
+++ linux-2.6.14-rc2-genirq/mm/bootmem.c
@@ -61,17 +61,9 @@ static unsigned long __init init_bootmem
 {
 	bootmem_data_t *bdata = pgdat->bdata;
 	unsigned long mapsize = ((end - start)+7)/8;
-	static struct pglist_data *pgdat_last;
 
-	pgdat->pgdat_next = NULL;
-	/* Add new nodes last so that bootmem always starts
-	   searching in the first nodes, not the last ones */
-	if (pgdat_last)
-		pgdat_last->pgdat_next = pgdat;
-	else {
-		pgdat_list = pgdat; 	
-		pgdat_last = pgdat;
-	}
+	pgdat->pgdat_next = pgdat_list;
+	pgdat_list = pgdat;
 
 	mapsize = ALIGN(mapsize, sizeof(long));
 	bdata->node_bootmem_map = phys_to_virt(mapstart << PAGE_SHIFT);



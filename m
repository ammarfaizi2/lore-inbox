Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318436AbSGSBv3>; Thu, 18 Jul 2002 21:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318437AbSGSBv2>; Thu, 18 Jul 2002 21:51:28 -0400
Received: from holomorphy.com ([66.224.33.161]:34445 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318436AbSGSBv1>;
	Thu, 18 Jul 2002 21:51:27 -0400
Date: Thu, 18 Jul 2002 18:54:21 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: nr_active_pte_chains
Message-ID: <20020719015421.GE1022@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@zip.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken's optimization of storing the pte's address directly in
the struct page defeats measuring pagetable occupancy by means of
measuring the space consumed by pte_chains. This patch reports a new
statistic independent of the allocated space for pte_chains describing
the number of reverse mappings performed.

Patch against 2.5.26 + akpm's pending patch series.



diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.26-virgin/fs/proc/proc_misc.c linux-2.5.26/fs/proc/proc_misc.c
--- linux-2.5.26-virgin/fs/proc/proc_misc.c	Thu Jul 18 18:45:25 2002
+++ linux-2.5.26/fs/proc/proc_misc.c	Thu Jul 18 20:05:48 2002
@@ -162,7 +162,8 @@
 		"Writeback:    %8lu kB\n"
 		"PageTables:   %8lu kB\n"
 		"PteChainTot:  %8lu kB\n"
-		"PteChainUsed: %8lu kB\n",
+		"PteChainUsed: %8lu kB\n"
+		"PteChainActv: %8lu\n",
 		K(i.totalram),
 		K(i.freeram),
 		K(i.sharedram),
@@ -180,7 +181,8 @@
 		K(ps.nr_writeback),
 		K(ps.nr_page_table_pages),
 		K(ps.nr_pte_chain_pages),
-		ps.used_pte_chains_bytes >> 10
+		ps.used_pte_chains_bytes >> 10,
+		ps.nr_active_pte_chains
 		);
 
 	return proc_calc_metrics(page, start, off, count, eof, len);
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.26-virgin/include/linux/page-flags.h linux-2.5.26/include/linux/page-flags.h
--- linux-2.5.26-virgin/include/linux/page-flags.h	Thu Jul 18 18:45:25 2002
+++ linux-2.5.26/include/linux/page-flags.h	Thu Jul 18 20:03:12 2002
@@ -81,6 +81,7 @@
 	unsigned long nr_page_table_pages;
 	unsigned long nr_pte_chain_pages;
 	unsigned long used_pte_chains_bytes;
+	unsigned long nr_active_pte_chains;
 } ____cacheline_aligned_in_smp page_states[NR_CPUS];
 
 extern void get_page_state(struct page_state *ret);
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.26-virgin/mm/page_alloc.c linux-2.5.26/mm/page_alloc.c
--- linux-2.5.26-virgin/mm/page_alloc.c	Thu Jul 18 18:45:25 2002
+++ linux-2.5.26/mm/page_alloc.c	Thu Jul 18 18:00:26 2002
@@ -568,6 +568,7 @@
 		ret->nr_page_table_pages += ps->nr_page_table_pages;
 		ret->nr_pte_chain_pages += ps->nr_pte_chain_pages;
 		ret->used_pte_chains_bytes += ps->used_pte_chains_bytes;
+		ret->nr_active_pte_chains += ps->nr_active_pte_chains;
 	}
 }
 
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.26-virgin/mm/rmap.c linux-2.5.26/mm/rmap.c
--- linux-2.5.26-virgin/mm/rmap.c	Thu Jul 18 18:45:25 2002
+++ linux-2.5.26/mm/rmap.c	Thu Jul 18 17:52:30 2002
@@ -148,6 +148,7 @@
 	}
 
 	pte_chain_unlock(page);
+	inc_page_state(nr_active_pte_chains);
 }
 
 /**
@@ -209,8 +210,8 @@
 
 out:
 	pte_chain_unlock(page);
+	dec_page_state(nr_active_pte_chains);
 	return;
-			
 }
 
 /**

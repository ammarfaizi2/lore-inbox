Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267607AbUJGTAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267607AbUJGTAh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 15:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267808AbUJGS7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:59:00 -0400
Received: from lindsey.linux-systeme.com ([62.241.33.80]:57498 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S267826AbUJGS4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:56:01 -0400
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
To: "Gabor Z. Papp" <gzp@papp.hu>
Subject: Re: [2.4] 0-order allocation failed
Date: Thu, 7 Oct 2004 20:54:16 +0200
User-Agent: KMail/1.7
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Michael Buesch <mbuesch@freenet.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200410071318.21091.mbuesch@freenet.de> <20041007153929.GB14614@logos.cnet> <x67jq2bcy3@gzp>
In-Reply-To: <x67jq2bcy3@gzp>
Organization: Linux-Systeme GmbH
X-Operating-System: Linux 2.4.20-wolk4.16 i686 GNU/Linux
MIME-Version: 1.0
Message-Id: <200410072054.17097@WOLK>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ZDZZBoxl8tswdcG"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_ZDZZBoxl8tswdcG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 07 October 2004 20:28, Gabor Z. Papp wrote:

Hi all,

> | > > Can you check how much swap space is there available when
> | > > the OOM killer trigger? I bet this is the case.
> | > The machine doesn't have swap.
> | Well then you're probably facing true OOM.
> | Add some swap.

> There is really no way to run 2.4 without swap?
> I have the same problem with nfsroot and ramdisk based setups after
> 1-2 weeks uptime.

stop whining about braindead 2.4 mainline vm. Apply the attached patch and be 
happy :p

Marcelo: Is there something wrong with my VM documentation update patches for 
2.4? Or do you not care and think: "Hello my friend, let's stick with 2.2 VM 
documentation even if almost all of the documentation is not longer valid"

;-)

ciao, Marc

--Boundary-00=_ZDZZBoxl8tswdcG
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="vm-anon-lru-3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="vm-anon-lru-3.patch"

diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids x-ref/include/linux/swap.h x/include/linux/swap.h
--- x-ref/include/linux/swap.h	2003-10-10 08:08:29.000000000 +0200
+++ x/include/linux/swap.h	2003-10-17 21:18:14.000000000 +0200
@@ -115,7 +115,7 @@ extern void swap_setup(void);
 extern wait_queue_head_t kswapd_wait;
 extern int FASTCALL(try_to_free_pages_zone(zone_t *, unsigned int));
 extern int FASTCALL(try_to_free_pages(unsigned int));
-extern int vm_vfs_scan_ratio, vm_cache_scan_ratio, vm_lru_balance_ratio, vm_passes, vm_gfp_debug, vm_mapped_ratio;
+extern int vm_vfs_scan_ratio, vm_cache_scan_ratio, vm_lru_balance_ratio, vm_passes, vm_gfp_debug, vm_mapped_ratio, vm_anon_lru;
 
 /* linux/mm/page_io.c */
 extern void rw_swap_page(int, struct page *);
diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids x-ref/include/linux/sysctl.h x/include/linux/sysctl.h
--- x-ref/include/linux/sysctl.h	2003-10-17 21:18:12.000000000 +0200
+++ x/include/linux/sysctl.h	2003-10-17 21:18:46.000000000 +0200
@@ -154,9 +154,10 @@ enum
 	VM_PAGEBUF=17,		/* struct: Control pagebuf parameters */
 	VM_GFP_DEBUG=18,        /* debug GFP failures */
 	VM_CACHE_SCAN_RATIO=19, /* part of the inactive cache list to scan */
-	VM_MAPPED_RATIO=20,     /* amount of unfreeable pages that triggers swapout */
+	VM_MAPPED_RATIO=20,	/* amount of unfreeable pages that triggers swapout */
 	VM_LAPTOP_MODE=21,	/* kernel in laptop flush mode */
 	VM_BLOCK_DUMP=22,	/* dump fs activity to log */
+	VM_ANON_LRU=23,		/* immediatly insert anon pages in the vm page lru */
 };
 
 
diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids x-ref/kernel/sysctl.c x/kernel/sysctl.c
--- x-ref/kernel/sysctl.c	2003-10-17 21:18:12.000000000 +0200
+++ x/kernel/sysctl.c	2003-10-17 21:18:14.000000000 +0200
@@ -287,6 +287,8 @@ static ctl_table vm_table[] = {
 	 &vm_cache_scan_ratio, sizeof(int), 0644, NULL, &proc_dointvec},
 	{VM_MAPPED_RATIO, "vm_mapped_ratio", 
 	 &vm_mapped_ratio, sizeof(int), 0644, NULL, &proc_dointvec},
+	{VM_ANON_LRU, "vm_anon_lru", 
+	 &vm_anon_lru, sizeof(int), 0644, NULL, &proc_dointvec},
 	{VM_LRU_BALANCE_RATIO, "vm_lru_balance_ratio", 
 	 &vm_lru_balance_ratio, sizeof(int), 0644, NULL, &proc_dointvec},
 	{VM_PASSES, "vm_passes", 
diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids x-ref/mm/memory.c x/mm/memory.c
--- x-ref/mm/memory.c	2003-10-17 21:18:09.000000000 +0200
+++ x/mm/memory.c	2003-10-17 21:18:14.000000000 +0200
@@ -997,7 +997,8 @@ static int do_wp_page(struct mm_struct *
 		if (PageReserved(old_page))
 			++mm->rss;
 		break_cow(vma, new_page, address, page_table);
-		lru_cache_add(new_page);
+		if (vm_anon_lru)
+			lru_cache_add(new_page);
 
 		/* Free the old page.. */
 		new_page = old_page;
@@ -1228,7 +1229,8 @@ static int do_anonymous_page(struct mm_s
 		mm->rss++;
 		flush_page_to_ram(page);
 		entry = pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
-		lru_cache_add(page);
+		if (vm_anon_lru)
+			lru_cache_add(page);
 		mark_page_accessed(page);
 	}
 
@@ -1283,7 +1285,8 @@ static int do_no_page(struct mm_struct *
 		}
 		copy_user_highpage(page, new_page, address);
 		page_cache_release(new_page);
-		lru_cache_add(page);
+		if (vm_anon_lru)
+			lru_cache_add(page);
 		new_page = page;
 	}
 
diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids x-ref/mm/vmscan.c x/mm/vmscan.c
--- x-ref/mm/vmscan.c	2003-10-17 21:18:13.000000000 +0200
+++ x/mm/vmscan.c	2003-10-17 21:18:14.000000000 +0200
@@ -65,6 +65,27 @@ int vm_lru_balance_ratio = 2;
 int vm_vfs_scan_ratio = 6;
 
 /*
+ * "vm_anon_lru" select if to immdiatly insert anon pages in the
+ * lru. Immediatly means as soon as they're allocated during the
+ * page faults.
+ *
+ * If this is set to 0, they're inserted only after the first
+ * swapout.
+ *
+ * Having anon pages immediatly inserted in the lru allows the
+ * VM to know better when it's worthwhile to start swapping
+ * anonymous ram, it will start to swap earlier and it should
+ * swap smoother and faster, but it will decrease scalability
+ * on the >16-ways of an order of magnitude. Big SMP/NUMA
+ * definitely can't take an hit on a global spinlock at
+ * every anon page allocation. So this is off by default.
+ *
+ * Low ram machines that swaps all the time want to turn
+ * this on (i.e. set to 1).
+ */
+int vm_anon_lru = 0;
+
+/*
  * The swap-out function returns 1 if it successfully
  * scanned all the pages it was asked to (`count').
  * It returns zero if it couldn't do anything,

--Boundary-00=_ZDZZBoxl8tswdcG--

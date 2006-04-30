Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbWD3DZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWD3DZr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 23:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWD3DZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 23:25:47 -0400
Received: from fmr17.intel.com ([134.134.136.16]:53959 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750896AbWD3DZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 23:25:46 -0400
Subject: [PATCH] don't use flush_tlb_all in suspend time
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 30 Apr 2006 11:24:22 +0800
Message-Id: <1146367462.21486.10.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


flush_tlb_all uses on_each_cpu, which will disable/enable interrupt.
In suspend/resume time, this will make interrupt wrongly enabled.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---

 linux-2.6.17-rc3-root/arch/i386/kernel/acpi/sleep.c   |    2 +-
 linux-2.6.17-rc3-root/arch/i386/mm/init.c             |    5 ++++-
 linux-2.6.17-rc3-root/arch/x86_64/kernel/acpi/sleep.c |    4 ++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff -puN arch/i386/kernel/acpi/sleep.c~flush_tlb_all_check arch/i386/kernel/acpi/sleep.c
--- linux-2.6.17-rc3/arch/i386/kernel/acpi/sleep.c~flush_tlb_all_check	2006-04-29 08:45:24.000000000 +0800
+++ linux-2.6.17-rc3-root/arch/i386/kernel/acpi/sleep.c	2006-04-29 08:46:49.000000000 +0800
@@ -29,7 +29,7 @@ static void init_low_mapping(pgd_t * pgd
 		set_pgd(pgd, *(pgd + USER_PTRS_PER_PGD));
 		pgd_ofs++, pgd++;
 	}
-	flush_tlb_all();
+	local_flush_tlb();
 }
 
 /**
diff -puN arch/i386/mm/init.c~flush_tlb_all_check arch/i386/mm/init.c
--- linux-2.6.17-rc3/arch/i386/mm/init.c~flush_tlb_all_check	2006-04-29 08:47:05.000000000 +0800
+++ linux-2.6.17-rc3-root/arch/i386/mm/init.c	2006-04-29 08:48:15.000000000 +0800
@@ -420,7 +420,10 @@ void zap_low_mappings (void)
 #else
 		set_pgd(swapper_pg_dir+i, __pgd(0));
 #endif
-	flush_tlb_all();
+	if (cpus_weight(cpu_online_map) == 1)
+		local_flush_tlb();
+	else
+		flush_tlb_all();
 }
 
 static int disable_nx __initdata = 0;
diff -puN arch/x86_64/kernel/acpi/sleep.c~flush_tlb_all_check arch/x86_64/kernel/acpi/sleep.c
--- linux-2.6.17-rc3/arch/x86_64/kernel/acpi/sleep.c~flush_tlb_all_check	2006-04-29 09:16:48.000000000 +0800
+++ linux-2.6.17-rc3-root/arch/x86_64/kernel/acpi/sleep.c	2006-04-29 09:17:19.000000000 +0800
@@ -66,7 +66,7 @@ static void init_low_mapping(void)
 	pgd_t *slot0 = pgd_offset(current->mm, 0UL);
 	low_ptr = *slot0;
 	set_pgd(slot0, *pgd_offset(current->mm, PAGE_OFFSET));
-	flush_tlb_all();
+	local_flush_tlb();
 }
 
 /**
@@ -92,7 +92,7 @@ int acpi_save_state_mem(void)
 void acpi_restore_state_mem(void)
 {
 	set_pgd(pgd_offset(current->mm, 0UL), low_ptr);
-	flush_tlb_all();
+	local_flush_tlb();
 }
 
 /**
_



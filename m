Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262410AbVHFILY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbVHFILY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 04:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVHFII0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 04:08:26 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:61957 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S262409AbVHFIFQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 04:05:16 -0400
Message-ID: <42F46F37.3040008@vmware.com>
Date: Sat, 06 Aug 2005 01:05:11 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>, akpm@osdl.org
Cc: chrisl@vmware.com, davej@codemonkey.org.uk, hpa@zytor.com,
       linux-kernel@vger.kernel.org, pavel@suse.cz, pratap@vmware.com,
       Riley@Williams.Name
Subject: Re: [PATCH 1/1] i386 Encapsulate copying of pgd entries
References: <200508060026.j760Q6FT025108@zach-dev.vmware.com> <20050806011301.GD7991@shell0.pdx.osdl.net>
In-Reply-To: <20050806011301.GD7991@shell0.pdx.osdl.net>
Content-Type: multipart/mixed;
 boundary="------------000903010602060808000900"
X-OriginalArrivalTime: 06 Aug 2005 08:04:38.0655 (UTC) FILETIME=[7E00E0F0:01C59A5D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000903010602060808000900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Chris Wright wrote:

>* zach@vmware.com (zach@vmware.com) wrote:
>  
>
>>+	memset(pgd, 0, USER_PTRS_PER_PGD*sizeof(pgd_t));
>> 	if (PTRS_PER_PMD == 1)
>> 		spin_lock_irqsave(&pgd_lock, flags);
>> 
>>-	memcpy((pgd_t *)pgd + USER_PTRS_PER_PGD,
>>+	clone_pgd_range((pgd_t *)pgd + USER_PTRS_PER_PGD,
>> 			swapper_pg_dir + USER_PTRS_PER_PGD,
>>-			(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
>>-
>>+			KERNEL_PGD_PTRS);
>> 	if (PTRS_PER_PMD > 1)
>> 		return;
>> 
>> 	pgd_list_add(pgd);
>> 	spin_unlock_irqrestore(&pgd_lock, flags);
>>-	memset(pgd, 0, USER_PTRS_PER_PGD*sizeof(pgd_t));
>>    
>>
>
>Why memset was never done on PAE?
>
>thanks,
>-chris
>  
>

Update patch.  Thanks for catching this.  Tested PAE and non-PAE on 
native hardware and in a virtual machine :)

Zach

--------------000903010602060808000900
Content-Type: text/plain;
 name="pgd-clone-call"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pgd-clone-call"

Add a clone operation for pgd updates.

This helps complete the encapsulation of updates to page tables (or pages
about to become page tables) into accessor functions rather than using
memcpy() to duplicate them.  This is both generally good for consistency
and also necessary for running in a hypervisor which requires explicit
updates to page table entries.

The new function is:

clone_pgd_range(pgd_t *dst, pgd_t *src, int count);
 
   dst - pointer to pgd range anwhere on a pgd page
   src - ""
   count - the number of pgds to copy.

   dst and src can be on the same page, but the range must not overlap
   and must not cross a page boundary.

Note that I ommitted using this call to copy pgd entries into the
software suspend page root, since this is not technically a live paging
structure, rather it is used on resume from suspend.  CC'ing Pavel in case
he has any feedback on this.

Thanks to Chris Wright for noticing that this could be more optimal in
PAE compiles by eliminating the memset.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/arch/i386/mm/pgtable.c
===================================================================
--- linux-2.6.13.orig/arch/i386/mm/pgtable.c	2005-08-04 12:02:10.000000000 -0700
+++ linux-2.6.13/arch/i386/mm/pgtable.c	2005-08-06 00:43:51.000000000 -0700
@@ -207,19 +207,19 @@
 {
 	unsigned long flags;
 
-	if (PTRS_PER_PMD == 1)
+	if (PTRS_PER_PMD == 1) {
+		memset(pgd, 0, USER_PTRS_PER_PGD*sizeof(pgd_t));
 		spin_lock_irqsave(&pgd_lock, flags);
+	}
 
-	memcpy((pgd_t *)pgd + USER_PTRS_PER_PGD,
+	clone_pgd_range((pgd_t *)pgd + USER_PTRS_PER_PGD,
 			swapper_pg_dir + USER_PTRS_PER_PGD,
-			(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
-
+			KERNEL_PGD_PTRS);
 	if (PTRS_PER_PMD > 1)
 		return;
 
 	pgd_list_add(pgd);
 	spin_unlock_irqrestore(&pgd_lock, flags);
-	memset(pgd, 0, USER_PTRS_PER_PGD*sizeof(pgd_t));
 }
 
 /* never called when PTRS_PER_PMD > 1 */
Index: linux-2.6.13/arch/i386/kernel/smpboot.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/smpboot.c	2005-08-04 12:02:10.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/smpboot.c	2005-08-04 13:15:45.000000000 -0700
@@ -1017,8 +1017,8 @@
 	tsc_sync_disabled = 1;
 
 	/* init low mem mapping */
-	memcpy(swapper_pg_dir, swapper_pg_dir + USER_PGD_PTRS,
-			sizeof(swapper_pg_dir[0]) * KERNEL_PGD_PTRS);
+	clone_pgd_range(swapper_pg_dir, swapper_pg_dir + USER_PGD_PTRS,
+			KERNEL_PGD_PTRS);
 	flush_tlb_all();
 	schedule_work(&task);
 	wait_for_completion(&done);
Index: linux-2.6.13/include/asm-i386/pgtable.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/pgtable.h	2005-08-04 12:02:10.000000000 -0700
+++ linux-2.6.13/include/asm-i386/pgtable.h	2005-08-05 17:12:33.000000000 -0700
@@ -276,6 +276,21 @@
 }
 
 /*
+ * clone_pgd_range(pgd_t *dst, pgd_t *src, int count);
+ *
+ *  dst - pointer to pgd range anwhere on a pgd page
+ *  src - ""
+ *  count - the number of pgds to copy.
+ *
+ * dst and src can be on the same page, but the range must not overlap,
+ * and must not cross a page boundary.
+ */
+static inline void clone_pgd_range(pgd_t *dst, pgd_t *src, int count)
+{
+       memcpy(dst, src, count * sizeof(pgd_t));
+}
+
+/*
  * Macro to mark a page protection value as "uncacheable".  On processors which do not support
  * it, this is a no-op.
  */

--------------000903010602060808000900--

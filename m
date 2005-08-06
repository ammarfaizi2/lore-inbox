Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbVHFGBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVHFGBi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 02:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbVHFGBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 02:01:35 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:5904 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S261790AbVHFGBd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 02:01:33 -0400
Message-ID: <42F451F0.7010400@vmware.com>
Date: Fri, 05 Aug 2005 23:00:16 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org, chrisl@vmware.com,
       davej@codemonkey.org.uk, hpa@zytor.com, linux-kernel@vger.kernel.org,
       pavel@suse.cz, pratap@vmware.com, Riley@Williams.Name
Subject: Re: [PATCH 1/1] i386 Encapsulate copying of pgd entries
References: <200508060026.j760Q6FT025108@zach-dev.vmware.com> <20050806011301.GD7991@shell0.pdx.osdl.net> <42F417E3.2070909@vmware.com>
In-Reply-To: <42F417E3.2070909@vmware.com>
Content-Type: multipart/mixed;
 boundary="------------020508080401040509050009"
X-OriginalArrivalTime: 06 Aug 2005 06:00:31.0734 (UTC) FILETIME=[274AE960:01C59A4C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020508080401040509050009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Zachary Amsden wrote:

> Chris Wright wrote:
>
>>
>> Why memset was never done on PAE?
>
>
> That's a good point.  The memset() is redundant on PAE, since it 
> allocates all 4 PMDs immediately after that (in pgd_alloc).  There are 
> two reasons for moving the memset() - one is that it can potentially 
> perform useful work ahead of the lock and effectively act as a 
> prefetch.  The second is that at least on a hypervisor, 
> clone_pgd_range() is likely to be taken as a page allocation hint, and 
> thus moving the memset() before this operation allows only the 
> actually present page directory entry updates to be passed to the 
> hypervisor.
>
> Actually, the memset() could be redundant on non-PAE as well, since we 
> should have gone through free_pgtables, which would have done a 
> pmd_clear() on each user level pmd, and the kernel level pmds are 
> copied in again inside the lock.
>
> I'll try it out to see if this is possible.
>
> Zach
>

So that turned out to be a really bad idea.  But, I did notice that the 
pmds in PAE mode could be cached with the pgds instead of destroying and 
re-allocating them.  Unfortunately, this spends three pages per cached 
PAE pgd, and doesn't look like a big win.  I ran microbenchmarks, stolen 
mostly from lmbench (thank you Larry!), and this patch shows almost no 
improvement.  Judging by the fact the the kmem slab cache seems to work 
very efficiently, I don't think the extra overhead from memset in the 
constructor is of much significance.

Here's the benchmark results on native hardware (P4, 2.4 GHz, PAE kernel):

Before:
(getpid and segv truncated beyond my scrollback, but of no significance)
  forkwait: 0.596u 3.932s 0:04.54 99.5% 0+0k 0+0io 0pf+0w
  forkwait: 0.632u 3.876s 0:04.50 100.0%        0+0k 0+0io 0pf+0w
  forkwait: 0.468u 4.048s 0:04.51 99.7% 0+0k 0+0io 0pf+0w
  forkwait: 0.516u 3.988s 0:04.50 99.7% 0+0k 0+0io 0pf+0w
  forkwait: 0.644u 3.908s 0:04.55 99.7% 0+0k 0+0io 0pf+0w
   divzero: 1.356u 6.712s 0:08.07 99.8% 0+0k 0+0io 0pf+0w
   divzero: 1.332u 6.620s 0:07.94 100.1%        0+0k 0+0io 0pf+0w
   divzero: 1.300u 6.652s 0:07.95 100.0%        0+0k 0+0io 0pf+0w
   divzero: 1.672u 6.312s 0:07.98 100.0%        0+0k 0+0io 0pf+0w
   divzero: 1.128u 6.824s 0:07.95 99.8% 0+0k 0+0io 0pf+0w
  lat_pipe: 0.228u 8.196s 0:16.98 49.5% 0+0k 0+0io 0pf+0w
  lat_pipe: 0.220u 8.420s 0:17.15 50.3% 0+0k 0+0io 0pf+0w
  lat_pipe: 0.236u 8.376s 0:17.00 50.5% 0+0k 0+0io 0pf+0w
  lat_pipe: 0.220u 8.140s 0:16.97 49.2% 0+0k 0+0io 0pf+0w
  lat_pipe: 0.232u 8.488s 0:16.86 51.6% 0+0k 0+0io 0pf+0w
    Switch: 5.896u 7.172s 0:11.97 109.1%        0+0k 0+0io 53pf+0w
    Switch: 6.168u 6.792s 0:11.23 115.3%        0+0k 0+0io 1pf+0w
    Switch: 6.084u 7.044s 0:11.22 116.9%        0+0k 0+0io 1pf+0w
    Switch: 6.044u 7.088s 0:11.34 115.6%        0+0k 0+0io 1pf+0w
    Switch: 6.252u 7.212s 0:11.45 117.5%        0+0k 0+0io 1pf+0w

After:

zach-dev2:Micro-bench $ cat out.post-patch
    getpid: 0.076u 0.000s 0:00.08 87.5% 0+0k 0+0io 0pf+0w
    getpid: 0.076u 0.004s 0:00.07 100.0%        0+0k 0+0io 0pf+0w
    getpid: 0.080u 0.000s 0:00.08 100.0%        0+0k 0+0io 0pf+0w
    getpid: 0.076u 0.000s 0:00.07 100.0%        0+0k 0+0io 0pf+0w
    getpid: 0.072u 0.004s 0:00.07 100.0%        0+0k 0+0io 0pf+0w
      segv: 1.168u 8.552s 0:09.72 99.8% 0+0k 0+0io 0pf+0w
      segv: 1.160u 8.544s 0:09.70 100.0%        0+0k 0+0io 0pf+0w
      segv: 1.248u 8.364s 0:09.61 99.8% 0+0k 0+0io 0pf+0w
      segv: 1.296u 8.368s 0:09.66 99.8% 0+0k 0+0io 0pf+0w
      segv: 1.312u 8.288s 0:09.59 100.0%        0+0k 0+0io 0pf+0w
  forkwait: 0.600u 3.932s 0:04.53 100.0%        0+0k 0+0io 0pf+0w
  forkwait: 0.580u 3.940s 0:04.51 100.2%        0+0k 0+0io 0pf+0w
  forkwait: 0.576u 3.948s 0:04.52 99.7% 0+0k 0+0io 0pf+0w
  forkwait: 0.492u 3.996s 0:04.48 100.0%        0+0k 0+0io 0pf+0w
  forkwait: 0.604u 3.908s 0:04.51 99.7% 0+0k 0+0io 0pf+0w
   divzero: 1.304u 6.740s 0:08.04 100.0%        0+0k 0+0io 0pf+0w
   divzero: 1.360u 6.704s 0:08.06 100.0%        0+0k 0+0io 0pf+0w
   divzero: 1.344u 6.696s 0:08.03 100.0%        0+0k 0+0io 0pf+0w
   divzero: 1.428u 6.600s 0:08.02 100.0%        0+0k 0+0io 0pf+0w
   divzero: 1.308u 6.720s 0:08.02 100.0%        0+0k 0+0io 0pf+0w
  lat_pipe: 0.212u 7.648s 0:16.40 47.8% 0+0k 0+0io 0pf+0w
  lat_pipe: 0.268u 8.208s 0:16.78 50.4% 0+0k 0+0io 0pf+0w
  lat_pipe: 0.188u 8.296s 0:16.42 51.5% 0+0k 0+0io 0pf+0w
  lat_pipe: 0.180u 8.084s 0:16.91 48.8% 0+0k 0+0io 0pf+0w
  lat_pipe: 0.160u 7.668s 0:16.85 46.4% 0+0k 0+0io 0pf+0w
    Switch: 6.168u 6.740s 0:11.91 108.3%        0+0k 0+0io 53pf+0w
    Switch: 5.860u 7.332s 0:11.45 115.1%        0+0k 0+0io 1pf+0w
    Switch: 5.804u 7.140s 0:11.34 114.1%        0+0k 0+0io 1pf+0w
    Switch: 6.168u 6.644s 0:11.12 115.1%        0+0k 0+0io 1pf+0w
    Switch: 6.076u 6.896s 0:11.34 114.2%        0+0k 0+0io 1pf+0w

So lat_pipe seems to have improved slightly.. but it could be noise.  
Yeah, not worth it.  Plus, this patch is obviously broken - the panic() 
could be avoided by reworking the code, but this seems like a large 
amount of work for very little gain.  Nevertheless, I have attached the 
patch for posterity's sake.

Zach

--------------020508080401040509050009
Content-Type: text/plain;
 name="pae-fork-opt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pae-fork-opt"


Index: linux-2.6.13-rc4-mm1/arch/i386/mm/pgtable.c
===================================================================
--- linux-2.6.13-rc4-mm1.orig/arch/i386/mm/pgtable.c	2005-08-04 05:42:32.000000000 -0700
+++ linux-2.6.13-rc4-mm1/arch/i386/mm/pgtable.c	2005-08-05 13:04:14.000000000 -0700
@@ -214,8 +214,16 @@
 	clone_pgd_range((pgd_t *)pgd + USER_PTRS_PER_PGD,
 			swapper_pg_dir + USER_PTRS_PER_PGD,
 			PTRS_PER_PGD - USER_PTRS_PER_PGD);
-	if (PTRS_PER_PMD > 1)
+	if (PTRS_PER_PMD > 1) {
+		int i;
+		for (i = 0; i < USER_PTRS_PER_PGD; ++i) {
+			pmd_t *pmd = kmem_cache_alloc(pmd_cache, GFP_KERNEL);
+			if (!pmd)
+				panic("oom");
+			set_pgd(&((pgd_t *)pgd)[i], __pgd(1 + __pa(pmd)));
+		}
 		return;
+	}
 
 	pgd_list_add(pgd);
 	spin_unlock_irqrestore(&pgd_lock, flags);
@@ -226,6 +234,14 @@
 {
 	unsigned long flags; /* can be called from interrupt context */
 
+	/* in the PAE case user pgd entries are overwritten before usage */
+	if (PTRS_PER_PMD > 1) {
+		int i;
+		for (i = 0; i < USER_PTRS_PER_PGD; ++i)
+			kmem_cache_free(pmd_cache, (void *)__va(pgd_val(((pgd_t *)pgd)[i])-1));
+		return;
+	}
+
 	spin_lock_irqsave(&pgd_lock, flags);
 	pgd_list_del(pgd);
 	spin_unlock_irqrestore(&pgd_lock, flags);
@@ -233,35 +249,12 @@
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	int i;
 	pgd_t *pgd = kmem_cache_alloc(pgd_cache, GFP_KERNEL);
-
-	if (PTRS_PER_PMD == 1 || !pgd)
-		return pgd;
-
-	for (i = 0; i < USER_PTRS_PER_PGD; ++i) {
-		pmd_t *pmd = kmem_cache_alloc(pmd_cache, GFP_KERNEL);
-		if (!pmd)
-			goto out_oom;
-		set_pgd(&pgd[i], __pgd(1 + __pa(pmd)));
-	}
 	return pgd;
 
-out_oom:
-	for (i--; i >= 0; i--)
-		kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
-	kmem_cache_free(pgd_cache, pgd);
-	return NULL;
 }
 
 void pgd_free(pgd_t *pgd)
 {
-	int i;
-
-	/* in the PAE case user pgd entries are overwritten before usage */
-	if (PTRS_PER_PMD > 1)
-		for (i = 0; i < USER_PTRS_PER_PGD; ++i)
-			kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
-	/* in the non-PAE case, free_pgtables() clears user pgd entries */
 	kmem_cache_free(pgd_cache, pgd);
 }
Index: linux-2.6.13-rc4-mm1/arch/i386/mm/init.c
===================================================================
--- linux-2.6.13-rc4-mm1.orig/arch/i386/mm/init.c	2005-08-04 04:01:27.000000000 -0700
+++ linux-2.6.13-rc4-mm1/arch/i386/mm/init.c	2005-08-05 13:02:34.000000000 -0700
@@ -635,7 +635,7 @@
 				PTRS_PER_PGD*sizeof(pgd_t),
 				0,
 				pgd_ctor,
-				PTRS_PER_PMD == 1 ? pgd_dtor : NULL);
+				pgd_dtor);
 	if (!pgd_cache)
 		panic("pgtable_cache_init(): Cannot create pgd cache");
 }

--------------020508080401040509050009--

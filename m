Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWBVDBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWBVDBZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 22:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWBVDBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 22:01:25 -0500
Received: from fmr20.intel.com ([134.134.136.19]:30364 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751221AbWBVDBY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 22:01:24 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: IA64 non-contiguous memory space bugs
Date: Wed, 22 Feb 2006 11:01:18 +0800
Message-ID: <99FA2ED298A9834DB1BF5DE8BDBF241331834A@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: IA64 non-contiguous memory space bugs
thread-index: AcY3V7Wgz3ml1mepSEWOlgyKtSiwtQABDlXg
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: "David Gibson" <david@gibson.dropbear.id.au>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Feb 2006 03:01:19.0158 (UTC) FILETIME=[40E00560:01C6375C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>-----Original Message-----
>>From: linux-ia64-owner@vger.kernel.org [mailto:linux-ia64-owner@vger.kernel.org] On Behalf Of 'David Gibson'
>>Sent: 2006Äê2ÔÂ22ÈÕ 10:26
>>To: Chen, Kenneth W
>>Cc: linux-ia64@vger.kernel.org; linux-kernel@vger.kernel.org
>>Subject: Re: IA64 non-contiguous memory space bugs
>>
>>Your patch below is insufficient, because there's a second test of
>>is_hugepage_only_range() further down.  However, instead of tweaking
>>the tested ranges, I think what we really want to do is check for
>>is_vm_hugetlb_page() instead.
>>
>>I was worried before, but now that you point out it's the 'end'
>>address which really matters, not the ceiling, that might be
>>sufficient.  Um.. except that hugepages, unlike normal pages these
>>days don't necessarily clean up all possible pagetable pages on
>>unmap...  crud.  Still the patch below ought to be an improvement.
>>
>>Index: working-2.6/mm/memory.c
>>===================================================================
>>--- working-2.6.orig/mm/memory.c	2006-02-22 10:42:14.000000000 +1100
>>+++ working-2.6/mm/memory.c	2006-02-22 13:22:07.000000000 +1100
>>@@ -277,7 +277,7 @@ void free_pgtables(struct mmu_gather **t
>> 		anon_vma_unlink(vma);
>> 		unlink_file_vma(vma);
>>
>>-		if (is_hugepage_only_range(vma->vm_mm, addr, HPAGE_SIZE)) {
>>+		if (is_vm_hugetlb_page(vma)) {
>> 			hugetlb_free_pgd_range(tlb, addr, vma->vm_end,
>> 				floor, next? next->vm_start: ceiling);
>> 		} else {
>>@@ -285,8 +285,7 @@ void free_pgtables(struct mmu_gather **t
>> 			 * Optimization: gather nearby vmas into one call down
>> 			 */
>> 			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
>>-			  && !is_hugepage_only_range(vma->vm_mm, next->vm_start,
>>-							HPAGE_SIZE)) {
>>+			       && !is_vm_hugetlb_page(vma->vm_mm)) {
is_vm_hugetlb_page(vma->vm_mm) should be is_vm_hugetlb_page(vma)?


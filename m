Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbVIGDPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbVIGDPY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 23:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbVIGDPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 23:15:24 -0400
Received: from fmr17.intel.com ([134.134.136.16]:20431 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750866AbVIGDPX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 23:15:23 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2/3 htlb-fault] Demand faulting for hugetlb
Date: Wed, 7 Sep 2005 11:13:06 +0800
Message-ID: <8126E4F969BA254AB43EA03C59F44E84033652C1@pdsmsx404>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/3 htlb-fault] Demand faulting for hugetlb
Thread-Index: AcWzLo0RE3SGBWexReiqqGdlJHQJvAAKnT/g
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: "Adam Litke" <agl@us.ibm.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Sep 2005 03:14:21.0532 (UTC) FILETIME=[3DCED1C0:01C5B35A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More comments below.

>>-----Original Message-----
>>From: linux-kernel-owner@vger.kernel.org
>>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Adam Litke
>>Sent: Wednesday, September 07, 2005 5:59 AM
>>To: linux-kernel@vger.kernel.org
>>Cc: ADAM G. LITKE [imap]
>>Subject: Re: [PATCH 2/3 htlb-fault] Demand faulting for hugetlb
>>
>>Below is a patch to implement demand faulting for huge pages.  The
main
>>motivation for changing from prefaulting to demand faulting is so that
>>huge page memory areas can be allocated according to NUMA policy.

>>@@ -277,18 +277,20 @@ int copy_hugetlb_page_range(struct mm_st
>> 	unsigned long addr = vma->vm_start;
>> 	unsigned long end = vma->vm_end;
>>
>>-	while (addr < end) {
>>+	for (; addr < end; addr += HPAGE_SIZE) {
>>+		src_pte = huge_pte_offset(src, addr);
>>+		if (!src_pte || pte_none(*src_pte))
>>+			continue;
>>+
>> 		dst_pte = huge_pte_alloc(dst, addr);
>> 		if (!dst_pte)
>> 			goto nomem;
>>-		src_pte = huge_pte_offset(src, addr);
>>-		BUG_ON(!src_pte || pte_none(*src_pte)); /* prefaulted */
>>+		BUG_ON(!src_pte);
Should this BUG_ON be deleted?

>> 		entry = *src_pte;
>> 		ptepage = pte_page(entry);
>> 		get_page(ptepage);
>> 		add_mm_counter(dst, rss, HPAGE_SIZE / PAGE_SIZE);
>> 		set_huge_pte_at(dst, addr, dst_pte, entry);
>>-		addr += HPAGE_SIZE;
>> 	}
>> 	return 0;
>>


>>+int hugetlb_pte_fault(struct mm_struct *mm, struct vm_area_struct
*vma,
>>+			unsigned long address, int write_access)
>>+{
>>+	int ret = VM_FAULT_MINOR;
>>+	unsigned long idx;
>>+	pte_t *pte;
>>+	struct page *page;
>>+	struct address_space *mapping;
>>+
>>+	BUG_ON(vma->vm_start & ~HPAGE_MASK);
>>+	BUG_ON(vma->vm_end & ~HPAGE_MASK);
>>+	BUG_ON(!vma->vm_file);
>>+
>>+	pte = huge_pte_alloc(mm, address);
Why to call huge_pte_alloc again? Hugetlb_fault already calls it.


>>+	if (!pte) {
>>+		ret = VM_FAULT_SIGBUS;
>>+		goto out;
>>+	}
>>+	if (! pte_none(*pte))
>>+		goto flush;
>>+
>>+	mapping = vma->vm_file->f_mapping;
>>+	idx = ((address - vma->vm_start) >> HPAGE_SHIFT)
>>+		+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
>>+retry:
>>+	page = find_get_page(mapping, idx);
>>+	if (!page) {
>>+		/* charge the fs quota first */
>>+		if (hugetlb_get_quota(mapping)) {
>>+			ret = VM_FAULT_SIGBUS;
>>+			goto out;
>>+		}
>>+		page = alloc_huge_page();
>>+		if (!page) {
>>+			hugetlb_put_quota(mapping);
>>+			ret = VM_FAULT_SIGBUS;
>>+			goto out;
>>+		}
>>+		if (add_to_page_cache(page, mapping, idx, GFP_ATOMIC)) {
>>+			put_page(page);
>>+			goto retry;
>>+		}
>>+		unlock_page(page);
>>+	}
>>+	add_mm_counter(mm, rss, HPAGE_SIZE / PAGE_SIZE);
>>+	set_huge_pte_at(mm, address, pte, make_huge_pte(vma, page));
>>+flush:
>>+	flush_tlb_page(vma, address);
>>+out:
>>+	return ret;
>>+}
>>+
>>+int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>>+			unsigned long address, int write_access)
>>+{
>>+	pte_t *ptep;
>>+	int rc = VM_FAULT_MINOR;
>>+
>>+	spin_lock(&mm->page_table_lock);
>>+
>>+	ptep = huge_pte_alloc(mm, address & HPAGE_MASK);
The alignment is not needed. How about change it to ptep =
huge_pte_alloc(mm, address)?

>>+	if (! ptep) {
>>+		rc = VM_FAULT_SIGBUS;
>>+		goto out;
>>+	}
>>+	if (pte_none(*ptep))
>>+		rc = hugetlb_pte_fault(mm, vma, address, write_access);
In function hugetlb_pte_fault, if(!pte_none(*ptep)), tlb page will be
flushed, but here is doesn't. Why?

>>+out:
>>+	spin_unlock(&mm->page_table_lock);
>>+	return rc;
>>+}

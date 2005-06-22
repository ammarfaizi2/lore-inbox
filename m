Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVFVRQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVFVRQo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 13:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVFVRQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 13:16:00 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:17032 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S261699AbVFVRLo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 13:11:44 -0400
X-IronPort-AV: i="3.93,221,1115010000"; 
   d="scan'208"; a="276763517:sNHT25133320"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: page allocation/attributes question (i386/x86_64 specific)
Date: Wed, 22 Jun 2005 12:11:42 -0500
Message-ID: <7A8F92187EF7A249BF847F1BF4903C040240AE3C@ausx2kmpc103.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: page allocation/attributes question (i386/x86_64 specific)
Thread-Index: AcV3Pt/FK5WDWX2bRTWpUIcp7s34vgAAWobQ
From: <Stuart_Hayes@Dell.com>
To: <linux-kernel@vger.kernel.org>
Cc: <Stuart_Hayes@Dell.com>
X-OriginalArrivalTime: 22 Jun 2005 17:11:43.0870 (UTC) FILETIME=[76C471E0:01C5774D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
I have a question regarding page attributes on i386/x86_64 platforms:

Supopse a function requests a page with __get_free_pages(), and the page
that's returned is actually part of a large (2MB) page that has a single
pte (or pmd, I guess) to control it.

Suppose this function then calls change_page_attr() to, say, modify the
caching policy for that page.  Since the page is part of a large 2MB
page (PAGE_PSE is set), change_page_attr() calls split_large_page() to
create 512 new PTEs, since the caching policy is only being changed on
the single 4K page, and not for the entire 2MB large page.

When split_large_page() creates the 512 new PTEs, it assigns the
requested attributes to the page in question, but it sets all of the
other 511 PTEs the PAGE_KERNEL attributes.  It never checks what
attributes were set for the large page--it just assumes that the other
511 pages should have PAGE_KERNEL attributes.

My question is this:  when split_large_page() is called, should it make
the other 511 PTEs inherit the page attributes from the large page (with
the exception of PAGE_PSE, obviously)?

There appears to be a bug (at least in certain 2.6 kernel versions)
where __get_free_pages() returns a page that's in a large page that is
executable (it doesn't have the PAGE_NX bit set)... but, after
change_page_attr() is called, the other 511 pages, which contain kernel
code, are no longer executable (because they were set to PAGE_KERNEL,
which has PAGE_NX set).

I've copied the split_large_page() code below for reference.

Thanks,
Stuart


static struct page *split_large_page(unsigned long address, pgprot_t
prot)
{ 
	int i; 
	unsigned long addr;
	struct page *base;
	pte_t *pbase;

	spin_unlock_irq(&cpa_lock);
	base = alloc_pages(GFP_KERNEL, 0);
	spin_lock_irq(&cpa_lock);
	if (!base) 
		return NULL;

	address = __pa(address);
	addr = address & LARGE_PAGE_MASK; 
	pbase = (pte_t *)page_address(base);
	for (i = 0; i < PTRS_PER_PTE; i++, addr += PAGE_SIZE) {
		pbase[i] = pfn_pte(addr >> PAGE_SHIFT, 
				   addr == address ? prot :
PAGE_KERNEL);
	}
	return base;
} 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992437AbWJTCrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992437AbWJTCrw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 22:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992436AbWJTCrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 22:47:51 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:44138 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S2992434AbWJTCru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 22:47:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LL0NY7GHiRLbMx91PXRpxKGf5pgtb5S6E1BrTbyAE5eq6vMJ4rfsKtefSPbmTDZ4qb4G+KWezy0RjKB2ZbFEexouAIKgBymDAy7KE2MVmYDWhcWVW2vH89Q6CnBgtFgrlpKSWWV9hwya5pXVIt6XIjsfdCwPH/8tiQt3SIAasi4=
Message-ID: <4df04b840610191947r2b48c2ddo45f0cd94d94a614b@mail.gmail.com>
Date: Fri, 20 Oct 2006 10:47:49 +0800
From: "yunfeng zhang" <zyf.zeroos@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: BUG: about flush TLB during unmapping a page in memory subsystem
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In rmap.c::try_to_unmap_one of 2.6.16.29, there are some code snippets

.....
/* Nuke the page table entry. */
flush_cache_page(vma, address, page_to_pfn(page));
pteval = ptep_clear_flush(vma, address, pte);
// >>> The above line is expanded as below
// >>> pte_t __pte;
// >>> __pte = ptep_get_and_clear((__vma)->vm_mm, __address, __ptep);
// >>> flush_tlb_page(__vma, __address);
// >>> __pte;

/* Move the dirty bit to the physical page now the pte is gone. */
if (pte_dirty(pteval))
        set_page_dirty(page);
.....


It seems that they only can work on UP system.

On SMP, let's suppose the pte was clean, after A CPU executed
ptep_get_and_clear,
B CPU makes the pte dirty, which will make a fatal error to A CPU since it gets
a stale pte, isn't right?

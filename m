Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316935AbSHJM15>; Sat, 10 Aug 2002 08:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316951AbSHJM15>; Sat, 10 Aug 2002 08:27:57 -0400
Received: from dp.samba.org ([66.70.73.150]:37583 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S316935AbSHJM14>;
	Sat, 10 Aug 2002 08:27:56 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15701.1794.957072.397815@argo.ozlabs.ibm.com>
Date: Sat, 10 Aug 2002 22:28:50 +1000 (EST)
To: arnd@bergmann-dalldorf.de
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 15/18 better pte invalidation
In-Reply-To: <200208051954.55546.arndb@de.ibm.com>
References: <200208051830.50713.arndb@de.ibm.com>
	<200208051954.55546.arndb@de.ibm.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann writes:

> 2) s/390 has an instruction called ipte (invalidate page table entry) that
>    is used to get rid of virtual pages. It does two things, first it set
>    the invalid bit in the pte and second it flushes the tlbs for this
>    page on all cpus. Very handy but it requires that the pte it should
>    flush is still valid. The introduction of establish_pte was a step
>    into the right direction but it is defined in mm/memory.c. We need
>    to be able to replace this function with a special s/390 variant.

It's now possible in 2.5 to go from a PTE pointer to the mm and
virtual address that it maps - see ptep_to_mm and ptep_to_address in
include/asm-generic/rmap.h.  I'm planning to use this to do MMU
hashtable management on PPC in set_pte et al. and thus avoid the
second walk of the Linux page tables that we currently do in
flush_tlb_* on PPC.  You could use those functions to let you use the
ipte instruction in set_pte et al. and then make the flush_tlb_*
functions be no-ops.

The ptep_to_mm and ptep_to_address functions came in with rmap, but
all they rely on is having the page->mapping and page->index fields
filled in for pagetable pages.  It should only be a minor addition to
the 2.4 MM system to set those fields, and it would be useful on ppc,
ppc64, s390 and s390x.

Paul.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbVLLV20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbVLLV20 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 16:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbVLLV20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 16:28:26 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:13761 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932146AbVLLV2Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 16:28:25 -0500
Subject: Re: 2.6.15-rc4 panic in __nr_to_section() with CONFIG_SPARSEMEM
From: Dave Hansen <haveblue@us.ibm.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: David Gibson <dwg@au1.ibm.com>, Andy Whitcroft <andyw@uk.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "ADAM G. LITKE [imap]" <agl@us.ibm.com>
In-Reply-To: <1134404367.2193.14.camel@localhost.localdomain>
References: <1133995060.21841.56.camel@localhost.localdomain>
	 <43976AA4.2060606@uk.ibm.com>
	 <1133997772.21841.62.camel@localhost.localdomain>
	 <1134002888.30387.82.camel@localhost>
	 <1134058055.21841.70.camel@localhost.localdomain>
	 <1134069335.6159.21.camel@localhost>
	 <20051208234841.GA30254@localhost.localdomain>
	 <1134087389.18179.2.camel@localhost>
	 <1134404367.2193.14.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 12 Dec 2005 13:28:09 -0800
Message-Id: <1134422889.27961.22.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-12 at 08:19 -0800, Badari Pulavarty wrote:
> NACK. 
> 
> Like I mentioned to you privately, I still get Oops with this patch for
> largepages. Please let me know, if you have a new version to try.

I'm going to throw this back over the wall at Adam and Dave Gibson.  It
is going to take a bit more than a cosmetic fix.  The complexity comes
because there are two _distinct_ hugetlb cases here.  The first is when
the HPTE is condensed into the PMD like on normal i386 or in the !
64K_PAGES case on ppc64.  The second is when the HPTE is stored like a
normal PTE in a PTE page like on the 64K_PAGES ppc64 case.

These need to be handled in two different places in the smaps pagetable
walk.  Add that into the normal small PTE case and we end up having
_three_ cases to handle for the end of the pagetable walk.

Before we did faulting for these PTEs, it would have been easy to have a
if() to hack it in at the top of the pagetable walk, but we can't do
that any more.

The big question is: do we ever need to deal with large pages in a
normal pagetable walk?  If not, we can probably just hack the two extra
cases in.  How do we tell in generic code whether we're looking at a
real "huge PMD", or one that points to a PTE page with "huge PTE"s?
That seems to be a ppc64-specific question for now.

Badari, appended is a patch that doesn't fix the accounting in smaps,
but will simply skip the huge page vmas.  It will at least keep you from
oopsing.

-- Dave

 smaps-fix-dave/fs/proc/task_mmu.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN fs/proc/task_mmu.c~smaps_fix fs/proc/task_mmu.c
--- smaps-fix/fs/proc/task_mmu.c~smaps_fix	2005-12-12 13:19:05.000000000 -0800
+++ smaps-fix-dave/fs/proc/task_mmu.c	2005-12-12 13:21:07.000000000 -0800
@@ -289,7 +289,7 @@ static int show_smap(struct seq_file *m,
 	struct mem_size_stats mss;
 
 	memset(&mss, 0, sizeof mss);
-	if (vma->vm_mm)
+	if (vma->vm_mm && !is_vm_hugetlb_page(vma))
 		smaps_pgd_range(vma, vma->vm_start, vma->vm_end, &mss);
 	return show_map_internal(m, v, &mss);
 }
_



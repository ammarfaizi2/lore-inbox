Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbUKELYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbUKELYw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 06:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbUKELYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 06:24:52 -0500
Received: from mx2.elte.hu ([157.181.151.9]:25556 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261550AbUKELYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 06:24:38 -0500
Date: Fri, 5 Nov 2004 12:24:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Lorenzo Allegrucci <l_allegrucci@yahoo.it>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm3
Message-ID: <20041105112404.GA32198@elte.hu>
References: <20041105001328.3ba97e08.akpm@osdl.org> <200411051041.17940.l_allegrucci@yahoo.it> <20041105102204.GA4730@elte.hu> <20041105110951.GA29702@elte.hu> <20041105111751.GC8349@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105111751.GC8349@wotan.suse.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> > The solution is to clip both 'first' and 'last' to PML4_SIZE boundary.
> > Since when we calculate 'first' we add at least +PML4_SIZE to the value,
> > it is safe to clip 'first'. It is obviously safe to clip 'last'.
> 
> It's a bit tricky because on 3level architectures it clips on PGDs,
> not PML4s, otherwise it would never free any pagetables.  But the
> if()s check that correctly.

indeed ... But in the do_munmap() case we dont even clip to PGD
boundary. So shouldnt we at least do the patch below?

	Ingo

--- linux/mm/mmap.c.orig
+++ linux/mm/mmap.c
@@ -1545,7 +1545,7 @@ no_mmaps:
 	}
 	if (pml4_index(last) > start_pml4_index ||
 	    pgd_index(last) > start_pgd_index) {
-		clear_page_range(tlb, first & PML4_MASK, last & PML4_MASK);
+		clear_page_range(tlb, first & PGDIR_MASK, last & PGDIR_MASK);
 		flush_tlb_pgtables(mm, first & PML4_MASK, last & PML4_MASK);
 	}
 }

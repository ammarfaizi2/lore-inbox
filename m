Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262641AbUKELLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbUKELLx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 06:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbUKELLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 06:11:52 -0500
Received: from mx1.elte.hu ([157.181.1.137]:14488 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262641AbUKELLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 06:11:43 -0500
Date: Fri, 5 Nov 2004 12:09:51 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lorenzo Allegrucci <l_allegrucci@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: 2.6.10-rc1-mm3
Message-ID: <20041105110951.GA29702@elte.hu>
References: <20041105001328.3ba97e08.akpm@osdl.org> <200411051041.17940.l_allegrucci@yahoo.it> <20041105102204.GA4730@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105102204.GA4730@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> > ------------[ cut here ]------------
> > kernel BUG at mm/memory.c:156!
> 
> > Process shmt04 (pid: 4854, threadinfo=dca51000 task=de374510)
> 
> reproducible here too, just running LTP's shmt04 directly triggers it
> immediately. Looks like there's interaction of 4-level pagetables with
> ipc/shm.c or mm/shmem.c.

due to the PML4 feature, the clear_page_tables() function changed to
clear_page_range(), changing its (first,size) argument to (first,last). 
Normally it's called with (0,TASK_SIZE) which normally is PML4-aligned,
but in the (relatively rare) do_munmap() use this is not the case. We
correctly calculate the range that could be cleared, but it's not
PML4_SIZE aligned.

The solution is to clip both 'first' and 'last' to PML4_SIZE boundary.
Since when we calculate 'first' we add at least +PML4_SIZE to the value,
it is safe to clip 'first'. It is obviously safe to clip 'last'.

The patch below implements this fix - it boots & works fine and shmt04
doesnt crash anymore. Andi, do you agree with this fix?

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/mm/mmap.c.orig
+++ linux/mm/mmap.c
@@ -1545,7 +1545,7 @@ no_mmaps:
 	}
 	if (pml4_index(last) > start_pml4_index ||
 	    pgd_index(last) > start_pgd_index) {
-		clear_page_range(tlb, first, last);
+		clear_page_range(tlb, first & PML4_MASK, last & PML4_MASK);
 		flush_tlb_pgtables(mm, first & PML4_MASK, last & PML4_MASK);
 	}
 }

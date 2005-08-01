Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVHAJUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVHAJUY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 05:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVHAJT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 05:19:29 -0400
Received: from mx1.elte.hu ([157.181.1.137]:1499 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261335AbVHAJTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 05:19:25 -0400
Date: Mon, 1 Aug 2005 11:19:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Robin Holt <holt@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Roland McGrath <roland@redhat.com>,
       Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
Message-ID: <20050801091956.GA3950@elte.hu>
References: <20050801032258.A465C180EC0@magilla.sf.frob.com> <42EDDB82.1040900@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EDDB82.1040900@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Hi,
> 
> Not sure if this should be fixed for 2.6.13. It can result in 
> pagecache corruption: so I guess that answers my own question.
> 
> This was tested by Robin and appears to solve the problem. Roland had 
> a quick look and thought the basic idea was sound. I'd like to get a 
> couple more acks before going forward, and in particular Robin was 
> contemplating possible efficiency improvements (although efficiency 
> can wait on correctness).
> 
> Feedback please, anyone.

it looks good to me, but wouldnt it be simpler (in terms of patch and 
architecture impact) to always retry the follow_page() in 
get_user_pages(), in case of a minor fault? The sequence of minor faults 
must always be finite so it's a safe solution, and should solve the race 
too. The extra overhead of an additional follow_page() is small.

Especially with 2.6.13 being close this looks like the safest bet, any 
improvement to this (i.e. your patch) can then be done in 2.6.14.

	Ingo


When get_user_pages for write access races with another process in the page
fault handler that has established the pte for read access, handle_mm_fault
in get_user_pages will return VM_FAULT_MINOR even if it hasn't made the page
correctly writeable (for example, broken COW).

Thus the assumption that get_user_pages has a writeable page at the mapping
after handle_mm_fault returns is incorrect. Fix this by retrying the lookup
and fault in get_user_pages before making the assumption that we have a
writeable page.

Great work by Robin Holt <holt@sgi.com> to debug the problem.

Originally-from: Nick Piggin <npiggin@suse.de>

simplified the patch into a two-liner:

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 mm/memory.c |    7 +++++++
 1 files changed, 7 insertions(+)

Index: linux-sched-curr/mm/memory.c
===================================================================
--- linux-sched-curr.orig/mm/memory.c
+++ linux-sched-curr/mm/memory.c
@@ -961,6 +961,13 @@ int get_user_pages(struct task_struct *t
 				switch (handle_mm_fault(mm,vma,start,write)) {
 				case VM_FAULT_MINOR:
 					tsk->min_flt++;
+					/*
+					 * We might have raced with a readonly
+					 * pagefault, retry to make sure we
+					 * got write access:
+					 */
+					if (write)
+						continue;
 					break;
 				case VM_FAULT_MAJOR:
 					tsk->maj_flt++;

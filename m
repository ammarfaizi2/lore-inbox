Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262564AbVHDOPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbVHDOPV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 10:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbVHDOPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 10:15:16 -0400
Received: from mailfe09.swip.net ([212.247.155.1]:9119 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262564AbVHDOPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 10:15:07 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Date: Thu, 4 Aug 2005 16:14:57 +0200
From: Alexander Nyberg <alexn@telia.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Robin Holt <holt@sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
       Andi Kleen <ak@suse.de>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
Message-ID: <20050804141457.GA1178@localhost.localdomain>
References: <Pine.LNX.4.58.0508020829010.3341@g5.osdl.org> <Pine.LNX.4.61.0508021645050.4921@goblin.wat.veritas.com> <Pine.LNX.4.58.0508020911480.3341@g5.osdl.org> <Pine.LNX.4.61.0508021809530.5659@goblin.wat.veritas.com> <Pine.LNX.4.58.0508021127120.3341@g5.osdl.org> <Pine.LNX.4.61.0508022001420.6744@goblin.wat.veritas.com> <Pine.LNX.4.58.0508021244250.3341@g5.osdl.org> <Pine.LNX.4.61.0508022150530.10815@goblin.wat.veritas.com> <42F09B41.3050409@yahoo.com.au> <Pine.LNX.4.58.0508030902380.3341@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508030902380.3341@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2005 at 09:12:37AM -0700 Linus Torvalds wrote:

> 
> 
> On Wed, 3 Aug 2005, Nick Piggin wrote:
> > 
> > Oh, it gets rid of the -1 for VM_FAULT_OOM. Doesn't seem like there
> > is a good reason for it, but might that break out of tree drivers?
> 
> Ok, I applied this because it was reasonably pretty and I liked the 
> approach. It seems buggy, though, since it was using "switch ()" to test 
> the bits (wrongly, afaik), and I'm going to apply the appended on top of 
> it. Holler quickly if you disagreee..
> 

x86_64 had hardcoded the VM_ numbers so it broke down when the numbers
were changed.

Signed-off-by: Alexander Nyberg <alexn@telia.com>

Index: linux-2.6/arch/x86_64/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/x86_64/mm/fault.c	2005-07-31 18:10:20.000000000 +0200
+++ linux-2.6/arch/x86_64/mm/fault.c	2005-08-04 16:04:59.000000000 +0200
@@ -439,13 +439,13 @@
 	 * the fault.
 	 */
 	switch (handle_mm_fault(mm, vma, address, write)) {
-	case 1:
+	case VM_FAULT_MINOR:
 		tsk->min_flt++;
 		break;
-	case 2:
+	case VM_FAULT_MAJOR:
 		tsk->maj_flt++;
 		break;
-	case 0:
+	case VM_FAULT_SIGBUS:
 		goto do_sigbus;
 	default:
 		goto out_of_memory;

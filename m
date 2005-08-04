Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVHDPfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVHDPfh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 11:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbVHDPdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 11:33:38 -0400
Received: from silver.veritas.com ([143.127.12.111]:31492 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S261646AbVHDPdX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 11:33:23 -0400
Date: Thu, 4 Aug 2005 16:35:06 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Alexander Nyberg <alexn@telia.com>, Linus Torvalds <torvalds@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Russell King <rmk@arm.linux.org.uk>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Robin Holt <holt@sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
       Andi Kleen <ak@suse.de>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
In-Reply-To: <20050804150053.GA1346@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0508041618020.4668@goblin.wat.veritas.com>
References: <Pine.LNX.4.58.0508020911480.3341@g5.osdl.org>
 <Pine.LNX.4.61.0508021809530.5659@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0508021127120.3341@g5.osdl.org>
 <Pine.LNX.4.61.0508022001420.6744@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0508021244250.3341@g5.osdl.org>
 <Pine.LNX.4.61.0508022150530.10815@goblin.wat.veritas.com>
 <42F09B41.3050409@yahoo.com.au> <Pine.LNX.4.58.0508030902380.3341@g5.osdl.org>
 <20050804141457.GA1178@localhost.localdomain> <42F2266F.30008@yahoo.com.au>
 <20050804150053.GA1346@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 04 Aug 2005 15:33:20.0206 (UTC) FILETIME=[D7AC0EE0:01C59909]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2005, Alexander Nyberg wrote:
> 
> Hardcoding is evil so it's good it gets cleaned up anyway.
> 
> > parisc, cris, m68k, frv, sh64, arm26 are also broken.
> > Would you mind resending a patch that fixes them all?
> 
> Remove the hardcoding in return value checking of handle_mm_fault()

Your patch looks right to me, and bless you for catching this.
But it does get into changing lots of arches, which we were
trying to avoid at this moment.  Well, that's up to Linus.

And it does miss arm, the only arch which actually needs changing
right now, if we simply restore the original values which Nick shifted
- although arm references the VM_FAULT_ codes in some places, it also
uses "> 0".  arm26 looks at first as if it needs changing too, but
a closer look shows it's remapping the faults and is okay - agreed?

I suggest for now the patch below, which does need to be applied
for the arm case, and makes applying your good cleanup less urgent.


Restore VM_FAULT_SIGBUS, VM_FAULT_MINOR and VM_FAULT_MAJOR to their
original values, so that arches which have them hardcoded will still
work before they're cleaned up.  And correct arm to use the VM_FAULT_
codes throughout, not assuming MINOR and MAJOR are the only ones > 0.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.13-rc5-git2/arch/arm/mm/fault.c	2005-08-02 12:06:28.000000000 +0100
+++ linux/arch/arm/mm/fault.c	2005-08-04 16:06:57.000000000 +0100
@@ -240,8 +240,11 @@ do_page_fault(unsigned long addr, unsign
 	/*
 	 * Handle the "normal" case first
 	 */
-	if (fault > 0)
+	switch (fault) {
+	case VM_FAULT_MINOR:
+	case VM_FAULT_MAJOR:
 		return 0;
+	}
 
 	/*
 	 * If we are in kernel mode at this point, we
@@ -261,7 +264,7 @@ do_page_fault(unsigned long addr, unsign
 		do_exit(SIGKILL);
 		return 0;
 
-	case 0:
+	case VM_FAULT_SIGBUS:
 		/*
 		 * We had some memory, but were unable to
 		 * successfully fix up this page fault.
--- 2.6.13-rc5-git2/include/linux/mm.h	2005-08-04 15:20:20.000000000 +0100
+++ linux/include/linux/mm.h	2005-08-04 15:52:34.000000000 +0100
@@ -625,10 +625,10 @@ static inline int page_mapped(struct pag
  * Used to decide whether a process gets delivered SIGBUS or
  * just gets major/minor fault counters bumped up.
  */
-#define VM_FAULT_OOM	0x00
-#define VM_FAULT_SIGBUS	0x01
-#define VM_FAULT_MINOR	0x02
-#define VM_FAULT_MAJOR	0x03
+#define VM_FAULT_SIGBUS	0x00
+#define VM_FAULT_MINOR	0x01
+#define VM_FAULT_MAJOR	0x02
+#define VM_FAULT_OOM	0x03
 
 /* 
  * Special case for get_user_pages.

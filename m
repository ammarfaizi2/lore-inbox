Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262472AbVCVFuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbVCVFuE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 00:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbVCVFqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 00:46:22 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:32550 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262505AbVCVFnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 00:43:45 -0500
Date: Tue, 22 Mar 2005 05:42:56 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "David S. Miller" <davem@davemloft.net>
cc: "Luck, Tony" <tony.luck@intel.com>, akpm@osdl.org, nickpiggin@yahoo.com.au,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
In-Reply-To: <20050321150205.4af39064.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0503220535550.5484@goblin.wat.veritas.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F03210DD4@scsmsx401.amr.corp.intel.com> 
    <20050321150205.4af39064.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many thanks for the testing.

On Mon, 21 Mar 2005, David S. Miller wrote:
> 
> This adjustment of addr relative to floor is very
> strange, it can advance "addr" (and thus "start")
> past the end of the VMA we are unmapping.

Not strange, it's just trying to skip a pointless iteration.

> In fact, it is miraculious that this free_pud_range()
> calling loop terminates properly!  Actually, it is
> no mystery, since the next PGD address is the same
> for both the original and adjusted value of "addr".
> So the loop terminates after the first iteration.

Miraculous indeed, I hadn't realized those do {} while () loops
were as robust as that.  But it's certainly wrong to have been
calling them once in this case, even if they did recover.

> Anyways, there's the full analysis, what do you make
> of this Hugh? :-)

Much better than I deserve.  Silly me.  This patch should fix it.

[PATCH 6/5] freepgt: fix addr,end check

Fix placing of free_p?d_range's check for addr against end.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- freepgt5/mm/memory.c	2005-03-22 04:28:40.000000000 +0000
+++ freepgt6/mm/memory.c	2005-03-22 05:11:05.000000000 +0000
@@ -127,11 +127,6 @@ static inline void free_pmd_range(struct
 	unsigned long next;
 	unsigned long start;
 
-	if (end - 1 > ceiling - 1)
-		end -= PMD_SIZE;
-	if (addr > end - 1)
-		return;
-
 	start = addr;
 	pmd = pmd_offset(pud, addr);
 	do {
@@ -202,7 +197,9 @@ void free_pgd_range(struct mmu_gather **
 			return;
 	}
 	ceiling &= PMD_MASK;
-	if (addr > ceiling - 1)
+	if (end - 1 > ceiling - 1)
+		end -= PMD_SIZE;
+	if (addr > end - 1)
 		return;
 
 	start = addr;

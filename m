Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbUEBIWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbUEBIWl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 04:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbUEBIWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 04:22:41 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:16906 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262388AbUEBIWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 04:22:36 -0400
Date: Sun, 2 May 2004 09:22:29 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Konstantin Kletschke <konsti@ku-gbr.de>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at include/linux/list.h:164!
In-Reply-To: <20040501150308.GB8709@ku-gbr.de>
Message-ID: <Pine.LNX.4.44.0405020856040.14500-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 May 2004, Konstantin Kletschke wrote:
> 
> May  1 12:03:07 kermit kernel: kernel BUG at include/linux/list.h:164!
> May  1 12:03:07 kermit kernel: invalid operand: 0000 [#1]
> May  1 12:03:07 kermit kernel: PREEMPT
> May  1 12:03:07 kermit kernel: CPU:    0
> May  1 12:03:07 kermit kernel: EIP:    0060:[exit_rmap+237/272] Not tainted VLI
> May  1 12:03:07 kermit kernel: EFLAGS: 00010283   (2.6.6-rc2-mm1)
....
> 2.6.6-rc2-mm1 with devmapper udm1 patch
> 
> Is this dump due to udma1 or not and the error is fixed now?

Probably not - I don't know this udma1 patch, but the error above
definitely occurs in my rmap area.  Could be due to slab corruption
from somewhere else, but that would be a poor assumption to make -
though neither my testing nor anyone else has seen the same (yet).

I imagine you're limited in the experiments you can do on that server,
and wouldn't want to run it with CONFIG_SLAB_DEBUG=y, which might show
up unrelated problems - interesting for us, but troublesome for you.

You're UP but PREEMPT on.  Hmm, there's a suspicious atomic_read
in exit_rmap: once upon a time I convinced myself it was good, but
it looks unsafe to me now - could cause a double free of an anonmm,
which would lead to your BUG if reallocated in between.

Not so likely for me to feel this is definitely the answer, but
likely enough to be well worth trying.  Please try patch below -
simple enough not to make your case worse anyway - thanks.

Hugh

--- 2.6.6-rc2-mm1/mm/rmap.c	2004-04-26 12:39:46.000000000 +0100
+++ linux/mm/rmap.c	2004-05-02 08:43:38.088319696 +0100
@@ -103,6 +103,7 @@ void exit_rmap(struct mm_struct *mm)
 {
 	struct anonmm *anonmm = mm->anonmm;
 	struct anonmm *anonhd = anonmm->head;
+	int anonhd_count;
 
 	mm->anonmm = NULL;
 	spin_lock(&anonhd->lock);
@@ -114,8 +115,9 @@ void exit_rmap(struct mm_struct *mm)
 		if (atomic_dec_and_test(&anonhd->count))
 			BUG();
 	}
+	anonhd_count = atomic_read(&anonhd->count);
 	spin_unlock(&anonhd->lock);
-	if (atomic_read(&anonhd->count) == 1) {
+	if (anonhd_count == 1) {
 		BUG_ON(anonhd->mm);
 		BUG_ON(!list_empty(&anonhd->list));
 		kmem_cache_free(anonmm_cachep, anonhd);


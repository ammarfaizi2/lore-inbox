Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312938AbSCZEBI>; Mon, 25 Mar 2002 23:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312939AbSCZEBC>; Mon, 25 Mar 2002 23:01:02 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:35834 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S312938AbSCZEAv>; Mon, 25 Mar 2002 23:00:51 -0500
Date: Mon, 25 Mar 2002 23:00:47 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [patch] mmap bug with drivers that adjust vm_start
Message-ID: <20020325230046.A14421@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

The patch below fixes a problem whereby a vma which has its vm_start 
address changed by the file's mmap operation can result in the vma 
being inserted into the wrong location within the vma tree.  This 
results in page faults not being handled correctly leading to SEGVs, 
as well as various BUG()s hitting on exit of the mm.  The fix is to 
recalculate the insertion point when we know the address has changed.  
Comments?  Patch is against 2.4.19-pre4.

		-ben
-- 
"A man with a bass just walked in,
 and he's putting it down
 on the floor."

:r ~/patches/v2.4.19-pre4-mmap_fix.diff
--- retest.3/mm/mmap.c.org	Mon Mar 25 19:38:10 2002
+++ retest.3/mm/mmap.c	Mon Mar 25 22:40:40 2002
@@ -548,7 +548,14 @@
 	 * Answer: Yes, several device drivers can do it in their
 	 *         f_op->mmap method. -DaveM
 	 */
-	addr = vma->vm_start;
+	if (addr != vma->vm_start) {
+		/* Since addr changed, we rely on the mmap op to prevent 
+		 * collisions with existing vmas and just use find_vma_prepare 
+		 * to update the tree pointers.
+		 */
+		addr = vma->vm_start;
+		find_vma_prepare(mm, addr, &prev, &rb_link, &rb_parent);
+	}
 
 	vma_link(mm, vma, prev, rb_link, rb_parent);
 	if (correct_wcount)

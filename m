Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263918AbUDFRFo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 13:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263921AbUDFRFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 13:05:43 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:8329
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263918AbUDFRFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 13:05:30 -0400
Date: Tue, 6 Apr 2004 19:05:27 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: racing anon_vma_prepares
Message-ID: <20040406170527.GB2234@dualathlon.random>
References: <Pine.LNX.4.44.0404061730270.17300-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404061730270.17300-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 05:40:50PM +0100, Hugh Dickins wrote:
> Just noticed that you rely on mmap_sem to protect anon_vma_prepare:
> but it doesn't, since concurrent faults can both down_read(&mmap_sem).
> I think the anon_vma_alloc should be done where you have anon_vma_prepare,
> but some kind of set_anon_vma under page_table_lock to set or free it.

great spotting, I'm grateful you found such a race. It could never be
noticed with testing. it definitely needs the page_table_lock to
serialize (I was biased by the vma merging that happens with the
down_write I guess ;).  Note that in the common case anon_vma_prepare
will do nothing, so I believe this fix should be already close optimal
(I know we could save a few cycles in the unlikely case by doing
something more than just anon_vma_prepare but that would render memory.c
more complicated, so it's doable but it's a lowpriority matter and I'd
be interested in having a smallest possible fix at the moment for
pratical reasons). later on we can optimize it further.

comments?

--- x/mm/objrmap.c.~1~	2004-04-06 18:53:49.987876768 +0200
+++ x/mm/objrmap.c	2004-04-06 19:04:49.190662712 +0200
@@ -725,15 +725,31 @@ int fastcall anon_vma_prepare(struct vm_
 	anon_vma_t * anon_vma = vma->anon_vma;
 
 	might_sleep();
-	if (!anon_vma) {
+	if (unlikely(!anon_vma)) {
+		struct mm_struct * mm;
+
 		anon_vma = anon_vma_alloc();
 		if (!anon_vma)
 			return -ENOMEM;
+
+		mm = vma->vm_mm;
+		spin_lock(&mm->page_table_lock);
+		if (unlikely(vma->anon_vma))
+			goto out_unlock_free;
+
 		vma->anon_vma = anon_vma;
-		/* mmap_sem to protect against threads is enough */
+		/* page_table_lock to protect against threads is enough */
 		list_add(&vma->anon_vma_node, &anon_vma->anon_vma_head);
+
+		spin_unlock(&mm->page_table_lock);
 	}
+ out:
 	return 0;
+
+ out_unlock_free:
+	spin_unlock(&vma->vm_mm->page_table_lock);
+	anon_vma_free(anon_vma);
+	goto out;
 }
 
 void fastcall anon_vma_merge(struct vm_area_struct * vma,

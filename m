Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946476AbWJTULn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946476AbWJTULn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 16:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946475AbWJTULn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 16:11:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4822 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946457AbWJTULm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 16:11:42 -0400
Date: Fri, 20 Oct 2006 13:10:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Miller <davem@davemloft.net>
cc: nickpiggin@yahoo.com.au, ralf@linux-mips.org,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       anemo@mba.ocn.ne.jp, linux-arch@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
In-Reply-To: <20061020.125851.115909797.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0610201302090.3962@g5.osdl.org>
References: <Pine.LNX.4.64.0610200846260.3962@g5.osdl.org>
 <20061020.123635.95058911.davem@davemloft.net> <Pine.LNX.4.64.0610201251440.3962@g5.osdl.org>
 <20061020.125851.115909797.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Oct 2006, David Miller wrote:
> 
> I did some more digging, here's what I think the hardware actually
> does:

Ok, this sounds sane.

What should we do about this? How does this patch look to people?

(Totally untested, and I'm not sure we should even do that whole 
"oldmm->mm_users" test, but I'm throwing it out here for discussion, in 
case it matters for performance. The second D$ flush should obviously be 
unnecessary for the common unthreaded case, which is why none of this has 
mattered historically, I think).

Comments? We need ARM, MIPS, sparc and S390 at the very least to sign off 
on this, and somebody to write a nice explanation for the changelog (and 
preferably do this through -mm too).

		Linus

---
diff --git a/kernel/fork.c b/kernel/fork.c
index 29ebb30..14c6a1d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -287,8 +287,18 @@ static inline int dup_mmap(struct mm_str
 	}
 	retval = 0;
 out:
-	up_write(&mm->mmap_sem);
 	flush_tlb_mm(oldmm);
+	/*
+	 * If we have other threads using the old mm, we need to
+	 * flush the D$ again - the other threads might have dirtied
+	 * it more before the TLB got flushed.
+	 *
+	 * After the flush, they can no longer dirty more pages,
+	 * since they are now marked read-only, of course.
+	 */
+	if (atomic_read(&oldmm->mm_users) != 1)
+		flush_cache_mm(oldmm);
+	up_write(&mm->mmap_sem);
 	up_write(&oldmm->mmap_sem);
 	return retval;
 fail_nomem_policy:

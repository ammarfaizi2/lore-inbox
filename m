Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312480AbSCZUoC>; Tue, 26 Mar 2002 15:44:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312474AbSCZUny>; Tue, 26 Mar 2002 15:43:54 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:11820 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S312703AbSCZUnq>; Tue, 26 Mar 2002 15:43:46 -0500
Date: Tue, 26 Mar 2002 15:43:45 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] mmap bug with drivers that adjust vm_start
Message-ID: <20020326154345.B25595@redhat.com>
In-Reply-To: <20020325230046.A14421@redhat.com> <20020326174236.B13052@dualathlon.random> <20020326135703.B25375@redhat.com> <20020326201502.J13052@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2002 at 08:15:02PM +0100, Andrea Arcangeli wrote:
> > we could BUG() on getting a vma back from the new find_vma_prepare call.
> 
> yes, it sounds a good idea to verify there's no other mapping in the way
> of the relocation (until a better fix is implemented), it's a slow path
> so we won't hurt performance.

Okay, updated patch for this is below.  I also added a printk to give us 
which mmap operation was invoked to aid in debugging.

> The good reason, is that currently we're literally corrupting the
> userspace with the senseless do_munmap call in the add<->addr+len area
> before the ->mmap lowlevel callback. And such an munmap is certainly not
> required to maintain source and binary compatibility (otherwise it would
> be insane in the first place :).

Ah, right.  I disallow MAP_FIXED addresses that are not the "correct" offset, 
so this case would fail, albeit with the do_munmap occurring.  Personally, 
I would rather see an mmap fail if it would collide with an existing mapping, 
but that might break some applications.

Thanks for looking this over.  Cheers,

		-ben
-- 
"A man with a bass just walked in,
 and he's putting it down
 on the floor."

:r ~/patches/v2.4.19-pre4-mmap_fix-2.diff
--- retest.3/mm/mmap.c.org	Mon Mar 25 19:38:10 2002
+++ retest.3/mm/mmap.c	Tue Mar 26 15:01:47 2002
@@ -14,6 +14,7 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/personality.h>
+#include <linux/compiler.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -548,7 +549,19 @@
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
+		if (unlikely(NULL != find_vma_prepare(mm, addr, &prev,
+						&rb_link, &rb_parent))) {
+			printk(KERN_ERR "buggy mmap operation: [<%p>]\n",
+				file ? file->f_op->mmap : NULL);
+			BUG();
+		}
+	}
 
 	vma_link(mm, vma, prev, rb_link, rb_parent);
 	if (correct_wcount)

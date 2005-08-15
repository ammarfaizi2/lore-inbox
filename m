Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbVHOTdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbVHOTdo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 15:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbVHOTdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 15:33:44 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:52641 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S964898AbVHOTdo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 15:33:44 -0400
Date: Mon, 15 Aug 2005 21:33:07 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the difference between /dev/kmem and /dev/mem)
Message-ID: <20050815193307.GA11025@aepfle.de>
References: <1123796188.17269.127.camel@localhost.localdomain> <1123809302.17269.139.camel@localhost.localdomain> <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org> <1123951810.3187.20.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0508130955010.19049@g5.osdl.org> <1123953924.3187.22.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0508131034350.19049@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508131034350.19049@g5.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 13, 2005 at 10:37:03AM -0700, Linus Torvalds wrote:
> 
> 
> On Sat, 13 Aug 2005, Arjan van de Ven wrote:
> > 
> > attached is the same patch but now with Steven's change made as well
> 
> Actually, the more I looked at that mmap_kmem() function, the less I liked 
> it.  Let's get that sucker fixed better first. It's still not wonderful, 
> but at least now it tries to verify the whole _range_ of the mapping.
> 
> Steven, does this "alternate mmap_kmem fix" patch work for you?
> 
> 		Linus
> ----
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -261,7 +261,11 @@ static int mmap_mem(struct file * file, 
>  
>  static int mmap_kmem(struct file * file, struct vm_area_struct * vma)
>  {
> -        unsigned long long val;
> +	unsigned long pfn, size;
> +
> +	/* Turn a kernel-virtual address into a physical page frame */
> +	pfn = __pa((u64)vma->vm_pgoff << PAGE_SHIFT) >> PAGE_SHIFT;
> +

ARCH=um doesnt like your version, but mine.

drivers/char/mem.c:267: error: invalid operands to binary <<

        pfn = (__pa((u64)vma->vm_pgoff) << PAGE_SHIFT) >> PAGE_SHIFT;


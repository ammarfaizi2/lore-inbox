Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262915AbVHEJFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262915AbVHEJFJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 05:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262916AbVHEJFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 05:05:09 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:60118 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S262915AbVHEJFH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 05:05:07 -0400
Date: Fri, 5 Aug 2005 11:05:06 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix VmSize and VmData after mremap
Message-ID: <20050805090506.GA26175@janus>
References: <Pine.LNX.4.61.0508041902310.6282@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508041902310.6282@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 07:05:30PM +0100, Hugh Dickins wrote:
> mremap's move_vma is applying __vm_stat_account to the old vma which may
> have already been freed: move it to just before the do_munmap.
> 
> mremapping to and fro with CONFIG_DEBUG_SLAB=y showed /proc/<pid>/status
> VmSize and VmData wrapping just like in kernel bugzilla #4842, and fixed
> by this patch - worth including in 2.6.13, though not yet confirmed that
> it fixes that specific report from Frank van Maarseveen.

The patch works, thanks.

> 
> Signed-off-by: Hugh Dickins <hugh@veritas.com>
> 
> --- 2.6.13-rc5-git2/mm/mremap.c	2005-06-17 20:48:29.000000000 +0100
> +++ linux/mm/mremap.c	2005-08-03 16:22:33.000000000 +0100
> @@ -229,6 +229,7 @@ static unsigned long move_vma(struct vm_
>  	 * since do_munmap() will decrement it by old_len == new_len
>  	 */
>  	mm->total_vm += new_len >> PAGE_SHIFT;
> +	__vm_stat_account(mm, vma->vm_flags, vma->vm_file, new_len>>PAGE_SHIFT);
>  
>  	if (do_munmap(mm, old_addr, old_len) < 0) {
>  		/* OOM: unable to split vma, just get accounts right */
> @@ -243,7 +244,6 @@ static unsigned long move_vma(struct vm_
>  			vma->vm_next->vm_flags |= VM_ACCOUNT;
>  	}
>  
> -	__vm_stat_account(mm, vma->vm_flags, vma->vm_file, new_len>>PAGE_SHIFT);
>  	if (vm_flags & VM_LOCKED) {
>  		mm->locked_vm += new_len >> PAGE_SHIFT;
>  		if (new_len > old_len)

-- 
Frank

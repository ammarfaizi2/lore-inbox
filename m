Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWJKNOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWJKNOS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 09:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161049AbWJKNOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 09:14:17 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:61967 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751276AbWJKNOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 09:14:16 -0400
Subject: Re: Removing MAX_ARG_PAGES (request for comments/assistance)
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Ollie Wild <aaw@google.com>
Cc: linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org,
       Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       linux-mm@kvack.org, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@muc.de>, linux-arch@vger.kernel.org,
       David Howells <dhowells@redhat.com>
In-Reply-To: <65dd6fd50610101705t3db93a72sc0847cd120aa05d3@mail.gmail.com>
References: <65dd6fd50610101705t3db93a72sc0847cd120aa05d3@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 11 Oct 2006 15:14:20 +0200
Message-Id: <1160572460.2006.79.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 17:05 -0700, Ollie Wild wrote:

> +                       vma->vm_flags &= ~VM_EXEC;
> +               // FIXME: Are the next two lines sufficient, or do I need to
> +               // do some additional magic?
> +               vma->vm_flags |= mm->def_flags;
> +               vma->vm_page_prot = protection_map[vma->vm_flags & 0x7];

Yeah, you'll need to change the PTEs for those pages you created by
calling get_user_page() by calling an mprotect like function; perhaps
something like:

 struct vm_area_struct *prev;
 unsigned long vm_flags = vma->vm_flags;

 s/vma->vm_flags/vm_flags/g

 err = mprotect_fixup(vma, &prev, vma->vm_start, vma->vm_end, vm_flags);
 BUG_ON(prev != vma);

mprotect_fixup will then set the new protection on all PTEs and update
vma->vm_flags and vma->vm_page_prot.

> +               /* Move stack pages down in memory. */
> +               if (stack_shift) {
> +                       // FIXME: Verify the shift is OK.
> +

What exactly are you wondering about? the call to move_vma looks sane to
me

> +                       /* This should be safe even with overlap because we
> +                        * are shifting down. */
> +                       ret = move_vma(vma, vma->vm_start,
> +                                       vma->vm_end - vma->vm_start,
> +                                       vma->vm_end - vma->vm_start,
> +                                       vma->vm_start - stack_shift);
> +                       if (ret & ~PAGE_MASK) {
> +                               up_write(&mm->mmap_sem);
> +                               return ret;
> +                       }
>                 }



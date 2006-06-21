Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWFUSlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWFUSlz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 14:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWFUSlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 14:41:55 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:41453 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932303AbWFUSly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 14:41:54 -0400
Date: Wed, 21 Jun 2006 13:41:29 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Sonny Rao <sonny@burdell.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, anton@samba.org
Subject: Re: Possible bug in do_execve()
Message-ID: <20060621184129.GB16576@sergelap.austin.ibm.com>
References: <20060620022506.GA3673@kevlar.burdell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060620022506.GA3673@kevlar.burdell.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sonny Rao (sonny@burdell.org):
> While doing some stress testing with a reduced number of MMU contexts,
> I found that an error path in exec seemed to call destroy_context()
> via mmdrop() immediately after init_new_context() failed.
> 
> specifically I got some warning from the idr code through powerpc
> mmu_context code:
> 
> idr_remove called for id=0 which is not allocated.
> Call Trace:
> [C0000003C9E73820] [C00000000000E760] .show_stack+0x74/0x1b4 (unreliable)
> [C0000003C9E738D0] [C000000000212F30] .idr_remove+0x1c4/0x274
> [C0000003C9E73990] [C00000000002CA14] .destroy_context+0x2c/0x60
> [C0000003C9E73A20] [C00000000004CDAC] .__mmdrop+0x50/0x80
> [C0000003C9E73AB0] [C0000000000C9E38] .do_execve+0x218/0x290
> [C0000003C9E73B60] [C00000000000F28C] .sys_execve+0x74/0xf8
> [C0000003C9E73C00] [C00000000000871C] syscall_exit+0x0/0x40
> --- Exception: c01 at .execve+0x8/0x14
>     LR = .____call_usermodehelper+0xdc/0xf4
> [C0000003C9E73EF0] [C000000000065388] .____call_usermodehelper+0xb0/0xf4 (unreliable)
> [C0000003C9E73F90] [C000000000023928] .kernel_thread+0x4c/0x68
> 
> 
> Here's the code in do_execve():
> 
>         retval = init_new_context(current, bprm->mm);
>         if (retval < 0)
>                 goto out_mm
> 
> <snip>
> 
> out_mm:
>         if (bprm->mm)
>                 mmdrop(bprm->mm);
> 
> mmdrop() then calls destroy_context().
> There's a similar path in compat_do_execve().
> 
> 
> Anton pointed out a comment in fork.c, which seems to inidcate
> incorrect behavior in the exec code. 
> 
> >From dup_mm() in fork.c:
> 
>       if (init_new_context(tsk, mm))
>                 goto fail_nocontext;
> 
> <snip>
> 
> fail_nocontext:
>         /*                                                              
>          * If init_new_context() failed, we cannot use mmput() to free the mm
>          * because it calls destroy_context()
>          */
>         mm_free_pgd(mm);
>         free_mm(mm);
>         return NULL;
> 
> 
> 
> Is the behavior in do_execve() correct?

Well, I assume the intent is for out_mm: to clean up from mm_alloc(),
not from 'init_new_context'.  So I think that code is correct.
This bug appears to be powerpc-specific, so would the following patch
be reasonable?

Note it is entirely untested, just to show where i think this should
be solved.  But I could try compile+boot test tonight.

thanks,
-serge

From: Serge E. Hallyn <hallyn@sergelap.(none)>
Date: Wed, 21 Jun 2006 13:37:27 -0500
Subject: [PATCH] powerpc: check for proper mm->context before destroying

arch/powerpc/mm/mmu_context_64.c:destroy_context() can be called
from __mmput() in do_execve() if init_new_context() failed.  This
can result in idr_remove() being called for an invalid context.

So, don't call idr_remove if there is no context.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 arch/powerpc/mm/mmu_context_64.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

ee74da9d3c122b92541dd6b7670731bd4a033f04
diff --git a/arch/powerpc/mm/mmu_context_64.c b/arch/powerpc/mm/mmu_context_64.c
index 714a84d..552d590 100644
--- a/arch/powerpc/mm/mmu_context_64.c
+++ b/arch/powerpc/mm/mmu_context_64.c
@@ -55,6 +55,9 @@ again:
 
 void destroy_context(struct mm_struct *mm)
 {
+	if (mm->context.id == NO_CONTEXT)
+		return;
+
 	spin_lock(&mmu_context_lock);
 	idr_remove(&mmu_context_idr, mm->context.id);
 	spin_unlock(&mmu_context_lock);
-- 
1.3.3


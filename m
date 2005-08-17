Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbVHQOXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbVHQOXt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 10:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbVHQOXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 10:23:49 -0400
Received: from dns.suna-asobi.com ([210.151.31.146]:20616 "EHLO
	dns.suna-asobi.com") by vger.kernel.org with ESMTP id S1751139AbVHQOXt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 10:23:49 -0400
Date: Wed, 17 Aug 2005 23:30:13 +0900
From: Akira Tsukamoto <akira-t@suna-asobi.com>
To: arjan@infradead.org, linux-kernel@vger.kernel.org,
       Hirokazu Takahashi <taka@valinux.co.jp>
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
In-Reply-To: <98df96d305081622107ca969f@mail.gmail.com>
References: <20050817.110503.97359275.taka@valinux.co.jp> <98df96d305081622107ca969f@mail.gmail.com>
Message-Id: <20050817233001.6E7C.AKIRA-T@suna-asobi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2005 14:10:34 +0900
Hiro Yoshioka <lkml.hyoshiok@gmail.com> mentioned:
> On 8/17/05, Akira Tsukamoto <akira-t@s9.dion.ne.jp> wrote:
> > Anyway, going back to copy_user topic,
> > big remaining issues are
> >   1)store/restore floating point register (80/64bytes) twice every time by
> >      surrounding with kernel_fpu_begin()/kernel_fpu_end() is big penalty
> 
> I don't know. If nobody uses MMX/XMM, then there is no need
> to save and restore.

I think you are misunderstanding between
 1)lazy fpu save handling for user space task
 2)kernel_fpu_begin()/kernel_fpu_end() inside the kernel

> >   2)after pagefault not always come back to copy function and corrupts fp register
> 
> I'm trying to understand this mechanism but I don't
> understand very well.

My explanation was a bit ambiguous, see the code below. 
Where the fp register saved? It saves fp register *inside* task_struct,

static inline void kernel_fpu_begin(void)
+	if (tsk->flags & PF_USEDFPU) {
+		asm volatile("rex64 ; fxsave %0 ; fnclex"
+			       : "=m" (tsk->thread.i387.fxsave));

static inline void save_init_fpu( struct task_struct *tsk )
+	if ( cpu_has_fxsr ) {
+		asm volatile( "fxrstor %0"
+			      : : "m" (tsk->thread.i387.fxsave) );

What happens, during your copy function, if memory is not allocated and 
generates pagefualt and goto reclaim memories and go into task switch
and change to other task.

-- 
Akira Tsukamoto



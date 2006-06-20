Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964916AbWFTCZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbWFTCZJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 22:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbWFTCZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 22:25:09 -0400
Received: from kevlar.burdell.org ([66.92.73.214]:33705 "EHLO
	kevlar.burdell.org") by vger.kernel.org with ESMTP id S964916AbWFTCZH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 22:25:07 -0400
Date: Mon, 19 Jun 2006 22:25:06 -0400
From: Sonny Rao <sonny@burdell.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: anton@samba.org
Subject: Possible bug in do_execve() 
Message-ID: <20060620022506.GA3673@kevlar.burdell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While doing some stress testing with a reduced number of MMU contexts,
I found that an error path in exec seemed to call destroy_context()
via mmdrop() immediately after init_new_context() failed.

specifically I got some warning from the idr code through powerpc
mmu_context code:

idr_remove called for id=0 which is not allocated.
Call Trace:
[C0000003C9E73820] [C00000000000E760] .show_stack+0x74/0x1b4 (unreliable)
[C0000003C9E738D0] [C000000000212F30] .idr_remove+0x1c4/0x274
[C0000003C9E73990] [C00000000002CA14] .destroy_context+0x2c/0x60
[C0000003C9E73A20] [C00000000004CDAC] .__mmdrop+0x50/0x80
[C0000003C9E73AB0] [C0000000000C9E38] .do_execve+0x218/0x290
[C0000003C9E73B60] [C00000000000F28C] .sys_execve+0x74/0xf8
[C0000003C9E73C00] [C00000000000871C] syscall_exit+0x0/0x40
--- Exception: c01 at .execve+0x8/0x14
    LR = .____call_usermodehelper+0xdc/0xf4
[C0000003C9E73EF0] [C000000000065388] .____call_usermodehelper+0xb0/0xf4 (unreliable)
[C0000003C9E73F90] [C000000000023928] .kernel_thread+0x4c/0x68


Here's the code in do_execve():

        retval = init_new_context(current, bprm->mm);
        if (retval < 0)
                goto out_mm

<snip>

out_mm:
        if (bprm->mm)
                mmdrop(bprm->mm);

mmdrop() then calls destroy_context().
There's a similar path in compat_do_execve().


Anton pointed out a comment in fork.c, which seems to inidcate
incorrect behavior in the exec code. 

>From dup_mm() in fork.c:

      if (init_new_context(tsk, mm))
                goto fail_nocontext;

<snip>

fail_nocontext:
        /*                                                              
         * If init_new_context() failed, we cannot use mmput() to free the mm
         * because it calls destroy_context()
         */
        mm_free_pgd(mm);
        free_mm(mm);
        return NULL;



Is the behavior in do_execve() correct?

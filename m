Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbTEVH0N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 03:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbTEVH0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 03:26:12 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.28]:12328 "EHLO
	mwinf0303.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262139AbTEVH0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 03:26:11 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: Use of sti in entry.S question
Date: Thu, 22 May 2003 09:39:13 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305220939.13619.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5/arch/i386/kernel/entry.S:

In work_resched, schedule may be called with
interrupts off:

work_resched:
        call schedule
        cli                             # make sure we don't miss an interrupt
                                        # setting need_resched or sigpending
                                        # between sampling and the iret
        movl TI_FLAGS(%ebp), %ecx
        andl $_TIF_WORK_MASK, %ecx      # is there any work to be done other
                                        # than syscall tracing?
        jz restore_all
        testb $_TIF_NEED_RESCHED, %cl
        jnz work_resched <====== schedule with interrupts disabled

Is this a mistake or an optimization?  Elsewhere in entry.S, interrupts
are turned on before calling schedule:

#ifdef CONFIG_PREEMPT
ENTRY(resume_kernel)
        cmpl $0,TI_PRE_COUNT(%ebp)      # non-zero preempt_count ?
        jnz restore_all
need_resched:
        movl TI_FLAGS(%ebp), %ecx       # need_resched set ?
        testb $_TIF_NEED_RESCHED, %cl
        jz restore_all
        testl $IF_MASK,EFLAGS(%esp)     # interrupts off (exception path) ?
        jz restore_all
        movl $PREEMPT_ACTIVE,TI_PRE_COUNT(%ebp)
        sti <====== schedule with interrupts enabled
        call schedule
        movl $0,TI_PRE_COUNT(%ebp)
        cli
        jmp need_resched
#endif

Thanks,

Duncan.

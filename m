Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263328AbTEVVyM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 17:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263339AbTEVVyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 17:54:09 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.26]:12903 "EHLO
	mwinf0502.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263328AbTEVVwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 17:52:11 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: Another use of sti in entry.S question
Date: Fri, 23 May 2003 00:05:14 +0200
User-Agent: KMail/1.5.1
References: <200305220939.13619.baldrick@wanadoo.fr>
In-Reply-To: <200305220939.13619.baldrick@wanadoo.fr>
Cc: Andi Kleen <ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305230005.14394.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is another place where interrupts get turned on in a called
function:

work_resched disables interrupts and falls through to work_notifysig.
work_notifysig calls do_notify_resume.
do_notify_resume calls do_signal.
do_signal calls get_signal_to_deliver.
get_signal_to_deliver does an spin_unlock_irq before returning,
enabling interrupts.

Is this a bug?

work_resched:
        sti
        call schedule
        cli                             # make sure we don't miss an interrupt
                                        # setting need_resched or sigpending
                                        # between sampling and the iret
        movl TI_FLAGS(%ebp), %ecx
        andl $_TIF_WORK_MASK, %ecx      # is there any work to be done other
                                        # than syscall tracing?
        jz restore_all
        testb $_TIF_NEED_RESCHED, %cl
        jnz work_resched

work_notifysig:                         # deal with pending signals and
                                        # notify-resume requests
        testl $VM_MASK, EFLAGS(%esp)
        movl %esp, %eax
        jne work_notifysig_v86          # returning to kernel-space or
                                        # vm86-space
        xorl %edx, %edx
        call do_notify_resume <== may enable interrupts
        jmp restore_all

        ALIGN
work_notifysig_v86:
        pushl %ecx
        call save_v86_state
        popl %ecx
        movl %eax, %esp
        xorl %edx, %edx
        call do_notify_resume <== may enable interrupts
        jmp restore_all

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbTFOSWQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 14:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbTFOSWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 14:22:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9229 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262524AbTFOSWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 14:22:14 -0400
Date: Sun, 15 Jun 2003 19:36:04 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: force_successful_syscall_return() buggy?
Message-ID: <20030615193604.L5417@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While looking at the new bits'n'pieces which has appeared in 2.5.71, I
noticed the following in alpha and ia64:

#define alpha_task_regs(task) \
  ((struct pt_regs *) ((long) (task)->thread_info + 2*PAGE_SIZE) - 1)

#define force_successful_syscall_return() (alpha_task_regs(current)->r0 = 0)


# define ia64_task_regs(t)              (((struct pt_regs *) ((char *) (t) + IA64_STK_OFFSET)) - 1)

#define force_successful_syscall_return()               \
        do {                                            \
                ia64_task_regs(current)->r8 = 0;        \
        } while (0)

I don't know what happens on these architectures, but I have a suspicion
that there is a case which the above will fail, maybe with dramatic
consequences.

Consider what happens when a userspace program is started from kernel
space, eg the init(8) or hotplug programs.  In these, we call execve()
from within kernel space function.  This implies that we have some
frames already on the stack.

AFAIK, sys_execve() does not ensure that the kernel stack will be empty
before starting the user space thread, so these programs are running with
a slightly reduced kernel stack.

In turn, this means that the user registers are not stored at the top
of the kernel stack when the user space program subsequently calls a
kernel system call, which means the *_task_regs() macro doesn't point
at the saved user registers.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


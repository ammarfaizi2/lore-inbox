Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263239AbTFPCTN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 22:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263245AbTFPCTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 22:19:13 -0400
Received: from dp.samba.org ([66.70.73.150]:49122 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263239AbTFPCTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 22:19:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16109.11192.531655.562208@cargo.ozlabs.ibm.com>
Date: Mon, 16 Jun 2003 12:30:16 +1000
From: Paul Mackerras <paulus@samba.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: force_successful_syscall_return() buggy?
In-Reply-To: <20030615193604.L5417@flint.arm.linux.org.uk>
References: <20030615193604.L5417@flint.arm.linux.org.uk>
X-Mailer: VM 7.16 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King writes:

> #define force_successful_syscall_return()               \
>         do {                                            \
>                 ia64_task_regs(current)->r8 = 0;        \
>         } while (0)
> 
> I don't know what happens on these architectures, but I have a suspicion
> that there is a case which the above will fail, maybe with dramatic
> consequences.

On PPC, I am going to use a bit in the thread_info flags field to
indicate that the current syscall should not return an error.  The
syscall entry and exit paths already look at the thread_info flags
(testing the syscall trace bit, among others) so it's convenient to
have the "no error" flag there too.  The flag bit gets cleared on
syscall entry, set by force_successful_syscall_return() and tested on
syscall exit.  The only restriction is that kernel code should not do
a system call between where it calls force_successful_syscall_return
and where it returns from the syscall.  But I don't believe we ever do
recursive system calls anyway, so that should be fine.

Regards,
Paul.

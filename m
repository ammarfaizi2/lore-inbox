Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbTFPRmB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 13:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264043AbTFPRmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 13:42:01 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10513 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263281AbTFPRl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 13:41:58 -0400
Date: Mon, 16 Jun 2003 18:55:49 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: davidm@hpl.hp.com
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: force_successful_syscall_return() buggy?
Message-ID: <20030616185549.E13312@flint.arm.linux.org.uk>
Mail-Followup-To: davidm@hpl.hp.com,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030615193604.L5417@flint.arm.linux.org.uk> <16110.147.422432.486761@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16110.147.422432.486761@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Mon, Jun 16, 2003 at 10:38:27AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 16, 2003 at 10:38:27AM -0700, David Mosberger wrote:
> >>>>> On Sun, 15 Jun 2003 19:36:04 +0100, Russell King <rmk@arm.linux.org.uk> said:
> 
>   Russell> Consider what happens when a userspace program is started
>   Russell> from kernel space, eg the init(8) or hotplug programs.  In
>   Russell> these, we call execve() from within kernel space function.
>   Russell> This implies that we have some frames already on the stack.
> 
>   Russell> AFAIK, sys_execve() does not ensure that the kernel stack
>   Russell> will be empty before starting the user space thread, so
>   Russell> these programs are running with a slightly reduced kernel
>   Russell> stack.
> 
>   Russell> In turn, this means that the user registers are not stored
>   Russell> at the top of the kernel stack when the user space program
>   Russell> subsequently calls a kernel system call, which means the
>   Russell> *_task_regs() macro doesn't point at the saved user
>   Russell> registers.
> 
> That's a limitation that was described in the change log entry:
> 
> 	The only limitation of force_successful_syscall_return() is
> 	that it doesn't help with system calls performed by the
> 	kernel.  But the kernel does that so rarely and for such a
> 	limited set of syscalls that this is not a real problem.

I'm not actually talking about subsequent syscalls issued by the kernel.
I'm talking about stuff like init, bash, and the module tools.  If
any of these call any of the affected syscalls which expect user
registers to be at the top of the kernel stack, they'll be accessing
the wrong data.  A corrected comment would be:

 	The only limitation of force_successful_syscall_return() is
 	that it doesn't help with system calls performed by the
 	kernel or user threads exec'd from the kernel.

I'd suggest such a comment is added to force_successful_syscall_return()
to ensure that anyone thinking it'll work for all user space processes
is sufficiently deterred.

> Alpha and ia64 have used pt_regs for "force-success" purposes for a
> long time, but if you want to add support to another platform, I'd
> also recommend using the task_info instead.

Oh, I'm currently not thinking about implementing this on ARM; this
touches a similar area which I investigated a number of months ago.
I through out the idea of accessing user registers for user space
programs at the top of the kernel stack because it does not work for
processes exec'd from kernel space.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


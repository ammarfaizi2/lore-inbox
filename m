Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313512AbSDQKnj>; Wed, 17 Apr 2002 06:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313509AbSDQKni>; Wed, 17 Apr 2002 06:43:38 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55823 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313508AbSDQKnh>; Wed, 17 Apr 2002 06:43:37 -0400
Date: Wed, 17 Apr 2002 11:43:31 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.5.8: Preempt problems
Message-ID: <20020417114331.D2386@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to debug a flood of:

error: sh[81] exited with preempt_count 1

messages on ARM with kernel 2.5.8, and its looking like a generic kernel
bug is causing it.

The point at which preempt_count gets set to '1' for each task is at the
lock_kernel() in start_kernel().  Why?

We start booting the kernel.  One of the very first things we do is call
lock_kernel(), which increments the preempt_count for PID0.  We initialise
stuff, and then clone the thread for PID1, init.

When we clone a thread, dup_task_struct() creates a new kernel stack and
thread_info structure.  The childs thread_info structure inherits from
the parent, which includes the preempt_count of 1.

We start the user space init(8) program, and run various other programs,
forking as we do.  Each time we fork(), we call dup_task_struct() which
causes each task to inherit the non-zero preempt_count.

Thus, we never reach a preempt_count of 0, and never actually preempt.

Comments?  Is there some fiddle in the x86 code somewhere that we've
missed in the ARM tree to get this to work?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


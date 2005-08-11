Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030306AbVHKNyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030306AbVHKNyp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 09:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbVHKNyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 09:54:45 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:49827 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030306AbVHKNyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 09:54:44 -0400
Subject: Re: Need help in understanding  x86  syscall
From: Steven Rostedt <rostedt@goodmis.org>
To: Ukil a <ukil_a@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050811053931.71120.qmail@web51604.mail.yahoo.com>
References: <20050811053931.71120.qmail@web51604.mail.yahoo.com>
Content-Type: text/plain; charset=iso-8859-13
Organization: Kihon Technologies
Date: Thu, 11 Aug 2005 09:54:36 -0400
Message-Id: <1123768476.17269.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-10 at 22:39 -0700, Ukil a wrote:
> I had this question. As per my understanding, in the
> Linux system call implementation on x86 architecture
> the call flows like this int 0x80 -> syscall ->
> sys_call_vector(taken from the table)-> return from
> interrupt service routine. 
> 
> Now I had the doubt that if the the syscall
> implementation is very large will the scheduling and
> other interrupts be blocked for the whole time till
> the process returns from the ISR (because in an ISR by
> default the interrupts are disabled unless ´sti¡ is
> called explicitly)? Thatÿs appears to be too long for
> the scheduling or other interrupts to be blocked? 
> Am I missing something here?

This is where interrupt is not a good term for syscall. It is really a
trap.  An interrupt is an outside source that stops the CPU from doing
what it was doing to go do something else (asynchronous event).  A trap
is something that the CPU calls on itself to do something else
(synchronous event).  So when a network packet comes in, the NIC sends
an interrupt request (request since the CPU may not immediately handle
it), and when the CPU is ready (interrupts on) it will stop what it is
doing and handle the network packet.

When you do a system call, it is a trap.  Quoting the Intel manual:

  The difference between an interrupt gate and a trap gate is as follows. If an interrupt or exception
  handler is called through an interrupt gate, the processor clears the interrupt enable (IF) flag in
  the EFLAGS register to prevent subsequent interrupts from interfering with the execution of the
  handler. When a handler is called through a trap gate, the state of the IF flag is not changed.


So when you go into the kernel through a trap (system call) interrupts
are still on if they were on to begin with, which is the case when
coming from user mode. But when you come into the kernel through a real
interrupt, then interrupts are off.

Also note that if you have preemption disabled, the system call will
_not_ do any scheduling unless it explicitly calls schedule.  If you
turn on voluntary preempt, it will call schedule at various spots in the
kernel that might call schedule anyway.  If you turn on full preemption,
then the process can be scheduled out anywhere in the kernel unless it
explicitly says it doesn't want to (preempt_disable or spin_lock).

-- Steve


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263598AbREYGyT>; Fri, 25 May 2001 02:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263596AbREYGyJ>; Fri, 25 May 2001 02:54:09 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:32841 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S263594AbREYGxz>; Fri, 25 May 2001 02:53:55 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] large stack variables (>=1K) in 2.4.4 and 2.4.4-ac8 
In-Reply-To: Your message of "Fri, 25 May 2001 00:33:56 CST."
             <200105250633.f4P6Xuj2017833@webber.adilger.int> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 25 May 2001 16:53:47 +1000
Message-ID: <24688.990773627@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2001 00:33:56 -0600 (MDT), 
Andreas Dilger <adilger@turbolinux.com> wrote:
>Keith Owens writes:
>> You cannot recover from a kernel stack overflow even with kdb.  The
>> exception handler and kdb use the stack that just overflowed.
>
>If it at least tells you that the stack has overflowed, and a backtrace
>of the stack up to that point, that would at least be useful for fixing
>the functions which caused the problem.

A small overflow of the kernel stack overwrites the struct task at the
bottom of the stack, recovery is dubious at best because we rely on
data in struct task.  A large overflow of the kernel stack either
corrupts the storage below this task's stack, which could hit anything,
or it gets a stack fault.

If we take a stack fault on ix86, stack_segment() is invoked.  Just
taking the fault and calling the routine uses the kernel stack which
has already overflowed, causing a double fault.  The double fault
handler uses the kernel stack, generating a triple fault.  The machine
is now dead.

The only way to avoid those problems is to move struct task out of the
kernel stack pages and to use a task gate for the stack fault and
double fault handlers, instead of a trap gate (all ix86 specific).
Those methods are expensive, at a minimum they require an extra page
for every process plus an extra stack per cpu.  I have not even
considered the extra cost of using task gates for the interrupts nor
how this method would complicate methods for getting the current struct
task pointer.  It is not worth the bother, we write better kernel code
than that.


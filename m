Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWFFFZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWFFFZN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 01:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWFFFZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 01:25:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:8659 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932113AbWFFFZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 01:25:11 -0400
To: Martin Bisson <bissonm@discreet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86_64 system call entry points
References: <44846210.4080602@discreet.com>
From: Andi Kleen <ak@suse.de>
Date: 06 Jun 2006 07:25:01 +0200
In-Reply-To: <44846210.4080602@discreet.com>
Message-ID: <p73zmgqzwia.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bisson <bissonm@discreet.com> writes:
 
> - sysenter/32 bits, executed on a 32 bit machine: I get a segfault on
> the sysenter instruction.  I use the following code to enter the
> system call:
> pid_t getpid32()
> {
>     pid_t resultvar;
> 
>     asm volatile (
>     "push    %%ebp\n\t"
>     "push    %%ecx\n\t"
>     "push    %%edx\n\t"
>     "mov     %%esp,%%ebp\n\t"
>     "sysenter\n\t"

You can't use your own SYSENTER. Since sysenter doesn't pass the original
address and the kernel always returns to a fixed address - which is in the vsyscall
page. The fixed address is used because there are not enough registers to pass
both syscall arguments and return address.

The instruction has a few other quirks and isn't exactly the best one Intel
ever designed.

> - int $0x80/64 bits: All system calls return -1 (EINTR).  Is there
> something wrong in the way I call it:

Hmm, it should do an 32bit syscall even from 64bit. I can take a look.

> pid_t getpid64()
> {
>     pid_t resultvar;
> 
>     asm volatile (
>     "int $0x80\n\t"
>     : "=a" (resultvar)     : "0" (__NR_getpid)
>     : "memory");
> 
>     return resultvar;
> }
> 
> 
> - sysenter/64 bits: I get an illegal instruction.  I've read that it's
> not implemented on AMD-64 (which is what I have).  Is there ANY x86_64
> machine on which this instruction is implemented?  Does this mean that
> the code that handles this case in entry.S has never been run?

Intel machines have it, but they don't have SYSCALL from compat mode. That
is why both are implemented. It should end at the code in ia32entry.S 

Again you can't use your own - so likely it is returning to the vsyscall page
and then jumping to a bogus address on the stack. You can verify that by
single stepping through it with a debugger.


> - syscall/64 bits: works fine
> - int $0x80/32 bits: works fine
> - syscall/32 bits: illegal instruction, but I guess that's all right
> because of the machine I use.

On AMD it should work. The kernel vsyscall page uses it.

-Andi

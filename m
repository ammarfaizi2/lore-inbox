Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318907AbSHEWb1>; Mon, 5 Aug 2002 18:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318912AbSHEWb0>; Mon, 5 Aug 2002 18:31:26 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:13955 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S318907AbSHEWbU>; Mon, 5 Aug 2002 18:31:20 -0400
Date: Tue, 6 Aug 2002 00:34:19 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Richard Zidlicky <rz@linux-m68k.org>
Cc: jdike@karaya.com, alan@redhat.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user mode
Message-Id: <20020806003419.3457fcb9.us15@os.inf.tu-dresden.de>
In-Reply-To: <20020805224415.A579@linux-m68k.org>
References: <200208031233.g73CXUB02612@devserv.devel.redhat.com>
	<200208031529.KAA01655@ccure.karaya.com>
	<20020805154607.7c021c56.us15@os.inf.tu-dresden.de>
	<20020805224415.A579@linux-m68k.org>
Organization: Disorganized
X-Mailer: Sylpheed version 0.7.8claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Aug 2002 22:44:15 +0200
Richard Zidlicky <rz@linux-m68k.org> wrote:

> very interesting, what is the handiest way to do "syscalls" in this model?
> Ptrace is still basically signal driven so I would expect it has still some 
> unnecessary overhead?

Task wants to do a syscall (i.e. int 0x30 in Fiasco), the kernel process tracing
the task sees the signal in its SIGCHLD handler. It pulls the registers out of the
task's address space using PTRACE_GETREGS and sets up an interrupt frame on the
kernel stack. EIP and ESP in the saved signal context are frobbed in a way that
the signal handler falls right into the correct interrupt gate when it returns.
iret works the other way round. SIGSEGV handler in the kernel process copies registers
back to task and restarts the task's process after restoring kernel state.

> > I would also very much like an extension that would allow one process to modify
> > the MM of another, possibly via an extended ptrace interface or a new syscall.
> > Also it would be nice if there was an alternate way to get at the cr2 register,
> > trap number and error code other than from a SIGSEGV handler.
> 
> that's what signals are for, too bad they are slow.

As it is now, in order to get at the page fault address one has to invoke a SIGSEGV
handler in the task, then look at the task's signal context to determine the pagefault
address, trapno etc. It would be much faster if the kernel could cancel the SIGSEGV signal
in the task's process and read out the the pagefault info from the TCB via a ptrace
extension. Saves the cost of a running a signal handler in the task and a bunch of context
switches.

> they are very expensive because of the way ptrace accesses the other process
> memory, did you try a piece of shared memory ?

Yes, trampoline page is shared between kernel and task. Nevertheless there are
context switches that wouldn't be necessary if the kernel could tweak the task's
mm directly.

-Udo.

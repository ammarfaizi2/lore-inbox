Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262099AbRETRSX>; Sun, 20 May 2001 13:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262102AbRETRSN>; Sun, 20 May 2001 13:18:13 -0400
Received: from chiara.elte.hu ([157.181.150.200]:55822 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S262099AbRETRSD>;
	Sun, 20 May 2001 13:18:03 -0400
Date: Sun, 20 May 2001 19:16:19 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Dave Airlie <airlied@skynet.ie>
Cc: <linux-vax@mithra.physics.montana.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: start_thread question...
In-Reply-To: <Pine.LNX.4.32.0105201717100.29656-100000@skynet>
Message-ID: <Pine.LNX.4.33.0105201908550.31113-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 20 May 2001, Dave Airlie wrote:

> I'm implementing start_thread for the VAX port and am wondering does
> start_thread have to return to load_elf_binary? I'm working on the
> init thread and what is happening is it is returning the whole way
> back to the execve caller .. which I know shouldn't happen.....

start_thread() doesnt do what one would intuitively think it does.

start_thread() simply prepares the new task's register set to be ready to
start user-space (which task is the current task as well, so certain
current CPU registers might have to be manually bootstrapped as well), but
start_thread() does not actually start execution of user-space code yet.

(a more correct name for start_thread() would be prepare_user_thread().)

> so I suppose what I'm looking for is the point where the user space
> code gets control... is it when the registers are set in the
> start_thread? if so how does start_thread return....

execution starts when the process returns from sys_execve(). By that time
we have already changed pagetables and other context information, dropped
basically everything from the previous context - without actually doing a
context-switch. In fact sys_execve() has an implicit context-switch,
without ever changing the kernel-stack though.

> On the VAX we have to call a return from interrupt to get to user
> space and I'm trying to figure out where this should happen...

this is how it happens on x86 too. Basically you start the new binary by
returning from an syscall that has bootstrapped all userspace context -
this approach should work on any architecture. (because every architecture
has to be able to execute user-space code after syscalls.)

	Ingo


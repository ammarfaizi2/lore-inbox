Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265390AbTFMNXq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 09:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265394AbTFMNXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 09:23:46 -0400
Received: from chaos.analogic.com ([204.178.40.224]:60804 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265390AbTFMNXf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 09:23:35 -0400
Date: Fri, 13 Jun 2003 09:39:17 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Peter Rusedski <peter_istanbul@yahoo.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: file operations in kernel module
In-Reply-To: <20030613132911.74745.qmail@web20710.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0306130936110.4248@chaos>
References: <20030613132911.74745.qmail@web20710.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jun 2003, Peter Rusedski wrote:

> Greetings!
>
> I am writing a kernel module for which I need to
> access a file from within the module. I have source of
> the same using normal open, read and close operations
> already written.
>
> My questions are
> What is the best approach to do the same in kernel
> module?
> Are there any constraints on maximum memory a module
> can use.
>
> Thanks in advance and apologies if I am at wrong
> place.
>
> Have a nice time,
>
> Peter.
>


File I/O from inside the kernel, FAQ............

As cited many times, the kernel is not a process. It is
designed to perform functions on behalf of a calling process.

Because it is not a process, it does not have a context.
A file descriptor without a context with which to associate
the file descriptor is worthless. For instance, all processes
are created with file descriptors, STDIN_FILENO, STDOUT_FILENO,
and STDERR_FILENO (0, 1, and 2), which are associated with some
I/O device. If these file-descriptor numbers were not associated
with a process context, every task would do I/O from the same
thing.

At any instant, the context of a process is represented by
the object called "current". This, currently, is a pointer to
a structure which contains the elements necessary to resume
execution of the process when the kernel call returns. It also
contains the member values which uniquely define the process and
allow the kernel to perform tasks on behalf of the calling process.

To perform file I/O within the kernel requires a process context.
You can either steal one or you can create one. Stealing a process
context has the great potential of corrupting the task from which
you stole the context. This is because I/O would be performed into
its address space and you will very well overwrite buffered data
that that process is using.

Creating a process context involves creating a kernel thread. This
thread will function properly and can perform file I/O. However,
you can never use any C runtime library functions in the kernel so
you have to perform all primitive file I/O yourself. For instance,
you call sys_open(), you can never use open() or fopen(), etc.

Here is some module-code that starts up, then runs down a kernel-
thread. This is snipped from a module that I wrote so it is
incomplete, meant only as a template.


#ifndef __KERNEL__
#define __KERNEL__
#endif

#ifndef MODULE
#define MODULE
#endif

#include <linux/module.h>
#include <linux/slab.h>
#include <linux/ioport.h>
#include <linux/poll.h>
#include <linux/sched.h>
#include <linux/init.h>
#include <asm/atomic.h>
#include <asm/delay.h>
#include <asm/io.h>
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
/*
 *  This kernel thread runs forever as long as the module is installed.
 */
static int gpib_thread(void *unused)
{
    int doit;
    unsigned long flags;
    exit_files(current);
    daemonize();
    spin_lock_irq(&current->sigmask_lock);
    sigemptyset(&current->blocked);
    recalc_sigpending(current);
    spin_unlock_irq(&current->sigmask_lock);
    memcpy(current->comm, task_name, sizeof(task_name));
    DEB(printk("gpib_thread\n"));
    for(;;)
    {
        // Kernel thread code goes here.



        if(!!signal_pending(current))
#ifdef NEW_THREAD_EXIT
            complete_and_exit(&info->quit, 0);
#else
            up_and_exit(&info->quit, 0);
#endif
    }
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
/*
 *   Initialize and register the module
 */
int __init init_module()
{
#ifdef NEW_THREAD_EXIT
    init_completion(&info->quit);
#else
    init_MUTEX_LOCKED(&info->quit);
#endif
    info->pid = kernel_thread(gpib_thread, NULL, CLONE_FS | CLONE_FILES);
}
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
/*
 *   Release the module.
 */
void cleanup_module()
{
        if(!!(result = kill_proc(info->pid, SIGTERM, 1)))
        {
            printk(A_sig, info->dev);
            return;
        }
#ifdef NEW_THREAD_EXIT
        wait_for_completion(&info->quit);
#else
        down(&info->quit);
#endif
}

Now, the only reason you would ever perform file I/O within the
kernel is as an "intellectual exercise". There is absolutely no
reason whatsoever to perform user-mode tasks within the kernel.

The way Unix/Linux is designed will always favor performing I/O
from user space. That's how it's supposed to be done with such
an Operating System. If you are actually designing something
that requires file I/O in the kernel, the design is defective.

There is only one Operating System that I know of in which there
was some performance to be gained by performing I/O from within
the kernel. That was VAX/VMS. Any such I/O was performed within
the context of the swapper process. The VAX/VMS kernel maintains
its own context. There are disadvantages, for instance every
interrupt generated a context-switch. There are advantages, the
interrupted task did not necessarily get the CPU back immediately
after an interrupt, etc.

The Unix model shares kernel code between all tasks, but the tasks
themselves get most of the CPU and are forced to give up the CPU
only when waiting for I/O or in the case of a CPU-Hog, when a
context switch is forced by a timer.

If you need to read parameters from a file, when installing
a kernel module, you simply do this in user-space at the time
your user-space process installs the module. That's what ioctl()
functions are for. Also, even if you continually need to do file
I/O, you still do it from user-mode. Your kernel module just
does the things that can't be done from user-mode code.

If you need a user-mode response to an interrupt, it's easy.
Your user-mode code sleeps in select() or poll(). The driver/module
code does whatever is necessary to handle the immediate needs
of the hardware, then executes wake_up_interruptible(). This
wakes up your task and it processes the data received in the ISR.

There is no advantage running user-mode tasks within the kernel
because you have to do the same thing anyway. There is no way
for an interrupt to attach() or callback() a task. No real-world
Operating System uses interrupt "thunks", where some user gets
the CPU directly from an interrupt. This cannot happen because,
with no context-switch in an interrupt, there is no way to
return to the interrupted task. It cannot switch to another
task. If it did (by making some kernel changes), you would never
be able to get back to the original interrupted task.

Over and over again I have users state; "I MUST do file I/O in the
kernel...". This has always been a result of an incomplete
understanding of what the kernel is and what the kernel does. Some
look at driver code and say; "It's just 'C' code. I can do this..."
Then they code a module and triple-fault the kernel.

The kernel is not a "high-performance" API where you can execute
some code with a performance advantage. The kernel is common-code
that can be executed by all tasks. That code is executed within
the context of the calling process. This makes it fast. The kernel
does file I/O through code that can't be modified by user tasks
so it follows the rules necessary to maintain file-systems. The
kernel, therefore, is a mechanism for maintaining the sanity of
a system. The actual work is done by the process itself.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270700AbTHSPDw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 11:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270765AbTHSPDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 11:03:51 -0400
Received: from chaos.analogic.com ([204.178.40.224]:54144 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S270700AbTHSO7v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 10:59:51 -0400
Date: Tue, 19 Aug 2003 11:01:55 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Simon Haynes <simon@baydel.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: File access
In-Reply-To: <20A82354434A@baydel.com>
Message-ID: <Pine.LNX.4.53.0308191033540.5978@chaos>
References: <67597854DA5@baydel.com> <1FDBD34B76B1@baydel.com>
 <Pine.LNX.4.53.0308190814420.3760@chaos> <20A82354434A@baydel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003, Simon Haynes wrote:

> Thanks I have looked at the attached file and I would really not like to
> access a file from the kernel but I cannot seem to get the user land app to
> work with writing. If you consider a kernel module which, in some event,
> needs to save some information in a file. The usr app is blocked in a read
> with interruptible_sleep_on. When the first write occurs the module calls
> wake_up_interruptible to write the data. Before the module can write the next
> chunk of data it needs to stall until the user process has finished.
> I can not find a method of stalling the module so it seems my only solution
> is to write the file from the kernel or dump the data somewhere manually.
>
> Cheers

No. SOP in user mode:
        pf.fd = fd;
        pf.revents = 0;
        pr.events  = POLLIN|OTHER_STUFF;
	if(poll(&pf, 1, NR) > 0)
            if(pf.revents & POLLIN))
                 read(fd, buf, BUF_LEN);

In the kernel module:

static wait_queue_head_t pwait;
static size_t global_poll;
static spinlock_t mylock;

// Remember to initialize both pwait and mylock;

static size_t poll(struct file *fp, struct poll_table_struct *wait)
{
    size_t poll_flag;
    size_t flags;
    poll_wait(fp, &pwait, wait);
    spin_lock_irqsave(&mylock, flags);
    poll_flag = global_poll | POLLRDNORM|POLLWRNORM;
    global_poll = 0;
    spin_lock_irqrestore(&mylock, flags);
    return poll_flag;
}

static void ISR(int irq, void *v, struct pt_regs *sp)
{
    spin_lock(&mylock);
    do_stuff_to_read_data_into_a_buffer();
    spin_unlock(&mylock);
    global_poll = POLLIN;
    wake_up_interruptible(&pwait);
}


So. You have a user-task sleeping in poll() or select().
The kernel is interrupted. It  calls your ISR where
you take data from wherever and put it into a buffer.
Then your ISR code, which knows that data are now available,
signals the sleeping task via wake_up_interruptible() and
then returns. The kernel scheduler now knows that your
task should be put into the run-queue and your task gets
the CPU via a return from poll(). You read the status
and now your task knows that data are available. Your
task calls read() to get the data.


There are no 'stalls'. You can be interrupted at any time.
Any time you switch buffers or manipulate pointers within
the module-code, where your code could get 'confused'
if an interrupt occurred, you use a spin-lock. This
prevents an interrupt from occurring at that time. You
release the lock as soon as it is safe to do so.

If data are streaming, you may need several buffers. You
need to synchronize your read() and the data source (the
ISR) so that old data are never overwritten. This, too, is
SOP. Just do it. It works. It's the basic stuff that makes
Unix work. There are lots of examples in the modules
supplied with the kernel sources.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.



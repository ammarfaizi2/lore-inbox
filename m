Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbUCBXP0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 18:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbUCBXP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 18:15:26 -0500
Received: from chaos.analogic.com ([204.178.40.224]:34944 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261559AbUCBXPS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 18:15:18 -0500
Date: Tue, 2 Mar 2004 18:16:30 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Roland Dreier <roland@topspin.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: poll() in 2.6 and beyond
In-Reply-To: <52hdx6rh7t.fsf@topspin.com>
Message-ID: <Pine.LNX.4.53.0403021808240.9351@chaos>
References: <Pine.LNX.4.53.0403021318580.796@chaos> <527jy3qalg.fsf@topspin.com>
 <Pine.LNX.4.53.0403021510270.1856@chaos> <52vflnq807.fsf@topspin.com>
 <Pine.LNX.4.53.0403021624300.2296@chaos> <52n06zq67n.fsf@topspin.com>
 <Pine.LNX.4.53.0403021651010.9048@chaos> <52hdx6rh7t.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2004, Roland Dreier wrote:

>     Richard> You are playing games with semantics because you are
>     Richard> wrong.  The code in fs/select.c about line 101, adds the
>     Richard> current caller to the wait-queue.
>
> I assume you mean the call to add_wait_queue() there.  That does not
> sleep.  Look at the implementation.  add_wait_queue() is defined in
> kernel/fork.c -- it just does some locking and calls
> __add_wait_queue().  __add_wait_queue() is really nothing more than
> a list_add().  There's nothing more to it and nothing that goes to
> sleep.  Where do you think add_wait_queue() goes to sleep?
>
>     Richard> This wait-queue is the mechanism by which the current
>     Richard> caller sleeps, i.e., gives the CPU up to somebody else.
>     Richard> That caller's thread will not return past that line until
>     Richard> a wake_up_interruptible() call has been made for/from the
>     Richard> driver or interface handling that file descriptor. In
>     Richard> this manner any number of file discriptors may be handled
>     Richard> because the poll() routine for each of then makes its own
>     Richard> entry into the wait-queue using the described mechanism.
>
> But there's only one thread around: the user space process that called
> into the kernel via poll().  If the first driver goes to sleep, which
> thread do you think is going to wake up and call into the second
> driver?
>

There are two routines where the CPU is actually given up,
do_select() and do_poll().  Search for schedule_timeout().
Once the scheduler has the CPU, it's available for any of
the other drivers. It's also available for the timer queues,
other tasks, and the interrupts.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.



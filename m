Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319220AbSIDRXQ>; Wed, 4 Sep 2002 13:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319223AbSIDRXQ>; Wed, 4 Sep 2002 13:23:16 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2432 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S319220AbSIDRXP>; Wed, 4 Sep 2002 13:23:15 -0400
Date: Wed, 4 Sep 2002 13:27:46 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Libershteyn, Vladimir" <vladimir.libershteyn@hp.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problem on a kernel driver(SuSE, SMP)
In-Reply-To: <8C18139EDEBC274AAD8F2671105F0E8E121765@cacexc02.americas.cpqcorp.net>
Message-ID: <Pine.LNX.3.95.1020904130721.865A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2002, Libershteyn, Vladimir wrote:

> Hi, All,
> 
> I'm looking for a help on a kernel module programming issue.
> 
> We have a hardware device I have a driver written for.
> It works without any problem on any of Red Hat, SMP machine or not. The same driver does work with
> SuSE 7.x non-SMP, but has a problem with SMP machines.
> 
> Here is a problem:
> 
> For synchronization I use semaphores. Semaphores initializes with init_MUTEX_LOCKED function
> which basically set the atomic value of a count to 0.
> In a routine that looking for a data I use a function down_interruptible(&sem) which should
> check the count value to be 0 and if it so the thread goes to slip until the ISR will set the 
> semaphore count back to initial value with a command up(&sem);
> 
> What happens with my driver, when it comes to the command down_interruptible(...) the whole
> system just hangs. I could not find any restrictions on using this mechanism, but just for the testing
> I switched from using semaphores to wait queues. The result is exactly the same.
> 
> What am I doing wrong? The kernel I'm running is 2.4.7-64G... and the OS is SuSE7.x Enterprise
> Again, It works fine on any Red Hat OS
> 

You are not too specific, which makes it hard to understand what may
be going wrong so I'll assume that you probably did a bad thing.

(1)  You cannot sleep in an interrupt, which means you can't use
down_*() and friends inside an ISR.

(2)  Wait queues should work fine from the 'user-side' of a driver,
but again, you cannot ever sleep in an interrupt service routine.
Look in ../linux/drivers/* for examples of code that works.

(3)  You can't use any wait-queue or sleep on a semaphore while
holding a spin-lock or while the interrupts are disabled. You can
manage your own lock against re-entry in your procedure, but you
can't allow two tasks to try the same semaphore at (nearly) the
same time or you can dead-lock.


(4)	The fact that 'down' hangs means that there is nothing
that the CPU can do. This is direct evidence that you have the
interrupts disabled when down executes.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.


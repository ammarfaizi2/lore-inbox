Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262911AbVCWU1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262911AbVCWU1O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 15:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbVCWUZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 15:25:51 -0500
Received: from alog0321.analogic.com ([208.224.222.97]:49542 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262908AbVCWUYC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 15:24:02 -0500
Date: Wed, 23 Mar 2005 15:23:50 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: sounak chakraborty <sounakrin@yahoo.co.in>
cc: linux-kernel@vger.kernel.org
Subject: Re: repeat a function after fixed time period
In-Reply-To: <20050323194308.8459.qmail@web53307.mail.yahoo.com>
Message-ID: <Pine.LNX.4.61.0503231522070.16567@chaos.analogic.com>
References: <20050323194308.8459.qmail@web53307.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2005, sounak chakraborty wrote:

> dear sir
> i want to call my own function inside the kernel
> after a fixed interval(i.e some kind of timer)
> how to do that which function i have to use to
> repeat the function
>
> anather way is that making my own system call
> which calls my function and
> this sytem call is being access by a user program
> which calls it after a fixed inter val of time
> will this be correct
> thanks
> sounak
>

This kernel code should do just fine.



struct INFO {
     struct timer_list timer;            // For test timer
     atomic_t running;                   // Timer is running
     };

//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
//
//   This stops the timer. This must NOT be called with a spin-lock
//   held.
//
static void stop_timer()
{
     if(atomic_read(&info->running))
     {
         atomic_dec(&info->running);
         if(info->timer.function)
             del_timer(&info->timer);
     }
}
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
//
//    This starts the timer. This must NOT be called with a spin-lock
//    held.
//
static void start_timer(void)
{
     if(!atomic_read(&info->running))
     {
         atomic_inc(&info->running);
         init_timer(&info->timer);
         info->timer.expires = jiffies + HZ;
         info->timer.data = 0;
         info->timer.function = test_timer;
         add_timer(&info->timer);
     }
}
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
//
//   This is the code that executes at a timer-interval.
//
static void test_timer(unsigned long data)
{
     info->timer.expires = jiffies + HZ;         // New expiration time
     if(atomic_read(&info->running))             // If it's still running
     {
         code_to_execute_every_timer_interval();
         add_timer(&info->timer);                // Into timer-queue again
     }
}
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270713AbTHALnf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 07:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270720AbTHALnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 07:43:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13319 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S270713AbTHALnX (ORCPT
	<rfc822;linux-kernel@vger.redhat.com>);
	Fri, 1 Aug 2003 07:43:23 -0400
Date: Fri, 1 Aug 2003 07:38:29 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Dinesh Gandhewar <dinesh_gandhewar@rediffmail.com>
cc: mlist-linux-kernel@nntp-server.caltech.edu
Subject: Re: volatile variable
In-Reply-To: <20030801105706.30523.qmail@webmail28.rediffmail.com>
Message-ID: <Pine.LNX.4.53.0308010723060.3077@chaos>
References: <20030801105706.30523.qmail@webmail28.rediffmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Aug 2003, Dinesh  Gandhewar wrote:

> Hello,
>
> If a system call is having following code.
>
> add current process into wait quque ;
> while (1)
> {  set task state INTERRUPTIBLE ;
>     if (a > 0)
>       break ;
>     schedule() ;
> }
> set task state RUNNING ;
> remove current from wait queue ;
>
>
> If an interrupt service is having following code
>
> set a = 512 ;
>
> 'a' is a global variable shared in ISR and system call
>
> Do I need to define a as 'volatile int a ;' ? Why?
>
> Thanks & Regards,
> Dinesh
>

First, there are already procedures available to do just
what you seem to want to do, interruptible_sleep_on() and
interruptible_sleep_on_timeout(). These take care of the
ugly details that can trip up compilers.

In any event in your loop, variable 'a', has already been
read by the code the compiler generates. There is nothing
else in the loop that touches that variable. Therefore
the compiler is free to (correctly) assume that whatever
it was when it was first read is what it will continue to
be. The compiler will therefore optimise it to be a single
read and compare. So, the loop will continue forever if
'a' started as zero because the compiler correctly knows
that it cannot possibly change in the only execution
path that it knows about.

To tell the compiler that there are other possible execution
paths in which the variable could be modified, you need to
declare the variable as "volatile". The variable's storage
hasn't changed. The size of the variable hasn't changed.
All you have done is told the compiler to read that variable
every time because it could have changed.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


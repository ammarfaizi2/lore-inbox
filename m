Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136764AbREIRQG>; Wed, 9 May 2001 13:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136761AbREIRQA>; Wed, 9 May 2001 13:16:00 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22283 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136762AbREIRPb>; Wed, 9 May 2001 13:15:31 -0400
Subject: Re: 
To: george@mvista.com (george anzinger)
Date: Wed, 9 May 2001 18:15:46 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), root@chaos.analogic.com,
        linux-kernel@vger.kernel.org (Linux kernel)
In-Reply-To: <3AF97773.80DAFFC0@mvista.com> from "george anzinger" at May 09, 2001 09:59:31 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14xXYz-0002oc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> from the interrupt back to the driver.  This is not unlike what you must
> already be doing for interrupt completion.
> 
> Do pay attention to getting the timer (&t->timer above) properly set up
> (see my first response or most any usage in the kernel).
> 
> Have I got this right Alan?

The other thing to watch is that you need to delete the timer before you unload
As you can safely del_timer() an initialised but already deleted timer that
isnt too onerous.

Waiting for a thread in the module unload is trickier. You cannot simply kill
the thread as it may run after cleanup_module() returns. Instead you do

static void cleanup_module(void)
{
	kill_thread();
	down(&thread_sem);
	printk("Thread dead\n");
}

and in the thread exit path do

	up_and_exit(&thread_sem, error_code);

This ensures that the thread of execution has left the module code space and
will not return.

Alan


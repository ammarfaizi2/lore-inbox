Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275743AbRJYR1r>; Thu, 25 Oct 2001 13:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275680AbRJYR1h>; Thu, 25 Oct 2001 13:27:37 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:6671 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S275743AbRJYR10>; Thu, 25 Oct 2001 13:27:26 -0400
Message-ID: <3BD84A80.BB08EBD8@zip.com.au>
Date: Thu, 25 Oct 2001 10:23:12 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12-ac6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: R.Oehler@GDImbH.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.10: printk() deadlocks
In-Reply-To: <XFMail.20011025144450.R.Oehler@GDImbH.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

R.Oehler@GDImbH.com wrote:
> 
> Hi, andrew,
> 
> currently I'm porting our WORM filesystem (OWFS) from kernel
> 2.4.0 to kernel 2.4.10. I'm used to rely on printk() to be callable
> from every place in the kernel, but now I experience deadlocks
> when calling it from some places within our filesystem.
> (I'm writing a ~600 lines in 2 seconds and I enlarged the buffer size
> to 1MB, what worked perfectly in the past.)
> The call-chain is:
> ...

But it isn't deadlocked.  The EIP points at this statement

                spin_unlock_irqrestore(&logbuf_lock, flags);
-->             console_may_schedule = 0;
                release_console_sem();

in printk().  So the output is about to come out to
the console device(s).

> A diff between printk.c of the two kernels shows:
>  * Rewrote bits to get rid of console_lock
>  *      01Mar01 Andrew Morton <andrewm@uow.edu.au>
> 
> Please could you tell me a workaround or some possibility to get out
> of this situation? I think printk() should be an absolutely reliable
> function which never schedules.

printk() doesn't schedule.  However, userspace processes which
write to /dev/ttyX *do* schedule, and the two paths use the same
code and have to lock against each other, etc.  That's why it's all
rather unclear.

Sorry, but I think you must be doing something strange to make this
happen - can you please diagnose a little further?  Investigate
further with kdb?  Can you send me the wherewithals to reproduce
it?  Are you running SMP?

-

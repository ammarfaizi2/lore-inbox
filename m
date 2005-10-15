Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbVJOJ6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbVJOJ6a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 05:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbVJOJ6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 05:58:30 -0400
Received: from fe-6c.inet.it ([213.92.5.112]:16124 "EHLO fe-6c.inet.it")
	by vger.kernel.org with ESMTP id S1751030AbVJOJ63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 05:58:29 -0400
From: Gabriele Brugnoni <news@dveprojects.com>
Organization: DVE Progettazione Elettronica
To: linux-kernel@vger.kernel.org
Subject: interruptible_sleep_on, interrupts and device drivers
Date: Sat, 15 Oct 2005 12:00:31 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510151200.32148.news@dveprojects.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm writing a device driver for a UART to be used to drive a RS485 line. 
I would use the interruptible_sleep_on function to wait for receiver ready,
or for the transmitter to finish.
I've take a look at how other device driver use this function, and a big
question is born on my mind:

In several device driver I've seen that:

The code check for the availability of data.
If not available, a call the interruptible_sleep_on is made.
In the interrupt handler, when data becomes ready, a wakeup_interruptible
call is made.

Often the variables that indicates if data is available or not are tested
between spin_lock and unlock (or save_irq and restore_irq) so that the
interrupt handler cannot change the status during check.

But:
If the test is made with IRQ closed, and IRQ are then enabled after the test
but before the call to interruptible_sleep_on, what happen if the handler
break the procedure immediately before entering the interruptible_sleep_on
function ?
I beleave that the interrupt handler, calling the wakeup function, will not
wake our process, because is not in the waiting list. But at return from
IRQ handler, the process will continue execution calling the sleep
function, and nobody will wake it because the data is now already available.

I try to explain better with an example:

This may be a function that should wait that the UART send all chars.
When the interrupt for shift empty will be serviced, the
wakeup_interruptible function will wake all waiting processes in wait list.


10: void waitEndTX ( void )
11: {
12:    unsigned long flags;
13:
14:    //....
15:
16:    spin_lock_irqsave(&mylock, flags);
17:    if( tx_done ) {
18:        spin_lock_irqrestore(&mylock, flags);
19:        return;
20:    }
21:    spin_lock_irqrestore(&mylock, flags);
22:    interruptible_sleep_on ( &uartwait );
23:}


This type of code is very used in a lot of device drivers, in kernel 2.6.x
(the char/specialix, for example).

OK, Now we suppose that the UART finish to send the character exactely when
the process has closed the IRQ and is about to the the tx_done variable.
(At line 17 for example).
The hardware will asserts the IRQ line, but the processor has the IRQ
closed, so the execution will continue in our process.
Now at line 21 our process enable the IRQ.
The CPU will immediately jumps to irq handler, breaking the execution at
line 22. Our handler will set the variable tx_done to one.
When the cpu control returns to our calling process, at line 21, the tx_done
has already tested and it's value was zero. The execution continue with the
call to interruptible_sleep_on function, that will put our process in the
uartwait queue, but nobody will wakeup it.

If this is true, a lot of device driver in linux kernel may have this
problem. This sound me very strange, so where I'm wrong ?


Thanks in advance.
Gabriele

(Note: I've tried to post this message with another program but I think 
without success. I apologize if this message will appears twice.)


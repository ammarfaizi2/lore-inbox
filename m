Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135222AbREHTtX>; Tue, 8 May 2001 15:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135225AbREHTtD>; Tue, 8 May 2001 15:49:03 -0400
Received: from chaos.analogic.com ([204.178.40.224]:13953 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S135222AbREHTsu>; Tue, 8 May 2001 15:48:50 -0400
Date: Tue, 8 May 2001 15:48:45 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Message-ID: <Pine.LNX.3.95.1010508154726.29540A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To driver wizards:

I have a driver which needs to wait for some hardware.
Basically, it needs to have some code added to the run-queue
so it can get some CPU time even though it's not being called.

It needs to get some CPU time which can be "turned on" or
"turned off" as a result of an interrupt or some external
input from  an ioctl().

So I thought that the "tasklet" would be ideal. However, the
scheduler "thinks" that a tasklet is an interrupt, so any
attempt to sleep in the tasklet results in a kernel panic,
"ieee scheduling in an interrupt..., BUG sched.c line 688".

Next, I added code to try queue_task(). This has the same problem.

Basically the procedure needs to do:

procedure()
{
    if(some_event)
        schedule_timeout(n);               /* Needs to sleep */
    else if(something_else)
        do_something();
   queue_task(procedure, &tq_immediate);   /* Needs to queue itself again */
}

Since I'm running against a time-line, I temporarily  gave the module
some CPU time through an ioctl(), i.e., a separate task that does nothing
except repeatably execute ioctl(GIVE_CPU, NULL); This shows that the
driver actually works. It's a GPIB driver so it needs to get the
CPU to find out if it's addressed to listen, etc. These events don't
produce interrupts.

So, what am I supposed to do to add a piece of driver code to the
run queue so it gets scheduled occasionally?

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284761AbSADLXi>; Fri, 4 Jan 2002 06:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288602AbSADLX2>; Fri, 4 Jan 2002 06:23:28 -0500
Received: from mx2.elte.hu ([157.181.151.9]:10376 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S284761AbSADLXX>;
	Fri, 4 Jan 2002 06:23:23 -0500
Date: Fri, 4 Jan 2002 14:20:49 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: rwhron <rwhron@earthlink.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <20020104061650.A22264@earthlink.net>
Message-ID: <Pine.LNX.4.33.0201041412550.4007-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Jan 2002, rwhron wrote:

> The second time I ran it, when I was tailing the output the machine
> seemed to freeze.  (Usually the syscall tests complete very quickly).
> I got the oops below on a serial console, it scrolled much longer and
> didn't seem to like the call trace would ever complete, so i rebooted.

the oops shows an infinite page fault, the actual point of fault is not
visible. To make it visible, could you please apply the following patch to
your tree and check the serial console? It should now just print a single
line (showing the faulting EIP) and freeze forever:

   pagefault at: 12341234. locking up now.

Please look up the EIP via gdb:

	gdb ./vmlinux
	list *0x12341234

(for this you'll have to add '-g' to CFLAGS in the top level Makefile.)

> I ran it a third time trying to isolate which test triggered the oops,
> but the behavior was different again.  The machine got very very slow,
> but tests would eventually print their output.  The test that
> triggered the behavior was apparently between pipe11 and the
> setrlimit01 command below.

i'll try these tests. Does the test use RT scheduling as well?

> It looks like you already have an idea where the problem is.
> Looking forward to the next patch.  :)

i havent found the bug yet :-|

	Ingo

--- linux/arch/i386/mm/fault.c.orig	Fri Jan  4 12:08:41 2002
+++ linux/arch/i386/mm/fault.c	Fri Jan  4 12:11:09 2002
@@ -314,6 +314,8 @@
  * Oops. The kernel tried to access some bad page. We'll have to
  * terminate things with extreme prejudice.
  */
+	printk("pagefault at: %08lx. locking up now.\n", regs->eip);
+	for (;;) __cli();

 	bust_spinlocks(1);



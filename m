Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbUCCSVc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 13:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbUCCSVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 13:21:32 -0500
Received: from chaos.analogic.com ([204.178.40.224]:34177 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262541AbUCCSVY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 13:21:24 -0500
Date: Wed, 3 Mar 2004 13:23:26 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: David Dillow <dave@thedillows.org>
cc: Bill Davidsen <davidsen@tmr.com>, Roland Dreier <roland@topspin.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: poll() in 2.6 and beyond
In-Reply-To: <1078286221.4302.23.camel@ori.thedillows.org>
Message-ID: <Pine.LNX.4.53.0403031313270.12900@chaos>
References: <1vmPm-4lU-11@gated-at.bofh.it> <1vonq-6dr-37@gated-at.bofh.it>
  <1voGY-6vC-41@gated-at.bofh.it> <1vpjt-7dl-17@gated-at.bofh.it> 
 <1vpCV-7wY-41@gated-at.bofh.it> <1vpWa-7Py-19@gated-at.bofh.it> 
 <4045106D.8060902@tmr.com>  <Pine.LNX.4.53.0403021817050.9351@chaos>
 <1078286221.4302.23.camel@ori.thedillows.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1678434306-311451252-1078338206=:12900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1678434306-311451252-1078338206=:12900
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 2 Mar 2004, David Dillow wrote:

> On Tue, 2004-03-02 at 18:32, Richard B. Johnson wrote:
> > Yes. The code I attached earlier shows that the poll() in a driver
> > gets called (correctly), then it calls poll_wait(). Unfortunately
> > the call to poll_wait() returns immediately so that the return
> > value from the driver's poll() is whatever it was before some
> > event occurred that the driver was going to signal with
> > wake_up_interruptible().
>
> You've been handed a clue enough times now that you should understand
> that poll_wait() does not, and has never, put the process to sleep.
>
> If you can show a case where do_poll() returns stale data, then by all
> means do so. We will be happy to fix any such error in the kernel.
>
> You say do_poll() looses the status returned from your driver's poll
> method. If your driver is truly returning a nonzero status from the
> poll() method call, then a simple read of the code in do_pollfd() will
> show that the only way it looses information from that event mask is if
> your user space is not setting that event type in pollfd.events.
>
> If I were you, I'd check two things:
> 1) that your poll method is really returning a non-zero status when you
> think it is
> 2) that your user space program is really asking for all events you
> think it is
>
> I think you'll find your problem is not this well-used mechanism in the
> kernel.
>
> Dave

The very great problems that exist with poll on linux-2.6.0
are being quashed by those who just like to argue. Therefore,
I wrote some code that emulates the environment in which I
discovered the poll failure. Experts can decide whatever they
want about the inner workings of poll(). I supposed that if
`ps` showed that a task was sleeping in poll() then it must
be sleeping in poll(). So, even it that's wrong, here is
irrefutable proof that there is a problem with polling events
getting lost on 2.6.0. The attached code will execute without
errors in 2.4.24 and below.

Here is the test code running on Linux-2.4.24

Script started on Wed Mar  3 10:24:05 2004
# make
gcc -Wall -O2 -D__KERNEL__ -DMODULE -DMAJOR_NR=199  -I/usr/src/linux-2.4.24/include -c -o thingy.o thingy.c
as -o rtc_hwr.o rtc_hwr.S
ld -i -o driver.o thingy.o rtc_hwr.o
gcc -Wall -o tester -O2 tester.c
rm -f THING
mknod THING c 199 0
# insmod driver.o
# lsmod
Module                  Size  Used by
driver                  1928   0  (unused)
nfs                    48008   0  (autoclean)
lockd                  37308   0  (autoclean) [nfs]
sunrpc                 66236   0  (autoclean) [nfs lockd]
vxidrvr                 2748   0  (unused)
vximsg                  5328   0  [vxidrvr]
ramdisk                 5596   0  (unused)
ipchains               42204   0
nls_cp437               4376   4  (autoclean)
3c59x                  28252   1
isofs                  17368   0  (unused)
loop                    8856   0
sr_mod                 12188   0  (unused)
cdrom                  27936   0  [sr_mod]
BusLogic               35832   7
sd_mod                 10472  14
scsi_mod               56236   3  [sr_mod BusLogic sd_mod]
# ./tester

You have mail in /var/spool/mail/root
# exit
exit
Script done on Wed Mar  3 11:05:56 2004

This ran for about 1/2 hour ( 10:24 -> 11:05) with no
errors.

This is the same thing, running on this exact same machine, booted with
Linux-2.6.0-test8

Script started on Wed Mar  3 13:00:18 2004
# make
gcc -Wall -O2 -D__KERNEL__ -DMODULE -DMAJOR_NR=199  -I/usr/src/linux-2.6.0-test8/include -c -o thingy.o thingy.c
as -o rtc_hwr.o rtc_hwr.S
ld -i -o driver.o thingy.o rtc_hwr.o
gcc -Wall -o tester -O2 tester.c
rm -f THING
mknod THING c 199 0
# insmod driver.o
# ./tester
ERROR: (51 != 1) Lost events : 50
ERROR: (59371 != 59369) Lost events : 52
ERROR: (75501 != 75498) Lost events : 55
ERROR: (94511 != 94509) Lost events : 57
ERROR: (164660 != 164658) Lost events : 59
ERROR: (194867 != 194864) Lost events : 62
ERROR: (206892 != 206890) Lost events : 64
ERROR: (214232 != 214230) Lost events : 66
ERROR: (308340 != 308337) Lost events : 69
ERROR: (353062 != 353059) Lost events : 72
ERROR: (444541 != 444539) Lost events : 74
ERROR: (446516 != 446514) Lost events : 76
ERROR: (447906 != 447904) Lost events : 78

# exit
exit
Script done on Wed Mar  3 13:04:39 2004

It ran from 13:00 to 13:04, accumulating 78 errors.

A review of the test code shows that the driver uses IRQ8
from the RTC timer chip. The driver doesn't care if some
interrupt ticks are lost because it just increments a memory
variable every time that an interrupt occurs. After that variable
is incremented, the interrupt service routine sets a global
flag to POLLIN and sends a wake_up_interruptible() to whomever
is sleeping in poll(). Spin-locks are put around critical
sections to prevent undefined results.

In the user-mode code, the task sleeping in poll() reads
the variable using read(). The user-mode code doesn't
care what the value is, only that it must be one-greater than
the last one read. If it isn't, an error message is written
to standard error.

Observations:
If the call to mlockall() is removed in the test-code, the
behavior seems to be better, just the opposite of what one
would suspect.

The priority (nice value) doesn't seem to affect anything.

The code runs without any errors on 2.4.24, 2.4.22, 2.4.21, and
2.4.18. The only source I have on this machine for 2.6.x is
for 2.6.0-test8.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


--1678434306-311451252-1078338206=:12900
Content-Type: APPLICATION/octet-stream; name="modules.tar.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.53.0403031323260.12900@chaos>
Content-Description: 
Content-Disposition: attachment; filename="modules.tar.gz"

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
WMMa1vA3hv8CQu0IfABQAAA=

--1678434306-311451252-1078338206=:12900--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbVC3Lxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVC3Lxk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 06:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVC3Lxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 06:53:40 -0500
Received: from general.keba.co.at ([193.154.24.243]:62354 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S261839AbVC3LwM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 06:52:12 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: 2.6.11, IDE: Strange scheduling behaviour: high-pri RT process not scheduled?
Date: Wed, 30 Mar 2005 13:52:05 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F3673231C2@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.11, IDE: Strange scheduling behaviour: high-pri RT process not scheduled?
Thread-Index: AcU1Ht/KAqlxfYNPRUCm0PrICKCLEg==
From: "kus Kusche Klaus" <kus@keba.com>
To: <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>,
       <B.Zolnierkiewicz@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've written a small test program which enables periodic RTC interrupts 
at 8192 Hz and then goes into a loop reading /dev/rtc and collecting 
timing statistics (using the rdtscl macro).

The program runs at highest realtime scheduling priority (99) with
memory 
locked. In the loop, it doesn't do any I/O except for /dev/rtc reads, no

memory allocations, nothing which could block or take time:

  rdtscl(old);

  for (i = 0; i < SAMPLES; ++i) {
    if (read(fd, &rtcval, sizeof (unsigned long)) != sizeof (unsigned
long)) {
      fprintf(stderr, "%s: reading rtc data failed: %s\n", argv[0],
              strerror(errno));
      exit(1);
    }
    rtcval >>= 8;
    --rtcval;
    if (rtcval >= INTERRUPTS)
      ++intr[INTERRUPTS];
    else
      ++intr[rtcval];
    
    rdtscl(new);
    delta = new - old;
    delta /= RESOLUTION;
    if (delta >= INTERVALS)
      ++cnt[INTERVALS];
    else
      ++cnt[delta];

    old = new;
  }

The test system runs a 2.6.11 kernel (no SMP) on a Pentium3 500 MHz 
embedded hardware. All filesystems are on a CF Card connected to the 
primary IDE controller (intel 440BX chipset) in PIO mode 2. The CF
card can transfer up to 2 MB/s. 
There are 192 MB RAM, most of it free.
The system is configured without swap space.

As long as the system is idle otherwise, my program works as expected: 
Most of the time, after an rtc interrupt the program gets the data from 
/dev/rtc within less than 50 microseconds.

Even with the test program running (which causes >16000 context switches

per second), vmstat shows more than 95 % idle CPU. Hence, the CPU needed

by the rtc irq handler and the test program is minimal.

However, things break seriously when exercising the CF card in parallel 
(e.g. with a dd if=/dev/hda of=/dev/null):

* The rtc *interrupt handler* is delayed for up to 250 *micro*seconds. 
This is very bad for my purpose, but easy to explain: It is roughly the 
time needed to transfer 512 Bytes from a CF card which can transfer 2 
Mbyte/sec, and obviously, the CPU blocks all interrupts while making pio

transfers. (Why? Is this really necessary?)

(I know because I instrumented the rtc irq handler with rdtscl(), too)

* The *test program* is regularly blocked for 63 *milli*seconds, 
sometimes for up to 300 *milli*seconds, which is absolutely
unacceptable.

* vmstat shows around 50 % sys CPU and around 50 % I/O wait, and 0 or
1 % user CPU (zero idle CPU). context switches are down to around 
500 from the expected >16000, which also indicates that my program is 
scheduled much less often than it should. Most of the time, vmstat shows
one running and one blocked process.

Now the big question:
*** Why doesn't my rt test program get *any* CPU for 63 jiffies? ***
(the system ticks at 1000 HZ)

* There is around 50 % idle CPU (I/O wait). I/O wait should not block my

program, because my program neither performs any disk I/O nor swaps.

* The dd program obviously gets some CPU regularly (because it copies 2 
MB/s, and because no other program could cause the 1 % user CPU load). 
The dd runs at normal shell scheduling priority, so it should be 
preempted immediately by my test program!

Some things I tried:
1.) Using a mdma2 instead of a pio2 CF card: The CF card speed doubles
    (4 MB/s instead of 2 MB/s), and the "blind time" of my test program
    halves from 63 ms to 32 ms, but basically, the problem remains.
2.) Using a realtime-preempt-2.6.12-rc1-V0.7.41-11 kernel with
PREEMPT_RT:
    If my test program runs at rtpri 99, the problem is gone: It is 
    scheduled within 30 microseconds after the rtc interrupt.
    If my test program runs at rtpri 1, it still suffers from delays 
    in the 30 to 300 millisecond range.

Thanks for any help!

Klaus Kusche
> Entwicklung Software - Steuerung
> Software Development - Control
> 
> KEBA AG
> A-4041 Linz
> Gewerbepark Urfahr
> Tel +43 / 732 / 7090-3120
> Fax +43 / 732 / 7090-8919
> E-Mail: kus@keba.com
> www.keba.com
> 
> 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWATJh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWATJh7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 04:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWATJh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 04:37:59 -0500
Received: from general.keba.co.at ([193.154.24.243]:47771 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S1750715AbWATJh6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 04:37:58 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: My vote against eepro* removal
Date: Fri, 20 Jan 2006 10:37:43 +0100
Message-ID: <AAD6DA242BC63C488511C611BD51F367323324@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: My vote against eepro* removal
Thread-Index: AcYdHCjoQesIkj4WS2yXVeBnpG1tKQAgsMOw
From: "kus Kusche Klaus" <kus@keba.com>
To: "John Ronciak" <john.ronciak@gmail.com>, "Adrian Bunk" <bunk@stusta.de>
Cc: "kus Kusche Klaus" <kus@keba.com>, "Lee Revell" <rlrevell@joe-job.com>,
       <linux-kernel@vger.kernel.org>, <john.ronciak@intel.com>,
       <ganesh.venkatesan@intel.com>, <jesse.brandeburg@intel.com>,
       <netdev@vger.kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: John Ronciak
> During the watchdog the e100 driver reads all of the status registers
> from the actual hardware.  There are 26 (worst case) register reads. 
> There is also a spin lock for another check in the watchdog.  It would
> still surprise me that all of this would take 500 usec.  If you are
> seeing this delay, you can comment out the scheduling of the watchdog
> to see if this goes away.  We'll need to narrow down exactly what in
> the watchdog is causing the delay

Retested it.

Software:
2.6.15.1-rt6, no additional patches, configured for full preemption.

Hardware:
500 MHz Pentium 3
According to lspci: 82443+82371 Chipset (440 BX + PIIX4)
According to lspci: 82559ER (09) e100
100 Mbit full duplex

Measurement software:
* I start the rtc at 8192 Hz.
* I read from /dev/rtc in a usermode realtime process.
* After each read, I read the tsc and calculate the interval.
* It should be 122 us most of the time, and indeed it is.
  At rtprio 2-99, practically all measurements are < 160-175 us
  on an otherwise idle machine (160 for 99, 175 for 2).
  At rtprio 1, there are some intervals of up to 300 us on an 
  idle machine.
* The program records the intervals in internal arrays and prints
  them at the end, it doesn't perform any I/O while it is running.

Basically, my software measures how long it takes for a realtime
process at prio n to get executed after it became ready:
The actual interval minus 122 is the time the process was waiting
for the CPU (didn't get scheduled).
This means that there was continuous CPU activity for at least
that long, either at a higher or the same rt prio, on in
non-thread kernel code.
(the rtc threaded interrupt handler is running above all others)

Effect of the e100 driver:
* There is no measurable effect when my test program is running
  at prio 2 - 99.
* For prio 1, I get an interval of 500-650 us every 2 seconds,
  which indicates a scheduling latency of 380-530 us.
Hence, some piece of code is running for ~500 us at rt prio 1.

Analysis of e100:
* If I comment out the whole body of e100_watchdog except for the
  timer re-registration, the delays are gone (so it is really the
  body of e100_watchdog). However, this makes eth0 non-functional.
* Commenting out parts of it, I found out that most of the time
  goes into its first half: The code from mii_ethtool_gset to
  mii_check_link (including) makes the big difference, as far as
  I can tell especially mii_ethtool_gset.

Effect of desktop preemption:
With desktop preemption insted of full preemption, the 400-500 us
scheduling delay hits at any rt priority, even at 99, i.e. the
CPU is occupied by non-thread kernel code.
Again, commenting out e100_watchdog brings the delays back to
well below 400 us.

Latency traces:
None.
The latency tracer does not record this scheduling latency.
My max. traces are around 35 us with full preemption and
around 70 us with desktop preemption, and are not related to e100.

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com

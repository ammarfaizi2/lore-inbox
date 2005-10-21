Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965040AbVJURkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbVJURkO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 13:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965041AbVJURkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 13:40:14 -0400
Received: from xproxy.gmail.com ([66.249.82.201]:44451 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965040AbVJURkM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 13:40:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZOa4A7OFjAC2Io2JKwmEMDIXov3WA7zcyQ4ZW35Rxohgk4AAs/24pVSWBF+d+2AA56Cyqb0kceX+efxqAo1eldn77Kg1uMa5szhiVFWoh5OEtNhXwajM+hhz2WPH+3TTLsmq0QqTJfNYsmX3RLHnEVitKY3D/V5zTQrN/AiRlZM=
Message-ID: <5bdc1c8b0510211040s40f3f9bbj7f83e174d7b6d937@mail.gmail.com>
Date: Fri, 21 Oct 2005 10:40:11 -0700
From: Mark Knecht <markknecht@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc5-rt3 - `IRQ 8'[798] is being piggy
Cc: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <5bdc1c8b0510211003j4e9bf03bhf1ea8e94ffe60153@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0510211003j4e9bf03bhf1ea8e94ffe60153@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/05, Mark Knecht <markknecht@gmail.com> wrote:
> Hi,
>    Maybe I'm catching something here? Maybe not - no xruns as of yet,
> but I've never seen these messages before. Kernel config attached.
>
>    dmesg has filled up with these messages:
>
> Read missed before next interrupt
> `IRQ 8'[798] is being piggy. need_resched=0, cpu=0
> Read missed before next interrupt
> `IRQ 8'[798] is being piggy. need_resched=0, cpu=0
> Read missed before next interrupt
> `IRQ 8'[798] is being piggy. need_resched=0, cpu=0
> Read missed before next interrupt
> wow!  That was a 14 millisec bump
> `IRQ 8'[798] is being piggy. need_resched=0, cpu=0
> Read missed before next interrupt
> wow!  That was a 12 millisec bump
> `IRQ 8'[798] is being piggy. need_resched=0, cpu=0
> Read missed before next interrupt
> wow!  That was a 17 millisec bump
> `IRQ 8'[798] is being piggy. need_resched=0, cpu=0
> Read missed before next interrupt
> wow!  That was a 89 millisec bump
> lightning ~ #
>
> lightning ~ # cat /proc/interrupts
>            CPU0
>   0:     928484    IO-APIC-edge  timer
>   1:        572    IO-APIC-edge  i8042
>   7:          2    IO-APIC-edge  lpptest
>   8:     529468    IO-APIC-edge  rtc
>   9:          0   IO-APIC-level  acpi
>   12:      91942    IO-APIC-edge  i8042
>   14:         48    IO-APIC-edge  ide0
>   50:          2   IO-APIC-level  ehci_hcd:usb1
>   58:     534656   IO-APIC-level  hdsp
>   66:          2   IO-APIC-level  ohci1394
> 217:     532660   IO-APIC-level  ohci_hcd:usb2, eth0
> 225:      24239   IO-APIC-level  libata, NVidia CK804
> 233:       9083   IO-APIC-level  libata
> NMI:        263
> LOC:     928256
> ERR:          1
> MIS:          0
> lightning ~ #
>
> Cheers,
> Mark

OK, I am able to reproduce this reliably. This machine has two sound cards:

IRQ58 - RME HDSP 9652 - running Jack
IRQ225 - Internal NVidia running Alsa

The NVidia is default for system sounds. The RME is for serious audio work.

1) I start the Jack server using the RME card:

 mark@lightning ~ $ /usr/bin/jackd -R -P80 -p512 -dalsa -dhw:1 -r44100 -p64 -n2
jackd 0.100.5
Copyright 2001-2005 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details

JACK compiled with System V SHM support.
loading driver ..
apparent rate = 44100
creating alsa driver ... hw:1|hw:1|64|2|44100|0|0|nomon|swmeter|-|32bit
control device hw:1
configuring for 44100Hz, period = 64 frames, buffer = 2 periods
nperiods = 2 for capture
nperiods = 2 for playback


2) I start MythTV using the NVidia chip. (NOT Jack) No problem in
dmesg occur until I start streaming a recorded TV program. As soon
streaming as I start I get the messages. I stop more or less
immediately and view dmesg.

(               X-7686 |#0): new 22 us maximum-latency critical section.
 => started at timestamp 2496745046: <do_IRQ+0x29/0x50>
 =>   ended at timestamp 2496745068: <do_IRQ+0x39/0x50>

Call Trace: <IRQ> <ffffffff8014dabc>{check_critical_timing+492}
       <ffffffff8014dd65>{sub_preempt_count_ti+117}
<ffffffff801101e9>{do_IRQ+57}
       <ffffffff8010e1bc>{ret_from_intr+0}  <EOI>
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<ffffffff80157160>] .... __do_IRQ+0xe0/0x180
.....[<00000000>] ..   ( <= _stext+0x7feff0e8/0xe8)

 =>   dump-end timestamp 2496745158

(               X-7686 |#0): new 22 us maximum-latency critical section.
 => started at timestamp 2498025339: <do_IRQ+0x29/0x50>
 =>   ended at timestamp 2498025362: <do_IRQ+0x39/0x50>

Call Trace: <IRQ> <ffffffff8014dabc>{check_critical_timing+492}
       <ffffffff8014dd65>{sub_preempt_count_ti+117}
<ffffffff801101e9>{do_IRQ+57}
       <ffffffff8010e1bc>{ret_from_intr+0}  <EOI>
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<ffffffff80157160>] .... __do_IRQ+0xe0/0x180
.....[<00000000>] ..   ( <= _stext+0x7feff0e8/0xe8)

 =>   dump-end timestamp 2498025445

(    mythfrontend-8048 |#0): new 32 us maximum-latency critical section.
 => started at timestamp 2537338337: <rtc_open+0xf/0xc0>
 =>   ended at timestamp 2537338369: <rtc_open+0x6b/0xc0>

Call Trace:<ffffffff8014dabc>{check_critical_timing+492}
<ffffffff8014dd65>{sub_preempt_count_ti+117}
       <ffffffff802a228b>{rtc_open+107} <ffffffff80297039>{misc_open+473}
       <ffffffff80182999>{chrdev_open+457} <ffffffff80178757>{__dentry_open+295}
       <ffffffff80178937>{filp_open+135}
<ffffffff8014dd65>{sub_preempt_count_ti+117}
       <ffffffff80178ac6>{get_unused_fd+230} <ffffffff80178c31>{do_sys_open+81}
       <ffffffff8010dc16>{system_call+126}
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<ffffffff802a222f>] .... rtc_open+0xf/0xc0
.....[<00000000>] ..   ( <= _stext+0x7feff0e8/0xe8)

 =>   dump-end timestamp 2537338467

`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
wow!  That was a 9 millisec bump
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
wow!  That was a 10 millisec bump
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
wow!  That was a 8 millisec bump
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
wow!  That was a 11 millisec bump
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
wow!  That was a 2 millisec bump
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
wow!  That was a 3 millisec bump
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
wow!  That was a 9 millisec bump
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
wow!  That was a 5 millisec bump
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
wow!  That was a 3 millisec bump
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
wow!  That was a 43 millisec bump
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt
`IRQ 8'[798] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt

rtc latency histogram of {mythfrontend/8043, 15216 samples}:
3 13365
4 817
5 236
6 114
7 48
8 64
9 91
10 44
11 45
12 23
13 13
14 3
15 6
16 6
17 3
18 2
19 5
20 2
21 4
22 3
23 16
24 9
25 4
26 3
29 1
32 3
33 1
34 1
35 1
39 2
46 1
57 1
66 1
71 1
83 1
169 1
331 1
347 1
348 1
351 1
365 1
368 1
369 2
370 1
372 3
373 2
374 2
375 2
376 3
377 1
378 4
379 2
380 4
382 1
384 1
385 5
386 1
387 3
388 2
389 2
390 2
391 1
393 1
394 3
395 2
396 2
398 2
399 1
400 1
401 2
403 2
404 4
405 1
406 2
407 7
411 1
412 1
413 3
414 2
416 3
417 1
418 1
419 1
420 2
421 1
422 3
423 1
425 1
427 3
428 1
430 3
431 2
435 1
436 1
437 2
438 2
439 1
440 1
441 1
442 1
443 1
445 2
446 1
449 1
450 1
452 1
456 2
457 1
460 1
461 1
462 1
466 1
468 1
469 1
478 1
480 1
481 2
483 1
485 1
486 1
489 1
490 1
491 1
495 1
499 1
500 1
503 2
504 2
507 2
508 1
509 1
511 2
512 1
518 1
519 1
520 1
522 1
523 2
524 1
525 1
526 2
527 1
528 1
529 1
530 1
531 1
532 1
536 2
537 2
543 2
544 1
547 1
549 1
552 1
553 2
554 2
555 1
557 2
558 1
559 2
562 1
564 1
565 1
566 3
568 1
571 1
573 1
574 2
575 3
583 2
584 2
591 1
595 1
597 1
599 1
603 2
604 2
606 1
612 1
620 1
621 1
627 1
629 1
639 1
659 1
681 1
692 1
704 1
937 1
1026 1
1027 1
1210 2
1214 1
1227 1
1231 1
1236 1
1237 1
1243 1
1246 1
1253 2
1254 1
1272 1
1277 1
1284 1
1285 1
1290 1
1308 1
1310 1
1312 1
1323 1
1331 1
1339 1
1342 2
1349 1
1372 1
1611 1
1798 1
2739 1
3524 1
3668 1
5921 1
8438 1
9018 1
9131 1
9999 3
lightning ~ #

   Why does using MythTV apparently cause so much trouble for the rtc?

Thanks,
Mark

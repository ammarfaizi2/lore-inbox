Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVCaPUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVCaPUN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 10:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVCaPUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 10:20:08 -0500
Received: from general.keba.co.at ([193.154.24.243]:33486 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S261498AbVCaPTM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 10:19:12 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.11, IDE: Strange scheduling behaviour: high-pri RT process not scheduled?
Date: Thu, 31 Mar 2005 17:19:04 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F3673231D2@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.11, IDE: Strange scheduling behaviour: high-pri RT process not scheduled?
Thread-Index: AcU15cZq8GAbBPM5RjCajVAUz6RgxQAHjPLg
From: "kus Kusche Klaus" <kus@keba.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>,
       <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Florian Schmidt" <mista.tapas@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> getting /dev/rtc handling right for latency measurement is 
> ... tricky.  
> The method i'm using under PREEMPT_RT is:
> 
>  chrt -f 84 -p `pidof 'IRQ 0'`
>  chrt -f 95 -p `pidof 'IRQ 8'`
>  ./rtc_wakeup -f 1024 -t 100000

I tried it your way.

First impressions with realtime-preempt-2.6.12-rc1-V0.7.42-01, 
rtc_wakeup and chrt:


The main difference is not between rtc_wakeup and my test script
(the timings agree very well), but comes from chrt for 'IRQ 8':

System not loaded, original 'IRQ 8' prio 49:
* rtc_wakeup at 89(99): max jitter: 378.2% (461 usec), missed irqs:  0
* rtc_wakeup at 1(11):  max jitter:  97.1% (118 usec), missed irqs: 25
System not loaded, 'IRQ 8' prio at 95:
* rtc_wakeup at 89(99): max jitter:  19.1% ( 23 usec), missed irqs:  0
* rtc_wakeup at 1(11):  max jitter: 190.7% (232 usec), missed irqs: 52


The following tests are made with 'IRQ 8' at 95, rtc_wakeup at 89(99):
* Heavy mmap load, no oom: max jitter:     42.1% (   51 usec)
* Heavy mmap load, oom:    max jitter:  11989.2% (14635 usec)
  (but still "missed irqs: 0", so IRQ 8 was also blocked for 14 ms)
* USB reads, no error:     max jitter:    707.7% (  863 usec)
  (happens rarely)
* USB reads, error:        max jitter:   7247.2% ( 8846 usec)
  (again, no missed irqs)
* USB stick connect:       max jitter:   5776.7% ( 7051 usec)
* USB stick disconnect:    max jitter:   2966.6% ( 3621 usec)
  (both without error!)


Notes:
* My system does not have a 'IRQ 0' kernel thread.
  It has IRQ 1, 3, 7, 8, 12 and 14.
  This is strange, because /proc/interrupts says
    0:    4805658          XT-PIC  timer  0/5658
    2:          0          XT-PIC  cascade  0/0
    3:          0          XT-PIC  serial  0/0
    7:      17538          XT-PIC  uhci_hcd:usb1, eth0  0/17538
    8:     838523          XT-PIC  rtc  0/38523
   14:       5775          XT-PIC  ide0  0/5775
* The syntax of chrt has changed:
  chrt -f -p <prio> <pid>
* I run rtc_wakeup with -f 8192.
  This is more realistic in our case.

CF card (IDE) load does not hurt as long as the rtc test runs
with a very high rtpri: The results did not differ significantly
from no-load results.
Attempts with tracing on and results with running the test 
at low rtpri will follow tomorrow...

-- 
Klaus Kusche
Entwicklung Software - Steuerung
Software Development - Control

KEBA AG
A-4041 Linz
Gewerbepark Urfahr
Tel +43 / 732 / 7090-3120
Fax +43 / 732 / 7090-8919
E-Mail: kus@keba.com
www.keba.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262088AbVCIRV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbVCIRV5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 12:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbVCIRV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 12:21:56 -0500
Received: from fmr23.intel.com ([143.183.121.15]:37345 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S262088AbVCIRVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 12:21:36 -0500
Message-Id: <200503091721.j29HLNg24054@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <axboe@suse.de>
Subject: RE: Direct io on block device has performance regression on 2.6.x kernel
Date: Wed, 9 Mar 2005 09:21:22 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcUkcSgaDBjncYCsRmWAZtN826Ko7QABKRbA
In-Reply-To: <20050308222737.3712611b.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote on Tuesday, March 08, 2005 10:28 PM
> But before doing anything else, please bench this on real hardware,
> see if it is worth pursuing.

Let me answer the questions in reverse order.  We started with running
industry standard transaction processing database benchmark on 2.6 kernel,
on real hardware (4P smp, 64 GB memory, 450 disks) running industry
standard db application.  What we measured is that with best tuning done
to the system, 2.6 kernel has a huge performance regression relative to
its predecessor 2.4 kernel (a kernel from RHEL3, 2.4.21 based).

Ever since we had that measurement, people kick my butt everyday and
asking "after you telling us how great 2.6 kernel is, why is my workload
running significantly slower on this shinny 2.6 kernel?".  It hurts,
It hurts like a sledge hammer nailed right in the middle of my head.

This is all real: real benchmark running on real hardware, with real
result showing large performance regression.  Nothing synthetic here.

And yes, it is all worth pursuing, the two patches on raw device recuperate
1/3 of the total benchmark performance regression.

The reason I posted the pseudo disk driver is for people to see the effect
easier without shelling out a couple of million dollar to buy all that
equipment.


> Once you bolt this onto a real device driver the proportional difference
> will fall, due to addition of the constant factor.
>
> Once you bolt all this onto a real disk controller all the numbers will get
> worse (but in a strictly proportional manner) due to the disk transfers
> depriving the CPU of memory bandwidth.
>

That's not how I would interpret the number.  Kernel utilization went up for
2.6 kernel running the same db workload.  One reason is I/O stack is taxing a
little bit on each I/O call (or I should say less efficient), even with minuscule
amount, given the shear amount of I/O rate, it will be amplified very quickly.
One cpu cycle spend in the kernel means one less cpu cycle for the application.
My mean point is with less efficient I/O stack, kernel is actually taking away
valuable compute resources from application to crunch SQL transaction.  And that
leads to lower performance.

One can extrapolate it the other way: make kernel more efficient in processing
these I/O requests, kernel utilization goes down, cycle saved will transfer to
application to crunch more SQL transaction, and performance goes up.  I hope
everyone is following me here.


> At 5 usecs per request I figure that's 3% CPU utilisation for 16k requests
> at 100 MB/sec.

Our smallest setup has 450 disks, and the workload will generate about 50,000
I/O per second.  Larger setup will have more I/O rate.


> What sort of CPU?
>
> What speed CPU?
>
> What size requests?
>
> Reads or writes?
>

1.6 GHz Itanium2, 9M L3
I/O requests are mixture of 2KB and 16KB, occasionally some large size in burst.
Both read/write, about 50/50 split on rw.

- Ken



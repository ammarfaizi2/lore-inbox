Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262410AbUJ0M0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbUJ0M0y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 08:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbUJ0MZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 08:25:25 -0400
Received: from fmr06.intel.com ([134.134.136.7]:46516 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262408AbUJ0MXv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 08:23:51 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Fixing MTRR smp breakage and suspending sysdevs.
Date: Wed, 27 Oct 2004 20:23:38 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD3057569A2A2@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Fixing MTRR smp breakage and suspending sysdevs.
Thread-Index: AcS8DAAgiBmYsSaeTNCYjA+bUNSXPgAEwOhQ
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>
Cc: <ncunningham@linuxmail.org>, "Patrick Mochel" <mochel@digitalimplant.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Oct 2004 12:23:41.0977 (UTC) FILETIME=[CBA45890:01C4BC1F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>> >One thing I have noticed is that by adding the sysdev suspend/resume
>> >calls, I've gained a few seconds delay. I'll see if I can track down
>> the
>> >cause.
>> Is the problem MTRR resume must be with IRQ enabled, right? Could we
>> implement a method sysdev resume with IRQ enabled? MTRR driver isn't
>> the
>
>MTRR does not deserve to be sysdev. It is not essential for the
>system, it only makes it slow.
It's a CPU driver, cpufreq driver is the same.

>
>> only case. The ACPI Link device is another case, it's a sysdev (it
must
>> resume before any PCI device resumed), but its resume (it uses
semaphore
>> and non-atomic kmalloc) can't invoked with IRQ enabled. I guess
cpufreq
>> driver is another case when suspend/resume SMP is supported.
>
>I do not see how enabling interrupts before setting up IRQs is good
>idea.
>
>What about this one, instead?
>
>* ACPI Link device should allocate with GFP_ATOMIC
>
>* during suspend, locks can't be taken. (We stop userland, etc). So it
>should be okay to down_trylock() and panic if that does not work.
Hmm, the only problem is ACPI link device resume code will call into
ACPI CA code. We can't change ACPI CA (its code is very huge).

Thanks,
Shaohua

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262718AbUJ1ClZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbUJ1ClZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 22:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbUJ1ClZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 22:41:25 -0400
Received: from fmr12.intel.com ([134.134.136.15]:58796 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S262718AbUJ1Ck7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 22:40:59 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Fixing MTRR smp breakage and suspending sysdevs.
Date: Thu, 28 Oct 2004 10:40:37 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD3057569A5B8@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Fixing MTRR smp breakage and suspending sysdevs.
Thread-Index: AcS8EfsXY1o15QQ6TFu8j9E6cOb6HAAfbqQwAAHbm4A=
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Pavel Machek" <pavel@ucw.cz>
Cc: <ncunningham@linuxmail.org>, "Patrick Mochel" <mochel@digitalimplant.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 Oct 2004 02:40:38.0312 (UTC) FILETIME=[822A7280:01C4BC97]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>>> >One thing I have noticed is that by adding the sysdev
suspend/resume
>>> >calls, I've gained a few seconds delay. I'll see if I can track
down
>>> the
>>> >cause.
>>> Is the problem MTRR resume must be with IRQ enabled, right? Could we
>>> implement a method sysdev resume with IRQ enabled? MTRR driver isn't
>>> the
>>
>>MTRR does not deserve to be sysdev. It is not essential for the
>>system, it only makes it slow.
>>
>>> only case. The ACPI Link device is another case, it's a
>>sysdev (it must
>>> resume before any PCI device resumed), but its resume (it
>>uses semaphore
>>> and non-atomic kmalloc) can't invoked with IRQ enabled. I
>>guess cpufreq
>>> driver is another case when suspend/resume SMP is supported.
>>
>>I do not see how enabling interrupts before setting up IRQs is good
>>idea.
>>
>>What about this one, instead?
>>
>>* ACPI Link device should allocate with GFP_ATOMIC
>>
>>* during suspend, locks can't be taken. (We stop userland, etc). So it
>>should be okay to down_trylock() and panic if that does not work.
>
>
>Actually, I am trying another approach for Link Device.
>
>- Temporarily enable interrupts during Link Device resume. Turn off all
the
>external interrupts at suspend time. They will remain suspended until
>interrupt device resumes.
>
>Something like the patch below. Only part I don't like is controlling
the
>resume order by Makefiles and the link order. Probably we can fix that
by
>sorting the sysdev list at the boottime, depending on our ordering
>requirements. I think, the resume order we need to maintain is
something
>like this: irqrouter, pit/timer, i8259, lapic, ioapic, others

Turn off PIC/IOAPIC in suspend time doesn't mean the PIC/IOAPIC is
disabled in resume. BIOS possibly turns them on in resume.

Thanks,
Shaohua

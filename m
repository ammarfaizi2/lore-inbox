Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbTHTEqf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 00:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbTHTEqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 00:46:35 -0400
Received: from fmr01.intel.com ([192.55.52.18]:3227 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S261705AbTHTEqc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 00:46:32 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: [PATCHSET][2.6][0/5]Support for HPET based timer - Take 1
Date: Tue, 19 Aug 2003 18:16:07 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1902C7D1CB@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCHSET][2.6][0/5]Support for HPET based timer - Take 1
Thread-Index: AcNmuKInHcx89LsYQGaKo2u9yMILRg==
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: <torvalds@osdl.org>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
X-OriginalArrivalTime: 20 Aug 2003 01:16:08.0112 (UTC) FILETIME=[A2661300:01C366B8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Resend - The original mail hasn't yet appeared on lkml, even 5 hours 
after posting]

High Precision Event Timer (HPET) is next generation timer
hardware and has various advantages over legacy 8254
(PIT) timer, like:
- Associated registers are mapped to memory space. So, we no
  longer require in and out on legacy ioports
- Memory map address is reported by ACPI (and are not
  hard-coded)
- Each timer can be configured to generate separate interrupts,
  even sharing lines with PCI devices
- HPET has a minimum period of 100 nanosecs and is not fixed.
  Giving a flexibility of increasing the resolution in future.
- Most current implementations has 3 counters, but in future,
  we can have as many as 32 timers per block, and 8
  HPET timer blocks (total 256 timers)
- Can support 32bit and 64bit counting

(Refer to http://www.intel.com/labs/platcomp/hpet/hpetspec.htm
 for complete specs)

The patchset that follow adds support for High Precision Event
Timer (HPET) based timer in kernel. This uses the HPET in
LegacyReplacement mode (so that counter 0 will be tied to IRQ0,
and counter 1 will be tied to IRQ 8). In this mode, HPET overrides
PIT and RTC interrupt lines. The patch will enable HPET by default,
on systems where ACPI tables reports this feature. The patch will
have no impact on systems that do not support this feature.

Patchset description:
1/5 - hpet1.patch - acpi boot time parsing changes to look for HPET
2/5 - hpet2.patch - All the changes required to use HPET in place
                    of PIT as the kernel base-timer at IRQ 0.
3/5 - hpet3.patch - All changes required to support timer services
                    (gettimeofday) with HPET. There are two options:
                    - Use HPET for gettimeofday.
                    - Use rdtsc for gettimeofday.
                    rdtsc is still faster then HPET reads, but HPET
                    has advantage that its rate remain same,
                    irrespective of CPU frequency. Also, HPET is
                    more scalable than TSC in case of multi-node
                    systems. So, our timer priority is
                    platform_specific_timer(if any), timer_hpet
                    and timer_tsc in that order.
4/5 - hpet4.patch - Miscallaneous makefile and config changes
5/5 - hpet5.patch - This can be a standalone patch. Without this
                    patch we loose interrupt generation capability
                    of RTC (/dev/rtc), due to HPET. With this patch
                    we basically try to emulate RTC interrupt
                    functions in software using HPET counter 1.
                    This is only required to provide compatibility
                    to the applications that depend on rtc driver's
                    interrupt generation capability.
                    This emulation will not be as accurate as RTC
                    interrupt, as HPET is not tied to RTC hardware
                    and does not know anything about RTC time.
                    But should enough for compatibility purposes.

All comments/feedbacks welcome.

Thanks,
-Venkatesh


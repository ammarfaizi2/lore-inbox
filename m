Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263758AbTLEAHi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 19:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263760AbTLEAHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 19:07:38 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:35803 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S263758AbTLEAHe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 19:07:34 -0500
Date: Thu, 4 Dec 2003 16:07:07 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Jesse Allen <the3dfxdude@hotmail.com>
Cc: Allen Martin <AMartin@nvidia.com>, b@netzentry.com,
       linux-kernel@vger.kernel.org
Subject: OOps? was: NForce2 pseudoscience stability testing (2.6.0-test11)
Message-ID: <20031205000707.GH29119@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Jesse Allen <the3dfxdude@hotmail.com>,
	Allen Martin <AMartin@nvidia.com>, b@netzentry.com,
	linux-kernel@vger.kernel.org
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F874@mail-sc-6.nvidia.com> <20031204200415.GA183@tesore.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031204200415.GA183@tesore.local>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 01:04:15PM -0700, Jesse Allen wrote:
> The results (uniprocessor system):
> 1. under 2.6.0-test11 with nvidia ide, dma enabled, apic
> grep on IDE hard disk at UDMA 100 -- locks nearly immediately
> and later attempt, grep on cdrom -- doesn't lock up (still will lock up with 
> hard disk though)

OK, so now you can reproduce.  Let's get an oops out of you. :)

Documentation/nmi_watchdog.txt:

[NMI watchdog is available for x86 and x86-64 architectures]

Is your system locking up unpredictably? No keyboard activity, just
a frustrating complete hard lockup? Do you want to help us debugging
such lockups? If all yes then this document is definitely for you.

On many x86/x86-64 type hardware there is a feature that enables
us to generate 'watchdog NMI interrupts'.  (NMI: Non Maskable Interrupt
which get executed even if the system is otherwise locked up hard).
This can be used to debug hard kernel lockups.  By executing periodic
NMI interrupts, the kernel can monitor whether any CPU has locked up,
and print out debugging messages if so.  

In order to use the NMI watchdog, you need to have APIC support in your
kernel. For SMP kernels, APIC support gets compiled in automatically. For
UP, enable either CONFIG_X86_UP_APIC (Processor type and features -> Local
APIC support on uniprocessors) or CONFIG_X86_UP_IOAPIC (Processor type and
features -> IO-APIC support on uniprocessors) in your kernel config.
CONFIG_X86_UP_APIC is for uniprocessor machines without an IO-APIC.
CONFIG_X86_UP_IOAPIC is for uniprocessor with an IO-APIC. [Note: certain
kernel debugging options, such as Kernel Stack Meter or Kernel Tracer,
may implicitly disable the NMI watchdog.]

For x86-64, the needed APIC is always compiled in, and the NMI watchdog is
always enabled with I/O-APIC mode (nmi_watchdog=1). Currently, local APIC
mode (nmi_watchdog=2) does not work on x86-64.

Using local APIC (nmi_watchdog=2) needs the first performance register, so
you can't use it for other purposes (such as high precision performance
profiling.) However, at least oprofile and the perfctr driver disable the
local APIC NMI watchdog automatically.

To actually enable the NMI watchdog, use the 'nmi_watchdog=N' boot
parameter.  Eg. the relevant lilo.conf entry:

        append="nmi_watchdog=1"

For SMP machines and UP machines with an IO-APIC use nmi_watchdog=1.
For UP machines without an IO-APIC use nmi_watchdog=2, this only works
for some processor types.  If in doubt, boot with nmi_watchdog=1 and
check the NMI count in /proc/interrupts; if the count is zero then
reboot with nmi_watchdog=2 and check the NMI count.  If it is still
zero then log a problem, you probably have a processor that needs to be
added to the nmi code.

A 'lockup' is the following scenario: if any CPU in the system does not
execute the period local timer interrupt for more than 5 seconds, then
the NMI handler generates an oops and kills the process. This
'controlled crash' (and the resulting kernel messages) can be used to
debug the lockup. Thus whenever the lockup happens, wait 5 seconds and
the oops will show up automatically. If the kernel produces no messages
then the system has crashed so hard (eg. hardware-wise) that either it
cannot even accept NMI interrupts, or the crash has made the kernel
unable to print messages.

NOTE: starting with 2.4.2-ac18 the NMI-oopser is disabled by default,
you have to enable it with a boot time parameter.  Prior to 2.4.2-ac18
the NMI-oopser is enabled unconditionally on x86 SMP boxes.

[ feel free to send bug reports, suggestions and patches to
  Ingo Molnar <mingo@redhat.com> or the Linux SMP mailing
  list at <linux-smp@vger.kernel.org> ]


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264465AbTE1As6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 20:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264467AbTE1As6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 20:48:58 -0400
Received: from main.gmane.org ([80.91.224.249]:51130 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264465AbTE1As4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 20:48:56 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
Subject: local apic timer ints not working with vmware: nolocalapic arg?
Date: Tue, 27 May 2003 20:53:00 -0400
Message-ID: <pan.2003.05.28.00.52.56.796565@interlinx.bc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@main.gmane.org
User-Agent: Pan/0.14.0 (I'm Being Nibbled to Death by Cats!)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Using a distribution (Mandrake's Cooker) patched kernel, I am unable to
successfully boot at 2.4.20ish kernel on VMware 2.0.4 build 1142.  The
problem seems to be with using local apic timer interrupts.  The last few
lines of the boot sequence before the kernel hangs are (copied by hand, so
please excuse typos):

Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1658.7651 MHz.
..... host bus clock speed is 0.0000 MHz.
cpu: 0, clocks: 0, slice: 0

So, to successfully boot this kernel after hunting around, I changed:

int dont_use_local_apic_timer __initdata = 0;

to

int dont_use_local_apic_timer __initdata = 1;

in arch/i386/kernel/apic.c and it booted successfully.  I noticed a
comment right at the start of setup_APIC_clocks() to short-circuit out:

	/* Disabled by DMI scan or kernel option? */
	if (dont_use_local_apic_timer)
		return;

so I went to see if I could use the DMI scan to blacklist the VMware host
from trying to use local APIC timer interrupts.  Unfortunately,
dmi_iterate() does not find the _DMI_ signature anywhere between 0xF0000
and 0xFFFFF.

So on to the other aspect of the comment "...or kernel option", but there
is no option to disable the local APIC timer.  The "noapic" option appears
to disable the IO-APIC.

So is it wrong to have a kernel option to disable the local APIC timer
interrupts?  Or is there a better way than a kernel option?  I thought using the DMI
scan would have been great, if it worked so I am wondering if there is any
other way to get a signature on the host system and disable the local APIC
timer without the operator having to pass a command line option.

I do know that I could simply build a kernel with the CONFIG_X86_UP_APIC
to work around this problem, but that means a "special" kernel just for
VMware and also means not being able to use vendor supplied kernels, or
vendor supplied boot media (i.e. CD-ROMs).

It would be nicer to be able to disable this feature at run-time than
build-time.

Thots?

b.




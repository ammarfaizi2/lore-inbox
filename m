Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267654AbTAXNxQ>; Fri, 24 Jan 2003 08:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267655AbTAXNxQ>; Fri, 24 Jan 2003 08:53:16 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:28489 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S267654AbTAXNxO>; Fri, 24 Jan 2003 08:53:14 -0500
To: Michael Fu <michael.fu@linux.co.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] e100 driver fails to initialize the hardware after kernel bootup through kexec
References: <1042450072.1744.75.camel@aminoacin.sh.intel.com>
	<1043390954.892.10.camel@aminoacin.sh.intel.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 24 Jan 2003 07:01:56 -0700
In-Reply-To: <1043390954.892.10.camel@aminoacin.sh.intel.com>
Message-ID: <m18yxaeje3.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Fu <michael.fu@linux.co.intel.com> writes:

> After kernel was bootup through kexec command, the NIC failed to
> initialize. The 2.5.52 kernel was patched with kexec and kexec-hwfix
> patch.

Interesting...  The patch goes cleanly onto newer kernels so feel
free to play with them.  You are running a single cpu system
so the kexec-hwfix patch should not make a difference at this point.

Your interrupt routing is via ACPI interesting...

> 
> the following was is the dmesg output:

[snip]
> Intel(R) PRO/100 Network Driver - version 2.1.24-k2
> Copyright (c) 2002 Intel Corporation
> 
> 
> 
> 
> 
> 
> PCI: Enabling device 02:09.0 (0000 -> 0003)
> PCI: Setting latency timer of device 02:09.0 to 64
> e100: selftest timeout
> e100: Failed to initialize, instance #0

[snip]

> I doubt this is a bug in E100 actually.

Given that everything else was working correctly this is almost
certainly an e100 driver or a hardware bug.  On x86 everything has
been working well enough that finding something that is not a
hardware/driver bug as a failure case is currently quite a challenge.

Q1: Is this reproducible?
Q2: Is this reproducible with the eepro100 driver?

You were doing the easy case of 2.5.52 to 2.5.52 I have gotten so many 
false positives with things working when I reboot the exact same kernel
I barely consider it a valid test case any more...

If it is a bug in the driver a shutdown method can be used to clean up
before reboot to place the device is a quiescent state. 
Either that or the drivers initialization code can be enhanced to
handle more strange states.  

I know the eepro100 driver issues a reset before playing with the
card.  The e100 driver is doing this in a different order, and it is
dying before it resets the card so that looks like the issue to me.

Doing a clean user space shutdown may also help.  Though your kexecwrapper
script looked like it was probably doing that o.k.

Eric

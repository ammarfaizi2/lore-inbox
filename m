Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265248AbTLLPBZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 10:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265235AbTLLO7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 09:59:16 -0500
Received: from chaos.analogic.com ([204.178.40.224]:41345 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265238AbTLLO5n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 09:57:43 -0500
Date: Fri, 12 Dec 2003 09:59:37 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Dale Mellor <dale@dmellor.dabsol.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: floppy motor spins when floppy module not installed
In-Reply-To: <16345.51504.583427.499297@l.a>
Message-ID: <Pine.LNX.4.53.0312120935240.10423@chaos>
References: <16345.51504.583427.499297@l.a>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Dec 2003, Dale Mellor wrote:

> 1. Floppy motor spins when floppy module not installed.
>
> 2. From the moment of bootup, the floppy drive motor spins when the kernel is
>    compiled to use the floppy driver as a module and this is not installed (the
>    motor stops as soon as the module is installed).
>
> 3. Keywords: floppy, module, kernel, boot.
>

Kernel version 2.6.0-test11

[SNIPPED...]

This was reported a long time ago and there were some patches
around to fix it. I guess it didn't get into the "main-line",
perhaps because people don't think it's important.

Your temporary fix is to disable the "floppy-seek" on boot and
to change the boot-sequence so the floppy is not accessed on
boot (change the BIOS to boot C: before A:). That will "fix"
the problem for the moment.

The correct fix, that nobody wanted to do, is to reset the
motor control bit in the FDC motor control register upon
startup. This was previously shown and patches exist.

There were doom-sayers that claimed that the earth may stop
turning (or something like that) if this was done which is
probably why it didn't get fixed. If you are bold and want
to try again, somewhere convenient in
              ../linux-nn.nn/arch/i386/boot/setup.S
write a zero byte out port 0x3f2. This port is used only
for the FDC motor so it won't hurt if the controller's not
even there.

Something like:

--- setup.S.orig	Tue Oct  7 09:24:33 2003
+++ setup.S	Fri Dec 12 09:52:32 2003
@@ -777,6 +777,10 @@
 	movb	$0xFB, %al			# mask all irq's but irq2 which
 	outb	%al, $0x21			# is cascaded

+	movw	$0x3f2, %dx
+	xorb	%al, %al			# Turn OFF FDC motor
+	outb	%al, %dx
+
 # Well, that certainly wasn't fun :-(. Hopefully it works, and we don't
 # need no steenking BIOS anyway (except for the initial loading :-).
 # The BIOS-routine wants lots of unnecessary data, and it's less



Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.



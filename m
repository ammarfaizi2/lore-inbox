Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317056AbSHOOlr>; Thu, 15 Aug 2002 10:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317058AbSHOOlr>; Thu, 15 Aug 2002 10:41:47 -0400
Received: from avscan1.sentex.ca ([199.212.134.11]:11792 "EHLO
	avscan1.sentex.ca") by vger.kernel.org with ESMTP
	id <S317056AbSHOOlq>; Thu, 15 Aug 2002 10:41:46 -0400
Message-ID: <007101c2446a$bb20b420$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: <JosMHinkle@netscape.net>, <linux-kernel@vger.kernel.org>
References: <79B43166.1160898F.0BD32098@netscape.net>
Subject: Re: Linux kernel 2.4.19 failure to access a serial port
Date: Thu, 15 Aug 2002 10:47:51 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: <JosMHinkle@netscape.net>
> Slight expansion: A system with two serial ports on ttyS0 and ttyS1
> and a hardware modem on ttyS2 was not serviced properly in kernel
> 2.4.19 and some earlier ones.  The modem at ttyS2 was fairly well
> ignored.  The interrupt requests used were ttyS0:irq4 ttyS1:irq3
> ttyS2:irq10
>
> Temporary fix:
>    In drivers/char/serial.c at the directive "#ifdef CONFIG_PCI"
> the assumption is made that interrupt requests are shared and
> there are more than four serial ports.  That is not necessarily
> true, and the directives defeat the options set in configuration.
>    The solution here was to comment out #define CONFIG_SERIAL_SHARE_IRQ
> and CONFIG_SERIAL_MANY_PORTS and recompile.
>
> #ifdef CONFIG_PCI
> #define ENABLE_SERIAL_PCI
> /*** Commented out to allow unshared IRQ's on ttyS0-ttyS3
> #ifndef CONFIG_SERIAL_SHARE_IRQ
> #define CONFIG_SERIAL_SHARE_IRQ
> #endif
> #ifndef CONFIG_SERIAL_MANY_PORTS
> #define CONFIG_SERIAL_MANY_PORTS
> #endif
> ***/
> #endif

This fix breaks the driver in a fundamental way. SHARE_IRQ and
MANY_PORTS are turned on if CONFIG_PCI is on because a) pci drivers
*must* share interrrupts and b) generally serial ports that are behind
a pci bus are multiport boards.

The effect of MANY_PORTS is merely to increase the size of the static
array that holds the serial port state. Whether or not it is on should
not have affected your problem. (I believe the smallest size of the
array is 4, for ttyS0-3.)

SHARE_IRQ should also not have affected your problem, since your modem
is configured at irq 10, and you haven't mentioned that anything else
is also using irq 10. If turning off this option "fixes" your problem
then that should indicate that your setup isn't what you think it is;
either the modem isn't really at irq 10 (unclear from your previous
post, and my lack of isapnp knowledge) and/or something else is also
using the same irq your modem is on.

Please see my previous email, and try some of my suggestions. The one
about reserving the irq in bios for isa-only use is critical.

..Stu

--
We make multiport serial boards.
<http://www.connecttech.com>
(800) 426-8979



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVALUZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVALUZT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 15:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVALUYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 15:24:53 -0500
Received: from alog0297.analogic.com ([208.224.222.73]:15488 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261397AbVALURK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 15:17:10 -0500
Date: Wed, 12 Jan 2005 15:16:48 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Justin Piszcz <jpiszcz@lucidpixels.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Question regarding ERR in /proc/interrupts.
In-Reply-To: <Pine.LNX.4.61.0501121410360.11524@p500>
Message-ID: <Pine.LNX.4.61.0501121454510.11899@chaos.analogic.com>
References: <Pine.LNX.4.61.0501121410360.11524@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2005, Justin Piszcz wrote:

> Is there anyway to log each ERR to a file or way to find out what caused each 
> ERR?
>
> For example, I know this is the cause of a few of them:
> spurious 8259A interrupt: IRQ7.
>
> But not all 20, is there any available option to do this?
>
> $ cat /proc/interrupts
>           CPU0
>  0:  887759057          XT-PIC  timer
>  1:       3138          XT-PIC  i8042
>  2:          0          XT-PIC  cascade
>  5:       5811          XT-PIC  Crystal audio controller
>  9:  265081861          XT-PIC  ide4, eth1, eth2
> 10:    9087912          XT-PIC  ide6, ide7
> 11:     837707          XT-PIC  ide2, ide3
> 12:      13854          XT-PIC  i8042
> 14:   63373075          XT-PIC  eth0
> NMI:          0
> ERR:         20
>

I'm not sure you really want to do that! The ERR value is a
spurious interrupt total. You will never learn where
it comes from because it comes from nowhere, which is
why it is called "spurious". Spurious interrupts are
really caused by the CPU, not a particular interrupt
controller. When the INT line is raised, the hardware
is supposed to put an address on the bus so the CPU can
branch to the handler (via some indirection). The
INT pin to the CPU is supposed to be manipulated
by a controller, either the PIC or IO-APIC.

Suppose the controller didn't raise an interrupt, but
the CPU thought it did. In that case, when the CPU signals
the controller to output the vector, the controller says;
"Dohhh... WTF. It's not me...". But the CPU needs some
address to complete the cycle so the controller puts its
last, lowest priority, vector on the bus to complete the
cycle. The CPU branches to the code and the code checks
for a possible printer interrupt (IRQ7). If the printer
didn't signal, it used to write a nasty-gram to the log
before acknowledging the interrupt. Recent kernels only
write such once. However, the number of such instances
are totaled for your review. If you have a lot of them,
it generally means you have:

(1) Too much crosstalk on the motherboard.
(2) Power supplies out of specification.
(3) Too hot so timing gets skewed.
(4) Etc.

It's NEVER the interrupt controller! NEVER. The Spurious
interrupt proves that the controller did its job by completing
the hardware handshake with the CPU. Don't kill the messenger.
It's just doing its job!

FYI 20 spurious interrupts out of the bazzillion shown isn't
too bad. It shows that your hardware isn't perfect.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.

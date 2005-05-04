Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbVEDBvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbVEDBvj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 21:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVEDBvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 21:51:39 -0400
Received: from [81.2.110.250] ([81.2.110.250]:22409 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261972AbVEDBvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 21:51:36 -0400
Subject: Re: tricky challenge for getting round level-driven interrupt
	problem: help!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux ARM Kernel list 
	<linux-arm-kernel@lists.arm.linux.org.uk>
In-Reply-To: <20050503215634.GH8079@lkcl.net>
References: <20050503215634.GH8079@lkcl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1115171395.14869.147.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 04 May 2005 02:50:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-05-03 at 22:56, Luke Kenneth Casson Leighton wrote:
> it only does level-based interrupts and i need to create a driver
> that does two-way 8-bit data communication.

Level triggered is generally considered a feature by people less than
200 years old 8)

> i would genuinely appreciate some advice from people with
> more experience than i on how to go about getting round
> this stupid hardware design - in order to make a RELIABLE,
> non-race-conditioned kernel driver.

Assuming you are using the core Linux IRQ code then you shouldn't have
any great problem. The basic rules with level triggered IRQ are that 

- You must ack the IRQ on the device to clear it either specifically or
as part of some other process.
- The device must raise the IRQ again if the irq condition is present
*at* or after the point of the IRQ ack (or in many implementations 'just
before' in fact)

the core Linux code deals with masking on the controller to ensure IRQ's
dont get called recursively, and ensuring an IRQ gets rechecked/recalled
on the unmask/exit path if it is still asserted.

So an implementation is much like a serial port fifo, assert the IRQ
until the PC has fetched all the bits. In fact the IRQ line is
essentially "NOT(fifo_empty)" and rechecked each time a byte is fetched.

*WAY* simpler than nasty edge triggered stuff 8)

Alan


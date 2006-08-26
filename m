Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWHZTfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWHZTfR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 15:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWHZTfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 15:35:16 -0400
Received: from science.horizon.com ([192.35.100.1]:7476 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750735AbWHZTfO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 15:35:14 -0400
Date: 26 Aug 2006 15:35:13 -0400
Message-ID: <20060826193513.27481.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: Serial custom speed deprecated?
Cc: stuartm@connecttech.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also, Oxford's 16PCI95x family has three different points of altering
> the clock; the clock prescaler, the actual sample rate (which is the
> classic /16 that most are used to), and the actual divisor. That can
> produce pretty much any baud rate, albeit with some error.

Their data sheet doesn't explain it too well, but it looks like they
use a similar implementation to the MSP430 UARTs, which are designed
to work with very low clock rates.  (32768 Hz watch crystals are
popular.)

Just as a reminder, UART receive operation is generally:
- After detecting a falling edge, wait half a bit time.
- Sample the input 3x and majority-vote.  If the input
  line is still low, call this a start bit and prepare to
  receive a character.
- Wait one bit time, sample 3x, and call the majority the start bit.
- Repeat for all data bits and the stop bit.  If the stop bit isn't
  1 as expected, note a framing error.

This is traditionally done by running a 16x clock sampling the
input, and after detecting a start bit on one clock (call that
clock 0), sample the start bit on clocks 7, 8 and 9, the first bit
on clocks 23, 24 and 25, etc.

MSP430 UARTs have a fully programmable clocks/bit number (no fixed /16,
although you want a few clocks per bit so the standard "sample 3x and
majority vote" algorithm works), and can add +1 clock to individual
bit times to approximate a desired baud rate more closely by dithering.
Oh, and they use both edges of the clock.

So it can go to a baud rate 1/3 of the input baud clock (sample the
start bit at 1, 1.5 and 2 clocks, then the first bit at 4, 4.5 and 5,
etc.), and proceed to 9/24, 10/24, etc.

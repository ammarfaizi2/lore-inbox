Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWAJPbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWAJPbV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 10:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWAJPbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 10:31:21 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:46226
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932178AbWAJPbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 10:31:20 -0500
Message-ID: <43C3D350.6070003@microgate.com>
Date: Tue, 10 Jan 2006 09:31:28 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Burkhard_Sch=F6lpen?= <bschoelpen@web.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI DMA Interrupt latency
References: <419982528@web.de>
In-Reply-To: <419982528@web.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Burkhard Schölpen wrote:
> The issue seems to be something like interrupt 
> latency in hardware. Measuring some signals with an 
> oscilloscope shows, that the delay from generating the 
> interrupt, which signals a finished transfer, to the time 
> when the interrupt register on the card is reset (i.e. the 
> beginning of the ISR) sometimes increases to more 
> than 500 microseconds, which is dimensions too high. 
> 
> ... Another consideration is, that 
> another driver could lock all interrupts for too long (but for 
> 500 us??).  

I also have implemented bus master devices based
on the Spartan 2 + Xilinx PCI core and wrote the
associated Linux driver.

My observations of interrupt latency using
a similar setup to what you describe showed
50usec is common but rare events on
the order of milliseconds are possible.
You are probably correct that the
problem as a poorly behaved driver.

If you have complete control over every system
your device is installed in, you can
find and eliminate any device that
causes high interrupt latency.

If you don't have that control, your hardware
needs to tolerate interrupt latency of
that magnitude.

You describe an implementation with a single
DMA buffer. You could switch to multiple
buffers (ring structure or 2 alternating buffers)
with an interrupt triggered after each
buffer is exhausted (I use a ring of buffers).
The remaining buffers allow the transfer to
continue while waiting for ISR execution.

Or, more crudely, trigger the interrupt when
the single buffer reaches some low water mark
and poll in the ISR for actual completion.

-- 
Paul Fulghum
Microgate Systems, Ltd.

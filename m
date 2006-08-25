Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422680AbWHYPFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422680AbWHYPFU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 11:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422673AbWHYPFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 11:05:20 -0400
Received: from ptb-relay02.plus.net ([212.159.14.213]:51943 "EHLO
	ptb-relay02.plus.net") by vger.kernel.org with ESMTP
	id S1422680AbWHYPFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 11:05:18 -0400
Message-ID: <44EF11A9.7050000@mauve.plus.com>
Date: Fri, 25 Aug 2006 16:05:13 +0100
From: Ian Stirling <ian.stirling@mauve.plus.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Maximus <john.maximus@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: SDIO drivers?
References: <3634de740608250226r37f75230t2a1c39d3307fb044@mail.gmail.com>
In-Reply-To: <3634de740608250226r37f75230t2a1c39d3307fb044@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maximus wrote:
> Hi,
>   Just going through the linux kernel sources which has support  for
> SD and MMC.
> 
>   Wondering whats the difference between SD and SDIO.
> 
>   What is meant by SDIO ?.  (SD + IO) ?.
> 
>   what  is meant  by  IO part?.
> 
> Are any SDIO drivers open source?.

I found the PDF at 
http://www.windowsfordevices.com/articles/AT3451543568.html of great use 
for understanding the differences.

Basically - SD and MMC are not really 'normal' memory - due to their 
connection, they act more like USB, or even network attached stuff.

At the top level that you'd want to present to the user, you've got the 
logical SD and SDIO device.
This can be one of 8 functions in a SD/SDIO card.
A SDIO card is a SD-I/O card - it does input or output. An SD card is 
just memory, with some area that may be encrypted - see the S of SD.

Now, there are many ways to connect to an SD(I'll omit the I/O from here 
in). First, you've got the 'low speed' 400kbps serial mode - that is 
common to MMC and SD, now you've got 20Mhz 1 bit serial that is SDs base 
  mode, and 4 bit 25Mhz that's the faster mode - there may have been 
faster clocks released since the above doc - I haven't checkes.

Each card can now either be connected directly to the controller, or it 
can be connected to a bus, sharing access between cards. This mode is of 
course slower, and can slow all devices on the bus to the speed of the 
slowest, and is hard to do well.

This is not a 'traditional' memory/IO device, it's more like USB, or IO 
across the network.
For example, a single 8 byte write to a configuration register takes 
about 64 clocks, which can be many tens of microseconds. In the slowest 
mode, you can't even reliably run a 16550 (which is what one of the 
standard class drivers - GPS - is defined as, a 16550 in register space) 
at the highest baud rates, without losing chars.

So - briefly, an SD card can have up to 8 functions, with varying 
bandwidth back to the host, depending on card and connection from a 
shared 32KiB/s to unshared 25MiB/s. The controller can vary from 
_really_ dumb - practically bit-banging, to one that does scatter-gather 
  DMA, and much of the protocol work for you.
AIUI, all of the controllers available do not expose the device as a 
'simple' register/memory interface, but as a message passing interface - 
with the exception of DMA.

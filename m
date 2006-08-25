Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422893AbWHYUa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422893AbWHYUa4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 16:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422895AbWHYUa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 16:30:56 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:58857 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1422893AbWHYUaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 16:30:55 -0400
Date: Fri, 25 Aug 2006 16:30:47 -0400
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Len Sorensen <lsorense@csclub.uwaterloo.ca>
Subject: Strange transmit corruption in jsm driver on geode sc1200 system
Message-ID: <20060825203047.GH13641@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am seeing a very strange problem with the jsm driver.

I am using a Digi Neo 2 DB9 card on a system with a Geode SC1200 cpu.
This is essentially an EXAR XC17D152 chip rebranded for Digi.

Kernel is based on debian's 2.6.16-17 which is 2.6.16.25 with a few
patches.

When I use minicom to transmit a chunk of text by sending a text file,
the data is transmitted in the wrong order.

testfile:
0123456789ABCDEF

Received text:
123056749AB8DEFC

If I use the same driver and the same card on a P4 system, everything
works fine.

The driver is doing memcpy_toio to tranfer data to the transmit FIFO
(which is a 64byte memory mapped block of memory on the PCI bus as far
as I can tell).  The data in the transmit queue is in the right order
being passed to memcpy_toio, but somehow by the time it is in the uart
and goes out the transmiter, every 4th byte is moved 3 bytes back.
Transmitting a single character at a time works fine of course since
there is nothing to swap it around with, and it is only copying a single
byte to the UART rather than a block of bytes.

I read something about the geodes doing memory write reordering, but
that it is supposed to magically not screw up PCI writes.  I have no
idea if it is or not though.

I have no problem with pcnet32 or any of the other PCI devices I use.

Does anyone have any suggestions for something to try?

The cpu in question has this information:
processor       : 0
vendor_id       : CyrixInstead
cpu family      : 5
model           : 9
model name      : Unknown
stepping        : 1
cpu MHz         : 266.760
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu tsc msr cx8 cmov mmx cxmmx
bogomips        : 535.33

I noticed that cyrix.c has some code for controlling reordering and
such, although it doesn't seem to match this particular cpu's ID, so it
isn't called.  I have no idea if it should have.

--
Len Sorensen

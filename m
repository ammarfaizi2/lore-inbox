Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129230AbRBTPuI>; Tue, 20 Feb 2001 10:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129350AbRBTPt6>; Tue, 20 Feb 2001 10:49:58 -0500
Received: from chaos.analogic.com ([204.178.40.224]:39555 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129230AbRBTPtq>; Tue, 20 Feb 2001 10:49:46 -0500
Date: Tue, 20 Feb 2001 10:49:14 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Probem with network performance 2.4.1
Message-ID: <Pine.LNX.3.95.1010220104511.29891A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Given the following topography:
       ____________
       |          |
       |  VXI RAM |
       |__________|
            |                    ---------------
     |------|-----|              | Ethernet    |
     | VXI bridge |              | AMD PcNet32 |
     |____________|              |_____________|
           |                            |
     ======|========== PCI BUS =========|=============
           |
     ______|_______
     |            |
     | PCI bridge |
     |____________|
           |
     ______|_______        ----------
     |            |        |        |
     |  CPU stuff |--------|   RAM  |
     |____________|        |________|


Problem:

Data transfer across the network sucks (18 - 20 kilobytes / second)
Symptoms:

(1) Data transfer from VXI RAM to RAM is about 18 megabytes per second
    (good).
(2) Data transfer from RAM to Ethernet host is about 9 megabytes per second
    (good).
(3) Data transfer from VXI RAM to Ethernet host is 18-20 kilobytes per second
    (awful).

A server exists in user space which reads data from VXI RAM to local
memory. This read occurs at about 18 megabytes per second. This is
fine and corresponds to the Bridge Chip specs within a few percent.

The data being read, is sent via socket to the host. If the data was
not read from VXI RAM first, but was just stale buffered data, the
transfer rate is about 9 megabytes per second. This is very good for
this chip. The CPU clock-rate is only 133 MHz.

When the data is read from VXI RAM, buffered locally, then sent
to the host, the transfer rate becomes horrible, 18-20 kilobytes
per second. The Ethernet packets are delayed and occur at a
100 Hz rate, one packet per context-switch.

There is nothing in either the VXI/Bus driver or the the Ethernet
driver that gives up the CPU, i.e., nobody calls schedule() in any
(known) path.

The transfer from the VXI bridge entails two ioctl() calls prior to
a read().  If I comment out the ioctl() calls, the data transfer
becomes acceptable at 5 megabytes/second. These ioctl() calls are
essential because they define the type of VME/Bus transfer, i.e.,
16/24/32 bit address space. However, for performance testing, I
hard-code 32 bit address space. These ioctl() functions are not
CPU intensive, they put a single longword into a memory-mapped
register and return.

So, is there something in the kernel that gets executed during
a user's ioctl() call, that gives away the CPU?. Or is there
something else that's screwing up the transfer rate?

Other info. Both the Ethernet chip and the VXI/Bus bridge are
bus masters. Fast back-to-back is enabled and posted writes
are enabled also. The PCI bus looks clean with no retries.
However, the PCI bus activity occurs at 100 Hz intervals.

Normally, I transfer 32k data buffers.

If I chop up the size of the data buffers being transferred to
1460 bytes (to fit in a single Ethernet packet), all of this
100 Hz chop-up goes away and the data 'streams'. However, the
increased overhead makes the data-transfer rate only 1 megabyte
per second which doesn't meet our spec.

There is something that's wasting a lot of CPU time that I
need. Also, all other tasks are sleeping during the data
transfer. Nothing is computable so, even if a schedule is
occurring, there should not be the observed CPU cycle loss.

This is Linux 2.4.1
 

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.



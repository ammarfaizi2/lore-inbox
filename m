Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270029AbUJNKgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270029AbUJNKgi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 06:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270028AbUJNKgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 06:36:37 -0400
Received: from zone3.gcu-squad.org ([217.19.50.74]:38920 "EHLO
	zone3.gcu-squad.org") by vger.kernel.org with ESMTP id S270024AbUJNKfo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 06:35:44 -0400
Date: Thu, 14 Oct 2004 12:31:26 +0200 (CEST)
To: greg@kroah.com
Subject: [RFC] SMBus multiplexing for the Tyan S4882
X-IlohaMail-Blah: khali@gcu.info
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <K2nOCbfL.1097749885.3147790.khali@gcu.info>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Greg, all,

A couple weeks ago, I started working on hardware monitoring support for
the Tyan S4882 4-CPU motherboard [1]. The board features an AMD-8111
dual SMBus adapter. All hardware monitoring devices are located on the
first (SMBus 1.0) adapter, which the i2c-amd756 driver supports (both in
the lm_sensors project for Linux 2.4 and in Linux 2.6).

The particularity of the board is that the SMBus is multiplexed using 3
Philips chips: one PCA9556 (8-way I/O, [2]) for control and two PCA9516
(5-way I2C mux, [3]). I2C bus multiplexing at the i2c core level was
discussed before [4], but nothing was ever integrated. I also did write
a stand-alone driver for the Philips PCA9540 (3-way I2C mux) some times
ago but this approach is neither convenient (the user has to manually
switch the mux, only one channel is visible at a given time) nor safe
(no lock, breaks client buffers).

This time, I tried a different approach. I integrated the multiplexing
into the bus driver (i2c-amd756). I do think it is the correct way,
since it isn't too complex (and doesn't affect the i2c subsystem
core), while still safe and transparent to both the user-space and the
i2c clients. The drawback is that the added code is highly
board-specific. I yet have to see a different, working approach with
less board-specific code though.

A patch against lm_sensors CVS can be seen here:
http://khali.linux-fr.org/devel/i2c/lm_sensors-CVS-S4882.patch
This is for Linux 2.4 but I plan to port it to 2.6 soon, which is why I
am requesting for comments on the LKML.

Here is a summary of what the code does:
1* Detect the S4882 systems, using the PCI subvendor and subdevice of the
SMBus device.
2* Dynamically allocate and fill 4 i2c_adapter structures and the 4
associated i2c_algorithm structures (one adapter+algorthm per CPU). Also
alter the main adapter's algorithm structure to point to a slightly
modified smbus_xfer function.
3* Register the mux chip (I2C address 0x18) as an i2c_client so that
nobody else will request it. I do not otherwise use the client, since I
can send SMBus transfer commands directly.
4* Clean everything up on unload, of course.

The new SMBus access functions are simple wrappers which change the mux
configuration and call the main access function. I refactored the code
wherever possible. The wrappers for "virtual" busses will also only
accept mux'd addresses, while the wrapper for the main bus will accept
only non-mux'd addresses. Note that doing this required specific
knowledge about the S4882 (you need to know which addresses can be
multiplexed).

Since the monitoring devices (LM63) are located on 4 mux'd busses and
the memory module EEPROMS are located on 4 other mux'd busses at
different addresses, I chose to merge the channels on a per-CPU basis.
This has the advantage of lowering the overhead, reducing the mux
switching and being overall more user-friendly. Note that doing this
required specific knowledge about the S4882 (you need to know which
channels can/should be merged). In particular, there is no way to guess
which pair of channels corresponds to any given CPU.

The driver also remembers the last mux combination used and only send a
mux switch command when this is really needed. This significantly lowers
the SMBus use overhead.

Since this adds a significant amount of code to the driver, I made the
S4882 support selectable as a configuration option.

Expected Objections & Answers:

O: The PCA9556 support could be moved to a separate driver.
A: I don't see no benefit. There is very little code for the PCA9556
driver among the code I added, and I believe that calling a PCA9556
interface would represent no less code. There is not much code to reuse
anyway, since the way the PCA9556 driver is used is specific to each
board. It could even be used for something compeletly different than
SMBus multiplexing, since it is a simple 8 channel I/O chip.

O: The specific S4882 support could be moved to a completely different
driver.
A: This would duplicate most of the i2c-amd756 driver code. The
additional support will not affect non-S4882 users except for the size
of the driver. People concerned about the size can recompile the driver
without the S4882 support.

Before I commit my changes to the lm_sensors CVS and port them to the
Linux 2.6 driver, I welcome constructive comments about my work.

Thanks,
Jean Delvare

[1] http://www.tyan.com/products/html/thunderk8qspro.html
[2] http://www.semiconductors.philips.com/pip/PCA9556PW.html
[3] http://www.semiconductors.philips.com/pip/PCA9516.html
[4] http://archives.andrew.net.au/lm-sensors/msg05047.html
    http://archives.andrew.net.au/lm-sensors/msg23149.html
    http://archives.andrew.net.au/lm-sensors/msg27255.html

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274496AbRIYFR4>; Tue, 25 Sep 2001 01:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274497AbRIYFRq>; Tue, 25 Sep 2001 01:17:46 -0400
Received: from adsl-66-121-5-226.dsl.snfc21.pacbell.net ([66.121.5.226]:9284
	"HELO switchmanagement.com") by vger.kernel.org with SMTP
	id <S274496AbRIYFRc>; Tue, 25 Sep 2001 01:17:32 -0400
Message-ID: <3BB01380.9070502@switchmanagement.com>
Date: Mon, 24 Sep 2001 22:17:52 -0700
From: Brian Strand <bstrand@switchmanagement.com>
Organization: Switch Management
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 3c59x + dpti2o problem with interrupt sharing?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We just got a new dual AMD box with an Adaptec IDE RAID card and a dual 
3com NIC on the motherboard, running stock suse 7.2 kernel 2.4.4-Suse. 
 All was well for a few days, but when the box was doing some moderate 
Oracle work involving the 3com and the raid card, the box fell off the 
network, and /var/log/messages was suddenly flooded with the following:

Sep 22 14:25:34 db001 kernel: eth0: Host error, FIFO diagnostic register 
0000.
Sep 22 14:25:34 db001 kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
Sep 22 14:25:34 db001 kernel: eth0: PCI bus error, bus status 800000a0
Sep 22 14:25:34 db001 kernel: scsi0: Data Parity Error Detected during 
address or write data phase
Sep 22 14:25:34 db001 kernel: eth0: using NWAY device table, not 8
Sep 22 14:25:34 db001 kernel: scsi1: PCI error Interrupt at seqaddr = 0x8
Sep 22 14:25:34 db001 kernel: scsi1: Data Parity Error Detected during 
address or write data phase
Sep 22 14:25:34 db001 kernel: eth0: Host error, FIFO diagnostic register 
0000.
Sep 22 14:25:34 db001 kernel: eth0: PCI bus error, bus status 80000020
Sep 22 14:25:34 db001 kernel: eth0: using NWAY device table, not 8
Sep 22 14:25:35 db001 kernel: eth0: Host error, FIFO diagnostic register 
0000.
Sep 22 14:25:35 db001 kernel: eth0: PCI bus error, bus status 80000020
Sep 22 14:25:35 db001 kernel: eth0: using NWAY device table, not 8

And the last 3 lines repeat for roughly 300000 lines.  Stripping the 
timestamps and doing an egrep 'eth|scsi' /var/log/messages | sort | 
 uniq of those lines, I got:

NETDEV WATCHDOG: eth0: transmit timed out
eth0: 3Com PCI 3c980 10/100 Base-TX NIC(Python-T) at 0x1400,  00:e0:81
eth0: 3Com PCI 3c980 10/100 Base-TX NIC(Python-T) at 0x1c00,  00:e0:81
eth0: Host error, FIFO diagnostic register 0000.
eth0: Interrupt posted but not delivered -- IRQ blocked by another dev
eth0: PCI bus error, bus status 80000020
eth0: PCI bus error, bus status 800000a0
eth0: Resetting the Tx ring pointer.
eth0: Too much work in interrupt, status e003.
eth0: transmit timed out, tx_status 00 status 7003.
eth0: transmit timed out, tx_status 00 status 7043.
eth0: using NWAY device table, not 8
scsi0: Data Parity Error Detected during address or write data phase
scsi0: PCI error Interrupt at seqaddr = 0x8
scsi1: Data Parity Error Detected during address or write data phase
scsi1: PCI error Interrupt at seqaddr = 0x8

Looking in /proc/interrupts, I noticed that eth0 and dpti were sharing 
an IRQ.  Is this the likely cause of the network failure, and if so, 
does anyone know of a way to get the PCI BIOS to assign separate IRQs to 
the RAID card and the dual 3com?  (I have a Tyan S2462 Thunder K7 board 
with nothing in the manual about this.)  I have disabled onboard SCSI 
(dual AIC7xxx), serial, and parallel as well as pulled the RAID card 
from the machine and power-cycled a few times, but when I put it back 
in, it's sharing an IRQ with the 3com again (I suppose I should try 
disabling/enabling the 3coms too).

A related question is:  should these drivers be able to share IRQs, i.e. 
is it a worthwhile goal to have them operate reliably while sharing 
IRQs, or is IRQ-sharing a performance loss and something to be avoided?

Thanks,
Brian Strand



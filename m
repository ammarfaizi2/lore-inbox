Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262625AbVAPWOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbVAPWOg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 17:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbVAPWOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 17:14:36 -0500
Received: from innocence.nightwish.hu ([217.20.130.196]:29314 "EHLO
	innocence.nightwish.hu") by vger.kernel.org with ESMTP
	id S262625AbVAPWOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 17:14:21 -0500
Subject: the famous Tyan S2885 PCI IDE problem, additional experiences
From: Pallai Roland <dap@mail.index.hu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 16 Jan 2005 23:14:18 +0100
Message-Id: <1105913658.3155.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 I've read a thread about Tyan S2885 IDE problems
(http://www.ussg.iu.edu/hypermail/linux/kernel/0412.3/0457.html),
unfortunately I suffered from it too, but in a different hardware setup
and I noticed some more details about it, I hope this may help somehow.

 My config is a Tyan Thunder K8W (S2885) dual Operon244 with 5 HighPoint
1820 PCI-X sata controllers and 44/4 SATA/UATA drives, and I get daily
2-3 messages like this, sometimes followed by a lockup:

Jan 12 09:16:45 EverDream kernel: IAL: COMPLETION ERROR, adapter 2, channel 5, flags=101
Jan 12 09:16:45 EverDream kernel: Retry on channel(5)
Jan 12 11:05:52 EverDream kernel: IAL: COMPLETION ERROR, adapter 1, channel 7, flags=101
Jan 12 11:05:52 EverDream kernel: IAL: COMPLETION ERROR, adapter 2, channel 7, flags=101
Jan 12 11:05:52 EverDream kernel: Retry on channel(7)
Jan 12 11:05:52 EverDream kernel: Retry on channel(7)

 The channel number is changing randomly, disks are on different power
supplies, and never reported errors before this Tyan board for months.
I'm sure they are OK. This is a general message for irq timeouts, etc,
if I understood correctly from the sources. This 'hptmv' driver only use
SCSI layer and maybe this means that it's not an IDE core bug.
 Interesting that only 2 controllers report errors, both of them are on
the PCI bus 2 (called PCI-X BUS A by the manual) where the BCM gbit
controller is sitting too. It is interesting too, that the BCM reports
TX timeouts (1-2 on a week), sometimes within a couple of seconds with
the HPT controllers like here:

Jan 14 08:15:43 EverDream kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jan 14 08:15:43 EverDream kernel: tg3: eth0: transmit timed out, resetting
Jan 14 08:15:43 EverDream kernel: tg3: tg3_stop_block timed out, ofs=3400 enable_bit=2
Jan 14 08:15:43 EverDream kernel: tg3: tg3_stop_block timed out, ofs=2400 enable_bit=2
Jan 14 08:15:43 EverDream kernel: tg3: tg3_stop_block timed out, ofs=1800 enable_bit=2
Jan 14 08:15:43 EverDream kernel: tg3: tg3_stop_block timed out, ofs=4800 enable_bit=2
Jan 14 08:15:43 EverDream kernel: tg3: eth0: Link is down.
Jan 14 08:15:46 EverDream kernel: tg3: eth0: Link is up at 1000 Mbps, full duplex.
Jan 14 08:15:46 EverDream kernel: tg3: eth0: Flow control is off for TX and off for RX.
Jan 14 08:15:49 EverDream kernel: IAL: COMPLETION ERROR, adapter 2, channel 5, flags=101
Jan 14 08:15:49 EverDream kernel: Retry on channel(5)
Jan 14 08:15:49 EverDream kernel: IAL: COMPLETION ERROR, adapter 2, channel 2, flags=101
Jan 14 08:15:50 EverDream kernel: Retry on channel(2)
Jan 14 08:15:50 EverDream kernel: IAL: COMPLETION ERROR, adapter 2, channel 4, flags=101
Jan 14 08:15:50 EverDream kernel: Retry on channel(4)

Maybe this tells that it is not even a block device problem but a
general problem with PCI IRQ routing..? I'm running kernel 2.6.9 and
hasn't tried "noapic" yet..


I don't know it helps or not, if not, sorry for the posting.


pieces from lspci:
0000:00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03)
0000:01:03.0 SCSI storage controller: Marvell Technology Group Ltd. MV88SX5081 8-port SATA I PCI-X Controller
0000:01:06.0 SCSI storage controller: Marvell Technology Group Ltd. MV88SX5081 8-port SATA I PCI-X Controller
0000:02:07.0 SCSI storage controller: Marvell Technology Group Ltd. MV88SX5081 8-port SATA I PCI-X Controller
0000:02:08.0 SCSI storage controller: Marvell Technology Group Ltd. MV88SX5081 8-port SATA I PCI-X Controller
0000:02:09.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5703X Gigabit Ethernet (rev 02)
0000:03:0a.0 SCSI storage controller: Marvell Technology Group Ltd. MV88SX5081 8-port SATA I PCI-X Controller
0000:03:0b.0 Unknown mass storage controller: Silicon Image, Inc. (formerly CMD Technology Inc) SiI 3114 [SATALink/SATARaid] Serial ATA Controller (rev 02)

/proc/interrupts (after a reboot, before the first sata/bcm error):
           CPU0       CPU1       
  0:     604097   10593099    IO-APIC-edge  timer
  1:          9       2674    IO-APIC-edge  i8042
  8:          0          4    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 14:      38737     585475    IO-APIC-edge  ide0
 15:      26636     426430    IO-APIC-edge  ide1
169:    4899544  143165201   IO-APIC-level  eth0
177:     176128    2812539   IO-APIC-level  hptmv
185:     335350    4787773   IO-APIC-level  hptmv
193:     490780    7767863   IO-APIC-level  hptmv
201:     131115    2117348   IO-APIC-level  hptmv
209:      47463     738712   IO-APIC-level  hptmv
217:      31527     477959   IO-APIC-level  libata
225:          0          0   IO-APIC-level  ohci_hcd, ohci_hcd
NMI:       4549       6999 
LOC:   11193412   11194887 
ERR:          0
MIS:          0


--
 dap


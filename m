Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130962AbRCJI1E>; Sat, 10 Mar 2001 03:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130964AbRCJI0y>; Sat, 10 Mar 2001 03:26:54 -0500
Received: from f3.law3.hotmail.com ([209.185.241.3]:4362 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S130962AbRCJI0q>;
	Sat, 10 Mar 2001 03:26:46 -0500
X-Originating-IP: [65.25.188.54]
From: "John William" <jw2357@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: HP Vectra XU 5/90 interrupt problems
Date: Sat, 10 Mar 2001 08:26:00 
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F30apMHi0SYNIPukg3n000033a8@hotmail.com>
X-OriginalArrivalTime: 10 Mar 2001 08:26:00.0592 (UTC) FILETIME=[BD077100:01C0A93B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having a problem with kernel 2.4.2-SMP on my HP Vectra XU 5/90. This is 
an old dual-pentium (Neptune chipset) machine.

The machine has an on-board SCSI and ethernet controller, and I have added a 
Netgear FA310TX card. Due to the "unique" design of the motherboard, all the 
PCI slots share an interrupt with the SCSI controller.

I have narrowed the problem down to the fact that the kernel is assigning 
the PCI devices edge-triggered interrupts (IO-APIC-edge) instead of level 
(IO-APIC-level). This causes the SCSI controller to hang if there is any 
network activity during disk activity.

The machine identifies itself as an MPC type #5 machine (ISA/PCI), but it 
seems to have EISA-style ELCR configuration information. If I hack mpparse.c 
to force my machine type to #6 (EISA), the PCI interrupts are correctly 
identified as level triggered.

Could someone please help me develop a correct workaround for this problem? 
I have been thinking about the following options:

If there is no MP-table interrupt configuration information for an ISA/PCI 
system, try falling back to ELCR information before giving up and using a 
standard "ISA" scheme? It seems that HP may have done this on several of 
their early SMP systems.

OR

If PCI interrupts are shared, force them to be level triggered? Can shared 
PCI interrupts be edge triggered? If not, then wouldn't this be the correct 
solution? This isn't specific to the Vectra, but could possibly prevent 
problems on any machine with a broken BIOS?

"/proc/interrupts" on the hacked kernel looks like:

           CPU0       CPU1
  0:     411243     337583    IO-APIC-edge  timer
  1:       1095       1260    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:        603        116    IO-APIC-edge  serial
  5:      21400      20657    IO-APIC-edge  soundblaster
  8:          0          2    IO-APIC-edge  rtc
  9:       3398       3158   IO-APIC-level  PCnet/PCI 79C970
10:     504852     505145   IO-APIC-level  tmscsim, eth1
NMI:     749766     749768
LOC:     748736     748797
ERR:          0

I can post the dmesg output, if that would help.

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com


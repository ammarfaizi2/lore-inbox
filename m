Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265759AbTGCKBW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 06:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265797AbTGCKBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 06:01:22 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:10957 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265759AbTGCKBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 06:01:11 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.5.74: ALSA lockups, and ACPI, IRQ routing
Date: Thu, 3 Jul 2003 04:22:55 -0400
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307030422.55210.ivg2@cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I've reported several times to LKML, I'm experiencing annoying ALSA lockups 
when using multimedia programs like xmms, xine, and mplayer.
My problem wasn't fixed in the last 4-5 kernels or so but I managed to figure 
out a workaround. When booting with acpi=off, the lockups are gone.

Why?
Here's some info....
==========================================
ALSA errors with DEBUG on memory allocation, and verbose prink:

ALSA sound/core/pcm_lib.c:215: Unexpected hw_pointer value (stream = 0, delta: 
-6488, max jitter = 8192): wrong interrupt acknowledge?
ALSA sound/pci/via82xx.c:687: invalid via82xx_cur_ptr, using last valid pointe

ALSA sound/core/pcm_native.c:1263: playback drain error (DMA or IRQ trouble?)
ALSA sound/pci/via82xx.c:687: invalid via82xx_cur_ptr, using last valid 
pointer

mplayer: 
ALSA lib pcm_hw.c:524:(snd_pcm_hw_drain) SNDRV_PCM_IOCTL_DRAIN failed: 
Input/output error
alsa-pause: pcm drain error: Input/output error


========================================
IRQ related ACPI messages/errors:

ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [ALKA] (IRQs 20, disabled)
ACPI: PCI Interrupt Link [ALKB] (IRQs 21, disabled)
ACPI: PCI Interrupt Link [ALKC] (IRQs 22, disabled)
ACPI: PCI Interrupt Link [ALKD] (IRQs 23, disabled)

ACPI: No IRQ known for interrupt pin A of device 0000:00:10.0
ACPI: No IRQ known for interrupt pin B of device 0000:00:10.1
ACPI: No IRQ known for interrupt pin C of device 0000:00:10.2
ACPI: No IRQ known for interrupt pin D of device 0000:00:10.3
ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1 - using IRQ 255
ACPI: No IRQ known for interrupt pin C of device 0000:00:11.5

0000:00:11.5 is my sound device (VIA 8233)

=======================================
/proc/interrupts under 2.5.74 with ACPI (init level 5):
           CPU0       
  0:     183866    IO-APIC-edge  timer
  1:        336    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  3:          0    IO-APIC-edge  uhci-hcd
  7:          0    IO-APIC-edge  uhci-hcd
  8:          1    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 10:          0    IO-APIC-edge  ehci_hcd
 11:          0    IO-APIC-edge  uhci-hcd, VIA8233
 12:       3433    IO-APIC-edge  i8042
 14:      17003    IO-APIC-edge  ide0
 15:         10    IO-APIC-edge  ide1
 16:       8167   IO-APIC-level  nvidia
 18:         32   IO-APIC-level  eth1
 19:        723   IO-APIC-level  eth0
NMI:          0 
LOC:     183783 
ERR:          0
MIS:          0

/proc/interrupts under 2.5.74 with ACPI off (init level 3):
           CPU0       
  0:      70300    IO-APIC-edge  timer
  1:        516    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:       5419    IO-APIC-edge  rtc
 12:        232    IO-APIC-edge  i8042
 14:       2266    IO-APIC-edge  ide0
 15:         10    IO-APIC-edge  ide1
 19:          0   IO-APIC-level  ehci_hcd
 21:          0   IO-APIC-level  uhci-hcd, uhci-hcd, uhci-hcd
 22:        172   IO-APIC-level  VIA8233
NMI:          0 
LOC:      70219 
ERR:          0
MIS:          0

Why does using ACPI cause my soundcard to lockup?
Any help will be greatly appreciated.
(BTW 2.4 kernels worked fine with ACPI on...)


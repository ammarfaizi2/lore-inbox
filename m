Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbUKFTQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbUKFTQV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 14:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbUKFTQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 14:16:21 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:24746 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261443AbUKFTPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 14:15:15 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.10-rc1-mm3: swsusp problems w/ ALSA driver, IRQs on AMD64
Date: Sat, 6 Nov 2004 20:14:08 +0100
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>,
       alsa-devel@alsa-project.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_AKSjBtCaNEtmwYM"
Message-Id: <200411062014.08202.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_AKSjBtCaNEtmwYM
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I'm having some troubles with swsusp on 2.6.10-rc1-mm3 (Athlon 64-based laptop 
w/ NForce3 chipset), although I don't think that swsusp itself is to blame.

First, I have to use the pci=routeirq kernel option, because otherwise the box 
does not resume (it either reboots or hangs indefinitely after saying "PM: 
Image restored successfully").

Second, there is a problem with the snd-intel8x0 ALSA driver that manifests 
itself with the following messages:

ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff]
[0xffffffff]
ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for 
register 0x26
ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff]
[0xffffffff]
ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for 
register 0x0

etc. for many different registers (~ 300 messages in total).  The sound chip 
apparently does not work after resume and it causes the USB controller that 
shares an IRQ with it to fail (the USB driver has to be reloaded manually).

Third, some important messages related to suspend/resume do not appear on the 
serial console (eg the above  ALSA messages, the "[nosave pfn 0x584]..." 
etc.), so I can't save them if the box hangs or reboots in the process.

Attached is the full log of what happens on the box during a typical 
suspend/resume cycle (no X, I manually unload the USB driver before suspend, 
reload it and restart networking after resume).

If you need any more information, please let me know.

Regards,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--Boundary-00=_AKSjBtCaNEtmwYM
Content-Type: text/x-log;
  charset="iso-8859-2";
  name="2.6.10-rc1-mm2-swsusp.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.10-rc1-mm2-swsusp.log"

Nov  6 19:13:09 albercik kernel: Emergency Sync complete
Nov  6 19:13:19 albercik kernel: ohci_hcd 0000:00:02.0: remove, state 1
Nov  6 19:13:19 albercik kernel: usb usb1: USB disconnect, address 1
Nov  6 19:13:19 albercik kernel: ohci_hcd 0000:00:02.0: USB bus 1 deregistered
Nov  6 19:13:19 albercik kernel: ohci_hcd 0000:00:02.1: remove, state 1
Nov  6 19:13:19 albercik kernel: usb usb2: USB disconnect, address 1
Nov  6 19:13:19 albercik kernel: ohci_hcd 0000:00:02.1: USB bus 2 deregistered
Nov  6 19:13:33 albercik kernel: Stopping tasks: ====================================|
Nov  6 19:13:33 albercik kernel: Freeing memory...  ^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^Hdone (16918 pages freed)
Nov  6 19:13:33 albercik kernel: PM: Attempting to suspend to disk.
Nov  6 19:13:33 albercik kernel: PM: snapshotting memory.
Nov  6 19:13:33 albercik kernel: swsusp: critical section: 
Nov  6 19:13:33 albercik kernel: ..<7>[nosave pfn 0x584].............................................swsusp: Need to copy 13528 pages
Nov  6 19:13:33 albercik kernel: suspend: (pages needed: 13528 + 512 free: 117351)
Nov  6 19:13:33 albercik kernel: ..<7>PM: Image restored successfully.
Nov  6 19:13:33 albercik kernel: Warning: CPU frequency out of sync: cpufreq and timing core thinks of 800000, is 1800000 kHz.
Nov  6 19:13:33 albercik kernel: ehci_hcd 0000:00:02.2: BIOS handoff failed (160, 1010001)
Nov  6 19:13:33 albercik kernel: ehci_hcd 0000:00:02.2: continuing after BIOS bug...
Nov  6 19:13:33 albercik kernel: PCI: cache line size of 64 is not supported by device 0000:00:02.2
Nov  6 19:13:33 albercik kernel: ehci_hcd 0000:00:02.2: USB 2.0 restarted, EHCI 1.00, driver 26 Oct 2004
Nov  6 19:13:34 albercik kernel: PCI: Enabling device 0000:00:06.0 (0000 -> 0003)
Nov  6 19:13:34 albercik kernel: ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 5 (level, low) -> IRQ 5
Nov  6 19:13:34 albercik kernel: PCI: Setting latency timer of device 0000:00:06.0 to 64
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:2102: AC'97 warm reset still in progress? [0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x26
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x0
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x26
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x20
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x26
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:34 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:35 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x2
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x2
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x6
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x6
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0xa
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0xa
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0xc
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0xc
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0xe
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0xe
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x10
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x10
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x12
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x12
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x14
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x14
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x16
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x16
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x18
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x18
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x1a
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x1a
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x1c
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x1c
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x20
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x20
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x22
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x22
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x2a
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2a
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x2c
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2c
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x2e
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2e
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x30
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x30
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x32
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x32
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x36
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x36
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x38
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x38
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x3a
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x3a
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x64
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x64
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x66
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:36 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x66
Nov  6 19:13:37 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:37 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x6a
Nov  6 19:13:37 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:37 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x6a
Nov  6 19:13:37 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:37 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x76
Nov  6 19:13:37 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:37 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x76
Nov  6 19:13:37 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:37 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x78
Nov  6 19:13:37 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:37 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x78
Nov  6 19:13:37 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:37 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x7a
Nov  6 19:13:37 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:37 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x7a
Nov  6 19:13:37 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:37 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x2a
Nov  6 19:13:37 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:37 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x2a
Nov  6 19:13:37 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:37 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x3a
Nov  6 19:13:37 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:13:38 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x2a
Nov  6 19:13:38 albercik kernel: ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
Nov  6 19:15:16 albercik kernel: ACPI: PCI interrupt 0000:02:01.2[C] -> GSI 11 (level, low) -> IRQ 11
Nov  6 19:15:16 albercik kernel: Restarting tasks... done
Nov  6 19:15:16 albercik kernel: ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
Nov  6 19:15:16 albercik kernel: ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 11 (level, low) -> IRQ 11
Nov  6 19:15:16 albercik kernel: ohci_hcd 0000:00:02.0: nVidia Corporation nForce3 USB 1.1
Nov  6 19:15:16 albercik kernel: PCI: Setting latency timer of device 0000:00:02.0 to 64
Nov  6 19:15:16 albercik kernel: ohci_hcd 0000:00:02.0: irq 11, pci mem 0xfebfb000
Nov  6 19:15:16 albercik kernel: ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
Nov  6 19:15:16 albercik kernel: hub 1-0:1.0: USB hub found
Nov  6 19:15:16 albercik kernel: hub 1-0:1.0: 3 ports detected
Nov  6 19:15:16 albercik kernel: ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 5 (level, low) -> IRQ 5
Nov  6 19:15:16 albercik kernel: ohci_hcd 0000:00:02.1: nVidia Corporation nForce3 USB 1.1 (#2)
Nov  6 19:15:16 albercik kernel: PCI: Setting latency timer of device 0000:00:02.1 to 64
Nov  6 19:15:16 albercik kernel: ohci_hcd 0000:00:02.1: irq 5, pci mem 0xfebfc000
Nov  6 19:15:16 albercik kernel: ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
Nov  6 19:15:16 albercik kernel: hub 2-0:1.0: USB hub found
Nov  6 19:15:16 albercik kernel: hub 2-0:1.0: 3 ports detected
Nov  6 19:15:17 albercik kernel: eth0: network connection down
Nov  6 19:15:20 albercik kernel: eth0: network connection up using port A
Nov  6 19:15:20 albercik kernel:     speed:           100
Nov  6 19:15:20 albercik kernel:     autonegotiation: yes
Nov  6 19:15:20 albercik kernel:     duplex mode:     full
Nov  6 19:15:20 albercik kernel:     flowctrl:        symmetric
Nov  6 19:15:20 albercik kernel:     irq moderation:  disabled
Nov  6 19:15:20 albercik kernel:     scatter-gather:  enabled
Nov  6 19:15:29 albercik kernel: eth0: no IPv6 routers present
Nov  6 19:16:51 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:16:51 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x2c
Nov  6 19:16:51 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:16:51 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2c
Nov  6 19:16:51 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:16:51 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x30
Nov  6 19:16:51 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:16:51 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x30
Nov  6 19:16:51 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:16:51 albercik kernel: ALSA sound/pci/intel8x0.c:595: codec_write 0: semaphore is not ready for register 0x2e
Nov  6 19:16:51 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:16:51 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2e
Nov  6 19:16:51 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:16:52 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2c
Nov  6 19:16:52 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:16:52 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x30
Nov  6 19:16:52 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:16:52 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2e
Nov  6 19:16:52 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:16:52 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2c
Nov  6 19:16:52 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:16:52 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x30
Nov  6 19:16:52 albercik kernel: ALSA sound/pci/intel8x0.c:580: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Nov  6 19:16:52 albercik kernel: ALSA sound/pci/intel8x0.c:611: codec_read 0: semaphore is not ready for register 0x2e

--Boundary-00=_AKSjBtCaNEtmwYM--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271680AbRHUOIq>; Tue, 21 Aug 2001 10:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271677AbRHUOIh>; Tue, 21 Aug 2001 10:08:37 -0400
Received: from wlg21.werkleitz.de ([195.37.189.21]:6800 "EHLO
	mail-2.werkleitz.de") by vger.kernel.org with ESMTP
	id <S271680AbRHUOI3>; Tue, 21 Aug 2001 10:08:29 -0400
Date: Tue, 21 Aug 2001 16:06:28 +0200
From: Martin Mueller <mm@lunetix.de>
To: linux-kernel@vger.kernel.org
Cc: dahinds@users.sourceforge.net
Subject: 2.4.9 breaks apm, ymfpci, pcmcia on VAIO + patch
Message-ID: <20010821160628.A2296@cicero.werkleitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Organization: Unorganized Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm not subscribed to the list, so please cc: me in replies (if any).

Until recently I ran 2.4.6-pre8 on my Sony VAIO N505SX(DE), and had
the following problems:

   - after suspend to RAM and resume, no interrrupts where delivered
     for the ymfpci sound driver and PCMCIA wavelan card

   - hibernation worked fine if I unloaded ymfpci and pcmcia before
     
   - display of remaining battery time was wrong (the 
     minute / reverse bytorder problem)

Linux 2.4.8 worked _extremely_ well, all problems except the wrong
battery display gone. I just could suspend the running laptop while
playing mp3s over NFS via the wavelan card and upon resume it just
continued playing without a glitch (except the volume settings where
wrong). BTW. the pcmcia resume/suspend thingy only works with
"irq_mode=0 pci_int=1 pci_csc=1" as opitions. When using 
"irp_list=11 irq_mode=2" I have the same behaviour as with
2.4.6-pre8. The pcmcia package used is pcmcia-cs.17-Aug-01.tar.gz.

Linux 2.4.9 breaks this paradise. The Laptop freezes on resume after
turning on the display backlight no matter what drivers inserted, even
without any modules loaded and no drivers except IDE disk compiled in
the kernel. Nothing is logged via syslog or displayed. Trying to
hibernate the laptop hangs for about 3min and then finally hibernates
the system. Resume works in this case.

Sound doesn't work at all anymore. The messages from the driver are:

Aug 21 15:01:32 cicero kernel: PCI: Enabling device 00:09.0 (0000 -> 0003) 
Aug 21 15:01:32 cicero kernel: PCI: Found IRQ 9 for device 00:09.0 
Aug 21 15:01:32 cicero kernel: ymfpci: YMF744 at 0xfedf8000 IRQ 9 
Aug 21 15:01:33 cicero kernel: ymfpci_codec_ready: codec 0 is not ready [0xffff] 

This is with the ymfpci module shipped with the kernel tree, the
ALSA messages are roughly the same.

I compiled the kernel both with IO-APIC support and without, it's
all the same.

If someone needs more info just let me know. I'm also willing
to test any patches to get the "2.4.8 behaviour" back.

bye
   MM

Martin Mueller      Phone: +49 39298 4125      e-mail:  mm@sig21.net
		    ICQ:         99023536              mm@lunetix.de
PGP/GPG mail welcome, keys as well other stuff at:  http://themm.net

PS.: This is the patch to fix the remaining battery time 
     display in 2.4.9

--- dmi_scan.c.orig     Tue Aug 21 15:52:33 2001
+++ dmi_scan.c  Tue Aug 21 15:52:07 2001
@@ -354,6 +354,11 @@
                        MATCH(DMI_BIOS_VERSION, "R0121Z1"),
                        MATCH(DMI_BIOS_DATE, "05/11/00"), NO_MATCH
                        } },
+       { swab_apm_power_in_minutes, "Sony VAIO PCG-N505X(DE)", { /* Handle problems with APM on Sony Vaio PCG-N505X(DE) */
+                       MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+                       MATCH(DMI_BIOS_VERSION, "R0206H"),
+                       MATCH(DMI_BIOS_DATE, "08/23/99"), NO_MATCH
+                       } },
        { NULL, }
 };
 


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264085AbUIZV7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbUIZV7o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 17:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbUIZV7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 17:59:44 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:26821 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S264085AbUIZV7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 17:59:32 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm3: swsusp horribly slow on AMD64
Date: Mon, 27 Sep 2004 00:01:09 +0200
User-Agent: KMail/1.6.2
Cc: Stefan Seyfried <seife@suse.de>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@suse.cz>
References: <200409251214.28743.rjw@sisk.pl> <200409261337.53298.rjw@sisk.pl> <41572E05.9030406@suse.de>
In-Reply-To: <41572E05.9030406@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_lwzVBzZDwxy5h2F"
Message-Id: <200409270001.09311.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_lwzVBzZDwxy5h2F
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 26 of September 2004 23:00, Stefan Seyfried wrote:
> Rafael J. Wysocki wrote:
> > On Sunday 26 of September 2004 12:09, Pavel Machek wrote:
> 
> >>>>We have seen something similar after hdparm was used on specific
> >>>>machines. Are you using hdparm?
> 
> Pavel, i am pretty sure the issue with hdparm and 32-bit disk access was
> just a symptom, not the cause. Rafael, please try the patch i posted in
> the other mail, i believe this is the right thing to do.

In summary:

1) The patch does not fix the problem. :-(

2) In the meantime, I've made the following change to pci-driver.c:

--- pci-driver.c	2004-09-26 23:35:32.701574416 +0200
+++ pci-driver.c.rjw	2004-09-26 23:35:18.441742240 +0200
@@ -328,6 +328,7 @@
  */
 static void pci_default_resume(struct pci_dev *pci_dev)
 {
+	printk("pci_default_resume (0x%04x, 0x%04x): %ld\n", pci_dev->vendor, 
pci_dev->device, jiffies/HZ);
 	/* restore the PCI config space */
 	pci_restore_state(pci_dev, pci_dev->saved_config_space);
 	/* if the device was enabled before suspend, reenable */
@@ -343,6 +344,7 @@
 	struct pci_dev * pci_dev = to_pci_dev(dev);
 	struct pci_driver * drv = pci_dev->driver;
 
+	printk("pci_device_resume (0x%04x, 0x%04x): %ld\n", pci_dev->vendor, 
pci_dev->device, jiffies/HZ);
 	if (drv && drv->resume)
 		drv->resume(pci_dev);
 	else

in order to identify the offending device.  I'm now almost sure that the 
NVidia chipset is to blame but I don't know which part of it exactly.

I've got two logs (attached), one of which is taken from the system with all 
modules loaded (swsusp.log), and the other comes from the system with no 
modules except for ipv6 (swsusp-nomod.log).  As you can see from the first 
log, the system with all modules loaded slows down significantly after 
pci_device_resume() is called for the device having vendor id = 0x10de 
(NVidia) and device id = 0x00d7 (no idea).  The system without modules is 
capable of writing 80-83% of pages to the swap _before_ slows down too and I 
have to wait for 1/2 h for the remaining ~20%.

I'm afraid I can't get any more info until I sort out the sysrq problem.

[-- snip --]

> >         /* Restore control flow magically appears here */
> >         restore_processor_state();
> > -       local_irq_enable();
> >         restore_highmem();
> > +       local_irq_enable();
> >         return error;
> >  }
> 
> without this one is needed or highmem will break "sometimes". Was really
> nasty. You did have highmem-resume problems, didn't you?

Yup, probably.  I only need to apply it to 2.6.9-rc2-mm1 to confirm that it 
fixes what I've seen.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--Boundary-00=_lwzVBzZDwxy5h2F
Content-Type: text/x-log;
  charset="iso-8859-2";
  name="swsusp.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="swsusp.log"

Stopping tasks: ==============================|
Freeing memory... done (17085 pages freed)
PM: Attempting to suspend to disk.
PM: snapshotting memory.
swsusp: critical section:
..<7>[nosave pfn 0x588]....................................swsusp: Need to copy 10916 pages
suspend: (pages needed: 10916 + 512 free: 119963)
..<7>[nosave pfn 0x588]....................................swsusp: critical section/: done (11044 pages copied)
PM: writing image.
pci_device_resume (0x10de, 0x00d1): 4294786
pci_default_resume (0x10de, 0x00d1): 4294786
pci_device_resume (0x10de, 0x00d0): 4294786
pci_default_resume (0x10de, 0x00d0): 4294786
pci_device_resume (0x10de, 0x00d4): 4294786
pci_default_resume (0x10de, 0x00d4): 4294786
pci_device_resume (0x10de, 0x00d7): 4294786
PCI: Setting latency timer of device 0000:00:02.0 to 64
pci_device_resume (0x10de, 0x00d7): 4294792
PCI: Setting latency timer of device 0000:00:02.1 to 64
pci_device_resume (0x10de, 0x00d8): 4294798
PCI: Setting latency timer of device 0000:00:02.2 to 64
pci_device_resume (0x10de, 0x00da): 4294801
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:06.0 to 64
pci_device_resume (0x10de, 0x00d9): 4294803
pci_default_resume (0x10de, 0x00d9): 4294803
pci_device_resume (0x10de, 0x00d5): 4294803
pci_default_resume (0x10de, 0x00d5): 4294803
pci_device_resume (0x10de, 0x00dd): 4294803
pci_default_resume (0x10de, 0x00dd): 4294803
pci_device_resume (0x10de, 0x00d2): 4294803
pci_default_resume (0x10de, 0x00d2): 4294803
pci_device_resume (0x1022, 0x1100): 4294803
pci_default_resume (0x1022, 0x1100): 4294803
pci_device_resume (0x1022, 0x1101): 4294803
pci_default_resume (0x1022, 0x1101): 4294803
pci_device_resume (0x1022, 0x1102): 4294803
pci_default_resume (0x1022, 0x1102): 4294803
pci_device_resume (0x1022, 0x1103): 4294803
pci_default_resume (0x1022, 0x1103): 4294803
pci_device_resume (0x11ab, 0x4320): 4294803
pci_default_resume (0x11ab, 0x4320): 4294803
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
pci_device_resume (0x1180, 0x0476): 4294803
pci_device_resume (0x1180, 0x0476): 4294806
pci_device_resume (0x1180, 0x0552): 4294809
ACPI: PCI interrupt 0000:02:01.2[C] -> GSI 11 (level, low) -> IRQ 11
pci_device_resume (0x1180, 0x0576): 4294809
pci_default_resume (0x1180, 0x0576): 4294809
pci_device_resume (0x1180, 0x0592): 4294809
pci_default_resume (0x1180, 0x0592): 4294809
pci_device_resume (0x14e4, 0x4320): 4294809
pci_default_resume (0x14e4, 0x4320): 4294809
pci_device_resume (0x10de, 0x031b): 4294809
pci_default_resume (0x10de, 0x031b): 4294809
 swsusp: Version: 132617
 swsusp: Num Pages: 130880
 swsusp: UTS Sys: Linux
 swsusp: UTS Node: albercik
 swsusp: UTS Release: 2.6.9-rc2-mm3
 swsusp: UTS Version: #4 Sun Sep 26 22:20:12 CEST 2004
 swsusp: UTS Machine: x86_64
 swsusp: UTS Domain:
 swsusp: CPUs: 1
 swsusp: Image: 11044 Pages
 swsusp: Pagedir: 0 Pages
Writing data to swap (11044 pages)...   0%


--Boundary-00=_lwzVBzZDwxy5h2F
Content-Type: text/x-log;
  charset="iso-8859-2";
  name="swsusp-nomod.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="swsusp-nomod.log"

Stopping tasks: ===========================|
Freeing memory... done (18713 pages freed)
PM: Attempting to suspend to disk.
PM: snapshotting memory.
swsusp: critical section:
..<7>[nosave pfn 0x588]...................................swsusp: Need to copy 10285 pages
suspend: (pages needed: 10285 + 512 free: 120594)
..<7>[nosave pfn 0x588]...................................swsusp: critical section/: done (10413 pages copied)
PM: writing image.
pci_device_resume (0x10de, 0x00d1): 4295657
pci_default_resume (0x10de, 0x00d1): 4295657
pci_device_resume (0x10de, 0x00d0): 4295657
pci_default_resume (0x10de, 0x00d0): 4295657
pci_device_resume (0x10de, 0x00d4): 4295657
pci_default_resume (0x10de, 0x00d4): 4295657
pci_device_resume (0x10de, 0x00d7): 4295657
pci_default_resume (0x10de, 0x00d7): 4295657
pci_device_resume (0x10de, 0x00d7): 4295657
pci_default_resume (0x10de, 0x00d7): 4295657
pci_device_resume (0x10de, 0x00d8): 4295657
pci_default_resume (0x10de, 0x00d8): 4295657
pci_device_resume (0x10de, 0x00da): 4295657
pci_default_resume (0x10de, 0x00da): 4295657
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:06.0 to 64
pci_device_resume (0x10de, 0x00d9): 4295657
pci_default_resume (0x10de, 0x00d9): 4295657
pci_device_resume (0x10de, 0x00d5): 4295657
pci_default_resume (0x10de, 0x00d5): 4295657
pci_device_resume (0x10de, 0x00dd): 4295657
pci_default_resume (0x10de, 0x00dd): 4295657
pci_device_resume (0x10de, 0x00d2): 4295657
pci_default_resume (0x10de, 0x00d2): 4295657
pci_device_resume (0x1022, 0x1100): 4295657
pci_default_resume (0x1022, 0x1100): 4295657
pci_device_resume (0x1022, 0x1101): 4295657
pci_default_resume (0x1022, 0x1101): 4295657
pci_device_resume (0x1022, 0x1102): 4295657
pci_default_resume (0x1022, 0x1102): 4295657
pci_device_resume (0x1022, 0x1103): 4295657
pci_default_resume (0x1022, 0x1103): 4295657
pci_device_resume (0x11ab, 0x4320): 4295657
pci_default_resume (0x11ab, 0x4320): 4295657
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
pci_device_resume (0x1180, 0x0476): 4295657
pci_default_resume (0x1180, 0x0476): 4295657
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 9 (level, low) -> IRQ 9
pci_device_resume (0x1180, 0x0476): 4295657
pci_default_resume (0x1180, 0x0476): 4295657
ACPI: PCI interrupt 0000:02:01.1[B] -> GSI 11 (level, low) -> IRQ 11
pci_device_resume (0x1180, 0x0552): 4295657
pci_default_resume (0x1180, 0x0552): 4295657
ACPI: PCI interrupt 0000:02:01.2[C] -> GSI 11 (level, low) -> IRQ 11
pci_device_resume (0x1180, 0x0576): 4295657
pci_default_resume (0x1180, 0x0576): 4295657
pci_device_resume (0x1180, 0x0592): 4295657
pci_default_resume (0x1180, 0x0592): 4295657
pci_device_resume (0x14e4, 0x4320): 4295657
pci_default_resume (0x14e4, 0x4320): 4295657
pci_device_resume (0x10de, 0x031b): 4295657
pci_default_resume (0x10de, 0x031b): 4295657
 swsusp: Version: 132617
 swsusp: Num Pages: 130880
 swsusp: UTS Sys: Linux
 swsusp: UTS Node: albercik
 swsusp: UTS Release: 2.6.9-rc2-mm3
 swsusp: UTS Version: #4 Sun Sep 26 22:20:12 CEST 2004
 swsusp: UTS Machine: x86_64
 swsusp: UTS Domain:
 swsusp: CPUs: 1
 swsusp: Image: 10413 Pages
 swsusp: Pagedir: 0 Pages
Writing data to swap (10413 pages)...  81%


--Boundary-00=_lwzVBzZDwxy5h2F--

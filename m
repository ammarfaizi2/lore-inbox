Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbUBHP0J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 10:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbUBHP0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 10:26:09 -0500
Received: from dsl-213-023-007-056.arcor-ip.net ([213.23.7.56]:8094 "EHLO
	fusebox.fsfeurope.org") by vger.kernel.org with ESMTP
	id S263646AbUBHPYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 10:24:25 -0500
Date: Sun, 8 Feb 2004 16:22:31 +0100
From: Georg C F Greve <greve@gnuhh.org>
Message-Id: <200402081522.i18FMVl7001382@brain.gnuhh.org>
To: linux-kernel@vger.kernel.org
CC: acpi-devel@lists.sourceforge.net
Subject: [PROBLEM] 2.6.3-rc1: still no suspend/resume on Centrino notebook (contains agp, lapic, swsusp)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this is a a report trying to help track down the issues with suspend
and resume on Centrino based notebooks. To make it easier to find in
the future, I also submitted it as

 http://bugzilla.kernel.org/attachment.cgi?id=2062&action=view

for

 http://bugzilla.kernel.org/show_bug.cgi?id=1877

------

All of this on ASUS M2N with kernel 2.6.3-rc1 + acpi-20040116-2.6.3
patch. When booting 2.6.3-rc1, I found an apparent inconsistency in
the AGP code, as dmesg reports

 agpgart: Detected an Intel 855 Chipset.
 agpgart: Maximum main memory to use for agp memory: 431M
 agpgart: Detected 8060K stolen memory.
 agpgart: AGP aperture is 128M @ 0xf0000000

while the chipset is Intel 855GM; output of lspci -vvv

  00:00.0 Host bridge: Intel Corp. 82852/855GM Host Bridge (rev 02)
	  Subsystem: Asustek Computer, Inc.: Unknown device 1751
  	  Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	  Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	  Latency: 0
	  Region 0: Memory at <unassigned> (32-bit, prefetchable)
	  Capabilities: [40] #09 [a105]

Detection seems to be done in drivers/char/agp/intel-agp.c, in
function agp_intel_probe, more specifically in the part

	case PCI_DEVICE_ID_INTEL_82855GM_HB:
		if (find_i830(PCI_DEVICE_ID_INTEL_82855GM_IG)) {
			bridge->driver = &intel_830_driver;
			name = "855";
		} else {
			bridge->driver = &intel_845_driver;
			name = "855GM";
		}
		break;

I don't know enough about the PCI ID intrinsics to tell what is the
difference between PCI_DEVICE_ID_INTEL_82855GM_HB and _IG. 

If nothing else, the reporting is misleading, as all information and
documentation reports this laptop with "855GM" chipset, while the
Linux kernel claims it is "855" (without "GM").

I'm not sure whether this is because

 a) the chipset should really have its own routines, but depending on
    some different implementations, the 830/845 driver can be used as
    a cludge.

or

 b) the chipset comes in two different implementations and the
    i830/i845 drivers are what should be used.

In any case: given that the logic is right, I propose to change the
reporting to "855GM (i830)" and "855GM (845)" to avoid confusion and
allow easier telling by dmesg messages which driver is used.


*** Suspend to RAM

When trying suspend to ram (S3), it showed the same results as 2.6.1:
the machine seems to suspend find with "echo 3bios > /etc/acpi/sleep"
and it seems the machine comes back -- only the screen is entirely
dead. 


So I tried changing the agp_intel_resume function in intel-agp.c to

static int agp_intel_resume(struct pci_dev *pdev)
{
	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);

	if (bridge->driver == &intel_generic_driver)
		intel_configure();
	else if (bridge->driver == &intel_820_driver)
		intel_820_configure();
	else if (bridge->driver == &intel_830_driver)
		intel_i830_configure();
	else if (bridge->driver == &intel_840_driver)
		intel_840_configure();
	else if (bridge->driver == &intel_845_driver)
		intel_845_configure();
	else if (bridge->driver == &intel_850_driver)
		intel_850_configure();
	else if (bridge->driver == &intel_860_driver)
		intel_860_configure();
	else if (bridge->driver == &intel_830mp_driver)
		intel_830mp_configure();
	else if (bridge->driver == &intel_7505_driver)
		intel_7505_configure();

	return 0;
}

to try bringing back things to life.


However, suspend to ram (S3) as above shows similar behaviour with the
syslog reporting:

Feb  8 14:51:26 myhost kernel: PM: Preparing system for suspend
Feb  8 14:51:26 myhost kernel: Stopping tasks: ==========================================|
Feb  8 14:51:26 myhost kernel: hdc: start_power_step(step: 0)
Feb  8 14:51:26 myhost kernel: hdc: completing PM request, suspend
Feb  8 14:51:26 myhost kernel: hda: start_power_step(step: 0)
Feb  8 14:51:26 myhost kernel: hda: start_power_step(step: 1)
Feb  8 14:51:26 myhost kernel: hda: complete_power_step(step: 1, stat: 50, err: 0)
Feb  8 14:51:26 myhost kernel: hda: completing PM request, suspend
Feb  8 14:51:26 myhost kernel: PM: Entering state.
Feb  8 14:51:26 myhost kernel:  hwsleep-0265 [1800] acpi_enter_sleep_state: Entering sleep state [S3]
Feb  8 14:51:26 myhost kernel: Back to C!
Feb  8 14:51:26 myhost kernel: PM: Finishing up.
Feb  8 14:51:26 myhost kernel: PCMCIA: socket df47582c: *** DANGER *** unable to remove socket power
Feb  8 14:51:26 myhost kernel: PCMCIA: socket df47542c: *** DANGER *** unable to remove socket power
Feb  8 14:51:26 myhost kernel: hda: Wakeup request inited, waiting for !BSY...
Feb  8 14:51:26 myhost kernel: hda: start_power_step(step: 1000)
Feb  8 14:51:26 myhost kernel: blk: queue df482200, I/O limit 4095Mb (mask 0xffffffff)
Feb  8 14:51:26 myhost kernel: hda: completing PM request, resume
Feb  8 14:51:26 myhost kernel: hdc: Wakeup request inited, waiting for !BSY...
Feb  8 14:51:26 myhost kernel: hdc: start_power_step(step: 1000)
Feb  8 14:51:26 myhost kernel: hdc: completing PM request, resume
Feb  8 14:51:27 myhost kernel: Restarting tasks... done
Feb  8 14:51:27 myhost kernel: Synaptics Touchpad, model: 1
Feb  8 14:51:27 myhost kernel:  Firmware: 4.6
Feb  8 14:51:27 myhost kernel:  180 degree mounted touchpad
Feb  8 14:51:27 myhost kernel:  Sensor: 18
Feb  8 14:51:27 myhost kernel:  new absolute packet format
Feb  8 14:51:27 myhost kernel:  Touchpad has extended capability bits
Feb  8 14:51:27 myhost kernel:  -> four buttons
Feb  8 14:51:27 myhost kernel:  -> multifinger detection
Feb  8 14:51:27 myhost kernel:  -> palm detection
Feb  8 14:51:27 myhost kernel: input: SynPS/2 Synaptics TouchPad on isa0060/serio4
Feb  8 14:51:31 myhost kernel: MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Feb  8 14:51:31 myhost kernel: Bank 1: f200000000000175


As I wasn't sure whether the chipset detection was correct, I forced
usage of the 845 driver by modifying the logic above to 

	case PCI_DEVICE_ID_INTEL_82855GM_HB:
		bridge->driver = &intel_845_driver;
		name = "855GM";
		break;

The kernel boots up normally and everything seems to work just like it
did for i830. Unfortunately, that includes suspend 2 ram (S3), which
shows the same behaviour. Here are the syslog entries:

Feb  8 13:19:40 myhost kernel: PM: Preparing system for suspend
Feb  8 13:19:40 myhost kernel: Stopping tasks: ==========================================|
Feb  8 13:19:40 myhost kernel: hdc: start_power_step(step: 0)
Feb  8 13:19:40 myhost kernel: hdc: completing PM request, suspend
Feb  8 13:19:40 myhost kernel: hda: start_power_step(step: 0)
Feb  8 13:19:40 myhost kernel: hda: start_power_step(step: 1)
Feb  8 13:19:40 myhost kernel: hda: complete_power_step(step: 1, stat: 50, err: 0)
Feb  8 13:19:40 myhost kernel: hda: completing PM request, suspend
Feb  8 13:19:40 myhost kernel: PM: Entering state.
Feb  8 13:19:40 myhost kernel:  hwsleep-0265 [992] acpi_enter_sleep_state: Entering sleep state [S3]
Feb  8 13:19:40 myhost kernel: Back to C!
Feb  8 13:19:40 myhost kernel: PM: Finishing up.
Feb  8 13:19:40 myhost kernel: PCI: Enabling device 0000:00:1f.5 (0005 -> 0007)
Feb  8 13:19:40 myhost kernel: PCI: Setting latency timer of device 0000:00:1f.5 to 64
Feb  8 13:19:40 myhost kernel: AC'97 warm reset still in progress? [0xffffffff]
Feb  8 13:19:40 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:40 myhost kernel: codec_write 0: semaphore is not ready for register 0x26
Feb  8 13:19:40 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:40 myhost kernel: codec_write 0: semaphore is not ready for register 0x0
Feb  8 13:19:40 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:40 myhost kernel: codec_write 0: semaphore is not ready for register 0x26
Feb  8 13:19:40 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:40 myhost kernel: codec_write 0: semaphore is not ready for register 0x20
Feb  8 13:19:40 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:40 myhost kernel: codec_write 0: semaphore is not ready for register 0x26
Feb  8 13:19:40 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:40 myhost kernel: codec_write 0: semaphore is not ready for register 0x2
Feb  8 13:19:40 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:40 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb  8 13:19:40 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:40 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb  8 13:19:40 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:40 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb  8 13:19:40 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_write 0: semaphore is not ready for register 0x2
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_write 0: semaphore is not ready for register 0x4
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 0: semaphore is not ready for register 0x4
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_write 0: semaphore is not ready for register 0x6
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 0: semaphore is not ready for register 0x6
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_write 0: semaphore is not ready for register 0xa
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 0: semaphore is not ready for register 0xa
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_write 0: semaphore is not ready for register 0xc
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 0: semaphore is not ready for register 0xc
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_write 0: semaphore is not ready for register 0xe
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 0: semaphore is not ready for register 0xe
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_write 0: semaphore is not ready for register 0x10
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 0: semaphore is not ready for register 0x10
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_write 0: semaphore is not ready for register 0x12
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 0: semaphore is not ready for register 0x12
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_write 0: semaphore is not ready for register 0x14
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 0: semaphore is not ready for register 0x14
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_write 0: semaphore is not ready for register 0x16
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 0: semaphore is not ready for register 0x16
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_write 0: semaphore is not ready for register 0x18
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 0: semaphore is not ready for register 0x18
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_write 0: semaphore is not ready for register 0x1a
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 0: semaphore is not ready for register 0x1a
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_write 0: semaphore is not ready for register 0x1c
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 0: semaphore is not ready for register 0x1c
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_write 0: semaphore is not ready for register 0x20
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 0: semaphore is not ready for register 0x20
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_write 0: semaphore is not ready for register 0x22
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 0: semaphore is not ready for register 0x22
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_write 0: semaphore is not ready for register 0x2a
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 0: semaphore is not ready for register 0x2a
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_write 0: semaphore is not ready for register 0x2c
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 0: semaphore is not ready for register 0x2c
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_write 0: semaphore is not ready for register 0x32
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 0: semaphore is not ready for register 0x32
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_write 0: semaphore is not ready for register 0x3a
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 0: semaphore is not ready for register 0x3a
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_write 1: semaphore is not ready for register 0x26
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_write 1: semaphore is not ready for register 0x0
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_write 1: semaphore is not ready for register 0x26
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_write 1: semaphore is not ready for register 0x20
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_write 1: semaphore is not ready for register 0x26
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_write 1: semaphore is not ready for register 0x2
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 1: semaphore is not ready for register 0x2
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 1: semaphore is not ready for register 0x2
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 1: semaphore is not ready for register 0x2
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 1: semaphore is not ready for register 0x2
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 1: semaphore is not ready for register 0x2
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 1: semaphore is not ready for register 0x2
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 1: semaphore is not ready for register 0x2
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 1: semaphore is not ready for register 0x2
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 1: semaphore is not ready for register 0x2
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 1: semaphore is not ready for register 0x2
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_write 1: semaphore is not ready for register 0x1c
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 1: semaphore is not ready for register 0x1c
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_write 1: semaphore is not ready for register 0x3e
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 1: semaphore is not ready for register 0x3e
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_write 1: semaphore is not ready for register 0x40
Feb  8 13:19:41 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb  8 13:19:41 myhost kernel: codec_read 1: semaphore is not ready for register 0x40
Feb  8 13:19:41 myhost kernel: PCMCIA: socket df43582c: *** DANGER *** unable to remove socket power
Feb  8 13:19:41 myhost kernel: PCMCIA: socket df43542c: *** DANGER *** unable to remove socket power
Feb  8 13:19:41 myhost kernel: hda: Wakeup request inited, waiting for !BSY...
Feb  8 13:19:41 myhost kernel: hda: start_power_step(step: 1000)
Feb  8 13:19:41 myhost kernel: blk: queue df442200, I/O limit 4095Mb (mask 0xffffffff)
Feb  8 13:19:41 myhost kernel: hda: completing PM request, resume
Feb  8 13:19:41 myhost kernel: hdc: Wakeup request inited, waiting for !BSY...
Feb  8 13:19:41 myhost kernel: hdc: start_power_step(step: 1000)
Feb  8 13:19:41 myhost kernel: hdc: completing PM request, resume
Feb  8 13:19:41 myhost kernel: Restarting tasks... done
Feb  8 13:19:41 myhost kernel: Synaptics Touchpad, model: 1
Feb  8 13:19:41 myhost kernel:  Firmware: 4.6
Feb  8 13:19:41 myhost kernel:  180 degree mounted touchpad
Feb  8 13:19:41 myhost kernel:  Sensor: 18
Feb  8 13:19:41 myhost kernel:  new absolute packet format
Feb  8 13:19:41 myhost kernel:  Touchpad has extended capability bits
Feb  8 13:19:41 myhost kernel:  -> four buttons
Feb  8 13:19:41 myhost kernel:  -> multifinger detection
Feb  8 13:19:41 myhost kernel:  -> palm detection
Feb  8 13:19:41 myhost kernel: input: SynPS/2 Synaptics TouchPad on isa0060/serio4
Feb  8 13:19:44 myhost kernel: MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Feb  8 13:19:44 myhost kernel: Bank 1: f200000000000171


So regardless of whether it is (a) or (b) above, it seems that both
i830 and 845 are unable of bringing the video chipset back to life on
my Intel 855GM Centrino notebook.


Given the posts of some people that suggested some success with the
830mp driver for some laptops, I also tried using that -- and it behaved
precisely like the i830 chipset. Screen was dead after S3, but the
syslog seems less catastrophic:

Feb  8 15:22:03 myhost kernel: PM: Preparing system for suspend
Feb  8 15:22:03 myhost kernel: Stopping tasks: ==========================================|
Feb  8 15:22:03 myhost kernel: hdc: start_power_step(step: 0)
Feb  8 15:22:03 myhost kernel: hdc: completing PM request, suspend
Feb  8 15:22:03 myhost kernel: hda: start_power_step(step: 0)
Feb  8 15:22:03 myhost kernel: hda: start_power_step(step: 1)
Feb  8 15:22:03 myhost kernel: hda: complete_power_step(step: 1, stat: 50, err: 0)
Feb  8 15:22:03 myhost kernel: hda: completing PM request, suspend
Feb  8 15:22:03 myhost kernel: PM: Entering state.
Feb  8 15:22:03 myhost kernel:  hwsleep-0265 [1545] acpi_enter_sleep_state: Entering sleep state [S3]
Feb  8 15:22:03 myhost kernel: Back to C!
Feb  8 15:22:03 myhost kernel: PM: Finishing up.
Feb  8 15:22:03 myhost kernel: PCMCIA: socket df43582c: *** DANGER *** unable to remove socket power
Feb  8 15:22:03 myhost kernel: PCMCIA: socket df43542c: *** DANGER *** unable to remove socket power
Feb  8 15:22:03 myhost kernel: hda: Wakeup request inited, waiting for !BSY...
Feb  8 15:22:03 myhost kernel: hda: start_power_step(step: 1000)
Feb  8 15:22:03 myhost kernel: blk: queue df442200, I/O limit 4095Mb (mask 0xffffffff)
Feb  8 15:22:03 myhost kernel: hda: completing PM request, resume
Feb  8 15:22:03 myhost kernel: hdc: Wakeup request inited, waiting for !BSY...
Feb  8 15:22:03 myhost kernel: hdc: start_power_step(step: 1000)
Feb  8 15:22:03 myhost kernel: hdc: completing PM request, resume
Feb  8 15:22:03 myhost kernel: Restarting tasks... done
Feb  8 15:22:04 myhost kernel: Synaptics Touchpad, model: 1
Feb  8 15:22:04 myhost kernel:  Firmware: 4.6
Feb  8 15:22:04 myhost kernel:  180 degree mounted touchpad
Feb  8 15:22:04 myhost kernel:  Sensor: 18
Feb  8 15:22:04 myhost kernel:  new absolute packet format
Feb  8 15:22:04 myhost kernel:  Touchpad has extended capability bits
Feb  8 15:22:04 myhost kernel:  -> four buttons
Feb  8 15:22:04 myhost kernel:  -> multifinger detection
Feb  8 15:22:04 myhost kernel:  -> palm detection
Feb  8 15:22:04 myhost kernel: input: SynPS/2 Synaptics TouchPad on isa0060/serio4
Feb  8 15:22:06 myhost kernel: MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Feb  8 15:22:06 myhost kernel: Bank 1: f200000000000175


So it seems that the "soft suspend" functions (S1, S3) simply don't work
with Kernel 2.6.x and Centrino (Intel 855GM chipset) notebooks.


*** Suspend to disk

I wasn't able to get suspend to disk to work, either. The suspend to disk
worked fine, but resume crashed at 

 Waiting for DMAs to settle down...
          double fault, gdt at c03c0300 [255 bytes]            
 double fault, tss at c0465800
 eip = c0116f8b, esp = df4ebf80
 eax = e0971884, ebx = e0971680, ecx = 0000007b, edx = 0000007b
 esi = 00000000, edi = c011617e

and after a while the fan turned itself on to full blast.

As software suspend V2 doesn't have a 2.6.3 patch yet (and the 2.6.2
patch creates rejects), I couldn't try it with 2.6.3. When trying it
with 2.6.2 the suspend worked, but resume died (crash/reboot).


*** Other suspicious stuff

The lines

 MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
 Bank 1: f200000000000171

which appeared in all syslogs above seem suspicions. Bank 1 sounds a lot
like "memory bank" -- but that number sounds quite high. 

Hope this helps.

Regards,
Georg


P.S. Oh, and enabling ACPI & Local APIC now crashes (instant reboot
instead of freeze) the machine on boot. 

P.P.S. For reference, here are the 2.6.3-rc1 dmesg bootup messages for
that machine, further details about that machine can be found at 

 http://bugzilla.kernel.org/show_bug.cgi?id=1877
 http://bugzilla.kernel.org/show_bug.cgi?id=1774


Linux version 2.6.3-rc1 (root@myhost) (gcc version 3.3.2 (Debian)) #5 Sun Feb 8 14:43:43 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001f740000 (usable)
 BIOS-e820: 000000001f740000 - 000000001f750000 (ACPI data)
 BIOS-e820: 000000001f750000 - 000000001f800000 (ACPI NVS)
503MB LOWMEM available.
On node 0 totalpages: 128832
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 124736 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                    ) @ 0x000f4b60
ACPI: RSDT (v001 A M I  OEMRSDT  0x06000310 MSFT 0x00000097) @ 0x1f740000
ACPI: FADT (v002 A M I  OEMFACP  0x06000310 MSFT 0x00000097) @ 0x1f740200
ACPI: OEMB (v001 A M I  OEMBIOS  0x06000310 MSFT 0x00000097) @ 0x1f750040
ACPI: DSDT (v001  0ABBD 0ABBD001 0x00000001 MSFT 0x0100000d) @ 0x00000000
Built 1 zonelists
Kernel command line: /dev/hda1 ro hdc=ide-scsi acpi_irq_isa=3,12 video=i810fb xres=800 yres=600 accel=1 vga=791 
ide_setup: hdc=ide-scsi
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1600.204 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Memory: 505564k/515328k available (2469k kernel code, 8976k reserved, 1011k data, 156k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3162.11 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: a7e9fbbf 00000000 00000000 00000000
CPU:     After vendor identify, caps: a7e9fbbf 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU:     After all inits, caps: a7e9fbbf 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1600MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040116
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:..................................................................................................................................................................................................................................................................................................................................
Table [DSDT](id F004) - 1067 Objects with 57 Devices 322 Methods 30 Regions
ACPI Namespace successfully loaded at root c04a9e3c
ACPI: IRQ9 SCI: Edge set to Level Trigger.
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0747 [06] ev_create_gpe_block   : GPE 00 to 31 [_GPE] 4 regs at 000000000000E428 on int 9
Completing Region/Field/Buffer/Package initialization:...................................................................................................................................
Initialized 30/30 Regions 35/35 Fields 39/39 Buffers 27/27 Packages (1075 nodes)
Executing all Device _STA and_INI methods:...........................................................
59 Devices found containing: 59 _STA, 7 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 12)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 *4 5 6 7 12)
ACPI: Power Resource [GFAN] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f2e10
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x39ea, dseg 0xf0000
pnp: 00:0a: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0a: ioport range 0xcf8-0xcff could not be reserved
PnPBIOS: Unknown tag '0x0', length '1'.
PnPBIOS: Unknown tag '0x8', length '7'.
PnPBIOS: Unknown tag '0x8', length '7'.
PnPBIOS: Resource structure does not contain an end tag.
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
SCSI subsystem initialized
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 4
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 7
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
agpgart: Detected an Intel 855 Chipset.
agpgart: Maximum main memory to use for agp memory: 431M
agpgart: Detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0xf0000000
vesafb: framebuffer at 0xf0000000, mapped to 0xe0095000, size 8000k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: protected mode interface info at 00ff:44f0
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
Machine check exception polling timer started.
speedstep-centrino: found "Intel(R) Pentium(R) M processor 1600MHz": max frequency: 1600000kHz
ikconfig 0.7 with /proc/config*
Initializing Cryptographic API
ACPI: AC Adapter [AC0] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Fan [FN00] (off)
ACPI: Processor [CPU1] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THRM] (52 C)
Asus Laptop ACPI Extras version 0.27
  M2N model detected, supported
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
mtrr: 0xf0000000,0x8000000 overlaps existing 0xf0000000,0x400000
[drm] Initialized i830 1.3.2 20021108 on minor 0
ipmi: message handler initialized
ipmi: device interface at char major 253
loop: loaded (max 8 devices)
8139too Fast Ethernet driver 0.9.27
eth0: RealTek RTL8139 at 0xe0873c00, 00:0e:a6:33:ba:17, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8101'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N060ATMR04-0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA DVD-ROM SD-R2312, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 117210240 sectors (60011 MB) w/7884KiB Cache, CHS=16383/255/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TOSHIBA   Model: DVD-ROM SD-R2312  Rev: 1708
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
Console: switching to colour frame buffer device 128x48
Yenta: CardBus bridge found at 0000:01:03.0 [1043:1754]
Yenta: ISA IRQ mask 0x0c08, PCI irq 7
Socket status: 30000006
Yenta: CardBus bridge found at 0000:01:03.1 [1043:1754]
Yenta: ISA IRQ mask 0x0c08, PCI irq 5
Socket status: 30000006
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 4.6
 180 degree mounted touchpad
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S1 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 156k freed
Adding 1020088k swap on /dev/hda8.  Priority:-1 extents:1
EXT3 FS on hda1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on loop0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 4, pci mem e08fbc00
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 5, io base 0000d480
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 5, io base 0000d800
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 5, io base 0000d880
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Disabled Privacy Extensions on device c0422740(lo)
request_module: failed /sbin/modprobe -- char-major-4-65. error = 256
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A

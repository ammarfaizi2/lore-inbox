Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVFCL0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVFCL0o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 07:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVFCL0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 07:26:44 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:7600 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261220AbVFCLZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 07:25:34 -0400
Date: Fri, 3 Jun 2005 16:55:24 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>, greg@kroah.com
Cc: Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [RFC/PATCH] Kdump: Disabling PCI interrupts in capture kernel
Message-ID: <20050603112524.GB7022@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="eJnRUKwClWJh1Khz"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

In kdump, sometimes, general driver initialization issues seems to be cropping 
in second kernel due to devices not being shutdown during crash and these 
devices are sending interrupts while second kernel is booting and drivers are 
not expecting any interrupts yet.

In some cases, we are observing a storm of interrupts while second kernel 
is booting and kernel disables that irq line. May be the case of stuck irq
line because it is shared level triggered irq and there is no driver
loaded for the device. 

So, we need something generic which disables interrupt generation from device
until a driver has been registered for that device and driver is ready to 
receive the interrupts. PCI specifications (ver 2.3 onwards), have introduced
interrupt disable bit in command register to disable interrupt generation
from the device. This can become handy here. In capture kernel, traverse all 
the PCI devices, disable interrupt generation. Enable the interrupt generation
back once the driver for that device registers. May be after the probe handler 
has run. In probe handler, driver can reset the device or register for irq so 
that it can handle any interrupt from the device after that.

Greg mentioned that there are reasons that we can not disable all pci
interrupts. Meanwhile I am going through archives to find more about it.

In previous conversations, Alan Stern had raised the issue of console also
not working if interrupts are disabled on all the devices. I am not sure
but this should be working at least for serial consoles and vga text consoles.
May be sufficient to capture the dump.

Attached is a hack patch which is by no means complete. I have got one machine
which has got some PCI 2.3 compliant hardware. After applying this hack this
problem does not occur atleast on this machine. Attached is the serial console 
log which shows one kind of problem due to unwanted interrupts. 

Bugme 4631 and 4573 are two more instances of driver initialization failure
in second kernel.






---
o In kdump, devices are not shutdown/reset after a crash and this leads to
  various driver initialization failures while second kernel is booting.
  Most of them seem to be happening due to the fact that system/driver
  is receiving the interrupts from device when it is not prepared to do so.

o This patch tries to solve the problem by disabling the interrupts at
  PCI level for all the devices. These interrupts are enabled back once the
  driver for that device registers. Currenty this enabling and disabling
  is done only in dump capture kernel.

o This is for devices compliant to PCI specification v2.3 or higher.
 


Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.12-rc5-mm1-16M-root/drivers/pci/pci-driver.c |    3 +
 linux-2.6.12-rc5-mm1-16M-root/drivers/pci/pci.c        |    4 ++
 linux-2.6.12-rc5-mm1-16M-root/include/linux/pci.h      |   33 +++++++++++++++++
 3 files changed, 39 insertions(+), 1 deletion(-)

diff -puN drivers/pci/pci.c~kdump-pci-interrupt-disable drivers/pci/pci.c
--- linux-2.6.12-rc5-mm1-16M/drivers/pci/pci.c~kdump-pci-interrupt-disable	2005-06-03 14:35:26.000000000 +0530
+++ linux-2.6.12-rc5-mm1-16M-root/drivers/pci/pci.c	2005-06-03 15:59:19.000000000 +0530
@@ -823,6 +823,10 @@ static int __devinit pci_init(void)
 
 	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
 		pci_fixup_device(pci_fixup_final, dev);
+
+		/* A hack to disable interrupts from all PCI devices in
+		 * capture kernel. */
+		pci_disable_device_intx(dev);
 	}
 	return 0;
 }
diff -puN drivers/pci/pci-driver.c~kdump-pci-interrupt-disable drivers/pci/pci-driver.c
--- linux-2.6.12-rc5-mm1-16M/drivers/pci/pci-driver.c~kdump-pci-interrupt-disable	2005-06-03 14:35:26.000000000 +0530
+++ linux-2.6.12-rc5-mm1-16M-root/drivers/pci/pci-driver.c	2005-06-03 14:35:26.000000000 +0530
@@ -248,7 +248,8 @@ static int pci_device_probe(struct devic
 	error = __pci_device_probe(drv, pci_dev);
 	if (error)
 		pci_dev_put(pci_dev);
-
+	else
+		pci_enable_device_intx(pci_dev);
 	return error;
 }
 
diff -puN include/linux/pci.h~kdump-pci-interrupt-disable include/linux/pci.h
--- linux-2.6.12-rc5-mm1-16M/include/linux/pci.h~kdump-pci-interrupt-disable	2005-06-03 14:35:26.000000000 +0530
+++ linux-2.6.12-rc5-mm1-16M-root/include/linux/pci.h	2005-06-03 16:06:32.000000000 +0530
@@ -901,6 +901,39 @@ extern void pci_disable_msix(struct pci_
 extern void msi_remove_pci_irq_vectors(struct pci_dev *dev);
 #endif
 
+#ifdef CONFIG_CRASH_DUMP
+static inline int pci_enable_device_intx(struct pci_dev *dev)
+{
+	u16 pci_command;
+
+	/* Enable Interrupt generation if not already enabled */
+	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
+	if (pci_command & PCI_COMMAND_INTX_DISABLE) {
+		pci_command &= ~PCI_COMMAND_INTX_DISABLE;
+		pci_write_config_word(dev, PCI_COMMAND, pci_command);
+	}
+	return 0;
+}
+
+static inline int pci_disable_device_intx(struct pci_dev *dev)
+{
+	u16 pci_command;
+
+	/* Disable Interrupt generation if not already disabled */
+	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
+	if (!(pci_command & PCI_COMMAND_INTX_DISABLE)) {
+		pci_command |= PCI_COMMAND_INTX_DISABLE;
+		pci_write_config_word(dev, PCI_COMMAND, pci_command);
+	}
+	return 0;
+}
+#else
+static inline int pci_enable_device_intx(struct pci_dev *dev)
+{ return 0; }
+static inline int pci_disable_device_intx(struct pci_dev *dev)
+{ return 0; }
+#endif /* CONFIG_CRASH_DUMP */
+
 #endif /* CONFIG_PCI */
 
 /* Include architecture-dependent settings and functions */
_

--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pci-logs.txt"

[root@llm15p ~]# SysRq : Trigger a crashdump
Linux version 2.6.12-rc5-mm1-16M (root@llm15p.in.ibm.com) (gcc version 3.4.3 20041212 (Red Hat 3.4.3-9.EL4)) #16 Fri Jun 3 14:24:23 IST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000100 - 000000000009dc00 (usable)
 BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000c7fcb940 (usable)
 BIOS-e820: 00000000c7fcb940 - 00000000c7fcf800 (ACPI data)
 BIOS-e820: 00000000c7fcf800 - 00000000c8000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 00000000000a0000 (usable)
 user: 0000000001000000 - 0000000001486000 (usable)
 user: 0000000001526400 - 0000000005000000 (usable)
0MB HIGHMEM available.
80MB LOWMEM available.
DMI 2.3 present.
Allocating PCI resources starting at 05000000 (gap: 05000000:fb000000)
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/sda3 console=tty0 console=ttyS1,38400 rhgb memmap=exactmap memmap=640K@0K memmap=4632K@16384K memmap=60263K@21657K elfcorehdr=21656K
PID hash table entries: 512 (order: 9, 8192 bytes)
Detected 3600.765 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Unknown interrupt or fault at EIP 00000292 00000060 c140c6a3
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 59464k/81920k available (3030k kernel code, 5880k reserved, 1098k data, 196k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 7209.88 BogoMIPS (lpj=14419769)
Mount-cache hash table entries: 512
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
CPU: Intel(R) Xeon(TM) CPU 3.60GHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0c20)
checking if image is initramfs... it is
Freeing initrd memory: 538k freed
softlockup thread 0 started up.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd71e, last bus=9
PCI: Using MMCONFIG
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050408
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
ACPI: PCI Interrupt Link [LP00] (IRQs *5)
ACPI: PCI Interrupt Link [LP01] (IRQs *11)
ACPI: PCI Interrupt Link [LP02] (IRQs *10)
ACPI: PCI Interrupt Link [LP03] (IRQs *11)
ACPI: PCI Interrupt Link [LP04] (IRQs *11)
ACPI: PCI Interrupt Link [LP05] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP06] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [LP07] (IRQs *5)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 16 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:00: ioport range 0x510-0x517 could not be reserved
pnp: 00:00: ioport range 0x504-0x507 could not be reserved
pnp: 00:00: ioport range 0x500-0x503 could not be reserved
pnp: 00:00: ioport range 0x520-0x53f has been reserved
pnp: 00:00: ioport range 0x540-0x547 has been reserved
pnp: 00:00: ioport range 0x460-0x461 has been reserved
pnp: 00:0e: ioport range 0x400-0x43f has been reserved
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1117808719.712:1): initialized
inotify device minor=63
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ACPI: Power Button (FF) [PWRF]
ACPI: CPU0 (power states: C1[C1])
lp: driver loaded but no devices found
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
cn_fork is registered
PNP: PS/2 controller has invalid data port 0x64; using default 0x60
PNP: PS/2 controller has invalid command port 0x60; using default 0x64
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
lp0: using parport0 (interrupt-driven).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
tg3.c:v3.29 (May 23, 2005)
ACPI: PCI Interrupt Link [LP00] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:06:00.0[A] -> Link [LP00] -> GSI 5 (level, low) -> IRQ 5
eth0: Tigon3 [partno(BCM95721) rev 4101 PHY(5750)] (PCIX:100MHz:32-bit) 10/100/1000BaseT Ethernet 00:11:25:3f:6f:10
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1] TSOcap[1] 
eth0: dma_rwctrl[76180000]
ACPI: PCI Interrupt 0000:07:00.0[A] -> Link [LP00] -> GSI 5 (level, low) -> IRQ 5
eth1: Tigon3 [partno(BCM95721) rev 4101 PHY(5750)] (PCIX:100MHz:32-bit) 10/100/1000BaseT Ethernet 00:11:25:3f:6f:11
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1] TSOcap[1] 
eth1: dma_rwctrl[76180000]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A]: no GSI - using IRQ 0
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x0480-0x0487, BIOS settings: hda:DMA, hdb:DMA
hda: BTC CD-ROM F523E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide-disk: probe of 0.0 failed with error 1
hda: ATAPI 48X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
PCI: Enabling device 0000:03:07.0 (0156 -> 0157)
ACPI: PCI Interrupt Link [LP02] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:03:07.0[A] -> Link [LP02] -> GSI 10 (level, low) -> IRQ 10
PCI: Enabling device 0000:03:07.1 (0156 -> 0157)
ACPI: PCI Interrupt Link [LP03] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:03:07.1[B] -> Link [LP03] -> GSI 11 (level, low) -> IRQ 11
scsi0 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.11
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 67-100Mhz, 512 SCBs

scsi1 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.11
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel B, SCSI Id=7, PCI-X 67-100Mhz, 512 SCBs

(scsi1:A:2): 320.000MB/s transfers (160.000MHz DT|IU|RTI, 16bit)
(scsi1:A:3): 320.000MB/s transfers (160.000MHz DT|IU|RTI, 16bit)
(scsi1:A:4): 320.000MB/s transfers (160.000MHz DT|IU|RTI, 16bit)
(scsi1:A:5): 320.000MB/s transfers (160.000MHz DT|IU|RTI, 16bit)
  Vendor: IBM-ESXS  Model: VPR073C3-ETS10FN  Rev: S330
  Type:   Direct-Access                      ANSI SCSI revision: 04
scsi1:A:2:0: Tagged Queuing enabled.  Depth 32
  Vendor: IBM-ESXS  Model: VPR073C3-ETS10FN  Rev: S330
  Type:   Direct-Access                      ANSI SCSI revision: 04
scsi1:A:3:0: Tagged Queuing enabled.  Depth 32
  Vendor: IBM-ESXS  Model: VPR073C3-ETS10FN  Rev: S330
  Type:   Direct-Access                      ANSI SCSI revision: 04
scsi1:A:4:0: Tagged Queuing enabled.  Depth 32
  Vendor: IBM-ESXS  Model: VPR073C3-ETS10FN  Rev: S330
  Type:   Direct-Access                      ANSI SCSI revision: 04
scsi1:A:5:0: Tagged Queuing enabled.  Depth 32
  Vendor: IBM       Model: 02R0962a S320  1  Rev: 1   
  Type:   Processor                          ANSI SCSI revision: 02
SCSI device sda: 143374000 512-byte hdwr sectors (73407 MB)
SCSI device sda: drive cache: write through
SCSI device sda: 143374000 512-byte hdwr sectors (73407 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3 sda4 < sda5 >
Attached scsi disk sda at scsi1, channel 0, id 2, lun 0
SCSI device sdb: 143374000 512-byte hdwr sectors (73407 MB)
SCSI device sdb: drive cache: write through
SCSI device sdb: 143374000 512-byte hdwr sectors (73407 MB)
SCSI device sdb: drive cache: write through
 sdb:
Attached scsi disk sdb at scsi1, channel 0, id 3, lun 0
SCSI device sdc: 143374000 512-byte hdwr sectors (73407 MB)
SCSI device sdc: drive cache: write through
SCSI device sdc: 143374000 512-byte hdwr sectors (73407 MB)
SCSI device sdc: drive cache: write through
 sdc:
Attached scsi disk sdc at scsi1, channel 0, id 4, lun 0
SCSI device sdd: 143374000 512-byte hdwr sectors (73407 MB)
SCSI device sdd: drive cache: write through
SCSI device sdd: 143374000 512-byte hdwr sectors (73407 MB)
SCSI device sdd: drive cache: write through
 sdd:
Attached scsi disk sdd at scsi1, channel 0, id 5, lun 0
Attached scsi generic sg0 at scsi1, channel 0, id 2, lun 0,  type 0
Attached scsi generic sg1 at scsi1, channel 0, id 3, lun 0,  type 0
Attached scsi generic sg2 at scsi1, channel 0, id 4, lun 0,  type 0
Attached scsi generic sg3 at scsi1, channel 0, id 5, lun 0,  type 0
Attached scsi generic sg4 at scsi1, channel 0, id 8, lun 0,  type 3
ieee1394: raw1394: /dev/raw1394 device initialized
usbmon: debugs is not available
ACPI: PCI Interrupt Link [LP07] enabled at IRQ 5
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LP07] -> GSI 5 (level, low) -> IRQ 5
ehci_hcd 0000:00:1d.7: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 5, io mem 0xf0000000
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
irq 11: nobody cared (try booting with the "irqpoll" option.
 [<c103a3ef>] __report_bad_irq+0x2a/0x8d
 [<c1039c28>] handle_IRQ_event+0x39/0x6d
 [<c103a4eb>] note_interrupt+0x7f/0xe4
 [<c1039dc5>] __do_IRQ+0x169/0x194
 [<c1004cc6>] do_IRQ+0x1b/0x28
 [<c1003256>] common_interrupt+0x1a/0x20
 [<c101d61b>] __do_softirq+0x2b/0x88
 [<c101d69e>] do_softirq+0x26/0x2a
 [<c101d759>] irq_exit+0x33/0x35
 [<c1004ccb>] do_IRQ+0x20/0x28
 [<c1003256>] common_interrupt+0x1a/0x20
 [<c1018916>] release_console_sem+0x43/0xf6
 [<c101875f>] vprintk+0x16c/0x277
 [<c1074dd8>] d_lookup+0x23/0x46
 [<c10748ac>] d_alloc+0x136/0x1a6
 [<c10185ef>] printk+0x17/0x1b
 [<c120f33f>] hub_probe+0xa0/0x168
 [<c1096dd1>] sysfs_new_dirent+0x1f/0x64
 [<c120d37f>] usb_probe_interface+0x59/0x71
 [<c116c9b2>] driver_probe_device+0x2f/0xa7
 [<c116ca2a>] __device_attach+0x0/0x5
 [<c116c259>] bus_for_each_drv+0x58/0x78
 [<c116ca8f>] device_attach+0x60/0x64
 [<c116ca2a>] __device_attach+0x0/0x5
 [<c116c383>] bus_add_device+0x29/0xa6
 [<c116f9c7>] device_pm_add+0x56/0x9c
 [<c116b7c3>] device_add+0xc5/0x14a
 [<c121557e>] usb_set_configuration+0x346/0x528
 [<c120fa47>] usb_new_device+0xab/0x1be
 [<c120007b>] ohci_iso_recv_set_channel_mask+0x3/0xc6
 [<c12124e1>] register_root_hub+0xaf/0x162
 [<c12133bf>] usb_add_hcd+0x172/0x396
 [<c1217bce>] usb_hcd_pci_probe+0x26e/0x375
 [<c10284e7>] __call_usermodehelper+0x0/0x61
 [<c110cbe4>] pci_device_probe_static+0x40/0x54
 [<c110cc27>] __pci_device_probe+0x2f/0x42
 [<c110cc63>] pci_device_probe+0x29/0x47
 [<c116c9b2>] driver_probe_device+0x2f/0xa7
 [<c116ca93>] __driver_attach+0x0/0x43
 [<c116cad4>] __driver_attach+0x41/0x43
 [<c116c1c2>] bus_for_each_dev+0x5a/0x7a
 [<c116cafc>] driver_attach+0x26/0x2a
 [<c116ca93>] __driver_attach+0x0/0x43
 [<c116c5cb>] bus_add_driver+0x6b/0xa5
 [<c110ce97>] pci_register_driver+0x5e/0x7c
 [<c14246f5>] init+0x1d/0x25
 [<c140c7ed>] do_initcalls+0x54/0xb6
 [<c100029c>] init+0x0/0x10c
 [<c100029c>] init+0x0/0x10c
 [<c10002c6>] init+0x2a/0x10c
 [<c1001348>] kernel_thread_helper+0x0/0xb
 [<c100134d>] kernel_thread_helper+0x5/0xb
handlers:
[<c11e3421>] (ahd_linux_isr+0x0/0x284)
Disabling IRQ #11
hub 1-0:1.0: 4 ports detected
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LP00] -> GSI 5 (level, low) -> IRQ 5
uhci_hcd 0000:00:1d.0: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #1
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 5, io base 0x00002200
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LP03] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.1: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #2
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 11, io base 0x00002600
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 3-2: new full speed USB device using uhci_hcd and address 2
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
input: USB HID v1.10 Keyboard [IBM PPC I/F] on usb-0000:00:1d.1-2
input: USB HID v1.10 Mouse [IBM PPC I/F] on usb-0000:00:1d.1-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
Advanced Linux Sound Architecture Driver Version 1.0.9rc3  (Thu Mar 24 10:33:39 2005 UTC).
ALSA device list:
  No soundcards found.
oprofile: using timer interrupt.
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard on isa0060/serio0
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
ip_conntrack version 2.1 (640 buckets, 5120 max) - 212 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
input: PS/2 Generic Mouse on isa0060/serio1
ipt_recent v0.3.2: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices: 
PCI0 
ACPI: (supports S0 S4 S5)
Freeing unused kernel memory: 196k freed
Red Hat nash version 4.1.18 starting
Mounted /proc filesystem
Mounting sysfs
Creating /dev
Starting udev
Loading scsi_modscsi_mod: version magic '2.6.9-5.EL 686 REGPARM 4KSTACKS gcc-3.4' should be '2.6.12-rc5-mm1-16M preempt PENTIUM4 gcc-3.4'
.ko module
sd_mod: version magic '2.6.9-5.EL 686 REGPARM 4KSTACKS gcc-3.4' should be '2.6.12-rc5-mm1-16M preempt PENTIUM4 gcc-3.4'
insmod: error inaic79xx: version magic '2.6.9-5.EL 686 REGPARM 4KSTACKS gcc-3.4' should be '2.6.12-rc5-mm1-16M preempt PENTIUM4 gcc-3.4'
serting '/lib/scjbd: version magic '2.6.9-5.EL 686 REGPARM 4KSTACKS gcc-3.4' should be '2.6.12-rc5-mm1-16M preempt PENTIUM4 gcc-3.4'
si_mod.ko': -1 Iext3: version magic '2.6.9-5.EL 686 REGPARM 4KSTACKS gcc-3.4' should be '2.6.12-rc5-mm1-16M preempt PENTIUM4 gcc-3.4'
nvalid module format
ERROR: /bin/insmod exited abnormally!
Loading sd_mod.ko module
insmod: error inserting '/lib/sd_mod.ko': -1 Invalid module format
ERROR: /bin/insmod exited abnormally!
Loading aic79xx.ko module
insmod: error inserting '/lib/aic79xx.ko': -1 Invalid module format
ERROR: /bin/insmod exited abnormally!
Loading jbd.ko module
insmod: error inserting '/lib/jbd.ko': -1 Invalid module format
ERROR: /bin/insmod exited abnormally!
Loading ext3.ko module
insmod: error inserting '/lib/ext3.ko': -1 Invalid module format
ERROR: /bin/insmod exited abnormally!
Creating root device
Mounting root filesystem
scsi1:0:2:0: Attempting to abort cmd c4dbab00: 0x28 0x0 0x2 0x8f 0xf9 0x76 0x0 0x0 0x2 0x0
scsi1:0:2:0: Command already completed
scsi1:0:2:0: Attempting to abort cmd c4dbab00: 0x0 0x0 0x0 0x0 0x0 0x0
scsi1:0:2:0: Command already completed
Recovery code sleeping
Recovery code awake
Timer Expired
scsi1: Device reset returning 0x2003
Recovery SCB completes
scsi1:0:2:0: Attempting to abort cmd c4dbab00: 0x0 0x0 0x0 0x0 0x0 0x0
(scsi1:A:2:0): Task Management Func 0x0 Complete
Kernel panic - not syncing: Unexpected TaskMgmt Func

 

--eJnRUKwClWJh1Khz--

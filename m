Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbVLUR4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbVLUR4f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 12:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbVLUR4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 12:56:35 -0500
Received: from ns2.suse.de ([195.135.220.15]:22187 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751143AbVLUR4e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 12:56:34 -0500
Date: Wed, 21 Dec 2005 18:56:28 +0100
From: Olaf Hering <olh@suse.de>
To: Olof Johansson <olof@lixom.net>, Paul Mackeras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: Re: console on POWER4 not working with 2.6.15
Message-ID: <20051221175628.GA29363@suse.de>
References: <20051220204530.GA26351@suse.de> <20051220214525.GB7428@pb15.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20051220214525.GB7428@pb15.lixom.net>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Dec 20, Olof Johansson wrote:

> On Tue, Dec 20, 2005 at 09:45:30PM +0100, Olaf Hering wrote:
> > The connection of ttyS0 to /dev/console doesnt seem to work anymore mit
> > 2.6.15-rc5+6 on a POWER4 p630 in fullsystempartition mode, no HMC
> > connected. It works with 2.6.14.4.
> > I tested 2.6.15-rc6 arch/powerpc/configs/ppc64_defconfig.
> 
> It seems to have been broken a while: According to test.kernel.org (last
> machine in the matrix is an SMP mode p650), it broke between 2.6.14-git2
> and 2.6.14-git3. Console output can be found in:
> 
> http://test.kernel.org/15622/debug/console.log   for the failed one
> http://test.kernel.org/15530/debug/console.log   for the successful one

I finally managed to find the culprit.

good: 25635c71e44111a6bd48f342e144e2fc02d0a314
bad:  f9bd170a87948a9e077149b70fb192c563770fdf

...
powerpc: Merge i8259.c into arch/powerpc/sysdev

This changes the parameters for i8259_init so that it takes two
parameters: a physical address for generating an interrupt
acknowledge cycle, and an interrupt number offset.  i8259_init
now sets the irq_desc[] for its interrupts; all the callers
were doing this, and that code is gone now.  This also defines
a CONFIG_PPC_I8259 symbol to select i8259.o for inclusion, and
makes the platforms that need it select that symbol.
...

--- good.log	2005-12-21 18:45:30.268293213 +0100
+++ bad.log	2005-12-21 18:44:45.381519395 +0100
@@ -38,7 +38,7 @@
 boot stdout isn't a display !
 trying /pci@400000000112/pci@2,6/pci@1/display@0 ...
 result: 0
-Starting Linux PPC64 #18 SMP Wed Dec 21 18:27:31 CET 2005
+Starting Linux PPC64 #19 SMP Wed Dec 21 18:35:08 CET 2005
 -----------------------------------------------------
 ppc64_pft_size                = 0x1b
 ppc64_debug_switch            = 0x0
@@ -54,7 +54,7 @@
 -----------------------------------------------------
 [boot]0100 MM Init
 [boot]0100 MM Init Done
-Linux version 2.6.14-rc5 (olaf@pomegranate) (gcc version 3.3.3 (SuSE Linux)) #18 SMP Wed Dec 21 18:27:31 CET 2005
+Linux version 2.6.14-rc5 (olaf@pomegranate) (gcc version 3.3.3 (SuSE Linux)) #19 SMP Wed Dec 21 18:35:08 CET 2005
 [boot]0012 Setup Arch
 Syscall map setup, 241 32 bits and 221 64 bits syscalls
 EEH: PCI Enhanced I/O Error Handling Enabled
@@ -68,7 +68,7 @@
 [boot]0020 XICS Init
 [boot]0021 XICS Done
 PID hash table entries: 4096 (order: 12, 131072 bytes)
-time_init: decrementer frequency = 181.700926 MHz
+time_init: decrementer frequency = 181.701073 MHz
 time_init: processor frequency   = 1453.000000 MHz
 Found initrd at 0xc000000004535000:0xc000000004667a34
 firmware_features = 0x0
@@ -76,7 +76,7 @@
 boot stdout isn't a display !
 trying /pci@400000000112/pci@2,6/pci@1/display@0 ...
 result: 0
-Starting Linux PPC64 #18 SMP Wed Dec 21 18:27:31 CET 2005
+Starting Linux PPC64 #19 SMP Wed Dec 21 18:35:08 CET 2005
 -----------------------------------------------------
 ppc64_pft_size                = 0x1b
 ppc64_debug_switch            = 0x0
@@ -92,7 +92,7 @@
 -----------------------------------------------------
 [boot]0100 MM Init
 [boot]0100 MM Init Done
-Linux version 2.6.14-rc5 (olaf@pomegranate) (gcc version 3.3.3 (SuSE Linux)) #18 SMP Wed Dec 21 18:27:31 CET 2005
+Linux version 2.6.14-rc5 (olaf@pomegranate) (gcc version 3.3.3 (SuSE Linux)) #19 SMP Wed Dec 21 18:35:08 CET 2005
 [boot]0012 Setup Arch
 Syscall map setup, 241 32 bits and 221 64 bits syscalls
 EEH: PCI Enhanced I/O Error Handling Enabled
@@ -110,7 +110,7 @@
 [boot]0020 XICS Init
 [boot]0021 XICS Done
 PID hash table entries: 4096 (order: 12, 131072 bytes)
-time_init: decrementer frequency = 181.700926 MHz
+time_init: decrementer frequency = 181.701073 MHz
 time_init: processor frequency   = 1453.000000 MHz
 Console: colour dummy device 80x25
 Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
@@ -130,6 +130,7 @@
 Freeing initrd memory: 1226k freed
 NET: Registered protocol family 16
 PCI: Probing PCI hardware
+Failed to request PCI IO region on PCI domain 0000
 Using INTC for W82c105 IDE controller.
 IOMMU table initialized, virtual merging enabled
 mapping IO 3fd30000000 -> d000080000000000, size: 100000
@@ -234,8 +235,22 @@
  target1:0:0: Beginning Domain Validation
  target1:0:0: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 31)
  target1:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 31)
- target1:0:0: Domain Validation skipping write tests
+ 1:0:0:0: ABORT operation started.
+ 1:0:0:0: ABORT operation timed-out.
+ 1:0:0:0: DEVICE RESET operation started.
+ 1:0:0:0: DEVICE RESET operation complete.
+ target1:0:0: control msgout: c.
+sym1: TARGET 0 has been reset.
+ 1:0:0:0: ABORT operation started.
+ 1:0:0:0: ABORT operation complete.
+ 1:0:0:0: BUS RESET operation started.
+ 1:0:0:0: BUS RESET operation complete.
+sym1: SCSI BUS reset detected.
+sym1: SCSI BUS has been reset.
  target1:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 31)
+ target1:0:0: Wide Transfers Fail
+ target1:0:0: Domain Validation skipping write tests
+ target1:0:0: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 31)
  target1:0:0: Ending Domain Validation
 ipr: IBM Power RAID SCSI Device Driver version: 2.0.14 (May 2, 2005)
 vio_register_driver: driver ibmvscsi registering
@@ -284,26 +299,25 @@
 hub 4-0:1.0: 1 port detected
 usbcore: registered new driver hiddev
 usbcore: registered new driver usbhid
-/home/olaf/kernel/git/ps2-ppc64/linux-2.6-25635c71e44111a6bd48f342e144e2fc02d0a314/drivers/usb/input/hid-core.c: v2.6:USB HID core driver
+/home/olaf/kernel/git/ps2-ppc64/linux-2.6-f9bd170a87948a9e077149b70fb192c563770fdf/drivers/usb/input/hid-core.c: v2.6:USB HID core driver
 mice: PS/2 mouse device common for all mice
 i2c /dev entries driver
 md: linear personality registered as nr 1
+atkbd.c: keyboard reset failed on isa0060/serio1
 md: raid0 personality registered as nr 2
 md: raid1 personality registered as nr 3
 md: raid10 personality registered as nr 9
 md: raid5 personality registered as nr 4
 raid5: measuring checksumming speed
-   8regs     :  3434.000 MB/sec
-   8regs_prefetch:  3071.000 MB/sec
-atkbd.c: keyboard reset failed on isa0060/serio1
-   32regs    :  4735.000 MB/sec
-   32regs_prefetch:  3721.000 MB/sec
-raid5: using function: 32regs (4735.000 MB/sec)
+   8regs     : 54242.000 MB/sec
+   8regs_prefetch: 208256.000 MB/sec
+   32regs    :     1.000 MB/sec
+   32regs_prefetch:     1.000 MB/sec
+raid5: using function: 8regs_prefetch (208256.000 MB/sec)
 md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
 md: bitmap version 3.39
 device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
 oprofile: using ppc64/power4 performance monitoring.
-input: AT Raw Set 2 keyboard on isa0060/serio0
 NET: Registered protocol family 2
 IP route cache hash table entries: 524288 (order: 10, 4194304 bytes)
 TCP established hash table entries: 1048576 (order: 12, 16777216 bytes)
@@ -316,56 +330,12 @@
 NET: Registered protocol family 1
 NET: Registered protocol family 17
 Freeing unused kernel memory: 372k freed
- running (1:1) /init --login
-
-creating device nodes .[: [0-9]*: bad number
-[: [0-9]*: bad number
-[: [0-9]*: bad n 0:0:15:0: phase change 6-7 9@400503a8 resid=7.
-umber
-0:0:15:0: neither page 0x83 nor 0x80 supported
+input: AT Raw Set 2 keyboard on isa0060/serio0
+ 0:0:15:0: phase change 6-7 9@400503a8 resid=7.
 st0: Block limits 1 - 16777215 bytes.
-[: [0-9]*: bad number
-1:0:0:0: neither page 0x83 nor 0x80 supported
-[: [0-9]*: bad number
-1:0:0:0: neither page 0x83 nor 0x80 supported
-[: [0-9]*: bad number
-1:0:0:0: ioctl failed: 6
-1:0:0:0: Unable to get INQUIRY vpd 1 page 0x0.
-[: [0-9]*: bad number
-1:0:0:0: ioctl failed: 6
-1:0:0:0: Unable to get INQUIRY vpd 1 page 0x0.
-[: [0-9]*: bad number
-1:0:0:0: ioctl failed: 6
-1:0:0:0: Unable to get INQUIRY vpd 1 page 0x0.
-[: [0-9]*: bad number
-1:0:0:0: neither page 0x83 nor 0x80 supported
-[: [0-9]*: bad number
-1:0:0:0: ioctl failed: 6
-1:0:0:0: Unable to get INQUIRY vpd 1 page 0x0.
-[: [0-9]*: bad number
-1:0:0:0: ioctl failed: 6
-1:0:0:0: Unable to get INQUIRY vpd 1 page 0x0.
-[: [0-9]*: bad number
-1:0:0:0: ioctl failed: 6
-1:0:0:0: Unable to get INQUIRY vpd 1 page 0x0.
-[: [0-9]*: bad number
-[: [0-9]*: bad number
-[: [0-9]*: bad number
-[: [0-9]*: bad number
-[: [0-9]*: bad number
-[: [0-9]*: bad number
-[: [0-9]*: bad number
-..
-mount  -o ro /deReiserFS: sda4: found reiserfs format "3.6" with standard journal
-v/sda4
+ReiserFS: sda4: found reiserfs format "3.6" with standard journal
 ReiserFS: sda4: using ordered data mode
 ReiserFS: sda4: journal params: device sda4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
 ReiserFS: sda4: checking transaction log (sda4)
 ReiserFS: sda4: Using r5 hash to sort names
-mknod: `/dev/fb0': File exists
-mknod: `/dev/fb1': File exists
-(none):/# /sbin/reboot -f
-md: stopping all md devices.
-Restarting system.
-.
 



-- 
short story of a lazy sysadmin:
 alias appserv=wotan

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318147AbSGRQAR>; Thu, 18 Jul 2002 12:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318227AbSGRQAR>; Thu, 18 Jul 2002 12:00:17 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:23702 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S318182AbSGRQAD>; Thu, 18 Jul 2002 12:00:03 -0400
Date: Thu, 18 Jul 2002 18:02:59 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: input subsystem config ?
Message-ID: <20020718160259.GE2326@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Vojtech Pavlik <vojtech@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20020717162904.B19935@ucw.cz> <20020717145523.GJ14581@tahoe.alcove-fr> <20020717172235.A20474@ucw.cz> <20020717153336.GK14581@tahoe.alcove-fr> <20020718144130.GB2326@tahoe.alcove-fr> <20020718164536.A30363@ucw.cz> <20020718144838.GC2326@tahoe.alcove-fr> <20020718171531.A30511@ucw.cz> <20020718152829.GD2326@tahoe.alcove-fr> <20020718173132.A30621@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <20020718173132.A30621@ucw.cz>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 18, 2002 at 05:31:32PM +0200, Vojtech Pavlik wrote:

> > I'm not sure about that. It will not work if I do not disable the
> > 'return -1' because the irq will get freed, so the driver will have
> > no chance to get any mouse event.
> 
> Actually, no. It also polls the chip repeatedly without needing an irq,
> so it can receive bytes even when no irq happens.

Ok, tried again and I confirm again, no events from the mouse.

> > Maybe I should put some debug statements in the pc_keyb.c interrupt
> > handler and see if the mouse does answer the control commands ?
> 
> That's a good idea, yes.

Ok, the mouse seems to answer the control commands. See the
attached files:
	DIFFS: the diffs I made to put tracing into 
		include/asm-i386/keyboard.h and drivers/char/pc_keyb.c
	DMESG-INPUT: kernel logs when input drivers are activated
	DMESG-NOINPUT: good old pc_keyb.c driver :-)

At the end of each DMESG files I tried to type on the keyboard and
move the mouse. In the first you have only the keyboard events, in
the second both of them.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=DIFFS

===== include/asm/keyboard.h 1.4 vs edited =====
--- 1.4/include/asm-i386/keyboard.h	Tue Feb  5 08:55:11 2002
+++ edited/include/asm/keyboard.h	Thu Jul 18 16:56:40 2002
@@ -48,11 +48,26 @@
 #define kbd_request_irq(handler) request_irq(KEYBOARD_IRQ, handler, 0, \
                                              "keyboard", NULL)
 
+#define KBD_DATA_REG            0x60    /* Keyboard data register (R/W) */
+#define KBD_STATUS_REG          0x64    /* Status register (R) */
+
 /* How to access the keyboard macros on this platform.  */
-#define kbd_read_input() inb(KBD_DATA_REG)
-#define kbd_read_status() inb(KBD_STATUS_REG)
-#define kbd_write_output(val) outb(val, KBD_DATA_REG)
-#define kbd_write_command(val) outb(val, KBD_CNTL_REG)
+static inline char kbd_read_input(void) { 
+	unsigned char tmp = inb(KBD_DATA_REG); 
+	printk("%02x <- KBD.C (input)\n", tmp); 
+	return tmp;
+}
+
+static inline char kbd_read_status(void) {
+	unsigned char tmp = inb(KBD_STATUS_REG); 
+	printk("%02x <- KBD.C (status)\n", tmp); 
+	return tmp;
+}
+
+#define kbd_write_output(val) \
+	{ printk("%02x -> KBD.C (output)\n", val); outb(val, KBD_DATA_REG); }
+#define kbd_write_command(val) \
+	{ printk("%02x -> KBD.C (command)\n", val); outb(val, KBD_CNTL_REG); }
 
 /* Some stoneage hardware needs delays after some operations.  */
 #define kbd_pause() do { } while(0)
===== drivers/char/pc_keyb.c 1.16 vs edited =====
--- 1.16/drivers/char/pc_keyb.c	Wed Jul 10 02:06:27 2002
+++ edited/drivers/char/pc_keyb.c	Thu Jul 18 17:00:42 2002
@@ -70,7 +70,7 @@
 #endif
 
 static spinlock_t kbd_controller_lock = SPIN_LOCK_UNLOCKED;
-static unsigned char handle_kbd_event(void);
+static unsigned char handle_kbd_event(int irq);
 
 /* used only by send_data - set by keyboard_interrupt */
 static volatile unsigned char reply_expected;
@@ -122,7 +122,7 @@
 		 * "handle_kbd_event()" will handle any incoming events
 		 * while we wait - keypresses or mouse movement.
 		 */
-		unsigned char status = handle_kbd_event();
+		unsigned char status = handle_kbd_event(0);
 
 		if (! (status & KBD_STAT_IBF))
 			return;
@@ -487,7 +487,7 @@
  * It requires that we hold the keyboard controller
  * spinlock.
  */
-static unsigned char handle_kbd_event(void)
+static unsigned char handle_kbd_event(int irq)
 {
 	unsigned char status = kbd_read_status();
 	unsigned int work = 10000;
@@ -504,11 +504,16 @@
 		if (!(status & (KBD_STAT_GTO | KBD_STAT_PERR)))
 #endif
 		{
+			printk("%02x <- KBD.C (interrupt, %s, %d)\n",
+				scancode, (status & KBD_STAT_MOUSE_OBF) ? "aux" : "kbd", irq);
 			if (status & KBD_STAT_MOUSE_OBF)
 				handle_mouse_event(scancode);
 			else
 				handle_keyboard_event(scancode);
 		}
+		else
+			printk("%02x <- KBD.C (FAKE interrupt, %s, %d)\n",
+				scancode, (status & KBD_STAT_MOUSE_OBF) ? "aux" : "kbd", irq);
 
 		status = kbd_read_status();
 	}
@@ -527,7 +532,7 @@
 #endif
 
 	spin_lock_irq(&kbd_controller_lock);
-	handle_kbd_event();
+	handle_kbd_event(irq);
 	spin_unlock_irq(&kbd_controller_lock);
 }
 

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=DMESG-INPUT

Linux version 2.5.26 (tiniou@crusoe.alcove-fr) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #2 Thu Jul 18 17:02:17 CEST 2002
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009b800 (usable)
 BIOS-e820: 000000000009b800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000006ff0000 (usable)
 BIOS-e820: 0000000006ff0000 - 0000000006fff800 (ACPI data)
 BIOS-e820: 0000000006fff800 - 0000000007000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
111MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 28656
zone(0): 4096 pages.
zone(1): 24560 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 SONY                       ) @ 0x000f8070
ACPI: RSDT (v001 SONY   P1       08193.02342) @ 0x06ffcfbe
ACPI: FADT (v002 SONY   P1       08193.02342) @ 0x06fff754
ACPI: BOOT (v001 SONY   P1       08193.02342) @ 0x06fff7d8
Sony Vaio laptop detected.
Kernel command line: ro root=/dev/hda2 LOCATION=work
Initializing CPU#0
Detected 595.655 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1026.04 BogoMIPS
Memory: 111336k/114624k available (1147k kernel code, 2884k reserved, 294k data, 192k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 0080803f 00000000 00000006, vendor = 7
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 512K (128 bytes/line)
CPU: Processor revision 1.3.1.3, 600 MHz
CPU: Code Morphing Software revision 4.1.4-7-51
CPU: 20000805 23:30 official release 4.1.4#2
CPU: After vendor init, caps: 0080813f 00000000 00000006 00000000
CPU:     After generic, caps: 0080813f 00000000 00000006 00000000
CPU:             Common caps: 0080813f 00000000 00000006 00000000
CPU: Transmeta(tm) Crusoe(tm) Processor TM5600 stepping 03
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: none
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd98e, last bus=0
PCI: Using configuration type 1
ACPI: Subsystem revision 20020702
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:..................................................................................................................
Table [DSDT] - 429 Objects with 35 Devices 114 Methods 14 Regions
ACPI Namespace successfully loaded at root c02ac5dc
evxfevnt-0076 [04] Acpi_enable           : Transition to ACPI mode successful
Executing all Device _STA and_INI methods:...................................
35 Devices found containing: 35 _STA, 2 _INI methods
Completing Region/Field/Buffer/Package initialization:............................................
Initialized 8/14 Regions 0/0 Fields 19/19 Buffers 17/17 Packages (429 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
pci_bind-0191 [94] acpi_pci_bind         : Device 00:00:0a.00 not present in PCI namespace
ACPI: Embedded Controller [EC0] (gpe 9)
ACPI: PCI Interrupt Link [LNKA] (IRQs *9)
ACPI: PCI Interrupt Link [LNKB] (IRQs *9)
ACPI: PCI Interrupt Link [LNKC] (IRQs *9)
ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
ACPI: Power Resource [LRP0] (off)
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi'
PCI: Cannot allocate resource region 4 of device 00:07.1
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
ACPI: AC Adapter [ACAD] (off-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PWRB]
ACPI: Fan [LRA0] (off)
acpi_processor-0897 [173] acpi_processor_get_per: Unsupported address space [127] (control_register)
ACPI: Processor [CPU0] (supports C1 C2 C3)
ACPI: Thermal Zone [ATF0] (64 C)
1c <- KBD.C (status)
ed -> KBD.C (output)
keyboard: Timeout - AT keyboard not present?(ed)
15 <- KBD.C (status)
fa <- KBD.C (input)
fa <- KBD.C (interrupt, kbd, 0)
14 <- KBD.C (status)
f4 -> KBD.C (output)
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
block: 256 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
ATA/ATAPI device driver v7.0.0
ATA: PCI bus speed 33.3MHz
ATA: Intel Corp. 82371AB PIIX4 IDE, PCI slot 00:07.1
ATA: chipset rev.: 1
ATA: non-legacy mode: IRQ probe delayed
PIIX: Intel Corp. 82371AB PIIX4 IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0x1090-0x1097, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1098-0x109f, BIOS settings: hdc:pio, hdd:pio
hda: HITACHI_DK23AA-12, DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 hda: 23579136 sectors w/512KiB Cache, CHS=23392/16/63, UDMA(33)
 hda: [PTBL] [1467/255/63] hda1 hda2 hda3 < hda5 hda6 >
mice: PS/2 mouse device common for all mice
i8042.c: fa <- i8042 (flush, kbd) [0]
i8042.c: 20 -> i8042 (command) [0]
i8042.c: 47 <- i8042 (return) [0]
i8042.c: 60 -> i8042 (command) [0]
i8042.c: 56 -> i8042 (parameter) [0]
i8042.c: d3 -> i8042 (command) [1]
i8042.c: 5a -> i8042 (parameter) [1]
i8042.c: a5 <- i8042 (return) [1]
i8042.c: a9 -> i8042 (command) [1]
i8042.c: 00 <- i8042 (return) [1]
i8042.c: a7 -> i8042 (command) [1]
i8042.c: 20 -> i8042 (command) [1]
i8042.c: 76 <- i8042 (return) [1]
i8042.c: a9 -> i8042 (command) [2]
i8042.c: 00 <- i8042 (return) [2]
i8042.c: a8 -> i8042 (command) [2]
i8042.c: 20 -> i8042 (command) [2]
i8042.c: 56 <- i8042 (return) [2]
i8042.c: 60 -> i8042 (command) [2]
i8042.c: 74 -> i8042 (parameter) [2]
i8042.c: 60 -> i8042 (command) [2]
i8042.c: 54 -> i8042 (parameter) [2]
i8042.c: 60 -> i8042 (command) [3]
i8042.c: 56 -> i8042 (parameter) [3]
i8042.c: d4 -> i8042 (command) [3]
i8042.c: f6 -> i8042 (parameter) [3]
i8042.c: 60 -> i8042 (command) [3]
i8042.c: 56 -> i8042 (parameter) [3]
i8042.c: 60 -> i8042 (command) [91]
i8042.c: 54 -> i8042 (parameter) [91]
i8042.c: 60 -> i8042 (command) [92]
i8042.c: 56 -> i8042 (parameter) [92]
i8042.c: d4 -> i8042 (command) [92]
i8042.c: f5 -> i8042 (parameter) [92]
i8042.c: 60 -> i8042 (command) [92]
i8042.c: 56 -> i8042 (parameter) [92]
i8042.c: 60 -> i8042 (command) [180]
i8042.c: 54 -> i8042 (parameter) [180]
serio: i8042 AUX port at 0x60,0x64 irq 12
i8042.c: 60 -> i8042 (command) [180]
i8042.c: 44 -> i8042 (parameter) [180]
i8042.c: 60 -> i8042 (command) [180]
i8042.c: 45 -> i8042 (parameter) [180]
i8042.c: f6 -> i8042 (kbd-data) [180]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [183]
i8042.c: f2 -> i8042 (kbd-data) [183]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [186]
i8042.c: ab <- i8042 (interrupt, kbd, 1) [192]
i8042.c: 60 -> i8042 (command) [192]
i8042.c: 44 -> i8042 (parameter) [192]
i8042.c: 60 -> i8042 (command) [192]
i8042.c: 45 -> i8042 (parameter) [192]
i8042.c: f5 -> i8042 (kbd-data) [192]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [195]
i8042.c: f2 -> i8042 (kbd-data) [195]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [198]
i8042.c: ab <- i8042 (interrupt, kbd, 1) [203]
i8042.c: 41 <- i8042 (interrupt, kbd, 1) [208]
i8042.c: ea -> i8042 (kbd-data) [208]
i8042.c: fe <- i8042 (interrupt, kbd, 1) [211]
i8042.c: f0 -> i8042 (kbd-data) [211]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [214]
i8042.c: 02 -> i8042 (kbd-data) [214]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [216]
i8042.c: f0 -> i8042 (kbd-data) [216]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [219]
i8042.c: 00 -> i8042 (kbd-data) [219]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [222]
i8042.c: 41 <- i8042 (interrupt, kbd, 1) [224]
input.c: calling /sbin/hotplug input [HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add PRODUCT=11/1/2/ab02 NAME=AT Set 2 keyboard]
input.c: hotplug returned -2
input: AT Set 2 keyboard on isa0060/serio0
i8042.c: f8 -> i8042 (kbd-data) [227]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [230]
i8042.c: ed -> i8042 (kbd-data) [230]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [233]
i8042.c: 00 -> i8042 (kbd-data) [234]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [239]
i8042.c: f4 -> i8042 (kbd-data) [239]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [242]
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 192k freed
Adding 530104k swap on /dev/hda5.  Priority:-1 extents:1
usb.c: registered new driver usbfs
usb.c: registered new driver hub
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,2), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
FAT: Using codepage cp437
FAT: Using IO charset iso8859-1
uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
hcd-pci.c: uhci-hcd @ 00:07.2, Intel Corp. 82371AB PIIX4 USB
hcd-pci.c: irq 9, io base 00001060
hcd.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found at /
hub.c: 2 ports detected
hcd-pci.c: remove: 00:07.2, state 3
usb.c: USB disconnect on device 1
usb.c: USB disconnect on device 1
hcd.c: USB bus 1 deregistered
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
SCSI subsystem driver Revision: 1.00
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.0 (895 buckets, 7160 max) - 292 bytes per conntrack
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
ds: no socket drivers loaded!
unloading Kernel Card Services
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Yenta IRQ list 0cb8, PCI irq9
Socket status: 30000419
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x370-0x377 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
eth0: NE2000 Compatible: io 0x300, irq 3, hw_addr 00:50:BA:8E:38:DE
i8042.c: 39 <- i8042 (interrupt, kbd, 1) [87790]
i8042.c: b9 <- i8042 (interrupt, kbd, 1) [87894]
i8042.c: 39 <- i8042 (interrupt, kbd, 1) [88077]
i8042.c: b9 <- i8042 (interrupt, kbd, 1) [88193]
i8042.c: 23 <- i8042 (interrupt, kbd, 1) [100363]
i8042.c: a3 <- i8042 (interrupt, kbd, 1) [100463]
spurious 8259A interrupt: IRQ7.

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=DMESG-NOINPUT

Linux version 2.5.26 (tiniou@crusoe.alcove-fr) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #2 Thu Jul 18 17:02:17 CEST 2002
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009b800 (usable)
 BIOS-e820: 000000000009b800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000006ff0000 (usable)
 BIOS-e820: 0000000006ff0000 - 0000000006fff800 (ACPI data)
 BIOS-e820: 0000000006fff800 - 0000000007000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
111MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 28656
zone(0): 4096 pages.
zone(1): 24560 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 SONY                       ) @ 0x000f8070
ACPI: RSDT (v001 SONY   P1       08193.02342) @ 0x06ffcfbe
ACPI: FADT (v002 SONY   P1       08193.02342) @ 0x06fff754
ACPI: BOOT (v001 SONY   P1       08193.02342) @ 0x06fff7d8
Sony Vaio laptop detected.
Kernel command line: ro root=/dev/hda2 LOCATION=work
Initializing CPU#0
Detected 595.655 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1026.04 BogoMIPS
Memory: 111336k/114624k available (1147k kernel code, 2884k reserved, 294k data, 192k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 0080803f 00000000 00000006, vendor = 7
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 512K (128 bytes/line)
CPU: Processor revision 1.3.1.3, 600 MHz
CPU: Code Morphing Software revision 4.1.4-7-51
CPU: 20000805 23:30 official release 4.1.4#2
CPU: After vendor init, caps: 0080813f 00000000 00000006 00000000
CPU:     After generic, caps: 0080813f 00000000 00000006 00000000
CPU:             Common caps: 0080813f 00000000 00000006 00000000
CPU: Transmeta(tm) Crusoe(tm) Processor TM5600 stepping 03
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: none
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd98e, last bus=0
PCI: Using configuration type 1
ACPI: Subsystem revision 20020702
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:..................................................................................................................
Table [DSDT] - 429 Objects with 35 Devices 114 Methods 14 Regions
ACPI Namespace successfully loaded at root c02ac5dc
evxfevnt-0076 [04] Acpi_enable           : Transition to ACPI mode successful
Executing all Device _STA and_INI methods:...................................
35 Devices found containing: 35 _STA, 2 _INI methods
Completing Region/Field/Buffer/Package initialization:............................................
Initialized 8/14 Regions 0/0 Fields 19/19 Buffers 17/17 Packages (429 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
pci_bind-0191 [94] acpi_pci_bind         : Device 00:00:0a.00 not present in PCI namespace
ACPI: Embedded Controller [EC0] (gpe 9)
ACPI: PCI Interrupt Link [LNKA] (IRQs *9)
ACPI: PCI Interrupt Link [LNKB] (IRQs *9)
ACPI: PCI Interrupt Link [LNKC] (IRQs *9)
ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
ACPI: Power Resource [LRP0] (off)
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi'
PCI: Cannot allocate resource region 4 of device 00:07.1
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
ACPI: AC Adapter [ACAD] (off-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PWRB]
ACPI: Fan [LRA0] (off)
acpi_processor-0897 [173] acpi_processor_get_per: Unsupported address space [127] (control_register)
ACPI: Processor [CPU0] (supports C1 C2 C3)
ACPI: Thermal Zone [ATF0] (64 C)
1c <- KBD.C (status)
a7 -> KBD.C (command)
1e <- KBD.C (status)
1c <- KBD.C (status)
60 -> KBD.C (command)
1e <- KBD.C (status)
1c <- KBD.C (status)
65 -> KBD.C (output)
14 <- KBD.C (status)
ed -> KBD.C (output)
15 <- KBD.C (status)
fa <- KBD.C (input)
fa <- KBD.C (interrupt, kbd, 1)
14 <- KBD.C (status)
14 <- KBD.C (status)
00 -> KBD.C (output)
15 <- KBD.C (status)
fa <- KBD.C (input)
fa <- KBD.C (interrupt, kbd, 1)
14 <- KBD.C (status)
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
block: 256 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
ATA/ATAPI device driver v7.0.0
ATA: PCI bus speed 33.3MHz
ATA: Intel Corp. 82371AB PIIX4 IDE, PCI slot 00:07.1
ATA: chipset rev.: 1
ATA: non-legacy mode: IRQ probe delayed
PIIX: Intel Corp. 82371AB PIIX4 IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0x1090-0x1097, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1098-0x109f, BIOS settings: hdc:pio, hdd:pio
hda: HITACHI_DK23AA-12, DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 hda: 23579136 sectors w/512KiB Cache, CHS=23392/16/63, UDMA(33)
 hda: [PTBL] [1467/255/63] hda1 hda2 hda3 < hda5 hda6 >
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 192k freed
Adding 530104k swap on /dev/hda5.  Priority:-1 extents:1
usb.c: registered new driver usbfs
usb.c: registered new driver hub
uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
hcd-pci.c: uhci-hcd @ 00:07.2, Intel Corp. 82371AB PIIX4 USB
hcd-pci.c: irq 9, io base 00001060
hcd.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found at /
hub.c: 2 ports detected
hub.c: new USB device 00:07.2-2, assigned address 2
spurious 8259A interrupt: IRQ7.
usb.c: USB device 2 (vend/prod 0x54c/0x32) is not claimed by any active driver.
SCSI subsystem driver Revision: 1.00
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: Sony      Model: MSC-U01N          Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
USB Mass Storage support registered.
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,2), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
FAT: Using codepage cp437
FAT: Using IO charset iso8859-1
14 <- KBD.C (status)
a8 -> KBD.C (command)
1e <- KBD.C (status)
1c <- KBD.C (status)
d4 -> KBD.C (command)
1e <- KBD.C (status)
1c <- KBD.C (status)
f4 -> KBD.C (output)
14 <- KBD.C (status)
14 <- KBD.C (status)
60 -> KBD.C (command)
1e <- KBD.C (status)
1e <- KBD.C (status)
1e <- KBD.C (status)
1e <- KBD.C (status)
1e <- KBD.C (status)
1e <- KBD.C (status)
1e <- KBD.C (status)
1e <- KBD.C (status)
3d <- KBD.C (status)
fa <- KBD.C (input)
fa <- KBD.C (interrupt, aux, 0)
3c <- KBD.C (status)
47 -> KBD.C (output)
34 <- KBD.C (status)
f4 -> KBD.C (output)
15 <- KBD.C (status)
fa <- KBD.C (input)
fa <- KBD.C (interrupt, kbd, 1)
14 <- KBD.C (status)
14 <- KBD.C (status)
d4 -> KBD.C (command)
1e <- KBD.C (status)
1c <- KBD.C (status)
ffffffff -> KBD.C (output)
35 <- KBD.C (status)
fa <- KBD.C (input)
fa <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
aa <- KBD.C (input)
aa <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
00 <- KBD.C (input)
00 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
34 <- KBD.C (status)
d4 -> KBD.C (command)
3e <- KBD.C (status)
3c <- KBD.C (status)
fffffff4 -> KBD.C (output)
35 <- KBD.C (status)
fa <- KBD.C (input)
fa <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
34 <- KBD.C (status)
d4 -> KBD.C (command)
3e <- KBD.C (status)
3c <- KBD.C (status)
fffffff2 -> KBD.C (output)
35 <- KBD.C (status)
fa <- KBD.C (input)
fa <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
00 <- KBD.C (input)
00 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
34 <- KBD.C (status)
d4 -> KBD.C (command)
3e <- KBD.C (status)
3c <- KBD.C (status)
fffffff3 -> KBD.C (output)
35 <- KBD.C (status)
fa <- KBD.C (input)
fa <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
34 <- KBD.C (status)
d4 -> KBD.C (command)
3e <- KBD.C (status)
3c <- KBD.C (status)
ffffffc8 -> KBD.C (output)
35 <- KBD.C (status)
fa <- KBD.C (input)
fa <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
34 <- KBD.C (status)
d4 -> KBD.C (command)
3e <- KBD.C (status)
3c <- KBD.C (status)
fffffff3 -> KBD.C (output)
35 <- KBD.C (status)
fa <- KBD.C (input)
fa <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
34 <- KBD.C (status)
d4 -> KBD.C (command)
3e <- KBD.C (status)
3c <- KBD.C (status)
64 -> KBD.C (output)
35 <- KBD.C (status)
fa <- KBD.C (input)
fa <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
34 <- KBD.C (status)
d4 -> KBD.C (command)
3e <- KBD.C (status)
3c <- KBD.C (status)
fffffff3 -> KBD.C (output)
35 <- KBD.C (status)
fa <- KBD.C (input)
fa <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
34 <- KBD.C (status)
d4 -> KBD.C (command)
3e <- KBD.C (status)
3c <- KBD.C (status)
50 -> KBD.C (output)
35 <- KBD.C (status)
fa <- KBD.C (input)
fa <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
34 <- KBD.C (status)
d4 -> KBD.C (command)
3e <- KBD.C (status)
3c <- KBD.C (status)
fffffff2 -> KBD.C (output)
35 <- KBD.C (status)
fa <- KBD.C (input)
fa <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
00 <- KBD.C (input)
00 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
34 <- KBD.C (status)
d4 -> KBD.C (command)
3e <- KBD.C (status)
3c <- KBD.C (status)
ffffffff -> KBD.C (output)
35 <- KBD.C (status)
fa <- KBD.C (input)
fa <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
aa <- KBD.C (input)
aa <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
00 <- KBD.C (input)
00 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
34 <- KBD.C (status)
d4 -> KBD.C (command)
3e <- KBD.C (status)
3c <- KBD.C (status)
fffffff4 -> KBD.C (output)
35 <- KBD.C (status)
fa <- KBD.C (input)
fa <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
34 <- KBD.C (status)
d4 -> KBD.C (command)
3e <- KBD.C (status)
3c <- KBD.C (status)
fffffff2 -> KBD.C (output)
35 <- KBD.C (status)
fa <- KBD.C (input)
fa <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
00 <- KBD.C (input)
00 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
34 <- KBD.C (status)
60 -> KBD.C (command)
3e <- KBD.C (status)
3c <- KBD.C (status)
65 -> KBD.C (output)
34 <- KBD.C (status)
a7 -> KBD.C (command)
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
sda : READ CAPACITY failed.
sda : status=0, message=00, host=7, driver=00 
sda : sense not available. 
sda: test WP failed, assume Write Enabled
 sda:SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 70000
end_request: I/O error, dev 08:00, sector 0
Buffer I/O error on device sd(8,0), logical block 0
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 70000
end_request: I/O error, dev 08:00, sector 0
Buffer I/O error on device sd(8,0), logical block 0
 unable to read partition table
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.0 (895 buckets, 7160 max) - 292 bytes per conntrack
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
ds: no socket drivers loaded!
unloading Kernel Card Services
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Yenta IRQ list 0cb8, PCI irq9
Socket status: 30000419
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x370-0x377 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
eth0: NE2000 Compatible: io 0x300, irq 3, hw_addr 00:50:BA:8E:38:DE
3c <- KBD.C (status)
a8 -> KBD.C (command)
3c <- KBD.C (status)
d4 -> KBD.C (command)
3e <- KBD.C (status)
3c <- KBD.C (status)
f4 -> KBD.C (output)
34 <- KBD.C (status)
34 <- KBD.C (status)
60 -> KBD.C (command)
3e <- KBD.C (status)
3e <- KBD.C (status)
3e <- KBD.C (status)
3d <- KBD.C (status)
fa <- KBD.C (input)
fa <- KBD.C (interrupt, aux, 0)
3c <- KBD.C (status)
47 -> KBD.C (output)
34 <- KBD.C (status)
f4 -> KBD.C (output)
15 <- KBD.C (status)
fa <- KBD.C (input)
fa <- KBD.C (interrupt, kbd, 1)
14 <- KBD.C (status)
15 <- KBD.C (status)
39 <- KBD.C (input)
39 <- KBD.C (interrupt, kbd, 1)
14 <- KBD.C (status)
15 <- KBD.C (status)
b9 <- KBD.C (input)
b9 <- KBD.C (interrupt, kbd, 1)
14 <- KBD.C (status)
35 <- KBD.C (status)
08 <- KBD.C (input)
08 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
02 <- KBD.C (input)
02 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
00 <- KBD.C (input)
00 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
08 <- KBD.C (input)
08 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
01 <- KBD.C (input)
01 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
00 <- KBD.C (input)
00 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
08 <- KBD.C (input)
08 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
02 <- KBD.C (input)
02 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
01 <- KBD.C (input)
01 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
08 <- KBD.C (input)
08 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
03 <- KBD.C (input)
03 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
00 <- KBD.C (input)
00 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
08 <- KBD.C (input)
08 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
05 <- KBD.C (input)
05 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
00 <- KBD.C (input)
00 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
08 <- KBD.C (input)
08 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
07 <- KBD.C (input)
07 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
01 <- KBD.C (input)
01 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
08 <- KBD.C (input)
08 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
08 <- KBD.C (input)
08 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
01 <- KBD.C (input)
01 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
08 <- KBD.C (input)
08 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
0a <- KBD.C (input)
0a <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
00 <- KBD.C (input)
00 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
08 <- KBD.C (input)
08 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
09 <- KBD.C (input)
09 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
01 <- KBD.C (input)
01 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
08 <- KBD.C (input)
08 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
0a <- KBD.C (input)
0a <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
00 <- KBD.C (input)
00 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
08 <- KBD.C (input)
08 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
09 <- KBD.C (input)
09 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
00 <- KBD.C (input)
00 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
08 <- KBD.C (input)
08 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
0a <- KBD.C (input)
0a <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
01 <- KBD.C (input)
01 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
08 <- KBD.C (input)
08 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
09 <- KBD.C (input)
09 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
00 <- KBD.C (input)
00 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
08 <- KBD.C (input)
08 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
05 <- KBD.C (input)
05 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
00 <- KBD.C (input)
00 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
08 <- KBD.C (input)
08 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
05 <- KBD.C (input)
05 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
00 <- KBD.C (input)
00 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
08 <- KBD.C (input)
08 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
04 <- KBD.C (input)
04 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
00 <- KBD.C (input)
00 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
08 <- KBD.C (input)
08 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
05 <- KBD.C (input)
05 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)
35 <- KBD.C (status)
00 <- KBD.C (input)
00 <- KBD.C (interrupt, aux, 12)
34 <- KBD.C (status)

--ibTvN161/egqYuK8--

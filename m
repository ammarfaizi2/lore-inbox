Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264436AbTEaUh2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 16:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264442AbTEaUh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 16:37:28 -0400
Received: from camus.xss.co.at ([194.152.162.19]:48140 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S264436AbTEaUhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 16:37:09 -0400
Message-ID: <3ED9158E.2080904@xss.co.at>
Date: Sat, 31 May 2003 22:50:22 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21rc6-ac1
References: <200305311153.h4VBrNi21640@devserv.devel.redhat.com>
In-Reply-To: <200305311153.h4VBrNi21640@devserv.devel.redhat.com>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010009080108000007030409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010009080108000007030409
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi!

Alan Cox wrote:
> Linux 2.4.21rc6-ac1
[...]
> o	Update ACPI to next Intel release		(Bernhard Rosenkraenzer)
[...]

There seem to be some problems with this:

1.) drivers/hotplug/acpiphp_glue.c doesn't compile
    I made the following patch to make it compile again.
    I hope it is ok, please check (I don't have any PCI
    hotplug device, so I can't test it myself).

--- acpiphp_glue.c.orig Sat May 31 20:24:42 2003
+++ acpiphp_glue.c      Sat May 31 20:38:26 2003
@@ -807,27 +807,33 @@
 find_host_bridge (acpi_handle handle, u32 lvl, void *context, void **rv)
 {
        acpi_status status;
-       struct acpi_device_info info;
+       struct acpi_device_info *info;
        char objname[5];
-       struct acpi_buffer buffer = { .length = sizeof(objname),
-                                     .pointer = objname };
+       struct acpi_buffer buffer;

-       status = acpi_get_object_info(handle, &info);
+       buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
+       buffer.pointer = NULL;
+       status = acpi_get_object_info(handle, &buffer);
        if (ACPI_FAILURE(status)) {
                dbg("%s: failed to get bridge information\n", __FUNCTION__);
                return AE_OK;           /* continue */
        }

-       info.hardware_id[sizeof(info.hardware_id)-1] = '\0';
+       info = buffer.pointer;
+       info->hardware_id.value[sizeof(info->hardware_id.value)-1] = '\0';

        /* TBD use acpi_get_devices() API */
-       if (info.current_status &&
-           (info.valid & ACPI_VALID_HID) &&
-           strcmp(info.hardware_id, ACPI_PCI_HOST_HID) == 0) {
+       if (info->current_status &&
+           (info->valid & ACPI_VALID_HID) &&
+           strcmp(info->hardware_id.value, ACPI_PCI_HOST_HID) == 0) {
+               buffer.length = sizeof(objname);
+               buffer.pointer = objname;
                acpi_get_name(handle, ACPI_SINGLE_NAME, &buffer);
                dbg("checking PCI-hotplug capable bridges under [%s]\n", objname);
                add_bridges(handle);
        }
+       ACPI_MEM_FREE (info);
+
        return AE_OK;
 }


2.) ACPI itself doesn't work right anymore and makes the system
    unusable... :-(
    It did work with the last AC kernel I tried (2.4.21-rc2-ac2)

    Symptoms are:
    No ethernet, NIC (Intel eepro100) doesn't get interrupts,
    ACPI interrupt "storm" (millions of IRQ in a few minutes)

    Booting with "acpi=off" makes the system work again, but without
    ACPI, of course.

    Here are a few more infos from the running system:

    Asus P4B motherboard, P4 1.6GHz processor, 1.2GB RAM

root@install:~ {502} $ uname -a
Linux install 2.4.21-rc6-ac1 #1 SMP Sat May 31 20:04:18 CEST 2003 i686 unknown

root@install:~ {503} $ uptime
 10:17pm  up 5 min,  2 users,  load average: 0.02, 0.13, 0.07

root@install:~ {504} $ lspci -v
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 03)
        Subsystem: Asustek Computer, Inc.: Unknown device 8070
        Flags: bus master, fast devsel, latency 0
        Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [e4] #09 [0104]
        Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 03) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: f2000000-f35fffff
        Prefetchable memory behind bridge: f3700000-f7ffffff

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 12) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: f1000000-f1ffffff
        Prefetchable memory behind bridge: f3600000-f36fffff

00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 12)
        Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 12) (prog-if 80 [Master])
        Subsystem: Asustek Computer, Inc.: Unknown device 8028
        Flags: bus master, medium devsel, latency 0
        I/O ports at b800 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 12) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8028
        Flags: bus master, medium devsel, latency 0, IRQ 5
        I/O ports at b400 [size=32]

00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 12) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8028
        Flags: bus master, medium devsel, latency 0, IRQ 9
        I/O ports at b000 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio (rev 12)
        Subsystem: Asustek Computer, Inc.: Unknown device 8072
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at a800 [size=256]
        I/O ports at a400 [size=64]

01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti4200] (rev a3) (prog-if 00 [VGA])
        Subsystem: Asustek Computer, Inc.: Unknown device 8047
        Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 11
        Memory at f2000000 (32-bit, non-prefetchable) [size=16M]
        Memory at f4000000 (32-bit, prefetchable) [size=64M]
        Memory at f3800000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at f37e0000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 2.0

02:0a.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
        Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter with Alert On LAN*
        Flags: bus master, medium devsel, latency 32, IRQ 9
        Memory at f1800000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at d800 [size=64]
        Memory at f1000000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2

root@install:~ {505} $ lsmod
Module                  Size  Used by    Tainted: P
i810_audio             23944   0  (autoclean)
soundcore               3972   2  (autoclean) [i810_audio]
ac97_codec             10920   0  (autoclean) [i810_audio]
nfsd                   67696   8  (autoclean)
nfs                    69784   7  (autoclean)
lockd                  47984   1  (autoclean) [nfsd nfs]
sunrpc                 65596   1  (autoclean) [nfsd nfs lockd]
af_packet              13256   2  (autoclean)
slip                    9056   4  (autoclean)
slhc                    4608   2  (autoclean) [slip]
eepro100               18516   1  (autoclean)
mii                     2464   0  (autoclean) [eepro100]
softdog                 1692   1  (autoclean)
quota_v1                1848  10
nvidia               1546816  10
keybdev                 1696   0  (unused)
mousedev                3896   1
hid                    18308   0  (unused)
usbmouse                1820   0  (unused)
input                   3552   0  [keybdev mousedev hid usbmouse]
uhci                   24816   0  (unused)
usbcore                59488   0  [hid usbmouse uhci]
ext3                   61924   4  (autoclean)
jbd                    40152   4  (autoclean) [ext3]
ide-cd                 28736   0  (autoclean)
cdrom                  27712   0  (autoclean) [ide-cd]
unix                   15880 104  (autoclean)
ext2                   34336   4
ide-disk               13344   9
piix                    7680   1

root@install:~ {506} $ cat /proc/interrupts
           CPU0
  0:      38742          XT-PIC  timer
  1:        422          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:       2829          XT-PIC  usb-uhci
  9:       2997          XT-PIC  usb-uhci, eth0
 10:       6582          XT-PIC  Intel ICH2
 11:      25148          XT-PIC  nvidia
 12:          9          XT-PIC  PS/2 Mouse
 14:      22010          XT-PIC  ide0
 15:         33          XT-PIC  ide1
NMI:          0
LOC:      38686
ERR:          0
MIS:          0

(Please find output of "dmesg" in attached file
"dmesg-2.4.21-rc6-ac1-acpioff")

And here's the interrupt configuration from the same kernel,
but with ACPI enabled, after about 3 minutes of uptime:
           CPU0
  0:      18132    IO-APIC-edge  timer
  1:        470    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  9:          1    IO-APIC-edge  eth0
 14:      17434    IO-APIC-edge  ide0
 15:         34    IO-APIC-edge  ide1
 19:         24   IO-APIC-level  usb-uhci
 22:    7378056   IO-APIC-level  acpi
 23:          0   IO-APIC-level  usb-uhci
NMI:          0
LOC:      18068
ERR:          0
MIS:          0

(dmesg output in attachment "dmesg-2.4.21-rc6-ac1-acpi")

Just for reference, here's some (IMHO) relevant information
from 2.4.21-rc2-ac2 on the same hardware:
[...]
May 16 18:52:37 install kernel: ENABLING IO-APIC IRQs
May 16 18:52:37 install kernel: init IO_APIC IRQs
May 16 18:52:37 install kernel:  IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-23 not connected.
May 16 18:52:37 install kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
May 16 18:52:37 install kernel: number of MP IRQ sources: 17.
May 16 18:52:37 install kernel: number of IO-APIC #2 registers: 24.
May 16 18:52:37 install kernel: testing the IO APIC.......................
May 16 18:52:37 install kernel:
May 16 18:52:37 install kernel: IO APIC #2......
May 16 18:52:37 install kernel: .... register #00: 02000000
May 16 18:52:37 install kernel: .......    : physical APIC id: 02
May 16 18:52:37 install kernel: .......    : Delivery Type: 0
May 16 18:52:37 install kernel: .......    : LTS          : 0
May 16 18:52:37 install kernel: .... register #01: 00178020
May 16 18:52:37 install kernel: .......     : max redirection entries: 0017
May 16 18:52:37 install kernel: .......     : PRQ implemented: 1
May 16 18:52:37 install kernel: .......     : IO APIC version: 0020
May 16 18:52:37 install kernel: .... register #02: 00000000
May 16 18:52:37 install kernel: .......     : arbitration: 00
May 16 18:52:37 install kernel: .... IRQ redirection table:
May 16 18:52:37 install kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
May 16 18:52:37 install kernel:  00 000 00  1    0    0   0   0    0    0    00
May 16 18:52:37 install kernel:  01 0FF 0F  0    0    0   0   0    1    1    39
May 16 18:52:37 install kernel:  02 001 01  0    0    0   0   0    1    1    31
May 16 18:52:37 install kernel:  03 0FF 0F  0    0    0   0   0    1    1    41
May 16 18:52:37 install kernel:  04 0FF 0F  0    0    0   0   0    1    1    49
May 16 18:52:37 install kernel:  05 0FF 0F  0    0    0   0   0    1    1    51
May 16 18:52:37 install kernel:  06 0FF 0F  0    0    0   0   0    1    1    59
May 16 18:52:37 install kernel:  07 0FF 0F  0    0    0   0   0    1    1    61
May 16 18:52:37 install kernel:  08 0FF 0F  0    0    0   0   0    1    1    69
May 16 18:52:37 install kernel:  09 0FF 0F  0    0    0   0   0    1    1    71
May 16 18:52:37 install kernel:  0a 0FF 0F  0    0    0   0   0    1    1    79
May 16 18:52:37 install kernel:  0b 0FF 0F  0    0    0   0   0    1    1    81
May 16 18:52:37 install kernel:  0c 0FF 0F  0    0    0   0   0    1    1    89
May 16 18:52:37 install kernel:  0d 0FF 0F  0    0    0   0   0    1    1    91
May 16 18:52:37 install kernel:  0e 0FF 0F  0    0    0   0   0    1    1    99
May 16 18:52:37 install kernel:  0f 0FF 0F  0    0    0   0   0    1    1    A1
May 16 18:52:37 install kernel:  10 000 00  1    0    0   0   0    0    0    00
May 16 18:52:37 install kernel:  11 000 00  1    0    0   0   0    0    0    00
May 16 18:52:37 install kernel:  12 000 00  1    0    0   0   0    0    0    00
May 16 18:52:37 install kernel:  13 000 00  1    0    0   0   0    0    0    00
May 16 18:52:37 install kernel:  14 000 00  1    0    0   0   0    0    0    00
May 16 18:52:37 install kernel:  15 000 00  1    0    0   0   0    0    0    00
May 16 18:52:37 install kernel:  16 0FF 0F  1    1    0   1   0    1    1    71
May 16 18:52:37 install kernel:  17 000 00  1    0    0   0   0    0    0    00
May 16 18:52:37 install kernel: IRQ to pin mappings:
May 16 18:52:37 install kernel: IRQ0 -> 0:2
May 16 18:52:37 install kernel: IRQ1 -> 0:1
May 16 18:52:37 install kernel: IRQ3 -> 0:3
May 16 18:52:37 install kernel: IRQ4 -> 0:4
May 16 18:52:37 install kernel: IRQ5 -> 0:5
May 16 18:52:37 install kernel: IRQ6 -> 0:6
May 16 18:52:37 install kernel: IRQ7 -> 0:7
May 16 18:52:37 install kernel: IRQ8 -> 0:8
May 16 18:52:37 install kernel: IRQ9 -> 0:9-> 0:22
May 16 18:52:37 install kernel: IRQ10 -> 0:10
May 16 18:52:37 install kernel: IRQ11 -> 0:11
May 16 18:52:37 install kernel: IRQ12 -> 0:12
May 16 18:52:37 install kernel: IRQ13 -> 0:13
May 16 18:52:37 install kernel: IRQ14 -> 0:14
May 16 18:52:37 install kernel: IRQ15 -> 0:15
May 16 18:52:37 install kernel: .................................... done.
May 16 18:52:37 install kernel: Using local APIC timer interrupts.
May 16 18:52:37 install kernel: calibrating APIC timer ...
May 16 18:52:37 install kernel: ..... CPU clock speed is 1614.4531 MHz.
May 16 18:52:37 install kernel: ..... host bus clock speed is 100.9032 MHz.
May 16 18:52:37 install kernel: cpu: 0, clocks: 1009032, slice: 504516
May 16 18:52:37 install kernel: CPU0<T0:1009024,T1:504496,D:12,S:504516,C:1009032>
May 16 18:52:37 install kernel: migration_task 0 on cpu=0
May 16 18:52:37 install kernel: ACPI: Subsystem revision 20030424
May 16 18:52:37 install kernel: PCI: PCI BIOS revision 2.10 entry at 0xf11f0, last bus=2
May 16 18:52:37 install kernel: PCI: Using configuration type 1
May 16 18:52:37 install kernel: IOAPIC[0]: Set PCI routing entry (2-22 -> 0xa9 -> IRQ 22)
May 16 18:52:37 install kernel: ACPI: Interpreter enabled
May 16 18:52:37 install kernel: ACPI: Using IOAPIC for interrupt routing
May 16 18:52:37 install kernel: ACPI: System [ACPI] (supports S0 S1 S4 S5)
May 16 18:52:37 install kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
May 16 18:52:37 install kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
May 16 18:52:37 install kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
May 16 18:52:37 install kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
May 16 18:52:37 install kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
May 16 18:52:37 install kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
May 16 18:52:37 install kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
May 16 18:52:37 install kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
May 16 18:52:37 install kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
May 16 18:52:37 install kernel: PCI: Probing PCI hardware (bus 00)
May 16 18:52:37 install kernel: Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Bridge
May 16 18:52:37 install kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
May 16 18:52:37 install kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
May 16 18:52:37 install kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
May 16 18:52:37 install kernel: PCI: Probing PCI hardware
May 16 18:52:37 install kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
May 16 18:52:37 install kernel: ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
May 16 18:52:37 install kernel: ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 5
May 16 18:52:37 install kernel: IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17)
May 16 18:52:37 install kernel: 00:00:1f[B] -> 2-17 -> IRQ 17
May 16 18:52:37 install kernel: IOAPIC[0]: Set PCI routing entry (2-23 -> 0xb9 -> IRQ 23)
May 16 18:52:37 install kernel: 00:00:1f[C] -> 2-23 -> IRQ 23
May 16 18:52:37 install kernel: IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19)
May 16 18:52:37 install kernel: 00:00:1f[D] -> 2-19 -> IRQ 19
May 16 18:52:37 install kernel: IOAPIC[0]: Set PCI routing entry (2-16 -> 0xc9 -> IRQ 16)
May 16 18:52:37 install kernel: 00:01:00[A] -> 2-16 -> IRQ 16
May 16 18:52:37 install kernel: Pin 2-17 already programmed
May 16 18:52:37 install kernel: IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd1 -> IRQ 21)
May 16 18:52:37 install kernel: 00:02:09[A] -> 2-21 -> IRQ 21
May 16 18:52:37 install kernel: IOAPIC[0]: Set PCI routing entry (2-22 -> 0xa9 -> IRQ 22)
May 16 18:52:37 install kernel: 00:02:09[B] -> 2-22 -> IRQ 22
May 16 18:52:37 install kernel: Pin 2-23 already programmed
May 16 18:52:37 install kernel: IOAPIC[0]: Set PCI routing entry (2-20 -> 0xd9 -> IRQ 20)
May 16 18:52:37 install kernel: 00:02:09[D] -> 2-20 -> IRQ 20
May 16 18:52:37 install kernel: Pin 2-22 already programmed
May 16 18:52:37 install kernel: Pin 2-23 already programmed
May 16 18:52:37 install kernel: Pin 2-20 already programmed
May 16 18:52:37 install kernel: Pin 2-21 already programmed
May 16 18:52:37 install kernel: Pin 2-23 already programmed
May 16 18:52:37 install kernel: Pin 2-20 already programmed
May 16 18:52:37 install kernel: Pin 2-21 already programmed
May 16 18:52:37 install kernel: Pin 2-22 already programmed
May 16 18:52:37 install kernel: Pin 2-20 already programmed
May 16 18:52:37 install kernel: Pin 2-21 already programmed
May 16 18:52:37 install kernel: Pin 2-22 already programmed
May 16 18:52:37 install kernel: Pin 2-23 already programmed
May 16 18:52:37 install kernel: Pin 2-21 already programmed
May 16 18:52:37 install kernel: Pin 2-22 already programmed
May 16 18:52:37 install kernel: Pin 2-23 already programmed
May 16 18:52:37 install kernel: Pin 2-20 already programmed
May 16 18:52:37 install kernel: IOAPIC[0]: Set PCI routing entry (2-18 -> 0xe1 -> IRQ 18)
May 16 18:52:37 install kernel: 00:02:0e[A] -> 2-18 -> IRQ 18
May 16 18:52:37 install kernel: Pin 2-19 already programmed
May 16 18:52:37 install kernel: Pin 2-16 already programmed
May 16 18:52:37 install kernel: Pin 2-17 already programmed
May 16 18:52:37 install kernel: Pin 2-20 already programmed
May 16 18:52:37 install kernel: PCI: Using ACPI for IRQ routing
May 16 18:52:37 install kernel: PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
[...]

So, rc2-ac2 ACPI code already reported problems with the
ethernet NIC, but here it worked without problems, anyway.
Not so with the rc6-ac1 ACPI code...

On the positive side: i810 audio seems to work fine (no
problem with xmms playing MP3 over the network)

Some minor annoyance:
ACPI initialization reports "Error: only one processor found."
I know, this is a SMP kernel on a non-SMP motherboard, but
"Error" is quite a strong word for that situation.

IMHO, "Warning: ..." would be more appropriate, but YMMV

Regards,

- andreas

-- 
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71

--------------010009080108000007030409
Content-Type: text/plain;
 name="dmesg-2.4.21-rc6-ac1-acpi"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.4.21-rc6-ac1-acpi"

Linux version 2.4.21-rc6-ac1 (root@install) (gcc version 2.95.3 20010315 (release)) #1 SMP Sat May 31 20:04:18 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000004fffc000 (usable)
 BIOS-e820: 000000004fffc000 - 000000004ffff000 (ACPI data)
 BIOS-e820: 000000004ffff000 - 0000000050000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
383MB HIGHMEM available.
896MB LOWMEM available.
ACPI: have wakeup address 0xc0002000
On node 0 totalpages: 327676
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 98300 pages.
ACPI: RSDP (v000 ASUS                       ) @ 0x000f75a0
ACPI: RSDT (v001 ASUS   <P4B>    16944.11825) @ 0x4fffc000
ACPI: FADT (v001 ASUS   <P4B>    16944.11825) @ 0x4fffc100
ACPI: BOOT (v001 ASUS   <P4B>    16944.11825) @ 0x4fffc040
ACPI: MADT (v001 ASUS   <P4B>    16944.11825) @ 0x4fffc080
ACPI: DSDT (v001   ASUS <P4B>    00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 Pentium 4(tm) XEON(tm) APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x1])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x16] polarity[0x3] trigger[0x3])
Using ACPI (MADT) for SMP configuration information
Kernel command line: BOOT_IMAGE=lx2421rc6ac1 ro root=303 1
Initializing CPU#0
Detected 1614.410 MHz processor.
Console: colour VGA+ 80x50
Calibrating delay loop... 3217.81 BogoMIPS
Memory: 1291828k/1310704k available (1113k kernel code, 18488k reserved, 503k data, 112k init, 393200k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU0: Intel(R) Pentium(R) 4 CPU 1.60GHz stepping 04
per-CPU timeslice cutoff: 1462.69 usecs.
task migration cache decay timeout: 10 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Error: only one processor found.
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 17.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 0FF 0F  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 0FF 0F  0    0    0   0   0    1    1    41
 04 0FF 0F  0    0    0   0   0    1    1    49
 05 0FF 0F  0    0    0   0   0    1    1    51
 06 0FF 0F  0    0    0   0   0    1    1    59
 07 0FF 0F  0    0    0   0   0    1    1    61
 08 0FF 0F  0    0    0   0   0    1    1    69
 09 0FF 0F  0    0    0   0   0    1    1    71
 0a 0FF 0F  0    0    0   0   0    1    1    79
 0b 0FF 0F  0    0    0   0   0    1    1    81
 0c 0FF 0F  0    0    0   0   0    1    1    89
 0d 0FF 0F  0    0    0   0   0    1    1    91
 0e 0FF 0F  0    0    0   0   0    1    1    99
 0f 0FF 0F  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 0FF 0F  1    1    0   1   0    1    1    71
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9-> 0:22
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1614.3270 MHz.
..... host bus clock speed is 100.8952 MHz.
cpu: 0, clocks: 1008952, slice: 504476
CPU0<T0:1008944,T1:504464,D:4,S:504476,C:1008952>
migration_task 0 on cpu=0
ACPI: Subsystem revision 20030522
PCI: PCI BIOS revision 2.10 entry at 0xf11f0, last bus=2
PCI: Using configuration type 1
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xa9 -> IRQ 22)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 5
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17)
00:00:1f[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xb9 -> IRQ 23)
00:00:1f[C] -> 2-23 -> IRQ 23
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19)
00:00:1f[D] -> 2-19 -> IRQ 19
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xc9 -> IRQ 16)
00:01:00[A] -> 2-16 -> IRQ 16
Pin 2-17 already programmed
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd1 -> IRQ 21)
00:02:09[A] -> 2-21 -> IRQ 21
Pin 2-23 already programmed
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xd9 -> IRQ 20)
00:02:09[D] -> 2-20 -> IRQ 20
Pin 2-23 already programmed
Pin 2-20 already programmed
Pin 2-21 already programmed
Pin 2-23 already programmed
Pin 2-20 already programmed
Pin 2-21 already programmed
Pin 2-20 already programmed
Pin 2-21 already programmed
Pin 2-23 already programmed
Pin 2-21 already programmed
Pin 2-23 already programmed
Pin 2-20 already programmed
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xe1 -> IRQ 18)
00:02:0e[A] -> 2-18 -> IRQ 18
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-20 already programmed
PCI: No IRQ known for interrupt pin A of device 02:0a.0
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: Maxtor 6E040L0, ATA DISK drive
hdb: Maxtor 6E040L0, ATA DISK drive
hdd: CDU5211, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
Partition check:
 hda:end_request: I/O error, dev 03:00 (hda), sector 0
end_request: I/O error, dev 03:00 (hda), sector 2
end_request: I/O error, dev 03:00 (hda), sector 4
end_request: I/O error, dev 03:00 (hda), sector 6
end_request: I/O error, dev 03:00 (hda), sector 0
end_request: I/O error, dev 03:00 (hda), sector 2
end_request: I/O error, dev 03:00 (hda), sector 4
end_request: I/O error, dev 03:00 (hda), sector 6
 unable to read partition table
 hdb:end_request: I/O error, dev 03:40 (hdb), sector 0
end_request: I/O error, dev 03:40 (hdb), sector 2
end_request: I/O error, dev 03:40 (hdb), sector 4
end_request: I/O error, dev 03:40 (hdb), sector 6
end_request: I/O error, dev 03:40 (hdb), sector 0
end_request: I/O error, dev 03:40 (hdb), sector 2
end_request: I/O error, dev 03:40 (hdb), sector 4
end_request: I/O error, dev 03:40 (hdb), sector 6
 unable to read partition table
IEEE 802.2 LLC for Linux 2.1 (c) 1996 Tim Alpaerts
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 776k freed
VFS: Mounted root (romfs filesystem) readonly.
Mounted devfs on /dev
ICH2: IDE controller at PCI slot 00:1f.1
ICH2: chipset revision 18
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:pio, hdd:DMA
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 80293248 sectors (41110 MB) w/2048KiB Cache, CHS=4998/255/63
hdb: attached ide-disk driver.
hdb: host protected area => 1
hdb: 80293248 sectors (41110 MB) w/2048KiB Cache, CHS=4998/255/63
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 >
 /dev/ide/host0/bus0/target1/lun0: p1
VFS: Mounted root (ext2 filesystem) readonly.
Trying to move old root to /initrd ... failed
Unmounting old root
Trying to free ramdisk memory ... okay
Mounted devfs on /dev
Freeing unused kernel memory: 112k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding Swap: 1953464k swap-space (priority -1)
blk: queue c0316ec0, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c0317010, I/O limit 4095Mb (mask 0xffffffff)
hdd: attached ide-cdrom driver.
hdd: ATAPI 52X CD-ROM drive, 120kB Cache
Uniform CD-ROM driver Revision: 3.12
hdd: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdd: drive_cmd: error=0x04Aborted Command 
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,9), internal journal
EXT3-fs: mounted filesystem with journal data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,65), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Setting latency timer of device 00:1f.2 to 64
uhci.c: USB UHCI at I/O 0xb400, IRQ 19
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1f.4 to 64
uhci.c: USB UHCI at I/O 0xb000, IRQ 23
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver usbmouse
usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4349  Thu Mar 27 19:00:02 PST 2003
ACPI: Power Button (FF) [PWRF]
hub.c: new USB device 00:1f.2-1, assigned address 2
input0: Logitech USB Mouse on usb1:2.0
Software Watchdog Timer: 0.05, timer margin: 60 sec
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: No IRQ known for interrupt pin A of device 02:0a.0
divert: allocating divert_blk for eth0
eth0: OEM i82557/i82558 10/100 Ethernet, 00:D0:B7:C5:87:D6, IRQ 9.
  Board assembly 734938-004, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
CSLIP: code copyright 1989 Regents of the University of California
SLIP: version 0.8.4-NET3.019-NEWTTY-MODULAR (dynamic channels, max=256).
SLIP linefill/keepalive option.
divert: not allocating divert_blk for non-ethernet device sl0
divert: not allocating divert_blk for non-ethernet device sl1
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out: status f048  0c00 at 0/60 command 0001a000.

--------------010009080108000007030409
Content-Type: text/plain;
 name="dmesg-2.4.21-rc6-ac1-acpioff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.4.21-rc6-ac1-acpioff"

Linux version 2.4.21-rc6-ac1 (root@install) (gcc version 2.95.3 20010315 (release)) #1 SMP Sat May 31 20:04:18 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000004fffc000 (usable)
 BIOS-e820: 000000004fffc000 - 000000004ffff000 (ACPI data)
 BIOS-e820: 000000004ffff000 - 0000000050000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
383MB HIGHMEM available.
896MB LOWMEM available.
ACPI: have wakeup address 0xc0002000
On node 0 totalpages: 327676
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 98300 pages.
Kernel command line: BOOT_IMAGE=lx2421rc6ac1 ro root=303 acpi=off
Found and enabled local APIC!
Initializing CPU#0
Detected 1614.433 MHz processor.
Console: colour VGA+ 80x50
Calibrating delay loop... 3217.81 BogoMIPS
Memory: 1291832k/1310704k available (1113k kernel code, 18484k reserved, 503k data, 112k init, 393200k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU0: Intel(R) Pentium(R) 4 CPU 1.60GHz stepping 04
per-CPU timeslice cutoff: 1462.69 usecs.
task migration cache decay timeout: 10 msecs.
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1614.3283 MHz.
..... host bus clock speed is 100.8953 MHz.
cpu: 0, clocks: 1008953, slice: 504476
CPU0<T0:1008944,T1:504464,D:4,S:504476,C:1008953>
migration_task 0 on cpu=0
ACPI: Subsystem revision 20030522
ACPI: Disabled via command line (acpi=off)
PCI: PCI BIOS revision 2.10 entry at 0xf11f0, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: Maxtor 6E040L0, ATA DISK drive
hdb: Maxtor 6E040L0, ATA DISK drive
hdd: CDU5211, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
Partition check:
 hda:end_request: I/O error, dev 03:00 (hda), sector 0
end_request: I/O error, dev 03:00 (hda), sector 2
end_request: I/O error, dev 03:00 (hda), sector 4
end_request: I/O error, dev 03:00 (hda), sector 6
end_request: I/O error, dev 03:00 (hda), sector 0
end_request: I/O error, dev 03:00 (hda), sector 2
end_request: I/O error, dev 03:00 (hda), sector 4
end_request: I/O error, dev 03:00 (hda), sector 6
 unable to read partition table
 hdb:end_request: I/O error, dev 03:40 (hdb), sector 0
end_request: I/O error, dev 03:40 (hdb), sector 2
end_request: I/O error, dev 03:40 (hdb), sector 4
end_request: I/O error, dev 03:40 (hdb), sector 6
end_request: I/O error, dev 03:40 (hdb), sector 0
end_request: I/O error, dev 03:40 (hdb), sector 2
end_request: I/O error, dev 03:40 (hdb), sector 4
end_request: I/O error, dev 03:40 (hdb), sector 6
 unable to read partition table
IEEE 802.2 LLC for Linux 2.1 (c) 1996 Tim Alpaerts
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 776k freed
VFS: Mounted root (romfs filesystem) readonly.
Mounted devfs on /dev
ICH2: IDE controller at PCI slot 00:1f.1
ICH2: chipset revision 18
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:pio, hdd:DMA
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 80293248 sectors (41110 MB) w/2048KiB Cache, CHS=4998/255/63
hdb: attached ide-disk driver.
hdb: host protected area => 1
hdb: 80293248 sectors (41110 MB) w/2048KiB Cache, CHS=4998/255/63
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 >
 /dev/ide/host0/bus0/target1/lun0: p1
VFS: Mounted root (ext2 filesystem) readonly.
Trying to move old root to /initrd ... failed
Unmounting old root
Trying to free ramdisk memory ... okay
Mounted devfs on /dev
Freeing unused kernel memory: 112k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding Swap: 1953464k swap-space (priority -1)
blk: queue c0316ec0, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c0317010, I/O limit 4095Mb (mask 0xffffffff)
hdd: attached ide-cdrom driver.
hdd: ATAPI 52X CD-ROM drive, 120kB Cache
Uniform CD-ROM driver Revision: 3.12
hdd: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdd: drive_cmd: error=0x04Aborted Command 
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,9), internal journal
EXT3-fs: mounted filesystem with journal data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,65), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Found IRQ 5 for device 00:1f.2
PCI: Setting latency timer of device 00:1f.2 to 64
uhci.c: USB UHCI at I/O 0xb400, IRQ 5
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 9 for device 00:1f.4
PCI: Setting latency timer of device 00:1f.4 to 64
uhci.c: USB UHCI at I/O 0xb000, IRQ 9
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver usbmouse
usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4349  Thu Mar 27 19:00:02 PST 2003
hub.c: new USB device 00:1f.2-1, assigned address 2
input0: Logitech USB Mouse on usb1:2.0
Software Watchdog Timer: 0.05, timer margin: 60 sec
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: Found IRQ 9 for device 02:0a.0
divert: allocating divert_blk for eth0
eth0: OEM i82557/i82558 10/100 Ethernet, 00:D0:B7:C5:87:D6, IRQ 9.
  Board assembly 734938-004, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
CSLIP: code copyright 1989 Regents of the University of California
SLIP: version 0.8.4-NET3.019-NEWTTY-MODULAR (dynamic channels, max=256).
SLIP linefill/keepalive option.
divert: not allocating divert_blk for non-ethernet device sl0
divert: not allocating divert_blk for non-ethernet device sl1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Intel 810 + AC97 Audio, version 0.24, 20:49:16 May 31 2003
PCI: Found IRQ 10 for device 00:1f.5
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH2 found at IO 0xa400 and 0xa800, MEM 0x0000 and 0x0000, IRQ 10
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
ac97_codec: AC97 Audio codec, id: ALG16 (ALC200/200P)
i810_audio: AC'97 codec 0 supports AMAP, total channels = 2

--------------010009080108000007030409--


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbVEIWKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVEIWKa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 18:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVEIWKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 18:10:30 -0400
Received: from outbound04.telus.net ([199.185.220.223]:56714 "EHLO
	priv-edtnes27.telusplanet.net") by vger.kernel.org with ESMTP
	id S261541AbVEIWJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 18:09:22 -0400
Subject: Kernel 2.6.12-rc4 and gcc-4.0.0  (datatype issue?)
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 09 May 2005 16:08:59 -0600
Message-Id: <1115676539.7849.73.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I recently built 2.6.12-rc4 with gcc-4.0.0, and got a few eip's on
boot (as reported by dmesg).  I have not found the errors affecting the
system yet (but I haven't tested exhaustively yet either).  If building
the recent kernels with gcc-4.0.0 is too early, then please disregard
this message. 
My first guess (as to the nature of the problem) is a conversion problem
in kernel/sysctl.c (line 1462 or thereabouts)...this:

static int do_proc_dointvec_conv(int *negp, unsigned long *lvalp,
                                 int *valp,
                                 int write, void *data)
{
        if (write) {
                *valp = *negp ? -*lvalp : *lvalp;
        } else {
                int val = *valp;
                if (val < 0) {
                        *negp = -1;
                        *lvalp = (unsigned long)-val;
                } else {
                        *negp = 0;
                        *lvalp = (unsigned long)val;
                }
        }
        return 0;
}
...

 (used for vector test/conversion prior to writing to the user buffer in
the system control table???) is having a datatype issue (and I must also
add that there were a lot of datatype warnings when compiling with
gcc4.0.0). For the curious, I submit the following dmesg:

syslogd startup succeeded
klogd 1.4.1, log source = /proc/kmsg started.
hed hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices:
FUTS PCI0 USB0 USB1 MAC0 AMR0 UAR1 UAR2 PS2M PS2K
ACPI: (supports S0 S1 S4 S5)
ReiserFS: hda3: found reiserfs format "3.6" with standard journal
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
syslog: klogd startup succeeded
ReiserFS: hda3: using ordered data mode
ReiserFS: hda3: journal params: device hda3, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit
age 30, max trans age 30
irqbalance: irqbalance startup succeeded
ReiserFS: hda3: checking transaction log (hda3)
ReiserFS: hda3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 256k freed
SCSI subsystem initialized
sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
sis900.c: v1.08.08 Jan. 22 2005
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:03.0[A] -> Link [LNKG] -> GSI 11 (level,
low) -> IRQ 11
0000:00:03.0: ICS LAN PHY transceiver found at address 1.
0000:00:03.0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xe000, IRQ 11, 00:50:2c:02:96:89.
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKB] -> GSI 10 (level,
low) -> IRQ 10
i2c-sis96x version 1.0.0
sis96x_smbus 0000:00:02.1: SiS96x SMBus base address: 0x1080
Linux video capture interface: v1.00
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKD] -> GSI 5 (level, low)
-> IRQ 5
bttv0: Bt878 (rev 2) at 0000:00:0b.0, irq: 5, latency: 32, mmio:
0xeb003000
bttv0: detected: ATI TV Wonder/VE [card=64], PCI subsystem ID is
1002:0003
bttv0: using: ATI TV-Wonder VE [card=64,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00ffffff [init]
bttv0: using tuner=19
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: i2c: checking for TDA9887 @ 0x86... not found
tuner 1-0060: chip found @ 0xc0 (bt878 #0 [sw])
tuner 1-0060: type set to 19 (Temic PAL* auto (4006 FN5))
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 .. ok
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:02.2[D] -> Link [LNKE] -> GSI 10 (level,
low) -> IRQ 10
ohci_hcd 0000:00:02.2: Silicon Integrated Systems [SiS] USB 1.0
Controller
ohci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.2: irq 10, io mem 0xeb002000
ohci_hcd 0000:00:02.2: resetting from state 'reset', control = 0x0
ohci_hcd 0000:00:02.2: enabling initreset quirk
ohci_hcd 0000:00:02.2: OHCI controller state
ohci_hcd 0000:00:02.2: OHCI 1.0, NO legacy support registers
ohci_hcd 0000:00:02.2: control 0x083 HCFS=operational CBSR=3
ohci_hcd 0000:00:02.2: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:02.2: intrstatus 0x00000004 SF
ohci_hcd 0000:00:02.2: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:02.2: fminterval a7782edf
ohci_hcd 0000:00:02.2: hcca frame #0003
ohci_hcd 0000:00:02.2: roothub.a 01001203 POTPGT=1 NOCP NPS NDP=3
ohci_hcd 0000:00:02.2: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:02.2: roothub.status 00008000 DRWE
ohci_hcd 0000:00:02.2: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:02.2: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:02.2: roothub.portstatus [2] 0x00000100 PPS
usb usb1: default language 0x0409
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: Silicon Integrated Systems [SiS] USB 1.0 Controller
usb usb1: Manufacturer: Linux 2.6.12-rc4 ohci_hcd
usb usb1: SerialNumber: 0000:00:02.2
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: no over-current protection
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: state 5 ports 3 chg 0000 evt 0000
usb 1-0:1.0: hotplug
ohci_hcd 0000:00:02.2: created debug files
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:02.3[A] -> Link [LNKH] -> GSI 11 (level,
low) -> IRQ 11
ohci_hcd 0000:00:02.3: Silicon Integrated Systems [SiS] USB 1.0
Controller (#2)
ohci_hcd 0000:00:02.3: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.3: irq 11, io mem 0xeb000000
ohci_hcd 0000:00:02.3: resetting from state 'reset', control = 0x0
ohci_hcd 0000:00:02.3: OHCI controller state
ohci_hcd 0000:00:02.3: OHCI 1.0, NO legacy support registers
ohci_hcd 0000:00:02.3: control 0x083 HCFS=operational CBSR=3
ohci_hcd 0000:00:02.3: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:02.3: intrstatus 0x00000044 RHSC SF
ohci_hcd 0000:00:02.3: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:02.3: fminterval a7782edf
ohci_hcd 0000:00:02.3: hcca frame #0003
ohci_hcd 0000:00:02.3: roothub.a 01001203 POTPGT=1 NOCP NPS NDP=3
ohci_hcd 0000:00:02.3: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:02.3: roothub.status 00008000 DRWE
ohci_hcd 0000:00:02.3: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:02.3: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:02.3: roothub.portstatus [2] 0x00010101 CSC PPS CCS
usb usb2: default language 0x0409
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: Silicon Integrated Systems [SiS] USB 1.0 Controller
(#2)
usb usb2: Manufacturer: Linux 2.6.12-rc4 ohci_hcd
usb usb2: SerialNumber: 0000:00:02.3
usb usb2: hotplug
usb usb2: adding 2-0:1.0 (config #1, interface 0)
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: no over-current protection
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: local power source is good
hub 2-0:1.0: state 5 ports 3 chg 0000 evt 0000
usb 2-0:1.0: hotplug
ohci_hcd 0000:00:02.3: GetStatus roothub.portstatus [2] = 0x00010101 CSC
PPS CCS
hub 2-0:1.0: port 3, status 0101, change 0001, 12 Mb/s
ohci_hcd 0000:00:02.3: created debug files
hub 2-0:1.0: debounce: port 3: total 100ms stable 100ms status 0x101
ohci_hcd 0000:00:02.3: GetStatus roothub.portstatus [2] = 0x00100103
PRSC PPS PES CCS
usb 2-3: new full speed USB device using ohci_hcd and address 2
ohci_hcd 0000:00:02.3: GetStatus roothub.portstatus [2] = 0x00100103
PRSC PPS PES CCS
usb 2-3: ep0 maxpacket = 8
usb 2-3: default language 0x0409
ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKB] -> GSI 10 (level,
low) -> IRQ 10
usb 2-3: new device strings: Mfr=1, Product=2, SerialNumber=3
usb 2-3: Product: DeskJet 930C
usb 2-3: Manufacturer: Hewlett-Packard
usb 2-3: SerialNumber: MY06T161Z9JL
usb 2-3: hotplug
usb 2-3: adding 2-3:1.0 (config #1, interface 0)
usb 2-3:1.0: hotplug
usb 2-3: adding 2-3:1.0 (config #1, interface 0)
usb 2-3:1.0: hotplug
hub 2-0:1.0: state 5 ports 3 chg 0000 evt 0008
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[eb005000-
eb0057ff]  Max Packet=[2048]
usblp 2-3:1.0: usb_probe_interface
usblp 2-3:1.0: usb_probe_interface - got id
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0
alt 1 proto 2 vid 0x03F0 pid 0x1204
drivers/usb/core/file.c: looking for a minor, starting at 0
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Unable to handle kernel paging request at virtual address 409edc14
 printing eip:
c011e3ad
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
Modules linked in: usblp ohci1394 ohci_hcd usbcore tuner bttv video_buf
i2c_algo_bit v4l2_common btcx_risc tveeprom videodev
i2c_sis96x i2c_core snd_emu10k1 snd_rawmidi snd_seq_device
snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer
snd_page_alloc snd_util_mem snd_hwdep snd soundcore sis900 sbp2 scsi_mod
ieee1394
CPU:    0
EIP:    0060:[<c011e3ad>]    Not tainted VLI
EFLAGS: 00010246   (2.6.12-rc4)
EIP is at do_proc_dointvec_conv+0x1d/0x4b
eax: 00000001   ebx: 409edc14   ecx: f79b9eec   edx: f79b9ef0
esi: b7f61001   edi: 00000002   ebp: 00000001   esp: f79b9ea4
ds: 007b   es: 007b   ss: 0068
Process sysctl (pid: 3453, threadinfo=f79b8000 task=f7824a80)
Stack: 00000001 c011e6c4 f79b9ef0 f79b9eec 409edc14 00000001 00000000
409edc14
       00000001 00000001 00000000 31000001 f795000a f7b87b7c 00000000
00000001
       f79495ac f79b9ed4 00000001 00000000 f7dbab80 f7c048e0 00000001
f79b9fa4
Call Trace:
 [<c011e6c4>] do_proc_dointvec+0x2e9/0x363
 [<c011e785>] proc_dointvec+0x47/0x4b
 [<c011e390>] do_proc_dointvec_conv+0x0/0x4b
 [<c011e0af>] do_rw_proc+0x89/0x95
 [<c011e13b>] proc_writesys+0x2f/0x33
 [<c0153c0c>] vfs_write+0x99/0x117
 [<c0153d49>] sys_write+0x4b/0x74
 [<c0102eff>] sysenter_past_esp+0x54/0x75
Code: 84 0f 00 00 89 c8 83 c4 18 5b 5e 5f 5d c3 53 8b 54 24 08 8b 4c 24
0c 8b 5c 24 10 8b 44 24 14 85 c0 74 0e 8b 02 85 c0 75 1a 8b 01 <89> 03
31 c0 5b c3 8b 03 85 c0 78 14 c7 02 00 00 00 00 89 01 31
 <7>ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0030e000e0000b39]
ieee1394: Node added: ID:BUS[0-01:1023]  GUID[0030e000e0000ae3]
ieee1394: Host added: ID:BUS[0-02:1023]  GUID[001106001a250051]
scsi0 : SCSI emulation for IEEE-1394 SBP-2 Devices
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [FUTS]
ACPI: Fan [FAN] (on)
ibm_acpi: ec object not found
ACPI: Thermal Zone [THRM] (75 C)
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: Node 0-00:1023: Max speed [S400] - Max payload [2048]
  Vendor: Maxtor 4  Model: G160J8            Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 06
scsi1 : SCSI emulation for IEEE-1394 SBP-2 Devices
SCSI device sda: 268435455 512-byte hdwr sectors (137439 MB)
sda: cache data unavailable
sda: assuming drive cache: write through
SCSI device sda: 268435455 512-byte hdwr sectors (137439 MB)
sda: cache data unavailable
sda: assuming drive cache: write through
 sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: Node 0-01:1023: Max speed [S400] - Max payload [2048]
  Vendor: Maxtor 4  Model: G160J8            Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 06
SCSI device sdb: 268435455 512-byte hdwr sectors (137439 MB)
sdb: cache data unavailable
sdb: assuming drive cache: write through
SCSI device sdb: 268435455 512-byte hdwr sectors (137439 MB)
sdb: cache data unavailable
sdb: assuming drive cache: write through
 sdb: sdb1
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
ReiserFS: hda1: found reiserfs format "3.6" with standard journal
ReiserFS: hda1: using ordered data mode
ReiserFS: hda1: journal params: device hda1, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: hda1: checking transaction log (hda1)
ReiserFS: hda1: Using r5 hash to sort names
ReiserFS: hdb1: found reiserfs format "3.6" with standard journal
ReiserFS: hdb1: using ordered data mode
ReiserFS: hdb1: journal params: device hdb1, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: hdb1: checking transaction log (hdb1)
ReiserFS: hdb1: Using r5 hash to sort names
Adding 500464k swap on /dev/hda2.  Priority:-1 extents:1
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (8191 buckets, 65528 max) - 212 bytes per
conntrack
Unable to handle kernel paging request at virtual address 409edc14
 printing eip:
c011e3ad
*pde = 00000000
Oops: 0002 [#2]
PREEMPT
Modules linked in: ipt_REJECT ipt_state ip_conntrack iptable_filter
ip_tables binfmt_misc sd_mod video thermal processor fan
button battery ac usblp ohci1394 ohci_hcd usbcore tuner bttv video_buf
i2c_algo_bit v4l2_common btcx_risc tveeprom videodev i2c_sis96x i2c_core
snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm_oss
snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_util_mem snd_hwdep
snd soundcore sis900 sbp2 scsi_mod ieee1394
CPU:    0
EIP:    0060:[<c011e3ad>]    Not tainted VLI
EFLAGS: 00010246   (2.6.12-rc4)
EIP is at do_proc_dointvec_conv+0x1d/0x4b
eax: 00000001   ebx: 409edc14   ecx: f67c9eec   edx: f67c9ef0
esi: b7f8c001   edi: 00000002   ebp: 00000001   esp: f67c9ea4
ds: 007b   es: 007b   ss: 0068
Process sysctl (pid: 4464, threadinfo=f67c8000 task=f7802510)
Stack: 00000001 c011e6c4 f67c9ef0 f67c9eec 409edc14 00000001 00000000
409edc14
       00000001 00000001 00000000 31000001 f52a000a f7823b7c 00000000
00000001
       f781182c f67c9ed4 00000001 00000000 f7af3580 f7c048e0 00000001
f67c9fa4
Call Trace:
 [<c011e6c4>] do_proc_dointvec+0x2e9/0x363
 [<c011e785>] proc_dointvec+0x47/0x4b
 [<c011e390>] do_proc_dointvec_conv+0x0/0x4b
 [<c011e0af>] do_rw_proc+0x89/0x95
 [<c011e13b>] proc_writesys+0x2f/0x33
 [<c0153c0c>] vfs_write+0x99/0x117
 [<c0153d49>] sys_write+0x4b/0x74
 [<c0102eff>] sysenter_past_esp+0x54/0x75
Code: 84 0f 00 00 89 c8 83 c4 18 5b 5e 5f 5d c3 53 8b 54 24 08 8b 4c 24
0c 8b 5c 24 10 8b 44 24 14 85 c0 74 0e 8b 02 85 c0 75 1a 8b 01 <89> 03
31 c0 5b c3 8b 03 85 c0 78 14 c7 02 00 00 00 00 89 01 31
 <6>eth0: Media Link On 10mbps half-duplex
Unable to handle kernel paging request at virtual address 409edc14
 printing eip:
c011e3ad
*pde = 00000000
Oops: 0002 [#3]
PREEMPT
Modules linked in: ipt_REJECT ipt_state ip_conntrack iptable_filter
ip_tables binfmt_misc sd_mod video thermal processor fan
button battery ac usblp ohci1394 ohci_hcd usbcore tuner bttv video_buf
i2c_algo_bit v4l2_common btcx_risc tveeprom videodev i2c_sis96x i2c_core
snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm_oss
snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_util_mem snd_hwdep
snd soundcore sis900 sbp2 scsi_mod ieee1394
CPU:    0
EIP:    0060:[<c011e3ad>]    Not tainted VLI
EFLAGS: 00010246   (2.6.12-rc4)
EIP is at do_proc_dointvec_conv+0x1d/0x4b
eax: 00000001   ebx: 409edc14   ecx: f74bdeec   edx: f74bdef0
esi: b7f37001   edi: 00000002   ebp: 00000001   esp: f74bdea4
ds: 007b   es: 007b   ss: 0068
Process sysctl (pid: 4730, threadinfo=f74bc000 task=f7261a80)
Stack: 00000001 c011e6c4 f74bdef0 f74bdeec 409edc14 00000001 00000000
409edc14
       00000001 00000001 00000000 31000001 f52a000a f781db7c 00000000
00000001
       f78925ac f74bded4 00000001 00000000 f7934980 f7c048e0 00000001
f74bdfa4
Call Trace:
 [<c011e6c4>] do_proc_dointvec+0x2e9/0x363
 [<c011e785>] proc_dointvec+0x47/0x4b
 [<c011e390>] do_proc_dointvec_conv+0x0/0x4b
 [<c011e0af>] do_rw_proc+0x89/0x95
 [<c011e13b>] proc_writesys+0x2f/0x33
 [<c0153c0c>] vfs_write+0x99/0x117
 [<c0153d49>] sys_write+0x4b/0x74
 [<c0102eff>] sysenter_past_esp+0x54/0x75
Code: 84 0f 00 00 89 c8 83 c4 18 5b 5e 5f 5d c3 53 8b 54 24 08 8b 4c 24
0c 8b 5c 24 10 8b 44 24 14 85 c0 74 0e 8b 02 85 c0 75 1a 8b 01 <89> 03
31 c0 5b c3 8b 03 85 c0 78 14 c7 02 00 00 00 00 89 01 31
 <6>Generic RTC Driver v1.07
ieee1394: raw1394: /dev/raw1394 device initialized
imm: Version 2.05 (for Linux 2.4.0)
imm: Found device at ID 6, Attempting to use EPP 32 bit
imm: Found device at ID 6, Attempting to use PS/2
imm: Communication established at 0x378 with ID 6 using PS/2
scsi2 : Iomega VPI2 (imm) interface
isa bounce pool size: 16 pages
  Vendor: IOMEGA    Model: ZIP 250           Rev: H.41
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sdc at scsi2, channel 0, id 6, lun 0
Linux agpgart interface v0.101 (c) Dave Jones
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 10 (level,
low) -> IRQ 10
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-7167  Fri Feb
25 09:08:22 PST 2005
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 10 (level,
low) -> IRQ 10
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-7167  Fri Feb
25 09:08:22 PST 2005
ReiserFS: sda1: found reiserfs format "3.6" with standard journal
ReiserFS: sda1: using ordered data mode
ReiserFS: sda1: journal params: device sda1, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: sda1: checking transaction log (sda1)
ReiserFS: sda1: Using r5 hash to sort names
ReiserFS: sdb1: found reiserfs format "3.6" with standard journal
ReiserFS: sdb1: using ordered data mode
ReiserFS: sdb1: journal params: device sdb1, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: sdb1: checking transaction log (sdb1)
ReiserFS: sdb1: Using r5 hash to sort names

cat /proc/sys/vm/* gives (item followed by data):
block_dump 0
dirty_background_ratio 10
dirty_expire_centisecs 3000
dirty_ratio 40
dirty_writeback_centisecs 500
laptop_mode 0
legacy_va_layout 0
lowmem_reserve_ratio 256     32
max_map_count 65536
min_free_kbytes 3831
nr_pdflush_threads 2
overcommit_memory 0
overcommit_ratio 50
page-cluster 3
swappiness 60
swap_token_timeout 0
vfs_cache_pressure 100


....The dmesg output as given was produced prior to the kernel-tainting
Nvidia module being added (The Nvidia module was added at least 5
minutes after boot), so all eip errors in dmesg can be considered
'untainted'.

Again, if gcc-4.0.0 is 'too early' then please disregard this message.

If you want more information (such as the output from /proc/sys/kernel,
etc.), you will have to contact me directly as I am not on the list.

Thanks!
-- 
Bob Gill <gillb4@telusplanet.net>



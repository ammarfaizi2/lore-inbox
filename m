Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263312AbTDCH0Q>; Thu, 3 Apr 2003 02:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263314AbTDCH0Q>; Thu, 3 Apr 2003 02:26:16 -0500
Received: from soft.uni-linz.ac.at ([140.78.95.99]:41635 "EHLO
	zeus.soft.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id <S263312AbTDCH0F>; Thu, 3 Apr 2003 02:26:05 -0500
Message-ID: <3E8BE4BB.800@gibraltar.at>
Date: Thu, 03 Apr 2003 09:37:31 +0200
From: Rene Mayrhofer <rene.mayrhofer@gibraltar.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: de-at, de-de, en-gb, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: BUG in 2.4.20: sbp2 and usb-storage SCSI emulation with devfs
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

There seems to be a bug in the devfs code in regards to SCSI emulation, 
which even produced the following message:


Apr  3 09:00:22 wally kernel: ieee1394: sbp2: Logged out of SBP-2 device
Apr  3 09:00:22 wally kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 0000001d
Apr  3 09:00:22 wally kernel:  printing eip:
Apr  3 09:00:22 wally kernel: c0164bb3
Apr  3 09:00:22 wally kernel: *pde = 00000000
Apr  3 09:00:22 wally kernel: Oops: 0002
Apr  3 09:00:22 wally kernel: CPU:    0
Apr  3 09:00:22 wally kernel: EIP:    0010:[_devfs_unhook+43/124]    Not 
tainted
Apr  3 09:00:22 wally kernel: EFLAGS: 00010206
Apr  3 09:00:22 wally kernel: eax: 00000000   ebx: f603ca20   ecx: 
f7877f80   edx: 00000005
Apr  3 09:00:22 wally kernel: esi: f7877f80   edi: 00000100   ebp: 
f6e3b780   esp: f5affec8
Apr  3 09:00:22 wally kernel: ds: 0018   es: 0018   ss: 0018
Apr  3 09:00:22 wally kernel: Process rmmod (pid: 1723, stackpage=f5aff000)
Apr  3 09:00:22 wally kernel: Stack: f603ca20 c0164c14 f7877f80 f7877f80 
00000010 c0164c8f f603ca20 f7877f80
Apr  3 09:00:22 wally kernel:        00000000 c014d304 f7877f80 ffffffff 
f6e3b780 00000000 00000000 f88e4deb
Apr  3 09:00:22 wally kernel:        f6e3b780 00000000 00000001 f88e5640 
f70ac600 f88de000 f7441a80 0000000f
Apr  3 09:00:22 wally kernel: Call Trace:    [_devfs_unregister+16/116] 
[devfs_unregister+23/36] [devfs_register_partitions+168/208] 
[usb-uhci:__insmod_usb-uhci_O/lib/modules/2.4.20/kernel/drivers/usb/u+-176661/96] 
[usb-uhci:__insmod_usb-uhci_O/lib/modules/2.4.20/kernel/drivers/usb/u+-174528/96]
Apr  3 09:00:22 wally kernel: 
[usb-uhci:__insmod_usb-uhci_O/lib/modules/2.4.20/kernel/drivers/usb/u+-255734/96] 
[usb-uhci:__insmod_usb-uhci_O/lib/modules/2.4.20/kernel/drivers/usb/u+-202553/96] 
[usb-uhci:__insmod_usb-uhci_O/lib/modules/2.4.20/kernel/drivers/usb/u+-202616/96] 
[usb-uhci:__insmod_usb-uhci_O/lib/modules/2.4.20/kernel/drivers/usb/u+-313986/96] 
[usb-uhci:__insmod_usb-uhci_O/lib/modules/2.4.20/kernel/drivers/usb/u+-254498/96] 
[usb-uhci:__insmod_usb-uhci_O/lib/modules/2.4.20/kernel/drivers/usb/u+-190304/96]
Apr  3 09:00:22 wally kernel: 
[usb-uhci:__insmod_usb-uhci_O/lib/modules/2.4.20/kernel/drivers/usb/u+-195351/96] 
[usb-uhci:__insmod_usb-uhci_O/lib/modules/2.4.20/kernel/drivers/usb/u+-190304/96] 
[free_module+23/152] [sys_delete_module+243/432] [system_call+51/56]
Apr  3 09:00:22 wally kernel:
Apr  3 09:00:22 wally kernel: Code: 89 42 18 8b 51 18 85 d2 75 08 8b 41 
14 89 43 0c eb 06 8b 41
Apr  3 09:00:22 wally kernel:  <7>ieee1394: Host removed: Node[00:1023] 
  GUID[00110600000051eb]  [Linux OHCI-1394]
Apr  3 09:00:22 wally kernel: ieee1394: Device removed: Node[02:1023] 
GUID[00d001010000502f]  [VST TECHNOLOGIESINC.]



To trigger this error, we used an USB2.0 mass storage device and a 
Firewire mass storage device at the same time, with devfs support 
compiled into the kernel (and automatically mounted during bootup). The 
system is a Debian 3.0 (woody) with kernel 2.4.20 and devfsd running. 
The list of the loaded kernel modules is:

Module                  Size  Used by    Not tainted
sbp2                   15648   0  (autoclean) (unused)
usb-storage            55040   0  (autoclean) (unused)
sd_mod                  9980   0  (unused)
scsi_mod               52028   3  (autoclean) [sbp2 usb-storage sd_mod]
nfsd                   66432   8  (autoclean)
lockd                  47200   1  (autoclean) [nfsd]
sunrpc                 58676   1  (autoclean) [nfsd lockd]
snd-seq-oss            22560   0  (unused)
snd-seq-midi-event      2840   0  [snd-seq-oss]
snd-seq                33772   2  [snd-seq-oss snd-seq-midi-event]
snd-pcm-oss            36516   0  (unused)
snd-mixer-oss          11072   0  [snd-pcm-oss]
snd-intel8x0           16224   0
snd-pcm                52480   0  [snd-pcm-oss snd-intel8x0]
snd-timer              12512   0  [snd-seq snd-pcm]
snd-ac97-codec         30992   0  [snd-intel8x0]
snd-page-alloc          4032   0  [snd-intel8x0 snd-pcm]
snd-mpu401-uart         2640   0  [snd-intel8x0]
snd-rawmidi            11296   0  [snd-mpu401-uart]
snd-seq-device          3812   0  [snd-seq-oss snd-seq snd-rawmidi]
snd                    26528   0  [snd-seq-oss snd-seq-midi-event 
snd-seq snd-pcm-oss snd-mixer-oss snd-intel8x0 snd-pcm snd-timer 
snd-ac97-codec snd-mpu401-uart snd-rawmidi snd-seq-device]
soundcore               3396   5  [snd]
usb-uhci               21252   0  (unused)
ehci-hcd               20096   0  (unused)
usbcore                60704   1  [usb-storage usb-uhci ehci-hcd]
vfat                    9244   0  (autoclean)
fat                    29016   0  (autoclean) [vfat]
mousedev                3808   1
input                   3136   0  [mousedev]
ohci1394               15232   0  (unused)
ieee1394               28328   0  [sbp2 ohci1394]
ipv6                  124896  -1
rtc                     5788   0  (autoclean)


The kernel compilation config is available if anybody needs them. After 
rebooting the system to a "known good" state, plugging both devices in 
(with hotplug support enabled) is enough to reliably reproduce the 
problem. It happens independently of the order in which the devices are 
plugged in.
When the second device is plugged in, the kernel message correctly 
states that "sdb" is claimed, but then tries to assign it to scsi0 in devfs:

Apr  3 09:17:15 wally kernel: scsi0 : SCSI emulation for USB Mass 
Storage devices
Apr  3 09:17:17 wally kernel: Attached scsi disk sdb at scsi0, channel 
0, id 0, lun 0

when the USB2.0 device is the second, or

Apr  3 09:24:07 wally kernel: scsi0 : IEEE-1394 SBP-2 protocol driver 
(host: ohci1394)
Apr  3 09:24:07 wally kernel: Attached scsi disk sdb at scsi0, channel 
0, id 0, lun 0

when the Firewire device is the second.





Parts of the debug log when first plugging in the USB2.0 mass storage, 
then the Firewire mass storage device.

Apr  3 09:05:50 wally kernel: ohci1394: $Rev: 578 $ Ben Collins 
<bcollins@debian.org>
Apr  3 09:05:50 wally kernel: PCI: Found IRQ 9 for device 02:0a.0
Apr  3 09:05:50 wally kernel: PCI: Sharing IRQ 9 with 02:04.1
Apr  3 09:05:50 wally kernel: ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[9] 
MMIO=[ed000000-ed0007ff]  Max Packet=[2048]
Apr  3 09:05:50 wally kernel: SCSI subsystem driver Revision: 1.00
Apr  3 09:05:50 wally kernel: ieee1394: Host added: Node[00:1023] 
GUID[00110600000051eb]  [Linux OHCI-1394]
Apr  3 09:05:50 wally kernel: scsi0 : IEEE-1394 SBP-2 protocol driver 
(host: ohci1394)
Apr  3 09:05:50 wally kernel: $Rev: 584 $ James Goodwin <jamesg@filanet.com>
Apr  3 09:05:50 wally kernel: SBP-2 module load options:
Apr  3 09:05:50 wally kernel: - Max speed supported: S400
Apr  3 09:05:50 wally kernel: - Max sectors per I/O supported: 255
Apr  3 09:05:50 wally kernel: - Max outstanding commands supported: 8
Apr  3 09:05:50 wally kernel: - Max outstanding commands per lun 
supported: 1
Apr  3 09:05:50 wally kernel: - Serialized I/O (debug): no
Apr  3 09:05:50 wally kernel: - Exclusive login: yes
Apr  3 09:05:50 wally kernel: mice: PS/2 mouse device common for all mice
Apr  3 09:05:50 wally kernel: usb.c: registered new driver usbdevfs
Apr  3 09:05:50 wally kernel: usb.c: registered new driver hub
Apr  3 09:05:50 wally kernel: ehci-hcd.c: 2002-May-07 USB 2.0 'Enhanced' 
Host Controller (EHCI) Driver
Apr  3 09:05:50 wally kernel: ehci-hcd.c: block sizes: qh 96 qtd 96 itd 
128 sitd 64
Apr  3 09:05:50 wally kernel: PCI: Found IRQ 9 for device 02:04.2
Apr  3 09:05:50 wally kernel: PCI: Sharing IRQ 9 with 00:1f.4
Apr  3 09:05:50 wally kernel: PCI: Sharing IRQ 9 with 02:0b.0
Apr  3 09:05:50 wally kernel: hcd.c: ehci-hcd @ 02:04.2, NEC Corporation 
USB 2.0
Apr  3 09:05:50 wally kernel: hcd.c: irq 9, pci mem f890a000
Apr  3 09:05:50 wally kernel: usb.c: new USB bus registered, assigned 
bus number 1
Apr  3 09:05:50 wally kernel: ehci-dbg.c: ehci_start hcs_params 0x2395 
dbg=0 cc=2 pcc=3 ports=5
Apr  3 09:05:50 wally kernel: ehci-dbg.c: 02:04.2: ehci_start portroute 
1 0 1 0 0
Apr  3 09:05:50 wally kernel: ehci-dbg.c: ehci_start hcc_params 0x0002 
caching 0 uframes 256/512/1024
Apr  3 09:05:50 wally kernel: ehci-hcd.c: reset 80002 cmd (park)=0 
ithresh=8 period=1024 Reset HALT
Apr  3 09:05:50 wally kernel: ehci-hcd.c: init 10001 cmd (park)=0 
ithresh=1 period=1024 RUN
Apr  3 09:05:50 wally kernel: ehci-hcd.c: USB 2.0 support enabled, EHCI 
rev 0.95
Apr  3 09:05:50 wally kernel: hcd.c: 02:04.2 root hub device address 1
Apr  3 09:05:50 wally kernel: usb.c: kmalloc IF f7881900, numif 1
Apr  3 09:05:50 wally kernel: usb.c: new device strings: Mfr=3, 
Product=2, SerialNumber=1
Apr  3 09:05:50 wally kernel: usb.c: USB device number 1 default 
language ID 0x0
Apr  3 09:05:50 wally kernel: Manufacturer: Linux 2.4.20 ehci-hcd
Apr  3 09:05:50 wally kernel: Product: NEC Corporation USB 2.0
Apr  3 09:05:50 wally kernel: SerialNumber: 02:04.2
Apr  3 09:05:50 wally kernel: hub.c: USB hub found
Apr  3 09:05:50 wally kernel: hub.c: 5 ports detected
Apr  3 09:05:50 wally kernel: hub.c: standalone hub
Apr  3 09:05:50 wally kernel: hub.c: individual port power switching
Apr  3 09:05:50 wally kernel: hub.c: individual port over-current protection
Apr  3 09:05:50 wally kernel: hub.c: Single TT
Apr  3 09:05:50 wally kernel: hub.c: TT requires at most 8 FS bit times
Apr  3 09:05:50 wally kernel: hub.c: Port indicators are not supported
Apr  3 09:05:50 wally kernel: hub.c: power on to power good time: 0ms
Apr  3 09:05:50 wally kernel: hub.c: hub controller current requirement: 0mA
Apr  3 09:05:50 wally kernel: hub.c: port removable status: RRRRR
Apr  3 09:05:50 wally kernel: hub.c: local power source is good
Apr  3 09:05:50 wally kernel: hub.c: no over-current condition exists
Apr  3 09:05:50 wally kernel: hub.c: enabling power on all ports
Apr  3 09:05:50 wally kernel: usb.c: hub driver claimed interface f7881900
Apr  3 09:05:50 wally kernel: usb.c: kusbd: /sbin/hotplug add 1
Apr  3 09:05:50 wally kernel: usb-uhci.c: $Revision: 1.275 $ time 
12:39:16 Apr  1 2003
Apr  3 09:05:50 wally kernel: usb-uhci.c: High bandwidth mode enabled
Apr  3 09:05:50 wally kernel: PCI: Found IRQ 9 for device 00:1f.2
Apr  3 09:05:50 wally kernel: PCI: Setting latency timer of device 
00:1f.2 to 64
Apr  3 09:05:50 wally kernel: usb-uhci.c: USB UHCI at I/O 0xb400, IRQ 9
Apr  3 09:05:50 wally kernel: usb-uhci.c: Detected 2 ports
Apr  3 09:05:50 wally kernel: usb.c: new USB bus registered, assigned 
bus number 2
Apr  3 09:05:50 wally kernel: usb.c: kmalloc IF f7881b80, numif 1
Apr  3 09:05:50 wally kernel: usb.c: new device strings: Mfr=0, 
Product=2, SerialNumber=1
Apr  3 09:05:50 wally kernel: usb.c: USB device number 1 default 
language ID 0x0
Apr  3 09:05:50 wally kernel: Product: USB UHCI Root Hub
Apr  3 09:05:50 wally kernel: SerialNumber: b400
Apr  3 09:05:50 wally kernel: hub.c: USB hub found
Apr  3 09:05:50 wally kernel: hub.c: 2 ports detected
Apr  3 09:05:50 wally kernel: hub.c: standalone hub
Apr  3 09:05:50 wally kernel: hub.c: ganged power switching
Apr  3 09:05:50 wally kernel: hub.c: global over-current protection
Apr  3 09:05:50 wally kernel: hub.c: Port indicators are not supported
Apr  3 09:05:50 wally kernel: hub.c: power on to power good time: 2ms
Apr  3 09:05:50 wally kernel: hub.c: hub controller current requirement: 0mA
Apr  3 09:05:50 wally kernel: hub.c: port removable status: RR
Apr  3 09:05:50 wally kernel: hub.c: local power source is good
Apr  3 09:05:50 wally kernel: hub.c: no over-current condition exists
Apr  3 09:05:50 wally kernel: hub.c: enabling power on all ports
Apr  3 09:05:50 wally kernel: usb.c: hub driver claimed interface f7881b80
Apr  3 09:05:50 wally kernel: usb.c: kusbd: /sbin/hotplug add 1
Apr  3 09:05:50 wally kernel: PCI: Found IRQ 9 for device 00:1f.4
Apr  3 09:05:50 wally kernel: PCI: Sharing IRQ 9 with 02:04.2
Apr  3 09:05:50 wally kernel: PCI: Sharing IRQ 9 with 02:0b.0
Apr  3 09:05:50 wally kernel: PCI: Setting latency timer of device 
00:1f.4 to 64
Apr  3 09:05:50 wally kernel: usb-uhci.c: USB UHCI at I/O 0xb000, IRQ 9
Apr  3 09:05:50 wally kernel: usb-uhci.c: Detected 2 ports
Apr  3 09:05:50 wally kernel: usb.c: new USB bus registered, assigned 
bus number 3
Apr  3 09:05:50 wally kernel: usb.c: kmalloc IF f7881dc0, numif 1
Apr  3 09:05:50 wally kernel: usb.c: new device strings: Mfr=0, 
Product=2, SerialNumber=1
Apr  3 09:05:50 wally kernel: usb.c: USB device number 1 default 
language ID 0x0
Apr  3 09:05:50 wally kernel: Product: USB UHCI Root Hub
Apr  3 09:05:50 wally kernel: SerialNumber: b000
Apr  3 09:05:50 wally kernel: hub.c: USB hub found
Apr  3 09:05:50 wally kernel: hub.c: 2 ports detected
Apr  3 09:05:50 wally kernel: hub.c: standalone hub
Apr  3 09:05:50 wally kernel: hub.c: ganged power switching
Apr  3 09:05:50 wally kernel: hub.c: global over-current protection
Apr  3 09:05:50 wally kernel: hub.c: Port indicators are not supported
Apr  3 09:05:50 wally kernel: hub.c: power on to power good time: 2ms
Apr  3 09:05:50 wally kernel: hub.c: hub controller current requirement: 0mA
Apr  3 09:05:50 wally kernel: hub.c: port removable status: RR
Apr  3 09:05:50 wally kernel: hub.c: local power source is good
Apr  3 09:05:50 wally kernel: hub.c: no over-current condition exists
Apr  3 09:05:50 wally kernel: hub.c: enabling power on all ports
Apr  3 09:05:50 wally kernel: usb.c: hub driver claimed interface f7881dc0
Apr  3 09:05:50 wally kernel: usb.c: kusbd: /sbin/hotplug add 1
Apr  3 09:05:50 wally kernel: usb-uhci.c: v1.275:USB Universal Host 
Controller Interface driver

<snip>

Apr  3 09:14:28 wally kernel: ieee1394: sbp2: Logged into SBP-2 device
Apr  3 09:14:28 wally kernel: ieee1394: sbp2: Node[02:1023]: Max speed 
[S400] - Max payload [2048]
Apr  3 09:14:28 wally kernel: ieee1394: Device added: Node[02:1023] 
GUID[00d001010000502f]  [VST TECHNOLOGIESINC.]
Apr  3 09:14:28 wally /etc/hotplug/ieee1394.agent: Setup sbp2 for 
IEEE1394 product 0x00d001/0x00609e/0x010483
Apr  3 09:14:28 wally /etc/hotplug/ieee1394.agent: Trying [sbp2]
Apr  3 09:14:28 wally /etc/hotplug/ieee1394.agent: missing kernel or 
user mode driver sbp2
Apr  3 09:14:54 wally kernel: ieee1394: sbp2: Logged out of SBP-2 device
Apr  3 09:14:54 wally kernel: scsi : 0 hosts left.
Apr  3 09:15:01 wally kernel: ieee1394: sbp2: Logged into SBP-2 device
Apr  3 09:15:01 wally kernel: ieee1394: sbp2: Node[02:1023]: Max speed 
[S400] - Max payload [2048]
Apr  3 09:15:01 wally kernel: scsi0 : IEEE-1394 SBP-2 protocol driver 
(host: ohci1394)
Apr  3 09:15:01 wally kernel: $Rev: 584 $ James Goodwin <jamesg@filanet.com>
Apr  3 09:15:01 wally kernel: SBP-2 module load options:
Apr  3 09:15:01 wally kernel: - Max speed supported: S400
Apr  3 09:15:01 wally kernel: - Max sectors per I/O supported: 255
Apr  3 09:15:01 wally kernel: - Max outstanding commands supported: 8
Apr  3 09:15:01 wally kernel: - Max outstanding commands per lun 
supported: 1
Apr  3 09:15:01 wally kernel: - Serialized I/O (debug): no
Apr  3 09:15:01 wally kernel: - Exclusive login: yes
Apr  3 09:15:01 wally kernel:   Vendor: FireWire  Model:  1394 Disk 
Drive  Rev:
Apr  3 09:15:01 wally kernel:   Type:   Direct-Access 
    ANSI SCSI revision: 02
Apr  3 09:15:01 wally kernel: Attached scsi disk sda at scsi0, channel 
0, id 0, lun 0
Apr  3 09:15:31 wally kernel: ieee1394: sbp2: aborting sbp2 command
Apr  3 09:15:31 wally kernel: 0x00 00 00 00 00 00
Apr  3 09:15:31 wally kernel: SCSI device sda: 39070080 512-byte hdwr 
sectors (20004 MB)
Apr  3 09:15:31 wally kernel:  /dev/scsi/host0/bus0/target0/lun0: p1 p2
Apr  3 09:16:13 wally PAM_unix[926]: authentication failure; (uid=0) -> 
root for ssh service
Apr  3 09:16:14 wally sshd[926]: Failed password for root from 
140.78.95.138 port 35762 ssh2
Apr  3 09:16:17 wally sshd[926]: Accepted password for root from 
140.78.95.138 port 35762 ssh2
Apr  3 09:16:17 wally PAM_unix[926]: (ssh) session opened for user root 
by (uid=0)
Apr  3 09:17:14 wally kernel: hub.c: port 1, portstatus 100, change 0, 
12 Mb/s
Apr  3 09:17:14 wally kernel: hub.c: port 2, portstatus 100, change 0, 
12 Mb/s
Apr  3 09:17:14 wally kernel: hub.c: port 3, portstatus 100, change 0, 
12 Mb/s
Apr  3 09:17:14 wally kernel: ehci-hub.c: GetStatus port 4 status 0x1803 
POWER speed=2 CSC CONNECT
Apr  3 09:17:14 wally kernel: hub.c: port 4, portstatus 501, change 1, 
480 Mb/s
Apr  3 09:17:14 wally kernel: hub.c: port 4 connection change
Apr  3 09:17:14 wally kernel: hub.c: port 4, portstatus 501, change 1, 
480 Mb/s
Apr  3 09:17:14 wally kernel: hub.c: port 4, portstatus 501, change 0, 
480 Mb/s
Apr  3 09:17:15 wally last message repeated 3 times
Apr  3 09:17:15 wally kernel: hub.c: port 4, portstatus 511, change 0, 
480 Mb/s
Apr  3 09:17:15 wally kernel: hub.c: port 4 of hub 1 not reset yet, 
waiting 10ms
Apr  3 09:17:15 wally kernel: hub.c: port 4, portstatus 511, change 0, 
480 Mb/s
Apr  3 09:17:15 wally kernel: hub.c: port 4 of hub 1 not reset yet, 
waiting 10ms
Apr  3 09:17:15 wally kernel: ehci-hub.c: 02:04.2 port 4 high speed
Apr  3 09:17:15 wally kernel: ehci-hub.c: GetStatus port 4 status 0x1005 
POWER speed=0 PE CONNECT
Apr  3 09:17:15 wally kernel: hub.c: port 4, portstatus 503, change 10, 
480 Mb/s
Apr  3 09:17:15 wally kernel: hub.c: new USB device 02:04.2-4, assigned 
address 2
Apr  3 09:17:15 wally kernel: usb.c: kmalloc IF f6def2c0, numif 1
Apr  3 09:17:15 wally kernel: usb.c: new device strings: Mfr=73, 
Product=90, SerialNumber=110
Apr  3 09:17:15 wally kernel: usb.c: USB device number 2 default 
language ID 0x409
Apr  3 09:17:15 wally kernel: Manufacturer: USB2.0 TO IDE
Apr  3 09:17:15 wally kernel: Product: USB Storage Adapter
Apr  3 09:17:15 wally kernel: SerialNumber: 11100E000044DC26
Apr  3 09:17:15 wally kernel: usb.c: unhandled interfaces on device
Apr  3 09:17:15 wally kernel: usb.c: USB device 2 (vend/prod 0x840/0x60) 
is not claimed by any active driver.
Apr  3 09:17:15 wally kernel:   Length              = 18
Apr  3 09:17:15 wally kernel:   DescriptorType      = 01
Apr  3 09:17:15 wally kernel:   USB version         = 2.00
Apr  3 09:17:15 wally kernel:   Vendor:Product      = 0840:0060
Apr  3 09:17:15 wally kernel:   MaxPacketSize0      = 64
Apr  3 09:17:15 wally kernel:   NumConfigurations   = 1
Apr  3 09:17:15 wally kernel:   Device version      = 11.01
Apr  3 09:17:15 wally kernel:   Device Class:SubClass:Protocol = 00:00:00
Apr  3 09:17:15 wally kernel:     Per-interface classes
Apr  3 09:17:15 wally kernel: Configuration:
Apr  3 09:17:15 wally kernel:   bLength             =    9
Apr  3 09:17:15 wally kernel:   bDescriptorType     =   02
Apr  3 09:17:15 wally kernel:   wTotalLength        = 0027
Apr  3 09:17:15 wally kernel:   bNumInterfaces      =   01
Apr  3 09:17:15 wally kernel:   bConfigurationValue =   02
Apr  3 09:17:15 wally kernel:   iConfiguration      =   00
Apr  3 09:17:15 wally kernel:   bmAttributes        =   c0
Apr  3 09:17:15 wally kernel:   MaxPower            =   98mA
Apr  3 09:17:15 wally kernel:
Apr  3 09:17:15 wally kernel:   Interface: 0
Apr  3 09:17:15 wally kernel:   Alternate Setting:  0
Apr  3 09:17:15 wally kernel:     bLength             =    9
Apr  3 09:17:15 wally kernel:     bDescriptorType     =   04
Apr  3 09:17:15 wally kernel:     bInterfaceNumber    =   00
Apr  3 09:17:15 wally kernel:     bAlternateSetting   =   00
Apr  3 09:17:15 wally kernel:     bNumEndpoints       =   03
Apr  3 09:17:15 wally kernel:     bInterface Class:SubClass:Protocol = 
  08:06:50
Apr  3 09:17:15 wally kernel:     iInterface          =   00
Apr  3 09:17:15 wally kernel:     Endpoint:
Apr  3 09:17:15 wally kernel:       bLength             =    7
Apr  3 09:17:15 wally kernel:       bDescriptorType     =   05
Apr  3 09:17:15 wally kernel:       bEndpointAddress    =   01 (out)
Apr  3 09:17:15 wally kernel:       bmAttributes        =   02 (Bulk)
Apr  3 09:17:15 wally kernel:       wMaxPacketSize      = 0200
Apr  3 09:17:15 wally kernel:       bInterval           =   01
Apr  3 09:17:15 wally kernel:     Endpoint:
Apr  3 09:17:15 wally kernel:       bLength             =    7
Apr  3 09:17:15 wally kernel:       bDescriptorType     =   05
Apr  3 09:17:15 wally kernel:       bEndpointAddress    =   82 (in)
Apr  3 09:17:15 wally kernel:       bmAttributes        =   02 (Bulk)
Apr  3 09:17:15 wally kernel:       wMaxPacketSize      = 0200
Apr  3 09:17:15 wally kernel:       bInterval           =   01
Apr  3 09:17:15 wally kernel:     Endpoint:
Apr  3 09:17:15 wally kernel:       bLength             =    7
Apr  3 09:17:15 wally kernel:       bDescriptorType     =   05
Apr  3 09:17:15 wally kernel:       bEndpointAddress    =   83 (in)
Apr  3 09:17:15 wally kernel:       bmAttributes        =   03 (Interrupt)
Apr  3 09:17:15 wally kernel:       wMaxPacketSize      = 0002
Apr  3 09:17:15 wally kernel:       bInterval           =   09
Apr  3 09:17:15 wally kernel: usb.c: kusbd: /sbin/hotplug add 2
Apr  3 09:17:15 wally kernel: hub.c: port 5, portstatus 100, change 0, 
12 Mb/s
Apr  3 09:17:15 wally /sbin/hotplug: arguments (usb) env 
(DEVFS=/proc/bus/usb OLDPWD=/ PATH=/bin:/sbin:/usr/sbin:/usr/bin 
ACTION=add PWD=/etc/hotplug SHLVL=1 HOME=/ DEVICE=/proc/bus/usb/001/002 
INTERFACE=8/6/80 PRODUCT=840/60/1101 TYPE=0/0/0 DEBUG=kernel _=/usr/bin/env)
Apr  3 09:17:15 wally /sbin/hotplug: invoke /etc/hotplug/usb.agent ()
Apr  3 09:17:15 wally /etc/hotplug/usb.agent: Setup usb-storage for USB 
product 840/60/1101
Apr  3 09:17:15 wally /etc/hotplug/usb.agent: Trying [usb-storage]
Apr  3 09:17:15 wally kernel: Initializing USB Mass Storage driver...
Apr  3 09:17:15 wally kernel: usb.c: registered new driver usb-storage
Apr  3 09:17:15 wally kernel: ehci-q.c: ep 0-in qtd token 80040d40 --> 
status -32
Apr  3 09:17:15 wally kernel: hcd.c: giveback urb f72c7a00 status -32 len 0
Apr  3 09:17:15 wally kernel: scsi0 : SCSI emulation for USB Mass 
Storage devices
Apr  3 09:17:17 wally kernel: ehci-q.c: ep 2-in qtd token 800d8d40 --> 
status -32
Apr  3 09:17:17 wally kernel: hcd.c: giveback urb f7824700 status -32 len 0
Apr  3 09:17:17 wally kernel:   Vendor: FUJITSU   Model: MHH2032AT 
    Rev: B815
Apr  3 09:17:17 wally kernel:   Type:   Direct-Access 
    ANSI SCSI revision: 02
Apr  3 09:17:17 wally kernel: devfs_mk_dir(host0/bus0/target0/lun0): 
using old entry in dir: f72c7980 "target0"
Apr  3 09:17:17 wally kernel: Attached scsi disk sdb at scsi0, channel 
0, id 0, lun 0
Apr  3 09:17:17 wally kernel: SCSI device sdb: 6357456 512-byte hdwr 
sectors (3255 MB)
Apr  3 09:17:17 wally kernel:  /dev/scsi/host0/bus0/target0/lun0: p1
Apr  3 09:17:17 wally kernel: devfs_register(disc): could not append to 
parent, err: -17
Apr  3 09:17:17 wally kernel: WARNING: USB Mass Storage data integrity 
not assured
Apr  3 09:17:17 wally kernel: USB Mass Storage device found at 2
Apr  3 09:17:17 wally kernel: usb.c: usb-storage driver claimed 
interface f6def2c0
Apr  3 09:17:17 wally kernel: USB Mass Storage support registered.
Apr  3 09:17:17 wally insmod: Using 
/lib/modules/2.4.20/kernel/drivers/usb/storage/usb-storage.o






Parts of the debug log when first plugging in the USB2.0 mass storage, 
then the Firewire mass storage device.

Apr  3 09:23:39 wally kernel: hub.c: port 4 connection change
Apr  3 09:23:39 wally kernel: hub.c: port 4, portstatus 501, change 1, 
480 Mb/s
Apr  3 09:23:39 wally kernel: hub.c: port 4, portstatus 501, change 0, 
480 Mb/s
Apr  3 09:23:39 wally last message repeated 3 times
Apr  3 09:23:39 wally kernel: hub.c: port 4, portstatus 511, change 0, 
480 Mb/s
Apr  3 09:23:39 wally kernel: hub.c: port 4 of hub 1 not reset yet, 
waiting 10ms
Apr  3 09:23:39 wally kernel: hub.c: port 4, portstatus 511, change 0, 
480 Mb/s
Apr  3 09:23:39 wally kernel: hub.c: port 4 of hub 1 not reset yet, 
waiting 10ms
Apr  3 09:23:39 wally kernel: ehci-hub.c: 02:04.2 port 4 high speed
Apr  3 09:23:39 wally kernel: ehci-hub.c: GetStatus port 4 status 0x1005 
POWER speed=0 PE CONNECT
Apr  3 09:23:39 wally kernel: hub.c: port 4, portstatus 503, change 10, 
480 Mb/s
Apr  3 09:23:39 wally kernel: hub.c: new USB device 02:04.2-4, assigned 
address 4
Apr  3 09:23:39 wally kernel: usb.c: kmalloc IF f6fd0180, numif 1
Apr  3 09:23:39 wally kernel: usb.c: new device strings: Mfr=73, 
Product=90, SerialNumber=110
Apr  3 09:23:39 wally kernel: usb.c: USB device number 4 default 
language ID 0x409
Apr  3 09:23:39 wally kernel: Manufacturer: USB2.0 TO IDE
Apr  3 09:23:39 wally kernel: Product: USB Storage Adapter
Apr  3 09:23:39 wally kernel: SerialNumber: 11100E000044DC26
Apr  3 09:23:39 wally kernel: usb.c: unhandled interfaces on device
Apr  3 09:23:39 wally kernel: usb.c: USB device 4 (vend/prod 0x840/0x60) 
is not claimed by any active driver.
Apr  3 09:23:39 wally kernel:   Length              = 18
Apr  3 09:23:39 wally kernel:   DescriptorType      = 01
Apr  3 09:23:39 wally kernel:   USB version         = 2.00
Apr  3 09:23:39 wally kernel:   Vendor:Product      = 0840:0060
Apr  3 09:23:39 wally kernel:   MaxPacketSize0      = 64
Apr  3 09:23:39 wally kernel:   NumConfigurations   = 1
Apr  3 09:23:39 wally kernel:   Device version      = 11.01
Apr  3 09:23:39 wally kernel:   Device Class:SubClass:Protocol = 00:00:00
Apr  3 09:23:39 wally kernel:     Per-interface classes
Apr  3 09:23:39 wally kernel: Configuration:
Apr  3 09:23:39 wally kernel:   bLength             =    9
Apr  3 09:23:39 wally kernel:   bDescriptorType     =   02
Apr  3 09:23:39 wally kernel:   wTotalLength        = 0027
Apr  3 09:23:39 wally kernel:   bNumInterfaces      =   01
Apr  3 09:23:39 wally kernel:   bConfigurationValue =   02
Apr  3 09:23:39 wally kernel:   iConfiguration      =   00
Apr  3 09:23:39 wally kernel:   bmAttributes        =   c0
Apr  3 09:23:39 wally kernel:   MaxPower            =   98mA
Apr  3 09:23:39 wally kernel:
Apr  3 09:23:39 wally kernel:   Interface: 0
Apr  3 09:23:39 wally kernel:   Alternate Setting:  0
Apr  3 09:23:39 wally kernel:     bLength             =    9
Apr  3 09:23:39 wally kernel:     bDescriptorType     =   04
Apr  3 09:23:39 wally kernel:     bInterfaceNumber    =   00
Apr  3 09:23:39 wally kernel:     bAlternateSetting   =   00
Apr  3 09:23:39 wally kernel:     bNumEndpoints       =   03
Apr  3 09:23:39 wally kernel:     bInterface Class:SubClass:Protocol = 
  08:06:50
Apr  3 09:23:39 wally kernel:     iInterface          =   00
Apr  3 09:23:39 wally kernel:     Endpoint:
Apr  3 09:23:39 wally kernel:       bLength             =    7
Apr  3 09:23:39 wally kernel:       bDescriptorType     =   05
Apr  3 09:23:39 wally kernel:       bEndpointAddress    =   01 (out)
Apr  3 09:23:39 wally kernel:       bmAttributes        =   02 (Bulk)
Apr  3 09:23:39 wally kernel:       wMaxPacketSize      = 0200
Apr  3 09:23:39 wally kernel:       bInterval           =   01
Apr  3 09:23:39 wally kernel:     Endpoint:
Apr  3 09:23:39 wally kernel:       bLength             =    7
Apr  3 09:23:39 wally kernel:       bDescriptorType     =   05
Apr  3 09:23:39 wally kernel:       bEndpointAddress    =   82 (in)
Apr  3 09:23:39 wally kernel:       bmAttributes        =   02 (Bulk)
Apr  3 09:23:39 wally kernel:       wMaxPacketSize      = 0200
Apr  3 09:23:39 wally kernel:       bInterval           =   01
Apr  3 09:23:39 wally kernel:     Endpoint:
Apr  3 09:23:39 wally kernel:       bLength             =    7
Apr  3 09:23:39 wally kernel:       bDescriptorType     =   05
Apr  3 09:23:39 wally kernel:       bEndpointAddress    =   83 (in)
Apr  3 09:23:39 wally kernel:       bmAttributes        =   03 (Interrupt)
Apr  3 09:23:39 wally kernel:       wMaxPacketSize      = 0002
Apr  3 09:23:39 wally kernel:       bInterval           =   09
Apr  3 09:23:39 wally kernel: usb.c: kusbd: /sbin/hotplug add 4
Apr  3 09:23:39 wally kernel: hub.c: port 5, portstatus 100, change 0, 
12 Mb/s
Apr  3 09:23:39 wally /sbin/hotplug: arguments (usb) env 
(DEVFS=/proc/bus/usb OLDPWD=/ PATH=/bin:/sbin:/usr/sbin:/usr/bin 
ACTION=add PWD=/etc/hotplug SHLVL=1 HOME=/ DEVICE=/proc/bus/usb/001/004 
INTERFACE=8/6/80 PRODUCT=840/60/1101 TYPE=0/0/0 DEBUG=kernel _=/usr/bin/env)
Apr  3 09:23:39 wally /sbin/hotplug: invoke /etc/hotplug/usb.agent ()
Apr  3 09:23:39 wally /etc/hotplug/usb.agent: Setup usb-storage for USB 
product 840/60/1101
Apr  3 09:23:39 wally /etc/hotplug/usb.agent: Trying [usb-storage]
Apr  3 09:23:39 wally kernel: Initializing USB Mass Storage driver...
Apr  3 09:23:39 wally kernel: usb.c: registered new driver usb-storage
Apr  3 09:23:39 wally kernel: ehci-q.c: ep 0-in qtd token 80040d40 --> 
status -32
Apr  3 09:23:39 wally kernel: hcd.c: giveback urb f75f2480 status -32 len 0
Apr  3 09:23:39 wally kernel: scsi0 : SCSI emulation for USB Mass 
Storage devices
Apr  3 09:23:42 wally kernel: ehci-q.c: ep 2-in qtd token 800d8d40 --> 
status -32
Apr  3 09:23:42 wally kernel: hcd.c: giveback urb f75f2180 status -32 len 0
Apr  3 09:23:42 wally kernel:   Vendor: FUJITSU   Model: MHH2032AT 
    Rev: B815
Apr  3 09:23:42 wally kernel:   Type:   Direct-Access 
    ANSI SCSI revision: 02
Apr  3 09:23:42 wally kernel: Attached scsi disk sda at scsi0, channel 
0, id 0, lun 0
Apr  3 09:23:42 wally kernel: SCSI device sda: 6357456 512-byte hdwr 
sectors (3255 MB)
Apr  3 09:23:42 wally kernel:  /dev/scsi/host0/bus0/target0/lun0: p1
Apr  3 09:23:42 wally kernel: WARNING: USB Mass Storage data integrity 
not assured
Apr  3 09:23:42 wally kernel: USB Mass Storage device found at 4
Apr  3 09:23:42 wally kernel: usb.c: usb-storage driver claimed 
interface f6fd0180
Apr  3 09:23:42 wally kernel: USB Mass Storage support registered.
Apr  3 09:23:42 wally insmod: Using 
/lib/modules/2.4.20/kernel/drivers/usb/storage/usb-storage.o
Apr  3 09:23:42 wally insmod: Symbol version prefix ''
Apr  3 09:23:42 wally /etc/hotplug/usb.agent: missing kernel or user 
mode driver usb-storage
Apr  3 09:24:04 wally kernel: ieee1394: Device added: Node[02:1023] 
GUID[00d001010000502f]  [VST TECHNOLOGIESINC.]
Apr  3 09:24:04 wally /etc/hotplug/ieee1394.agent: Setup sbp2 for 
IEEE1394 product 0x00d001/0x00609e/0x010483
Apr  3 09:24:04 wally /etc/hotplug/ieee1394.agent: Trying [sbp2]
Apr  3 09:24:06 wally ntpd[701]: kernel time discipline status change 41
Apr  3 09:24:07 wally kernel: ieee1394: sbp2: Logged into SBP-2 device
Apr  3 09:24:07 wally kernel: ieee1394: sbp2: Node[02:1023]: Max speed 
[S400] - Max payload [2048]
Apr  3 09:24:07 wally kernel: scsi0 : IEEE-1394 SBP-2 protocol driver 
(host: ohci1394)
Apr  3 09:24:07 wally kernel: $Rev: 584 $ James Goodwin <jamesg@filanet.com>
Apr  3 09:24:07 wally kernel: SBP-2 module load options:
Apr  3 09:24:07 wally kernel: - Max speed supported: S400
Apr  3 09:24:07 wally kernel: - Max sectors per I/O supported: 255
Apr  3 09:24:07 wally kernel: - Max outstanding commands supported: 8
Apr  3 09:24:07 wally kernel: - Max outstanding commands per lun 
supported: 1
Apr  3 09:24:07 wally kernel: - Serialized I/O (debug): no
Apr  3 09:24:07 wally kernel: - Exclusive login: yes
Apr  3 09:24:07 wally kernel:   Vendor: FireWire  Model:  1394 Disk 
Drive  Rev:
Apr  3 09:24:07 wally kernel:   Type:   Direct-Access 
    ANSI SCSI revision: 02
Apr  3 09:24:07 wally kernel: devfs_mk_dir(host0/bus0/target0/lun0): 
using old entry in dir: f7887380 "target0"
Apr  3 09:24:07 wally kernel: Attached scsi disk sdb at scsi0, channel 
0, id 0, lun 0


best regards,
Rene Mayrhofer and Simon Vogl


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315758AbSGSG25>; Fri, 19 Jul 2002 02:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315762AbSGSG25>; Fri, 19 Jul 2002 02:28:57 -0400
Received: from zeppo.NMSU.Edu ([128.123.29.173]:41346 "EHLO zeppo.NMSU.Edu")
	by vger.kernel.org with ESMTP id <S315758AbSGSG2u>;
	Fri, 19 Jul 2002 02:28:50 -0400
Message-Id: <200207190621.g6J6L6V07597@zeppo.NMSU.Edu>
From: Vassili Papavassiliou <pvs@NMSU.Edu>
To: linux-kernel@vger.kernel.org
cc: Vassili Papavassiliou <pvs@NMSU.Edu>
Subjecn: Simultaneous timeout of PCMCIA and USB under heavy load, kernel 2.4.18
Date: Fri, 19 Jul 2002 00:21:06 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
    This is a reproducible problem on a Gateway Solo 9100 laptop, 233 MHz PII.
At the very end I include a bug report from the kernel, as printed in the log
file (/var/log/messages) some time later. It may be totally unrelated, but it
seems to make references to PCMCIA and USB, so I decided not to omit it. 
 * Please CC any responses to pvs@nmsu.edu *

    I use Red Hat 7.3, kernel 2.4.18-3. USB and PCMCIA both usually work well. 
However, they both time out during normal activity on the USB bus when there 
is heavy traffic through a PCMCIA card. Examples include moving or scrolling
with a USB mouse, such as Targus optical mini-mouse (or a serial mouse such as
a Logitech wheel mouse connected to a USB port replicator), while downloading
a large web page using a D-Link DWL-650 802.11b card, or a 3Com 3C589C Combo
10BaseT/Coax Ethernet card, or while reading data from a SCSI drive (an Orb,
from Castlewood) connected through an Adaptec SlimSCSI 1480A cardbus adapter
(for example, while doing "du -sk" on such a disk). The symptom is that both
the PCMCIA and the USB peripherals are dropped - all of them - simultaneously
and it is very difficult or impossible to recover them without a reboot. An
example, during a download through the DWL-650 as the mouse was used to scroll
down the page, is shown below:


Jul 18 16:49:24 localhost kernel: usb.c: USB disconnect on device 7
Jul 18 16:49:25 localhost kernel: hub.c: USB new device connect on bus1/1, assigned device number 8
Jul 18 16:49:29 localhost kernel: usb_control/bulk_msg: timeout
Jul 18 16:49:29 localhost kernel: usb.c: USB device not accepting new address=8 (error=-110)
Jul 18 16:49:29 localhost kernel: hub.c: USB new device connect on bus1/1, assigned device number 9
Jul 18 16:49:31 localhost kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jul 18 16:49:31 localhost kernel: wvlan_cs: eth0 Tx timed out! Resetting card
Jul 18 16:49:31 localhost kernel: wvlan_cs: MAC address on eth0 is 00 40 05 df 4b 9c
Jul 18 16:49:31 localhost kernel: wvlan_cs: This is a PrismII card, not a Wavelan IEEE card :-(
Jul 18 16:49:31 localhost kernel: You may want report firmare revision (0x8) and what the card support.
Jul 18 16:49:31 localhost kernel: I will try to make it work, but you should look for a better driver.
Jul 18 16:49:31 localhost kernel: wvlan_cs: Found firmware 0x8 (vendor 2) - Firmware capabilities : 1-0-0-0-1
Jul 18 16:49:33 localhost kernel: usb_control/bulk_msg: timeout
Jul 18 16:49:33 localhost kernel: usb.c: USB device not accepting new address=9 (error=-110)
Jul 18 16:49:35 localhost kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jul 18 16:49:35 localhost kernel: wvlan_cs: eth0 Tx timed out! Resetting card
Jul 18 16:49:35 localhost kernel: wvlan_cs: MAC address on eth0 is 00 40 05 df 4b 9c
Jul 18 16:49:35 localhost kernel: wvlan_cs: This is a PrismII card, not a Wavelan IEEE card :-(
Jul 18 16:49:35 localhost kernel: You may want report firmare revision (0x8) and what the card support.
Jul 18 16:49:35 localhost kernel: I will try to make it work, but you should look for a better driver.
Jul 18 16:49:35 localhost kernel: wvlan_cs: Found firmware 0x8 (vendor 2) - Firmware capabilities : 1-0-0-0-1
Jul 18 16:49:39 localhost kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jul 18 16:49:39 localhost kernel: wvlan_cs: eth0 Tx timed out! Resetting card


and this goes on, continuous failed attempts to restart the eth0 interface,
interspersed with "usb.c: USB device not accepting new address=..." messages.
Note that this driver (wvlan_cs) actually works with this card, inspite of the
messages that it's not the best one. The only way I could restart the eth0
interface was to unplug the USB devices, unload uhci, usbcore, and any other
USB modules that would unload (i.e., didn't say "busy") and then eject the
card and restart the PCMCIA system with "service pcmcia restart"). That did
the job. 

    I had similar or worse experiences with usb-uhci and the 3Com ethernet 
card, which led me to switch to uhci, which seemed to be a little more
tolerant to USB activity under PCMCIA traffic, but still eventually produced
the above event. As I mentioned, USB devices usually work well without the
PCMCIA cards with this kernel, and vice-versa.

    Under kernel 2.2.x (Red Hat 7.0) I had only observed this behavior with
the cardbus card (the 1480A SCSI adapter). Cardbus and USB share the only PCI
IRQ on this computer, 10. In 2.4.x, all PC cards are assigned IRQ 10. I don't
know if this is relevant, I understand it is supposed to be that way. In any
case, all cards have exibited this problem. Also, it is not limited to a USB
mouse, I believe I have seen it with traffic in other USB devices, such a modem
(although it's hard to tell, because the mouse is usually connected as well).

    Some additional information: output from ver_linux


# sh /usr/src/linux-2.4/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux localhost.localdomain 2.4.18-3 #1 Thu Apr 18 07:37:53 EDT 2002 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.14
e2fsprogs              1.27
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.22
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         uhci wvlan_cs ds yenta_socket pcmcia_core binfmt_misc parport_pc lp parport autofs ipchains ide-cd cdrom opl3sa2 ad1848 mpu401 sound soundcore mousedev input usbcore ext3 jbd


>From the boot messages (sorry about the length):


Jul 18 14:58:29 localhost syslogd 1.4.1: restart.
Jul 18 14:58:29 localhost syslog: syslogd startup succeeded
Jul 18 14:58:29 localhost kernel: klogd 1.4.1, log source = /proc/kmsg started.
Jul 18 14:58:29 localhost kernel: 0:07.2
Jul 18 14:58:29 localhost kernel: uhci.c: USB UHCI at I/O 0xfce0, IRQ 10
Jul 18 14:58:29 localhost kernel: usb.c: new USB bus registered, assigned bus number 1
Jul 18 14:58:29 localhost kernel: hub.c: USB hub found
Jul 18 14:58:29 localhost kernel: hub.c: 2 ports detected
Jul 18 14:58:29 localhost kernel: hub.c: USB new device connect on bus1/1, assigned device number 2
Jul 18 14:58:29 localhost kernel: usb.c: USB device 2 (vend/prod 0x458/0x3) is not claimed by any active driver.
Jul 18 14:58:29 localhost kernel: usb.c: registered new driver hiddev
Jul 18 14:58:29 localhost kernel: usb.c: registered new driver hid
Jul 18 14:58:29 localhost kernel: input0: USB HID v1.00 Mouse [KYE Genius USB Wheel Mouse] on usb1:2.0
Jul 18 14:58:29 localhost kernel: hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
Jul 18 14:58:29 localhost kernel: hid-core.c: USB HID support drivers
Jul 18 14:58:29 localhost kernel: mice: PS/2 mouse device common for all mice
Jul 18 14:58:29 localhost syslog: klogd startup succeeded
Jul 18 14:58:29 localhost kernel: EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,8), internal journal
Jul 18 14:58:29 localhost kernel: ad1848/cs4248 codec driver Copyright (C) by Hannu Savolainen 1993-1996
Jul 18 14:58:29 localhost portmap: portmap startup succeeded
Jul 18 14:58:29 localhost kernel: ad1848: No ISAPnP cards found, trying standard ones...
Jul 18 14:58:29 localhost kernel: opl3sa2: No PnP cards found
Jul 18 14:58:29 localhost kernel: opl3sa2: Search for a card at 0x880.
Jul 18 14:58:29 localhost kernel: opl3sa2: Found OPL3-SA3 (YMF715B or YMF719B)
Jul 18 14:58:29 localhost kernel: ad1848: Interrupt test failed (IRQ5)
Jul 18 14:58:29 localhost kernel: opl3sa2: Control I/O port 0x370 not free
Jul 18 14:58:29 localhost kernel: opl3sa2: There was a problem probing one  of the ISA PNP cards, continuing
Jul 18 14:58:29 localhost rpc.statd[861]: Version 0.3.3 Starting
Jul 18 14:58:29 localhost nfslock: rpc.statd startup succeeded
Jul 18 14:58:29 localhost kernel: opl3sa2: Control I/O port 0x370 not free
Jul 18 14:58:30 localhost kernel: opl3sa2: There was a problem probing one  of the ISA PNP cards, continuing
Jul 18 14:58:30 localhost kernel: opl3sa2: Control I/O port 0x370 not free
Jul 18 14:58:30 localhost kernel: opl3sa2: There was a problem probing one  of the ISA PNP cards, continuing
Jul 18 14:58:30 localhost kernel: kjournald starting.  Commit interval 5 seconds
Jul 18 14:58:30 localhost kernel: EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,1), internal journal
Jul 18 14:58:30 localhost kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jul 18 14:58:30 localhost kernel: kjournald starting.  Commit interval 5 seconds
Jul 18 14:58:30 localhost kernel: EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,7), internal journal
Jul 18 14:58:30 localhost kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jul 18 14:58:30 localhost kernel: kjournald starting.  Commit interval 5 seconds
Jul 18 14:58:30 localhost kernel: EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,6), internal journal
Jul 18 14:58:30 localhost kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jul 18 14:58:30 localhost kernel: kjournald starting.  Commit interval 5 seconds
Jul 18 14:58:30 localhost kernel: EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,5), internal journal
Jul 18 14:58:30 localhost kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jul 18 14:58:30 localhost kernel: kjournald starting.  Commit interval 5 seconds
Jul 18 14:58:30 localhost kernel: EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,2), internal journal
Jul 18 14:58:30 localhost kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jul 18 14:58:30 localhost kernel: ide-floppy driver 0.99.newide
Jul 18 14:58:30 localhost kernel: hdc: ATAPI 20X CD-ROM drive, 128kB Cache, DMA
Jul 18 14:58:30 localhost kernel: Uniform CD-ROM driver Revision: 3.12
Jul 18 14:58:30 localhost kernel: hdc: DMA disabled
Jul 18 14:58:30 localhost kernel: parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
Jul 18 14:58:30 localhost kernel: parport0: irq 7 detected
Jul 18 14:58:30 localhost kernel: ip_conntrack (2048 buckets, 16384 max)
Jul 18 14:58:30 localhost keytable: Loading keymap:  succeeded
Jul 18 14:58:30 localhost keytable: Loading system font:  succeeded
Jul 18 14:58:30 localhost random: Initializing random number generator:  succeeded
Jul 18 14:58:31 localhost pcmcia: Starting PCMCIA services:
Jul 18 14:58:31 localhost pcmcia:  modules
Jul 18 14:58:31 localhost kernel: Linux Kernel Card Services 3.1.22
Jul 18 14:58:31 localhost kernel:   options:  [pci] [cardbus] [pm]
Jul 18 14:58:31 localhost kernel: PCI: Found IRQ 10 for device 00:0a.0
Jul 18 14:58:31 localhost kernel: PCI: Found IRQ 10 for device 00:0a.1
Jul 18 14:58:31 localhost kernel: Yenta IRQ list 0000, PCI irq10
Jul 18 14:58:31 localhost kernel: Socket status: 30000811
Jul 18 14:58:31 localhost kernel: Yenta IRQ list 0000, PCI irq10
Jul 18 14:58:31 localhost kernel: Socket status: 30000007
Jul 18 14:53:26 localhost rc.sysinit: Mounting proc filesystem:  succeeded
Jul 18 14:53:26 localhost rc.sysinit: Unmounting initrd:  succeeded
Jul 18 14:53:26 localhost sysctl: net.ipv4.ip_forward = 0
Jul 18 14:53:26 localhost sysctl: net.ipv4.conf.default.rp_filter = 1
Jul 18 14:53:26 localhost sysctl: kernel.sysrq = 0
Jul 18 14:53:26 localhost sysctl: kernel.core_uses_pid = 1
Jul 18 14:53:26 localhost rc.sysinit: Configuring kernel parameters:  succeeded
Jul 18 14:53:26 localhost date: Thu Jul 18 14:53:02 MDT 2002
Jul 18 14:53:26 localhost rc.sysinit: Setting clock  (utc): Thu Jul 18 14:53:02 MDT 2002 succeeded
Jul 18 14:53:26 localhost rc.sysinit: Loading default keymap succeeded
Jul 18 14:53:26 localhost rc.sysinit: Setting default font (lat0-sun16):  succeeded
Jul 18 14:53:26 localhost rc.sysinit: Activating swap partitions:  succeeded
Jul 18 14:53:26 localhost rc.sysinit: Setting hostname localhost.localdomain:  succeeded
Jul 18 14:53:26 localhost rc.sysinit: Mounting USB filesystem:  succeeded
Jul 18 14:53:26 localhost rc.sysinit: Initializing USB controller (uhci):  succeeded
Jul 18 14:53:26 localhost rc.sysinit: Initializing USB HID interface:  succeeded
Jul 18 14:53:26 localhost rc.sysinit: Initializing USB mouse:  succeeded
Jul 18 14:53:26 localhost fsck: /: 19881/64256 files (0.5% non-contiguous), 85366/257008 blocks
Jul 18 14:53:26 localhost rc.sysinit: Checking root filesystem succeeded
Jul 18 14:53:26 localhost rc.sysinit: Remounting root filesystem in read-write mode:  succeeded
Jul 18 14:53:27 localhost rc.sysinit: Finding module dependencies:  succeeded
Jul 18 14:53:27 localhost rc.sysinit: Loading sound module (opl3sa2):  succeeded
Jul 18 14:53:28 localhost fsck: /boot: recovering journal
Jul 18 14:53:29 localhost fsck: /boot: 40/10040 files (2.5% non-contiguous), 10123/40131 blocks
Jul 18 14:53:29 localhost fsck: /home: recovering journal
Jul 18 14:53:30 localhost fsck: /home: |
Jul 18 14:54:22 localhost fsck: /home: 30341/1310720 files (0.2% non-contiguous), 361822/2618587 blocks
Jul 18 14:54:33 localhost fsck: /opt: recovering journal
Jul 18 14:55:12 localhost fsck: /opt: 47732/256512 files (0.1% non-contiguous), 308061/512064 blocks
Jul 18 14:55:20 localhost fsck: /usr: recovering journal
Jul 18 14:57:25 localhost fsck: /usr: 156757/641280 files (0.1% non-contiguous), 720666/1281175 blocks
Jul 18 14:57:30 localhost fsck: /var: recovering journal
Jul 18 14:57:32 localhost fsck: /var:
Jul 18 14:57:32 localhost fsck: Clearing orphaned inode 103449 (uid=502, gid=502, mode=0140775, size=0)
Jul 18 14:57:32 localhost fsck: /var: Clearing orphaned inode 73862 (uid=0, gid=0, mode=020600, size=0)
Jul 18 14:57:32 localhost fsck: /var: Clearing orphaned inode 73861 (uid=0, gid=0, mode=020600, size=0)
Jul 18 14:57:35 localhost fsck: /var: 1556/132768 files (3.7% non-contiguous), 33332/265072 blocks
Jul 18 14:57:37 localhost rc.sysinit: Checking filesystems succeeded
Jul 18 14:57:38 localhost rc.sysinit: Mounting local filesystems:  succeeded
Jul 18 14:57:38 localhost rc.sysinit: Enabling local filesystem quotas:  succeeded
Jul 18 14:57:40 localhost rc.sysinit: Enabling swap space:  succeeded
Jul 18 14:58:11 localhost init: Switching to runlevel: 5
Jul 18 14:58:11 localhost kudzu: Updating /etc/fstab succeeded
Jul 18 14:58:24 localhost kudzu:  succeeded
Jul 18 14:58:25 localhost ipchains: Flushing all current rules and user defined chains: succeeded
Jul 18 14:58:25 localhost ipchains: Clearing all current rules and user defined chains: succeeded
Jul 18 14:58:26 localhost ipchains: Applying ipchains firewall rules succeeded
Jul 18 14:58:27 localhost sysctl: net.ipv4.ip_forward = 0
Jul 18 14:58:27 localhost sysctl: net.ipv4.conf.default.rp_filter = 1
Jul 18 14:58:27 localhost sysctl: kernel.sysrq = 0
Jul 18 14:58:27 localhost sysctl: kernel.core_uses_pid = 1
Jul 18 14:58:27 localhost network: Setting network parameters:  succeeded
Jul 18 14:58:28 localhost logger: punching nameserver 216.227.0.68 through the firewall
Jul 18 14:58:28 localhost logger: punching nameserver 64.34.48.36 through the firewall
Jul 18 14:58:28 localhost network: Bringing up loopback interface:  succeeded
Jul 18 14:58:28 localhost network: Bringing up interface eth0:  succeeded
Jul 18 14:58:28 localhost network: Bringing up interface ppp0:  succeeded
Jul 18 14:58:32 localhost pcmcia:  cardmgr.
Jul 18 14:58:32 localhost cardmgr[994]: starting, version is 3.1.22
Jul 18 14:58:32 localhost rc: Starting pcmcia:  succeeded
Jul 18 14:58:33 localhost cardmgr[994]: config error, file './config.opts' line 8: no function bindings
Jul 18 14:58:33 localhost cardmgr[994]: watching 2 sockets
Jul 18 14:58:33 localhost kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Jul 18 14:58:33 localhost kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x200-0x207 0x220-0x22f 0x378-0x37f 0x388-0x38f 0x398-0x39f 0x4d0-0x4d7
Jul 18 14:58:33 localhost kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Jul 18 14:58:33 localhost cardmgr[994]: initializing socket 0
Jul 18 14:58:33 localhost cardmgr[994]: socket 0: Intersil PRISM2 11 Mbps Wireless Adapter
Jul 18 14:58:33 localhost kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
Jul 18 14:58:33 localhost cardmgr[994]: executing: 'modprobe wvlan_cs'
Jul 18 14:58:33 localhost kernel: wvlan_cs: WaveLAN/IEEE PCMCIA driver v1.0.6
Jul 18 14:58:33 localhost kernel: wvlan_cs: (c) Andreas Neuhaus <andy@fasta.fh-dortmund.de>
Jul 18 14:58:33 localhost kernel: wvlan_cs: index 0x01: Vcc 3.3, irq 10, io 0x0100-0x013f
Jul 18 14:58:33 localhost kernel: wvlan_cs: Registered netdevice eth0
Jul 18 14:58:33 localhost kernel: wvlan_cs: MAC address on eth0 is 00 40 05 df 4b 9c
Jul 18 14:58:33 localhost kernel: wvlan_cs: This is a PrismII card, not a Wavelan IEEE card :-(
Jul 18 14:58:33 localhost kernel: You may want report firmare revision (0x8) and what the card support.
Jul 18 14:58:33 localhost kernel: I will try to make it work, but you should look for a better driver.
Jul 18 14:58:33 localhost kernel: wvlan_cs: Found firmware 0x8 (vendor 2) - Firmware capabilities : 1-0-0-0-1
Jul 18 14:58:33 localhost cardmgr[994]: executing: './network start eth0'
Jul 18 14:58:33 localhost netfs: Mounting other filesystems:  succeeded
Jul 18 14:58:34 localhost apmd: apmd startup succeeded
Jul 18 14:58:34 localhost /etc/hotplug/net.agent: invoke ifup eth0
Jul 18 14:58:34 localhost apmd[1069]: Version 3.0.2 (APM BIOS 1.2, Linux driver 1.16)
Jul 18 14:58:34 localhost autofs: automount startup succeeded
Jul 18 14:58:35 localhost sshd: Starting sshd:
Jul 18 14:58:35 localhost apmd[1069]: Charge: * * * (2% unknown)
Jul 18 14:58:35 localhost sshd:  succeeded
Jul 18 14:58:35 localhost sshd:
Jul 18 14:58:35 localhost rc: Starting sshd:  succeeded
Jul 18 14:58:38 localhost xinetd[1240]: xinetd Version 2002.03.28 started with libwrap options compiled in.
Jul 18 14:58:38 localhost xinetd[1240]: Started working: 1 available service
Jul 18 14:58:39 localhost xinetd: xinetd startup succeeded
Jul 18 14:58:41 localhost kernel: parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
Jul 18 14:58:41 localhost kernel: parport0: irq 7 detected
Jul 18 14:58:41 localhost kernel: lp0: using parport0 (polling).
Jul 18 14:58:41 localhost kernel: lp0: console ready
Jul 18 14:58:42 localhost lpd: lpd startup succeeded
Jul 18 14:58:44 localhost sendmail: sendmail startup succeeded
Jul 18 14:58:44 localhost gpm: gpm startup succeeded
Jul 18 14:58:45 localhost crond: crond startup succeeded
Jul 18 14:58:46 localhost xfs: xfs startup succeeded
Jul 18 14:58:46 localhost xfs: listening on port 7100
Jul 18 14:58:46 localhost anacron: anacron startup succeeded
Jul 18 14:58:47 localhost atd: atd startup succeeded
Jul 18 14:58:47 localhost xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/cyrillic (unreadable)
Jul 18 14:58:47 localhost xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/CID (unreadable)
Jul 18 14:58:47 localhost xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/local (unreadable)
Jul 18 14:58:47 localhost xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/latin2/Type1 (unreadable)
Jul 18 14:58:47 localhost wine: Registering binary handler for Windows applications
Jul 18 14:58:49 localhost rc: Starting wine:  succeeded
Jul 18 14:58:49 localhost linuxconf-setup: Linuxconf final setup
Jul 18 14:58:49 localhost linuxconf-setup:   Setting firewalling
Jul 18 14:58:49 localhost linuxconf-setup:   Checking kernel configuration
Jul 18 14:58:49 localhost rc: Starting linuxconf-setup:  succeeded
Jul 18 14:58:53 localhost modprobe: modprobe: Can't locate module char-major-81


PCI information:


# lspci -vvv
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (AGP disabled) (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at <unassigned> (32-bit, prefetchable) [size=256M]

00:02.0 VGA compatible controller: Trident Microsystems Cyber 9397 (rev f3) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at fe400000 (32-bit, non-prefetchable) [size=4M]
        Region 1: Memory at fede0000 (32-bit, non-prefetchable) [size=128K]
        Region 2: Memory at fe800000 (32-bit, non-prefetchable) [size=4M]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:07.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at fcd0 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at fce0 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:0a.0 CardBus bridge: Cirrus Logic PD 6832 PCMCIA/CardBus Ctrlr (rev c1)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
        Memory window 0: 10400000-107ff000
        Memory window 1: 10800000-10bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
        16-bit legacy interface ports at 0001

00:0a.1 CardBus bridge: Cirrus Logic PD 6832 PCMCIA/CardBus Ctrlr (rev c1)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin B routed to IRQ 10
        Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=05, subordinate=08, sec-latency=176
        Memory window 0: 10c00000-10fff000
        Memory window 1: 11000000-113ff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+


Interrupts:


# cat /proc/interrupts
           CPU0
  0:    3297005          XT-PIC  timer
  1:      40234          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  MS Sound System
  8:          2          XT-PIC  rtc
 10:      99147          XT-PIC  Cirrus Logic PD 6832, Cirrus Logic PD 6832 (#2), wvlan_cs
 12:      59480          XT-PIC  PS/2 Mouse
 14:     357225          XT-PIC  ide0
 15:     479276          XT-PIC  ide1
NMI:          0
ERR:          0


(when USB devices are connected, they are also assigned IRQ 10. IRQ 12, PS/2
Mouse, is the touchpad).


Finally, the bug report from the kernel. I noticed it as I was preparing this
message a few hours later and may not be relevant. It did not cause the PC
card to drop out, but there were no USB devides connected at the time. I only
include it because of the references to ds and uhci; pardon me if this is not
related to the other problem:


Jul 18 19:42:55 localhost kernel: kernel BUG at slab.c:815!
Jul 18 19:42:55 localhost kernel: invalid operand: 0000
Jul 18 19:42:55 localhost kernel: uhci wvlan_cs ds yenta_socket pcmcia_core binf
mt_misc parport_pc lp parport au
Jul 18 19:42:55 localhost kernel: CPU:    0
Jul 18 19:42:55 localhost kernel: EIP:    0010:[<c012e33a>]    Not tainted
Jul 18 19:42:55 localhost kernel: EFLAGS: 00010286
Jul 18 19:42:55 localhost kernel:
Jul 18 19:42:55 localhost kernel: EIP is at kmem_cache_create [kernel] 0x32a (2.
4.18-3)
Jul 18 19:42:55 localhost kernel: eax: 0000001a   ebx: c138fc18   ecx: 00000001
  edx: 0000cda6
Jul 18 19:42:55 localhost kernel: esi: c138fc12   edi: d0917caf   ebp: c138fd00
  esp: ccb5ded8
Jul 18 19:42:55 localhost kernel: ds: 0018   es: 0018   ss: 0018
Jul 18 19:42:55 localhost kernel: Process modprobe (pid: 4336, stackpage=ccb5d00
0)
Jul 18 19:42:55 localhost kernel: Stack: c022500e 0000032f ccb5dee4 0000001c 000
00000 fffffff4 00000001 00000001
Jul 18 19:42:56 localhost kernel:        d0916932 d0917ca1 0000003c 00000020 000
20000 00000000 00000000 ffffffff
Jul 18 19:42:56 localhost kernel:        0000399c d0912000 00000001 d0912000 000
00001 c0118e65 d0917e28 ca477000
Jul 18 19:42:56 localhost kernel: Call Trace: [<d0916932>] uhci_hcd_init [uhci]
0x72
Jul 18 19:42:56 localhost kernel: [<d0917ca1>] .rodata.str1.1 [uhci] 0x3e1
Jul 18 19:42:56 localhost kernel: [<c0118e65>] sys_init_module [kernel] 0x535
Jul 18 19:42:56 localhost kernel: [<d0917e28>] .kmodtab [uhci] 0x0
Jul 18 19:42:56 localhost kernel: [<d0912060>] uhci_show_td [uhci] 0x0
Jul 18 19:42:56 localhost kernel: [<c0108923>] system_call [kernel] 0x33
Jul 18 19:42:56 localhost kernel:
Jul 18 19:42:56 localhost kernel:
Jul 18 19:42:56 localhost kernel: Code: 0f 0b 5a 59 8b 1b 81 fb 48 45 2c c0 75 c
8 8b 15 48 45 2c c0


Thank you for your attention and any hints, suggestions, or intuition.

                                                   Vassili Papavassiliou


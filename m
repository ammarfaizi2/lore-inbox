Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268276AbTGIOjw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 10:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268283AbTGIOjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 10:39:52 -0400
Received: from CPE00e02915899a-CM.cpe.net.cable.rogers.com ([24.157.227.104]:47510
	"EHLO mokona.furryterror.org") by vger.kernel.org with ESMTP
	id S268276AbTGIOjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 10:39:42 -0400
From: Zygo Blaxell <uixjjji1@umail.furryterror.org>
Subject: Re: 2.4.21 IDE and IEEE1394+SBP2 regressions, orinoco_pci progress
Date: Wed, 09 Jul 2003 10:54:16 -0400
Organization: Furry Cats and Hungry Terrors
Message-ID: <pan.2003.07.09.10.54.10.958963.10062@umail.hungrycats.org>
References: <pan.2003.07.08.22.25.12.249185.15455@umail.hungrycats.org> <pan.2003.07.08.22.25.12.249185.15455@umail.hungrycats.org> <20030709021201.GH5830@phunnypharm.org>
User-Agent: Pan/0.11.2 (Unix)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Comment-To: "Ben Collins" <bcollins@debian.org>
NNTP-Posting-Host: 10.215.3.77
X-Header-Mangling: Original "From:" was <zblaxell@umail.hungrycats.org>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Jul 2003 22:12:01 -0400, Ben Collins wrote:
> You did do rescan-scsi-bus.sh?

Yes.  On 2.4.20 the Debian 'hotplug' package (Version: 0.0.20030117-7)
does this automagically.  On 2.4.21 I have to do it explicitly, by hand,
some seconds after the device is connected.  See also the discussion of
IEEE1394 resets below.

> What do you mean by "can't login"?  Do you
> mean it shows a login timeout, or that it doesn't even try?
> What does /proc/bus/ieee1394/devices show?

It doesn't try.  It either can't identify the device properly, or it hangs
completely while doing various ieee1394-related operations.  I've never
seen a login timeout per se, although I have seen bus resets that last
forever (or at least several hours) and login errors (usually because
the drive thinks Linux is already exclusively logged into it).

There are a variety of failure modes which ultimately prevent sbp2 from
being able to connect the IEEE1394 device to the Linux SCSI layer.

2.4.20 just works (so far).

This is 2.4.20 (SMP or single-processor, both work fine):

# modprobe ohci1394

ohci1394: $Rev: 578 $ Ben Collins <bcollins@debian.org>
PCI: Found IRQ 11 for device 02:00.2
PCI: Sharing IRQ 11 with 00:1d.2
PCI: Sharing IRQ 11 with 00:1f.1
PCI: Sharing IRQ 11 with 02:02.0
ieee1394: Device added: Node[00:1023]  GUID[005077350710020e]  [Prolific PL3507 Combo Device]
ieee1394: Host added: Node[01:1023]  GUID[00061b02010011a3]  [Linux OHCI-1394]
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Node[00:1023]: Max speed [S400] - Max payload [2048]
scsi1 : IEEE-1394 SBP-2 protocol driver (host: ohci1394)
$Rev: 584 $ James Goodwin <jamesg@filanet.com>
SBP-2 module load options:
- Max speed supported: S400
- Max sectors per I/O supported: 255
- Max outstanding commands supported: 8
- Max outstanding commands per lun supported: 1
- Serialized I/O (debug): no
- Exclusive login: no

# Note:  neither setting for exclusive logins seems to work better than
# the other...

# Plug device

ieee1394: got invalid ack 11 from node 65473 (tcode 4)
ieee1394: Node 00:1023 changed to 01:1023
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Node[00:1023]: Max speed [S400] - Max payload [2048]
ieee1394: Device added: Node[00:1023]  GUID[005077350710020e]  [Prolific PL3507 Combo Device]

# cat /proc/bus/ieee1394/devices

Node[00:1023]  GUID[005077350710020e]:
  Vendor ID: `Prolific PL3507 Combo Device' [0x005077]
  Capabilities: 0x0083c0
  Bus Options:
    IRMC(0) CMC(0) ISC(0) BMC(0) PMC(0) GEN(0)
    LSPD(0) MAX_REC(64) CYC_CLK_ACC(255)
  Unit Directory 0:
    Vendor/Model ID: Prolific PL3507 Combo Device [005077] / (1394-ATAPI rev1.10) [000001]
    Software Specifier ID: 00609e
    Software Version: 010483
    Driver: SBP2 Driver
    Length (in quads): 8
Node[01:1023]  GUID[00061b02010011a3]:
  Vendor ID: `Linux OHCI-1394' [0x000074]
  Capabilities: 0x0083c0
  Bus Options:
    IRMC(1) CMC(1) ISC(1) BMC(0) PMC(0) GEN(0)
    LSPD(2) MAX_REC(2048) CYC_CLK_ACC(0)
  Host Node Status:
    Host Driver     : ohci1394
    Nodes connected : 2
    Nodes active    : 2
    SelfIDs received: 2
    Irm ID          : [01:1023]
    BusMgr ID       : [01:1023]
    In Bus Reset    : no
    Root            : yes
    Cycle Master    : yes
    IRM             : yes
    Bus Manager     : yes

# Note:  I also get the following sometimes:

Node[00:1023]  GUID[00061b02010011a3]:
  Vendor ID: `Linux OHCI-1394' [0x000074]
  Capabilities: 0x0083c0
  Bus Options:
    IRMC(1) CMC(1) ISC(1) BMC(0) PMC(0) GEN(0)
    LSPD(2) MAX_REC(2048) CYC_CLK_ACC(0)
  Host Node Status:
    Host Driver     : ohci1394
    Nodes connected : 2
    Nodes active    : 2
    SelfIDs received: 2
    Irm ID          : [01:1023]
    BusMgr ID       : [63:1023]
    In Bus Reset    : no
    Root            : no
    Cycle Master    : no
    IRM             : no
    Bus Manager     : no
Node[01:1023]  GUID[005077350710020e]:
  Vendor ID: `Prolific PL3507 Combo Device' [0x005077]
  Capabilities: 0x0083c0
  Bus Options:
    IRMC(0) CMC(0) ISC(0) BMC(0) PMC(0) GEN(0)
    LSPD(0) MAX_REC(64) CYC_CLK_ACC(255)
  Unit Directory 0:
    Vendor/Model ID: Prolific PL3507 Combo Device [005077] / (1394-ATAPI rev1.10) [000001]
    Software Specifier ID: 00609e
    Software Version: 010483
    Driver: SBP2 Driver
    Length (in quads): 8

# echo scsi add-single-device 1 0 0 0 > /proc/scsi/scsi
# Note: the Debian 'hotplug' package typically does this automagically

scsi singledevice 1 0 0 0
  Vendor: Maxtor 6  Model: Y120L0            Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 06
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
 /dev/scsi/host1/bus0/target0/lun0: p1 p2

# fdisk, mount, umount, etc...

# echo scsi remove-single-device 1 0 0 0 > /proc/scsi/scsi

# Unplug device

ieee1394: Node 01:1023 changed to 00:1023
ieee1394: Host removed: Node[00:1023]  GUID[005077350710020e]  [Prolific PL3507 Combo Device]
ieee1394: sbp2: Logged out of SBP-2 device

I can do the above an apparently unlimited number of times.  I can even
repeatably remove and reinsert the various modules.  

Incidentally, while I was collecting all this stuff I noticed that the
ohci1394 driver doesn't work after a warm reboot--it sometimes can't
detect any devices on the ieee1394 bus, or can't detect the ohci1394
device on the PCI bus.  That's not a big deal as I normally don't reboot
unless the machine crashes, and other drivers (RTC and USB) lock up in
warm reboots as well, but only in 2.4.19 and later...but that's a whole
other bug report.

This is 2.4.21 without SMP and with all IEEE1394- and SCSI-related
modules compiled as modules:

# modprobe ohci1394

ohci1394: $Rev: 896 $ Ben Collins <bcollins@debian.org>
PCI: Found IRQ 11 for device 02:00.2
PCI: Sharing IRQ 11 with 00:1d.2
PCI: Sharing IRQ 11 with 00:1f.1
PCI: Sharing IRQ 11 with 02:02.0
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[c0201000-c02017ff]  Max Packet=[2048]
ieee1394: Device added: Node[00:1023]  GUID[005077350710020e]  [Prolific PL3507 Combo Device]
ieee1394: Host added: Node[01:1023]  GUID[00061b02010011a3]  [Linux OHCI-1394]
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc10120 ffc00000 00000000 84510b04
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI emulation for IEEE-1394 SBP-2 Devices
blk: queue c1674818, I/O limit 4095Mb (mask 0xffffffff)
ieee1394: sbp2: Query logins to SBP-2 device successful
ieee1394: sbp2: Maximum concurrent logins supported: 1
ieee1394: sbp2: Number of active logins: 0
ieee1394: sbp2: Logged into SBP-2 device
spurious 8259A interrupt: IRQ7.

# echo scsi add-single-device 0 0 0 0 > /proc/scsi/scsi

scsi singledevice 0 0 0 0
  Vendor: Maxtor 6  Model: Y120L0            Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 06
blk: queue df2d0a18, I/O limit 4095Mb (mask 0xffffffff)

# a few seconds and several 'fdisk -l /dev/sda' attempts later

Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
 /dev/scsi/host0/bus0/target0/lun0:<7>ldm_validate_partition_table(): Found an MS-DOS partition table, not a dynamic disk.
 p1 p2
	
# fdisk, mount, umount, etc...

# echo scsi remove-single-device 1 0 0 0 > /proc/scsi/scsi

# cat /proc/bus/ieee1394/devices

# (hangs)

# ps xar

PID TTY      STAT   TIME COMMAND
   71 ?        D      0:00 /sbin/modprobe -s sbp2
  122 pts/2    R      0:00 ps xar

# Unplug device

# (nothing happens)

The modprobe (and sometimes sbp2) processes in D state can't be killed.
Module loading and unloading is broken at this point.  Nothing on ieee1394
works at this point.  The "cat /proc/bus/ieee1394/devices" command seems
to hang at any time that it is issued with the SBP2 device connected.

This effectively means that the device can be connected once per reboot.

The following is 2.4.21 SMP with IEEE1394 modules as modules, and SCSI
disk support compiled into the kernel:

# modprobe ohci1394

ohci1394: $Rev: 896 $ Ben Collins <bcollins@debian.org>
PCI: Found IRQ 11 for device 02:00.2
PCI: Sharing IRQ 11 with 00:1d.2
PCI: Sharing IRQ 11 with 00:1f.1
PCI: Sharing IRQ 11 with 02:02.0
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[c0201000-c02017ff]  Max Packet=[2048]
ieee1394: Device added: Node[00:1023]  GUID[005077350710020e]  [Prolific PL3507 Combo Device]
ieee1394: Host added: Node[01:1023]  GUID[00061b02010011a3]  [Linux OHCI-1394]
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc10120 ffc00000 00000000 84510aaf
scsi0 : SCSI emulation for IEEE-1394 SBP-2 Devices
blk: queue c166c61c, I/O limit 4095Mb (mask 0xffffffff)
spurious 8259A interrupt: IRQ7.
ieee1394: sbp2: Query logins to SBP-2 device successful
ieee1394: sbp2: Maximum concurrent logins supported: 1
ieee1394: sbp2: Number of active logins: 0
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Node[00:1023]: Max speed [S400] - Max payload [2048]

# Note hotplug doesn't work here, I have to add the device manually:

# echo scsi add-single-device 0 0 0 0 > /proc/scsi/scsi

scsi singledevice 0 0 0 0
  Vendor: Maxtor 6  Model: Y120L0            Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 06
blk: queue c175e21c, I/O limit 4095Mb (mask 0xffffffff)
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
 /dev/scsi/host0/bus0/target0/lun0: p1 p2

# cat /proc/bus/ieee1394/devices

Node[00:1023]  GUID[005077350710020e]:
  Vendor ID: `Prolific PL3507 Combo Device' [0x005077]
  Capabilities: 0x0083c0
  Bus Options:
    IRMC(0) CMC(0) ISC(0) BMC(0) PMC(0) GEN(0)
    LSPD(0) MAX_REC(64) CYC_CLK_ACC(255)
  Unit Directory 0:
    Vendor/Model ID: Prolific PL3507 Combo Device [005077] / (1394-ATAPI rev1.10) [000001]
    Software Specifier ID: 00609e
    Software Version: 010483
    Driver: SBP2 Driver
    Length (in quads): 8
Node[01:1023]  GUID[00061b02010011a3]:
  Vendor ID: `Linux OHCI-1394' [0x000074]
  Capabilities: 0x0083c0
  Bus Options:
    IRMC(1) CMC(1) ISC(1) BMC(0) PMC(0) GEN(0)
    LSPD(2) MAX_REC(2048) CYC_CLK_ACC(0)
  Host Node Status:
    Host Driver     : ohci1394
    Nodes connected : 2
    Nodes active    : 2
    SelfIDs received: 2
    Irm ID          : [01:1023]
    BusMgr ID       : [63:1023]
    In Bus Reset    : no
    Root            : yes
    Cycle Master    : yes
    IRM             : yes
    Bus Manager     : no

# fdisk, mount, etc.

# echo scsi remove-single-device 1 0 0 0 > /proc/scsi/scsi

# Unplug device

ieee1394: Node 01:1023 changed to 00:1023
ieee1394: Host removed: Node[00:1023]  GUID[005077350710020e]  [Prolific PL3507 Combo Device]
ieee1394: sbp2: Logged out of SBP-2 device

# cat /proc/bus/ieee1394/devices

Node[00:1023]  GUID[00061b02010011a3]:
  Vendor ID: `Linux OHCI-1394' [0x000074]
  Capabilities: 0x0083c0
  Bus Options:
    IRMC(1) CMC(1) ISC(1) BMC(0) PMC(0) GEN(0)
    LSPD(2) MAX_REC(2048) CYC_CLK_ACC(0)
  Host Node Status:
    Host Driver     : ohci1394
    Nodes connected : 1
    Nodes active    : 1
    SelfIDs received: 1
    Irm ID          : [00:1023]
    BusMgr ID       : [63:1023]
    In Bus Reset    : no
    Root            : yes
    Cycle Master    : yes
    IRM             : yes
    Bus Manager     : no

# Reconnect device

ieee1394: got invalid ack 11 from node 65473 (tcode 4)
ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
ieee1394: Sending PHY configuration packet (I hope)...
ieee1394: Node 00:1023 changed to 01:1023

# cat /proc/bus/ieee1394/devices

Node[01:1023]  GUID[00061b02010011a3]:
  Vendor ID: `Linux OHCI-1394' [0x000074]
  Capabilities: 0x0083c0
  Bus Options:
    IRMC(1) CMC(1) ISC(1) BMC(0) PMC(0) GEN(0)
    LSPD(2) MAX_REC(2048) CYC_CLK_ACC(0)
  Host Node Status:
    Host Driver     : ohci1394
    Nodes connected : 2
    Nodes active    : 2
    SelfIDs received: 2
    Irm ID          : [01:1023]
    BusMgr ID       : [63:1023]
    In Bus Reset    : no
    Root            : yes
    Cycle Master    : yes
    IRM             : yes
    Bus Manager     : no

# Note:  the device really is physically connected above, it just doesn't
# show up.  The "gscanbus" program (I'm using the Debian package) will
# show a node on the IEEE1394 bus, name and type "Unknown".

# echo scsi add-single-device 0 0 0 0 > /proc/scsi/scsi
# Doesn't work...the sbp2 driver hasn't seen the drive, so obviously
# the SCSI layer can't see it either.

# modprobe raw1394

raw1394: /dev/raw1394 device initialized

# run gscanbus, pick Control > Force Bus Reset from the menu.
# This uses libraw1394 and sends a reset through port 0.

ieee1394: sbp2: Query logins to SBP-2 device successful
ieee1394: sbp2: Maximum concurrent logins supported: 1
ieee1394: sbp2: Number of active logins: 0
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Node[00:1023]: Max speed [S400] - Max payload [2048]
ieee1394: Device added: Node[00:1023]  GUID[005077350710020e]  [Prolific PL3507 Combo Device]
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc10d20 ffc00000 00000000 8451dcf0

# cat /proc/bus/ieee1394/devices again

Node[01:1023]  GUID[00061b02010011a3]:
  Vendor ID: `Linux OHCI-1394' [0x000074]
  Capabilities: 0x0083c0
  Bus Options:
    IRMC(1) CMC(1) ISC(1) BMC(0) PMC(0) GEN(0)
    LSPD(2) MAX_REC(2048) CYC_CLK_ACC(0)
  Host Node Status:
    Host Driver     : ohci1394
    Nodes connected : 2
    Nodes active    : 2
    SelfIDs received: 2
    Irm ID          : [01:1023]
    BusMgr ID       : [63:1023]
    In Bus Reset    : no
    Root            : yes
    Cycle Master    : yes
    IRM             : yes
    Bus Manager     : no
Node[00:1023]  GUID[005077350710020e]:
  Vendor ID: `Prolific PL3507 Combo Device' [0x005077]
  Capabilities: 0x0083c0
  Bus Options:
    IRMC(0) CMC(0) ISC(0) BMC(0) PMC(0) GEN(0)
    LSPD(0) MAX_REC(64) CYC_CLK_ACC(255)
  Unit Directory 0:
    Vendor/Model ID: Prolific PL3507 Combo Device [005077] / (1394-ATAPI rev1.10) [000001]
    Software Specifier ID: 00609e
    Software Version: 010483
    Driver: SBP2 Driver
    Length (in quads): 8

>From this point on the device behaves as above, i.e. an explicit
echo scsi add-single-device command will get the device working as it
did the first time it was connected.  This bus reset is required after
almost all subsequent reconnects until the next reboot.  It has worked
without reset at various times but I'm not sure what the triggers are.
A suspend-resume cycle seems to work.

> Do I understand correctly that this is under cardbus?

No, it's built into the laptop.  It does share a PCI bus with the
cardbus bridge:

00:00.0 Host bridge: Intel Corp. 82830 830 Chipset Host Bridge (rev 02)
00:01.0 PCI bridge: Intel Corp. 82830 830 Chipset AGP Bridge (rev 02)
00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 01)
00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 01)
00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 01)
00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 41)
00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 01)
00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 01)
00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus (rev 01)
00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio (rev 01)
00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem (rev 01)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY
02:00.0 CardBus bridge: Ricoh Co Ltd RL5c478 (rev a0)
02:00.1 CardBus bridge: Ricoh Co Ltd RL5c478 (rev a0)
02:00.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C522 IEEE 1394 Controller
02:02.0 Network controller: Harris Semiconductor Prism 2.5 Wavelan chipset (rev 01)
02:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3) PRO/100 VE (LOM) Ethernet Controller (rev 41)

I do most testing without cardmgr or pcmcia modules running, but most
"production" use with cardmgr and pcmcia modules running.  I generally
don't use PCMCIA cards very often with this laptop (certainly not during
these tests) as most devices I need are built in or on USB.

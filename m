Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262153AbTCRE3C>; Mon, 17 Mar 2003 23:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262158AbTCRE3C>; Mon, 17 Mar 2003 23:29:02 -0500
Received: from [66.186.193.1] ([66.186.193.1]:29198 "HELO
	unix113.hosting-network.com") by vger.kernel.org with SMTP
	id <S262153AbTCRE3A>; Mon, 17 Mar 2003 23:29:00 -0500
X-Comments: BlackMail headers - Mail to abuse@featureprice.com to report spam.
X-Authenticated-Connect: 63.109.146.2
X-Authenticated-Timestamp: 23:50:38(EST) on March 17, 2003
X-HELO-From: rohan.arnor.net
X-Mail-From: <thoffman@arnor.net>
X-Sender-IP-Address: 63.109.146.2
Subject: [2.5.65 BUG ?] Loading SBP2 driver gives no error, but no block
	device either.
From: Torrey Hoffman <thoffman@arnor.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Mar 2003 20:37:51 -0800
Message-Id: <1047962370.1292.6.camel@rohan.arnor.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I've also entered this in bugzilla.kernel.org as bug #466.  This is the
first 2.5.x kernel I've got running, so I don't have any notes on when
this bug appeared.  But 2.4.x doesn't have this problem.)

Distribution: Red Hat 8.0
Hardware Environment: Single Processor Pentium III, details below
Software Environment: 
Problem Description: Loading ieee1394 SBP2 driver doesn't result in a
usable block device appearing.

Steps to reproduce: 
Attach firewire drive. 
Boot 2.5.65, load ieee1394, ohci1394, sbp2 modules.

The firewire to IDE bridge is correctly detected, as is the actual hard
drive attached to the bridge.  Everything seems to be fine, but the
drive does not show up in /proc/partitions, and I can't mount /dev/sda1.

(Under a 2.4.x kernel, /dev/sda and /dev/sda1 would show up at this
point)

Here is more information: ieee1394 and SCSI settings from .config:

CONFIG_SCSI=m
CONFIG_BLK_DEV_SD=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m

CONFIG_IEEE1394=m
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_SBP2=m

dmesg after loading the modules has:

ohci1394_0: Unexpected PCI resource length of 1000!
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[9]  MMIO=[e9000000-e90007ff]  Max
Packet=[2048]
ieee1394: Node added: ID:BUS[00:1023]  GUID[0004830000002cb3]  [Unknown]
(Oxford  )
ieee1394: Host added: ID:BUS[01:1023]  GUID[0030dd8000505e29]  [Unknown]
(Linux
OHCI-1394)

SCSI subsystem initialized
scsi0 : SCSI emulation for for IEEE-1394 Storage Devices
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Node[00:1023]: Max speed [S400] - Max payload [2048]
  Vendor: WDC WD12  Model: 00JB-00CRA1       Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 06

- - -
cat /proc/partitions shows no sd devices, just /dev/hda and it's
partitions.

cat /proc/bus/ieee1394/devices
Node[00:1023]  GUID[0004830000002cb3]:
  Vendor ID   : `Unknown' [0x000483]
  Vendor text : `Oxford  '
  Capabilities: 0x0083c0
  Tlabel stats:
    Free  : 64
    Total : 66
    Mask  : 0000000000000000
  Bus Options :
    IRMC(0) CMC(0) ISC(0) BMC(0) PMC(0) GEN(0)
    LSPD(0) MAX_REC(64) CYC_CLK_ACC(255)
  Unit Directory 0:
    Vendor/Model ID  : Oxford   [000483] / 911D [000001]
    Software Spec ID : 00609e
    Software Version : 010483
    Driver           : SBP2 Driver
    Length (in quads): 8
Node[01:1023]  GUID[0030dd8000505e29]:
  Vendor ID   : `Unknown' [0x000000]
  Vendor text : `Linux OHCI-1394'
  Capabilities: 0x0083c0
  Tlabel stats:
    Free  : 64
    Total : 23
    Mask  : 0000000000000000
  Bus Options :
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

cat scsi/sbp2/0
Host scsi0             : SBP-2 IEEE-1394 (ohci1394)
Driver version         : $Rev: 797 $ James Goodwin <jamesg@filanet.com>

Module options         :
  sbp2_max_speed       : S400
  sbp2_max_sectors     : 255
  sbp2_serialize_io    : no
  sbp2_exclusive_login : yes

Attached devices       :
  [Channel: 00, Id: 00, Lun: 00]  Direct-Access     WDC WD12 00JB-00CRA1

- - - - -
$ cat /proc/scsi/scsi

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: WDC WD12 Model: 00JB-00CRA1      Rev:
  Type:   Direct-Access                    ANSI SCSI revision: 06

- - - - -
$ cat /proc/devices
[cut char devices]
Block devices:
  1 ramdisk
  3 ide0
  7 loop
 22 ide1

Any help would be greatly appreciated.
Torrey Hoffman
thoffman@arnor.net


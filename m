Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269256AbTCBRe0>; Sun, 2 Mar 2003 12:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269257AbTCBRe0>; Sun, 2 Mar 2003 12:34:26 -0500
Received: from mx03.cyberus.ca ([216.191.240.24]:5895 "EHLO mx03.cyberus.ca")
	by vger.kernel.org with ESMTP id <S269256AbTCBReY>;
	Sun, 2 Mar 2003 12:34:24 -0500
Date: Sun, 2 Mar 2003 12:44:06 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@transmeta.com>,
       Jeff Garzik <jgarzik@pobox.com>, "" <kuznet@ms2.inr.ac.ru>,
       "" <david.knierim@tekelec.com>,
       Robert Olsson <Robert.Olsson@data.slu.se>,
       Donald Becker <becker@scyld.com>, "" <linux-kernel@vger.kernel.org>,
       "" <alexander@netintact.se>
Subject: PCI init issues
Message-ID: <20030302121050.F61365@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Seems like Linux 2.4.x has PCI initialization issues when you start
having funky PCI bus setups. Now before you point a finger at
the BIOs please read on...
In other words Linux needs a lot of help from the bios and if it doesnt
get it things get messed up. When the bios initializes _all_ the mp table
or acpi stuff things work great.
For example Linux doesnt seem to be very smart about things like second
level pci bridges...

Example:
------
]0;root@localhost:~[root@localhost root]# lspci -tv
-[00]-+-00.0  Intel Corp. e7500 DRAM Controller
      +-00.1  Intel Corp. e7500 DRAM Controller Error Reporting
      +-02.0-[01-04]--+-1c.0  Intel Corp. 82870P2 P64H2 I/OxAPIC
      |               +-1d.0-[02]--
      |               +-1e.0  Intel Corp. 82870P2 P64H2 I/OxAPIC
      |               \-1f.0-[03-04]----01.0-[04]--+-04.0  Digital
Equipment Corporation DECchip 21142/43
      |                                            +-05.0  Digital
Equipment Corporation DECchip 21142/43
      |                                            +-06.0  Digital
Equipment Corporation DECchip 21142/43
      |                                            \-07.0  Digital
Equipment Corporation DECchip 21142/43
      +-03.0-[05-07]--+-1c.0  Intel Corp. 82870P2 P64H2 I/OxAPIC
      |               +-1d.0-[06]--+-01.0  Intel Corp.: Unknown device
100f
      |               |            +-02.0  Intel Corp.: Unknown device
1010
      |               |            \-02.1  Intel Corp.: Unknown device
1010
      |               +-1e.0  Intel Corp. 82870P2 P64H2 I/OxAPIC
      |               \-1f.0-[07]--
      +-1d.0  Intel Corp. 82801CA/CAM USB (Hub
      +-1d.1  Intel Corp. 82801CA/CAM USB (Hub
      +-1d.2  Intel Corp. 82801CA/CAM USB (Hub
      +-1e.0-[08]--+-01.0  ATI Technologies Inc Rage XL
      |            +-02.0  Intel Corp. 82557/8/9 [Ethernet Pro 100]
      |            \-03.0  Intel Corp. 82557/8/9 [Ethernet Pro 100]
      +-1f.0  Intel Corp. 82801CA ISA Bridge (LPC)
      +-1f.1  Intel Corp. 82801CA IDE U100
      \-1f.3  Intel Corp. 82801CA/CAM SMBus
-------------

See those DECchip 21142/43 devices? They are about 3 layers down
from the root and theyll never work properly unless the BIOS is capable
of initializing everything. The first of the 4 devices will receive
interupts correctly, the rest dont.

-------
]0;root@localhost:~[root@localhost root]# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
  0:     441198     441826     442361     439749    IO-APIC-edge  timer
  1:          1          0          0          1    IO-APIC-edge  keyboard
  2:          0          0          0          0          XT-PIC  cascade
  4:         75         78         82         52    IO-APIC-edge  serial
  8:          1          0          0          0    IO-APIC-edge  rtc
 14:       2000       1787       1960       1535    IO-APIC-edge  ide0
 15:       1860       1750       2021       1603    IO-APIC-edge  ide1
 17:       3396       3440       3400       3415   IO-APIC-level  eth0
 18:          6          2          2          3   IO-APIC-level  eth1
 24:          5          3          5          3   IO-APIC-level  eth5,
eth6, eth7, eth8
 96:        426        424        425        424   IO-APIC-level  eth2
100:        427        424        424        425   IO-APIC-level  eth3
101:        425        424        425        423   IO-APIC-level  eth4
NMI:          0          0          0          0
LOC:    1762876    1762850    1762971    1762970
ERR:          0
MIS:          0
--------------

Interupt routing as can be seen above is really messed for that device.

The workaround is to move the board so the the DECchip 21142/43 devices
are at a depth not to exceed 3.

Seems this has been an ongoing problem on Linux.
http://www.tux.org/hypermail/linux-tulip/2002-Aug/0000.html

The above is the same motherboard as mentioned in the thread above except
the two processors have hyperthreading capability.

Q1: How do we resolve this other than moving around boards?
Q2: Should we really be dependent on bios this bad?
According to that thread things dont work on the BSDs either but work fine
on WinXP (shudder). Does this mean winxp doesnt depend on BIOS?
Should we really be dependent on the BIOS this much?
Shouldnt things like second level pci bridge be part of Linux discovery?

cheers,
jamal

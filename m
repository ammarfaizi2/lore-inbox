Return-Path: <linux-kernel-owner+w=401wt.eu-S1423129AbWLUXcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423129AbWLUXcK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 18:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423130AbWLUXcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 18:32:10 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:58276 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423129AbWLUXcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 18:32:09 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: bcm43xx-dev@lists.berlios.de
Subject: bcm43xx from 2.6.20-rc1-mm1 on HPC nx6325 (x86_64)
Date: Fri, 22 Dec 2006 00:33:37 +0100
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612220033.37927.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to make the bcm43xx driver out of the 2.6.20-rc1-mm1 kernel work on
an HPC nx6325, with no luck, so far, although I'm using a firmware that has
been reported to work with these boxes
(http://gentoo-wiki.com/HARDWARE_Gentoo_on_HP_Compaq_nx6325#Onboard_Wireless_.28802.11.29).

The driver loads and seems to operate the hardware to some extent, but there
seems to be a problem with interrupts.  Namely, the chip doesn't seem to
generate any.

Right after a fresh 'modprobe bcm43xx' I get the following messages in dmesg:

bcm43xx driver
ACPI: PCI Interrupt 0000:30:00.0[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:30:00.0 to 64
bcm43xx: Chip ID 0x4311, rev 0x1
bcm43xx: Number of cores: 4
bcm43xx: Core 0: ID 0x800, rev 0x11, vendor 0x4243
bcm43xx: Core 1: ID 0x812, rev 0xa, vendor 0x4243
bcm43xx: Core 2: ID 0x817, rev 0x3, vendor 0x4243
bcm43xx: Core 3: ID 0x820, rev 0x1, vendor 0x4243
bcm43xx: PHY connected
bcm43xx: Detected PHY: Version: 4, Type 2, Revision 8
bcm43xx: Detected Radio: ID: 2205017f (Manuf: 17f Ver: 2050 Rev: 2)
bcm43xx: Radio turned off
bcm43xx: Radio turned off
PM: Adding info for No Bus:eth1
printk: 3 messages suppressed.
SoftMAC: ASSERTION FAILED (0) at: net/ieee80211/softmac/ieee80211softmac_wx.c:306:ieee80211softmac_wx_get_rate()

but, strangely enough, eth1 does not appear, but eth2 appears instead:

# ifconfig eth1 up
eth1: unknown interface: No such device
# ifconfig eth2 up
#

Now there are lots of

SoftMAC: ASSERTION FAILED (0) at: net/ieee80211/softmac/ieee80211softmac_wx.c:306:ieee80211softmac_wx_get_rate()

messages in dmesg followed by

bcm43xx: PHY connected
PM: Adding info for No Bus:0000:30:00.0
PM: Removing info for No Bus:0000:30:00.0
PM: Adding info for No Bus:0000:30:00.0
PM: Removing info for No Bus:0000:30:00.0
PM: Adding info for No Bus:0000:30:00.0
PM: Removing info for No Bus:0000:30:00.0
PM: Adding info for No Bus:0000:30:00.0
PM: Removing info for No Bus:0000:30:00.0
bcm43xx: Microcode rev 0x122, pl 0x98 (2004-11-16  07:21:20)
bcm43xx: Radio turned on
bcm43xx: Chip initialized
bcm43xx: 32-bit DMA initialized
bcm43xx: Keys cleared
bcm43xx: Selected 802.11 core (phytype 2)
PM: Adding info for No Bus:hw_random
ADDRCONF(NETDEV_UP): eth2: link is not ready

Now, if I run iwconfig on it, I get

eth2      IEEE 802.11b/g  ESSID:off/any  Nickname:"Broadcom 4311"
          Mode:Managed  Frequency=2.437 GHz  Access Point: Invalid
          Bit Rate=1 Mb/s   Tx-Power=18 dBm
          RTS thr:off   Fragment thr:off
          Encryption key:off
          Link Quality=0/100  Signal level=-256 dBm  Noise level=-256 dBm
          Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
          Tx excessive retries:0  Invalid misc:0   Missed beacon:0

and 'iwlist eth2 scan' says 'eth2      No scan results', although a working
access point is standing next to the box and the following line appears in
dmesg:

SoftMAC: Scanning finished: scanned 14 channels starting with channel 1

_But_ if I do 'cat /proc/interrupts' now, I get:

           CPU0       CPU1
  0:    1247596          0    <NULL>-edge      timer
  1:       3939       1170   IO-APIC-edge      i8042
  8:          0          0   IO-APIC-edge      rtc
 12:        150        170   IO-APIC-edge      i8042
 14:      38129       6047   IO-APIC-edge      ide0
 16:      99585      18389   IO-APIC-fasteoi   libata, HDA Intel
 18:          0          0   IO-APIC-fasteoi   bcm43xx
 19:      48003       9582   IO-APIC-fasteoi   ohci_hcd:usb1, ohci_hcd:usb2, ehci_hcd:usb3
 20:          0          3   IO-APIC-fasteoi   yenta, tifm_7xx1, ohci1394, sdhci:slot0
 21:      11522       2467   IO-APIC-fasteoi   acpi
 23:      68971      11663   IO-APIC-fasteoi   eth0
NMI:          0          0
LOC:    1247662    1247039
ERR:         10

so apparently there's something wrong.

Greetings,
Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King

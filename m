Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264635AbUEJP00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264635AbUEJP00 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 11:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264645AbUEJP0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 11:26:25 -0400
Received: from jollyroger.montana.com ([66.109.128.82]:58082 "EHLO
	jollyroger.montana.com") by vger.kernel.org with ESMTP
	id S264635AbUEJP0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 11:26:19 -0400
Subject: Re: ACPI and broken PCI IRQ sharing on Asus M5N laptop
From: Franklin Marmon <marmon@montana.com>
Reply-To: marmon@montana.com
To: Patrick Reynolds <reynolds@cs.duke.edu>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.58.0405100054430.20030@shekel.cs.duke.edu>
References: <A6974D8E5F98D511BB910002A50A6647615FAF0D@hdsmsx403.hd.intel.com>
	 <1084160004.12352.82.camel@dhcppc4>
	 <Pine.GSO.4.58.0405100054430.20030@shekel.cs.duke.edu>
Content-Type: multipart/mixed; boundary="=-l/faqtGVrcX3XmUmzWUL"
Organization: none
Message-Id: <1084202747.5268.2.camel@laptop.hydeco.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 10 May 2004 09:25:47 -0600
X-Milter: Stats for this sender(12.32.45.18) over the last (60) seconds con_count(1) msg_count(3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-l/faqtGVrcX3XmUmzWUL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I'm having a similar problem on a eMachine M6805.  When booting with
pci=noacpi my ethernet and firewire drivers are on different (working)
irq's than they get when booting without it.  I've attached more
detailed info to the message, but was just wondering if there was a
document showing the different acpi_xxx options? Or if you could point
me in the right place to find them?

Thank you,

frm

On Sun, 2004-05-09 at 23:07, Patrick Reynolds wrote:
> On Sun, 9 May 2004, Len Brown wrote:
> 
> > On Sun, 2004-05-09 at 20:44, Patrick Reynolds wrote:
> > > Booting with default parameters puts the i8042 psmouse channel, the
> > > Intel
> > > 8x0 sound card, and the Cardbus controller all on IRQ 12.  The mouse
> > try booting with "acpi_irq_isa=12"
> 
> That worked.  The interrupts got redistributed like so:
>   6:        172          XT-PIC  Intel 82801DB-ICH4, yenta
>   7:       3014          XT-PIC  uhci_hcd, yenta, ndiswrapper
>   8:          4          XT-PIC  rtc
>   9:        188          XT-PIC  acpi
>  12:       1028          XT-PIC  i8042
> 
> > I'd be interested to see your dmesg and /proc/interrupts from 2.6.1
> 
> It piles the sound and cardbus onto IRQ 5, along with a USB that I'm
> actually using.  For some reason it doesn't touch IRQ 6.  Here are dmesg
> and /proc/interrupts from 2.6.1, 2.6.6 w/ acpi_irq_isa=12, and 2.6.6 w/
> your patch:
> 
> http://www.cs.duke.edu/~reynolds/acpi-notes
> 
> On Sun, 9 May 2004, Len Brown wrote:
> 
> > On the assumption that cmdline works, please try this patch
> > (without any cmdline param).
> >
> > It simply tweaks the heuristic and makes IRQ12 less attractive compared
> > to the others.
> 
> That also worked and produced the same IRQ mapping as acpi_irq_isa=12.
> 
> Thanks!  If you want any more logs, etc, let me know.
> 
> --Patrick
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

--=-l/faqtGVrcX3XmUmzWUL
Content-Disposition: attachment; filename=pci_data
Content-Type: text/plain; name=pci_data; charset=
Content-Transfer-Encoding: 7bit

###############################################################################
#
# consistant elements

#
# lspci -v
#

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
        Subsystem: VIA Technologies, Inc. VT6102 [Rhine II] Embeded Ethernet 
                   Controller on VT8235
        Flags: bus master, medium devsel, latency 64, IRQ 9
        I/O ports at 1800 [size=256]
        Memory at d0002c00 (32-bit, non-prefetchable) [size=256]
        Capabilities: <available only to root>


###############################################################################
# 
# normal operation
#   kernel parameters include pci=noacpi
#


#
# /var/log/messages
#
  Apr 27 08:03:16 laptop kernel: PCI: Sharing IRQ 9 with 0000:00:12.0


#
# cat /proc/interupts
#
           CPU0
  0:     102200          XT-PIC  timer
  1:        146          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:       2712          XT-PIC  uhci_hcd, eth0
 10:        178          XT-PIC  acpi, uhci_hcd, VIA8233
 11:          0          XT-PIC  uhci_hcd
 12:        588          XT-PIC  i8042
 14:       8752          XT-PIC  ide0
 15:        964          XT-PIC  ide1
NMI:          0
ERR:          0



###############################################################################
#
# next step, removed pci=noacpi from the kernel parameters
#


#
# errors which occured when bringing up my ethernet interface (shown above)
# when booted without pci=noacpi
#

eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
irq 9: nobody cared!
Call Trace:
 [<c010bb2a>] __report_bad_irq+0x2a/0x90
 [<c010bc1c>] note_interrupt+0x6c/0xb0
 [<c010c1a9>] do_IRQ+0x259/0x340
 [<c010c0de>] do_IRQ+0x18e/0x340
 [<c010a158>] common_interrupt+0x18/0x20
 [<c0210e1a>] acpi_processor_idle+0xd5/0x1c7
 [<c01070bc>] cpu_idle+0x2c/0x40
 [<c03c6701>] start_kernel+0x181/0x1c0
 [<c03c6430>] unknown_bootoption+0x0/0x120
 
handlers:
[<e0aad630>] (usb_hcd_irq+0x0/0x70 [usbcore])
[<e0958780>] (snd_via82xx_interrupt+0x0/0x400 [snd_via82xx])
Disabling IRQ #9

# 
# lspci -v is identical to the one above
#

# 
# cat /proc/interupts
#
           CPU0
  0:     323327          XT-PIC  timer
  1:       1223          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:     100000          XT-PIC  uhci_hcd, VIA8233
 10:       1227          XT-PIC  acpi, uhci_hcd
 11:          0          XT-PIC  uhci_hcd, eth0
 12:      25710          XT-PIC  i8042
 14:       7832          XT-PIC  ide0
 15:       5416          XT-PIC  ide1
NMI:          0
ERR:          0


###############################################################################
# 
# results
#

Notice that when allowing acpi to assign the irq's eth0 is on irq11, when 
turning of acpi for pci devices it is on irq 9.  The other device which is 
'off' is VIA8233 (should be 10, is put on 9 under acpi).  

--=-l/faqtGVrcX3XmUmzWUL--


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262394AbRENUnM>; Mon, 14 May 2001 16:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262484AbRENUnC>; Mon, 14 May 2001 16:43:02 -0400
Received: from inet-mail3.oracle.com ([148.87.2.203]:21414 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S262394AbRENUmw>; Mon, 14 May 2001 16:42:52 -0400
Message-ID: <3B00359F.A3E1C389@oracle.com>
Date: Mon, 14 May 2001 12:44:31 -0700
From: Ted Haining <ted.haining@oracle.com>
Organization: Oracle Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-4.lfs i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PCI scanning error for Intel 450NX PCI bridge in 2.4.x 
Content-Type: multipart/mixed;
 boundary="------------137DEDA4C31215ED0D01EAD5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------137DEDA4C31215ED0D01EAD5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi all,

I've found a bug in the PCI initialization routines for the Intel 450NX
PCI bridge chip used on the HP Netserver L4.

The L4 has the following PCI bus layout:

PCI bus #0 -> Intel 450NX bridge -> PCI bus #1
PCI bus #0 -> DECchip 21152 bridge -> PCI bus #2

Given this layout, pci_do_scan_bus calls pci_scan_slot to scan each
device on the bus.  This mechanism correctly locates all the devices on
bus #0 until it reaches the Intel 450NX bridge.  At this point, the
pci_fixup_device call in pci_scan_slot invokes pci_fixup_i450nx, which
executes the following bit of code:

if (busno)
    pci_scan_bus(busno, pci_root_ops, NULL); /* Bus A */
if (suba < subb)
    pci_scan_bus(suba+1, pci_root_ops, NULL); /* Bus B */

This (eventually) runs pci_do_scan_bus again on PCI bus #1, discovering
_all_ the devices there.

The device information found by pci_scan_bus within pci_fixup_i450nx
turns out to be incorrect for reasons described below.

Once pci_scan_slot is run for all slots on bus #0, pci_do_scan_bus calls

pcibios_fixup_bus and pci_scan_bridge to look behind any bridge chips to

discover devices on PCI bus #1 and PCI bus #2.  This discovers the
devices on PCI bus #1 again, providing a second set of CORRECT device
definitions for bus #1 which do NOT overwrite those discovered during
pci_fixup_i450nx.

These two sets of different sets of device information for cards on PCI
bus #1 produce PCI resource conflicts that eventually prevent these
cards from functioning properly.

An examination of the device information found pci_fixup_i450nx reveals
that kernel attempts to allocate I/O and memory resources on bus #0 for
the cards on bus #1 AFTER these same resources on bus #0 are reserved
for the 450NX bridge between bus #0 and bus #1 (since the bridge was
found first).  This produces resource allocation errors that cause the
I/O and memory resources for devices on bus #1 to be reallocated later
to different locations on bus #0 that do not work.

This also means that the kernel assigns device names for both sets of
found information pertaining to devices on PCI bus #1 (e.g. an Intel
EtherExpress 10/100 card on bus #1 will appear as eth0 and eth1, a
second such card would appear as eth2 and eth3, etc...).  Neither of
these devices actually work (because they both have the same assigned
IRQ?).

I have an annotated copy of a dmesg with kernel debug and some other
messages of my own detailing this behavior if anyone is interested.

My temporary fix for this problem is to comment out the two calls to
pci_scan_bus in pci_fixup_i450nx.  This prevents the first set of
incorrect device information for cards on PCI bus #1 from being created.

This means that the second, correct set are the only ones used for
resource allocation.

Unless I'm wrong, the reason for the calls to pci_scan_bus in
pci_fixup_i450nx
are there to find any bridges and buses behind the 450NX bridge.   Why
is
this scanning for ALL devices?  Should it just be trying to locate other

bridges?

Ted Haining
--
The opinions expressed in this e-mail do not necessarily reflect those
of any person, group, or corporation, except the author himself.

--------------137DEDA4C31215ED0D01EAD5
Content-Type: text/x-vcard; charset=us-ascii;
 name="ted.haining.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Ted Haining
Content-Disposition: attachment;
 filename="ted.haining.vcf"

begin:vcard 
n:Haining;Ted
tel;fax:650-413-0168
tel;work:650-607-5743
x-mozilla-html:FALSE
adr:;;;;;;
version:2.1
email;internet:ted.haining@oracle.com
title:Member of Technical Staff
x-mozilla-cpt:;-15904
fn:Ted Haining
end:vcard

--------------137DEDA4C31215ED0D01EAD5--


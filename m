Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbTJaJmJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 04:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbTJaJmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 04:42:09 -0500
Received: from gort.metaparadigm.com ([203.117.131.12]:64701 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S263130AbTJaJmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 04:42:05 -0500
Message-ID: <3FA22E6F.8000404@metaparadigm.com>
Date: Fri, 31 Oct 2003 17:42:07 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031024 Debian/1.5-2
X-Accept-Language: en
MIME-Version: 1.0
To: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.0-test9 Fix oops in quirk_via_bridge
Content-Type: multipart/mixed;
 boundary="------------050808060008080403090902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050808060008080403090902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I have a VIA cardbus 1394 controller which oops on insertion
after an APM suspend/resume cycle (without card inserted):

bounds: 0000 [#1]
CPU:    0
EIP:    0060:[<c0300060>]    Tainted: PF
EFLAGS: 00010206
EIP is at quirk_via_bridge+0x4/0x1c
eax: 0000ffff   ebx: c02982e0   ecx: d1958000   edx: 000c0010
esi: d1958000   edi: 00000001   ebp: 00000000   esp: da401ee8
ds: 007b   es: 007b   ss: 0068
Process pccardd (pid: 1093, threadinfo=da400000 task=da4c8780)
Stack: c019fb85 d1958000 00000001 d1958000 00000000 c019fbc2 d1958000 00000001
         c02980a0 d1958000 dfdebf14 c019d828 00000001 d1958000 00000000 dec2802c
         dfdebf00 dfdebf14 00000000 e3dfe7c7 dfdebf00 00000000 dec2802c da401f48
Call Trace:
   [<c019fb85>] pci_do_fixups+0x52/0x54
   [<c019fbc2>] pci_fixup_device+0x3b/0x49
   [<c019d828>] pci_scan_slot+0x46/0x8f
   [<e3dfe7c7>] cb_alloc+0x29/0xf7 [pcmcia_core]
   [<e3dfb9aa>] socket_insert+0x90/0x102 [pcmcia_core]
   [<e3dfbc0d>] socket_detect_change+0x54/0x7e [pcmcia_core]
   [<e3dfbdbc>] pccardd+0x185/0x1f9 [pcmcia_core]

quirk_via_bridge (which is marked device PCI_ANY_ID) triggers on
my 1394 controller which vendor=VIA but is not a bridge.

Strangely making the quirk and its data __devinit solves the problem
(as is most of the other stuff in pci/quirks.c). Not sure if it is
the correct fix but it works for me. ie. why did I get the oops
in the first place? as the quirks data was global and not marked
for an __init section.

$ lspci -d 1106:
07:00.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46)

~mc


--------------050808060008080403090902
Content-Type: text/plain;
 name="fix_via_quirk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_via_quirk.patch"

--- linux-2.6.0-test9/drivers/pci/quirks.c	2003-10-31 16:49:25.000000000 +0800
+++ linux-2.6.0-test9-mc/drivers/pci/quirks.c	2003-10-31 16:49:57.000000000 +0800
@@ -644,9 +644,9 @@
  *	VIA northbridges care about PCI_INTERRUPT_LINE
  */
  
-int interrupt_line_quirk;
+__devinitdata int interrupt_line_quirk;
 
-static void __init quirk_via_bridge(struct pci_dev *pdev)
+static void __devinit quirk_via_bridge(struct pci_dev *pdev)
 {
 	if(pdev->devfn == 0)
 		interrupt_line_quirk = 1;


--------------050808060008080403090902--


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbTKGXpm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 18:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTKGWQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:16:44 -0500
Received: from mail.kroah.org ([65.200.24.183]:48808 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264599AbTKGT2m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 14:28:42 -0500
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10682332743672@kroah.com>
Subject: [PATCH] More fixes for 2.6.0-test9
In-Reply-To: <20031107192620.GA4276@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Nov 2003 11:27:54 -0800
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1418, 2003/11/07 10:04:16-08:00, michael@metaparadigm.com

[PATCH] PCI: Fix oops in quirk_via_bridge

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

Making the quirk __devinit solves the problem.


 drivers/pci/quirks.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	Fri Nov  7 11:22:16 2003
+++ b/drivers/pci/quirks.c	Fri Nov  7 11:22:16 2003
@@ -646,7 +646,7 @@
  
 int interrupt_line_quirk;
 
-static void __init quirk_via_bridge(struct pci_dev *pdev)
+static void __devinit quirk_via_bridge(struct pci_dev *pdev)
 {
 	if(pdev->devfn == 0)
 		interrupt_line_quirk = 1;


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317012AbSIANtc>; Sun, 1 Sep 2002 09:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317022AbSIANtc>; Sun, 1 Sep 2002 09:49:32 -0400
Received: from netfinity.realnet.co.sz ([196.28.7.2]:31365 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317012AbSIANtb>; Sun, 1 Sep 2002 09:49:31 -0400
Date: Sun, 1 Sep 2002 16:10:37 +0200 (SAST)
From: Zwane Mwaikambo <zwane@mwaikambo.name>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Greg Kroah-Hartmann <greg@kroah.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5] pci_free_consistent on ohci initialisation failure
Message-ID: <Pine.LNX.4.44.0209011608550.26729-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The trace at the end of the message shows the init failure.

	Zwane

Index: linux-2.5.33/drivers/usb/host/ohci-hcd.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.33/drivers/usb/host/ohci-hcd.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ohci-hcd.c
--- linux-2.5.33/drivers/usb/host/ohci-hcd.c	31 Aug 2002 22:30:41 -0000	1.1.1.1
+++ linux-2.5.33/drivers/usb/host/ohci-hcd.c	1 Sep 2002 12:03:57 -0000
@@ -621,9 +621,12 @@
 		hc_reset (ohci);
 	
 	ohci_mem_cleanup (ohci);
-
-	pci_free_consistent (ohci->hcd.pdev, sizeof *ohci->hcca,
-		ohci->hcca, ohci->hcca_dma);
+	if (ohci->hcca) {
+		pci_free_consistent (ohci->hcd.pdev, sizeof *ohci->hcca,
+					ohci->hcca, ohci->hcca_dma);
+		ohci->hcca = NULL;
+		ohci->hcca_dma = 0;
+	}
 }
 
 /*-------------------------------------------------------------------------*/

ohci-hcd.c: USB HC TakeOver failed!
hcd-pci.c: remove: 00:01.2, state 0
kernel BUG at page_alloc.c:463!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c013fcaf>]    Not tainted
EFLAGS: 00010286
eax: 00000010   ebx: c1265c40   ecx: 00000001   edx: c03dae00
esi: 00000000   edi: ffffffed   ebp: c1763efc   esp: c1763e9c
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 1, threadinfo=c1762000 task=c175c040)
Stack: cf779c00 cf581000 c02df7d2 cf779c00 00000100 cf581000 0f581000 cf60f000
       cf60f4c0 cf779c00 c02dc734 cf60f4c0 c1763ed0 00000000 cf60f4c0 c1763efc
       c02dc6bd cf779c00 cf779f44 c1763efc 00000000 d0019000 00001000 c036ce00
Call Trace: [<c02df7d2>] [<c02dc734>] [<c02dc6bd>] [<c020bc68>] [<c023cb0e>]
   [<c023cd55>] [<c023dc7a>] [<c023cd73>] [<c023cd20>] [<c023e4d5>] [<c020bd66>]

   [<c0105114>] [<c0105090>] [<c0105829>]

Code: 0f 0b cf 01 4c 6c 37 c0 f0 ff 4b 04 0f 94 c0 84 c0 74 0e 89
 <0>Kernel panic: Attempted to kill init!

>>EIP; c013fcaf <__free_pages+5f/90>   <=====
Trace; c02df7d2 <ohci_stop+42/50>
Trace; c02dc734 <usb_hcd_pci_remove+64/150>
Trace; c02dc6bd <usb_hcd_pci_probe+35d/370>
Trace; c020bc68 <pci_device_probe+38/50>
Trace; c023cb0e <found_match+2e/100>
Trace; c023cd55 <do_driver_attach+35/40>
Trace; c023dc7a <bus_for_each_dev+da/1c0>
Trace; c023cd73 <driver_attach+13/20>
Trace; c023cd20 <do_driver_attach+0/40>
Trace; c023e4d5 <driver_register+f5/110>
Trace; c020bd66 <pci_register_driver+36/50>
Trace; c0105114 <init+84/240>
Trace; c0105090 <init+0/240>
Trace; c0105829 <kernel_thread_helper+5/c>
Code;  c013fcaf <__free_pages+5f/90>
00000000 <_EIP>:
Code;  c013fcaf <__free_pages+5f/90>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013fcb1 <__free_pages+61/90>
   2:   cf                        iret
Code;  c013fcb2 <__free_pages+62/90>
   3:   01 4c 6c 37               add    %ecx,0x37(%esp,%ebp,2)
Code;  c013fcb6 <__free_pages+66/90>
   7:   c0                        (bad)
Code;  c013fcb7 <__free_pages+67/90>
   8:   f0 ff 4b 04               lock decl 0x4(%ebx)
Code;  c013fcbb <__free_pages+6b/90>
   c:   0f 94 c0                  sete   %al
Code;  c013fcbe <__free_pages+6e/90>
   f:   84 c0                     test   %al,%al
Code;  c013fcc0 <__free_pages+70/90>
  11:   74 0e                     je     21 <_EIP+0x21> c013fcd0
<__free_pages+80/90>
Code;  c013fcc2 <__free_pages+72/90>
  13:   89 00                     mov    %eax,(%eax)

-- 
function.linuxpower.ca


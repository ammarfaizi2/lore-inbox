Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262961AbTDBVAb>; Wed, 2 Apr 2003 16:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263011AbTDBVAa>; Wed, 2 Apr 2003 16:00:30 -0500
Received: from p50827EC2.dip.t-dialin.net ([80.130.126.194]:10624 "HELO
	p50827EC2.dip.t-dialin.net") by vger.kernel.org with SMTP
	id <S262961AbTDBVA2>; Wed, 2 Apr 2003 16:00:28 -0500
From: Lars Noschinski <lars@usenet.noschinski.de>
To: <linux-kernel@vger.kernel.org>, James Simmons <jsimmons@infradead.org>
Subject: Re: Much better framebuffer fixes.
References: <20030327002012$0b44@gated-at.bofh.it>
Message-Id: <20030402210028Z262961-25575+40862@vger.kernel.org>
Date: Wed, 2 Apr 2003 16:00:28 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons <jsimmons@infradead.org> writes:

> Okay. Here are more framebuffer fixes. Please try these fixes and let me 
> know how they work out for you.

Doesn't work for my Radeon 9100, as I get a kernel panic. As of 2.5.66
the Radeon 9100 is not supported, I run a slightly modified version
(diff to 2.5.66 appended). At least the framebuffer seems to work,
till now I had now time for further tests.

Kernel panic (typos possible):
==============================
EFLAGS   00010282
EIP is at fb_set_var+0x23/0xa0
eax: 6b6b6b6b   ebx: dffe3000   ecx: 0000009f   edx: 00000000
esi: dff8fe71   edi: dffe3001   ebp: dff8f464   esp: dff8fe2c
ds: 007b    es: 007b    ss: 0068
Process swapper (pid: 1, threadinfo=dff8e000 task dff8c000)
Stack: dff8fe64 dff8ff04 dffe30ac dffe3000 co45132e dff8fe64 dffe3000 dffe31dc
       00000100 00000000 dff28000 dffe32fc dffe30bc dffe32fe 00000280 000001e0
       00000280 000001e0 00000000 00000000 00000008 00000000 00000000 00000008
Call Trace
     [<c02adbd8>] radeonfb_pci_register+0x68/0x7e0
     [<c022a591>] pci_device_probe+0x41/0x60
     [<c0271237>] bus_match+0x37/0x70
     [<c0271323>] driver_attach+0x43/0x70
     [<c02715d2>] bus_add_driver+0xa2/0xe0
     [<c02719e1>] driver_register+0x41/0x50
     [<c022a6a2>] pci_register_driver+0x42/0x60
     [<c01051a8>] init+0xc8/0x290
     [<c01050e0>] init+0x0/0x290
     [<c010712d>] kernel_thread_helper+0x5/0x18
Code: 83 78 14 00 75 0f 89 df 8d 75 0c fc b9 28 00 00 00 f3 a5 eb
  <0> Kernel panic: Attempted to kill init!
==============================

Patch:
==============================
--- linux-2.5.66/drivers/video/radeonfb.c	2003-04-02 22:10:08.000000000 +0200
+++ linux-2.5.66-fbdev-ln/drivers/video/radeonfb.c	2003-04-02 22:02:42.000000000 +0200
@@ -121,7 +121,8 @@
 	RADEON_ND,
 	RADEON_NE,
 	RADEON_NF,
-	RADEON_NG
+	RADEON_NG,
+	RADEON_QM	/* LN (my Radeon 9100) */
 };
 
 enum radeon_arch {
@@ -168,7 +169,8 @@
 	{ "9700 ND", RADEON_R300 },
 	{ "9700 NE", RADEON_R300 },
 	{ "9700 NF", RADEON_R300 },
-	{ "9700 NG", RADEON_R300 }
+	{ "9700 NG", RADEON_R300 },
+	{ "9100 QM", RADEON_R200 } /* LN (my Radeon 9100) */
 };
 
 
@@ -213,6 +215,7 @@
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_NE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_NE},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_NF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_NF},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_NG, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_NG},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_QM, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_QM}, /* LN (my Radeon 9100) */
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, radeonfb_pci_table);
@@ -881,6 +884,16 @@
 				rinfo->pll.ref_div = 12;
 				rinfo->pll.ref_clk = 2700;
 				break;
+			case PCI_DEVICE_ID_ATI_RADEON_ND:
+			case PCI_DEVICE_ID_ATI_RADEON_NE:
+			case PCI_DEVICE_ID_ATI_RADEON_NF:
+			case PCI_DEVICE_ID_ATI_RADEON_NG:
+				rinfo->pll.ppll_max = 40000;
+				rinfo->pll.ppll_min = 20000;
+				rinfo->pll.xclk = 27000;
+				rinfo->pll.ref_div = 12;
+				rinfo->pll.ref_clk = 2700;
+				break;
 			case PCI_DEVICE_ID_ATI_RADEON_QD:
 			case PCI_DEVICE_ID_ATI_RADEON_QE:
 			case PCI_DEVICE_ID_ATI_RADEON_QF:
--- linux-2.5.66/include/linux/pci_ids.h	2003-04-02 22:10:00.000000000 +0200
+++ linux-2.5.66-fbdev-ln/include/linux/pci_ids.h	2003-04-02 22:02:32.000000000 +0200
@@ -279,6 +279,7 @@
 #define PCI_DEVICE_ID_ATI_RADEON_QO	0x514f
 #define PCI_DEVICE_ID_ATI_RADEON_Ql	0x516c
 #define PCI_DEVICE_ID_ATI_RADEON_BB	0x4242
+#define PCI_DEVICE_ID_ATI_RADEON_QM	0x514d /* LN (my Radeon 9100) */
 /* Radeon RV200 (7500) */
 #define PCI_DEVICE_ID_ATI_RADEON_QW	0x5157
 #define PCI_DEVICE_ID_ATI_RADEON_QX	0x5158

Lars Noschinski

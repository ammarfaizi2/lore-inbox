Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263692AbTK2Gtm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 01:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263693AbTK2Gtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 01:49:42 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:23680
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263692AbTK2Gtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 01:49:39 -0500
Date: Sat, 29 Nov 2003 01:48:26 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: netdev@oss.sgi.com
Subject: [PATCH][2.6] e100_phy.c uses free'd .text after init
Message-ID: <Pine.LNX.4.58.0311290033120.1674@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was causing an oops when using mii-tool due to the .text being free'd
after initialisation.

Unable to handle kernel paging request at virtual address 0000f6b6
printing eip:
c064e997
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c064e997>]    Not tainted
EFLAGS: 00010296
EIP is at e100_phy_init+0x1/0x80
eax: 00000001   ebx: f7b6b200   ecx: c05ab020   edx: f7b6b200
esi: bffff64d   edi: e4ec5d98   ebp: f7b6b000   esp: e4ec5d68
ds: 007b   es: 007b   ss: 0068
Process ethtool (pid: 846, threadinfo=e4ec4000 task=e97ac6b0)
Stack: c0385415 f7b6b200 c038506b f7b6b200 f7b6b000 00000000 c0387e8b f7b6b200
       bffff620 0000002c f7b6b200 e4ec5d9a 00000002 000002cf 000000cf 00010064
       00010001 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Call Trace:
[<c0385415>] e100_hw_init+0x13/0x11d
[<c038506b>] e100_close+0x66/0x7a
[<c0387e8b>] e100_ethtool_set_settings+0xf1/0x17e
[<c0387603>] e100_do_ethtool_ioctl+0xc9/0x6d7
[<c0127517>] update_wall_time+0xd/0x36
[<c0127908>] do_timer+0xc0/0xc5
[<c010f52c>] timer_interrupt+0x62/0x11b
[<c0137fbd>] find_get_page+0x28/0x3c
[<c0139036>] filemap_nopage+0x23b/0x31a
[<c014593e>] do_no_page+0x1a8/0x36f
[<c03093fb>] vsnprintf+0x21a/0x47e
[<c0145d00>] handle_mm_fault+0xf7/0x162
[<c045ea56>] dev_ethtool+0x2cc/0x2d2
[<c045c2f9>] dev_ioctl+0x16e/0x2cf
[<c049c63c>] inet_ioctl+0xf4/0x104
[<c045354c>] sock_ioctl+0xe5/0x286
[<c01653fe>] sys_ioctl+0x118/0x294
[<c011900e>] do_page_fault+0x0/0x51b
[<c0109115>] sysenter_past_esp+0x52/0x71

Code: 67 20 64 69 73 63 6c 61 69 6d 65 72 20 69 6e 20 74 68 65 0d

Index: linux-2.6.0-test11/drivers/net/e100/e100_phy.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test11/drivers/net/e100/e100_phy.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 e100_phy.c
--- linux-2.6.0-test11/drivers/net/e100/e100_phy.c	28 Nov 2003 18:03:05 -0000	1.1.1.1
+++ linux-2.6.0-test11/drivers/net/e100/e100_phy.c	29 Nov 2003 05:39:53 -0000
@@ -132,7 +132,7 @@ e100_mdi_read(struct e100_private *bdp,
 	}
 }

-static unsigned char __devinit
+static unsigned char
 e100_phy_valid(struct e100_private *bdp, unsigned int phy_address)
 {
 	u16 ctrl_reg, stat_reg;
@@ -150,7 +150,7 @@ e100_phy_valid(struct e100_private *bdp,
 	return true;
 }

-static void __devinit
+static void
 e100_phy_address_detect(struct e100_private *bdp)
 {
 	unsigned int addr;
@@ -180,7 +180,7 @@ e100_phy_address_detect(struct e100_priv
 	}
 }

-static void __devinit
+static void
 e100_phy_id_detect(struct e100_private *bdp)
 {
 	u16 low_id_reg, high_id_reg;
@@ -204,7 +204,7 @@ e100_phy_id_detect(struct e100_private *
 		      ((unsigned int) high_id_reg << 16));
 }

-static void __devinit
+static void
 e100_phy_isolate(struct e100_private *bdp)
 {
 	unsigned int phy_address;
@@ -227,7 +227,7 @@ e100_phy_isolate(struct e100_private *bd
 	}
 }

-static unsigned char __devinit
+static unsigned char
 e100_phy_specific_setup(struct e100_private *bdp)
 {
 	u16 misc_reg;
@@ -380,7 +380,7 @@ e100_phy_fix_squelch(struct e100_private
  * Returns:
  *	NOTHING
  */
-static void __devinit
+static void
 e100_fix_polarity(struct e100_private *bdp)
 {
 	u16 status;
@@ -916,7 +916,7 @@ e100_phy_reset(struct e100_private *bdp)
 	schedule_timeout(HZ / 2);
 }

-unsigned char __devinit
+unsigned char
 e100_phy_init(struct e100_private *bdp)
 {
 	e100_phy_reset(bdp);

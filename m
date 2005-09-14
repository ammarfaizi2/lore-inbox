Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965058AbVINWLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbVINWLW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965061AbVINWLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:11:21 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:63709 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S965058AbVINWLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:11:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chuck Ebbert <76306.1226@compuserve.com>
Subject: 2.6.14-rc1 on ATI hangs when executing _STA and _INI methods
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 15 Sep 2005 00:11:08 +0200
In-Reply-To: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
Message-ID: <m3y85z8flv.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> In other words, a lot of stuff all over the place. Be nice now, and follow 
> the rules: put away the new toys, and instead work on making sure the 
> stuff that got merged is all solid. Ok?

My Compaq Presario R3057EA hangs during ACPI initialization. The last
message is "Executing all Device _STA and _INI methods". git bisect
told me that:

  66759a01adbfe8828dd063e32cf5ed3f46696181 is first bad commit
  diff-tree 66759a01adbfe8828dd063e32cf5ed3f46696181 (from 049cdefe19f95b67b06b70915cd8e4ae7173337a)
  Author: Chuck Ebbert <76306.1226@compuserve.com>
  Date:   Mon Sep 12 18:49:25 2005 +0200

    [PATCH] x86-64: i386/x86-64: Fix time going twice as fast problem on ATI Xpress chipsets

    Original patch from Bertro Simul

    This is probably still not quite correct, but seems to be
    the best solution so far.

    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

Passing enable_timer_pin_1 as a kernel boot parameter doesn't help,
but this patch does:

diff --git a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@@ -2213,8 +2213,6 @@ static inline void check_timer(void)
 				setup_nmi();
 				enable_8259A_irq(0);
 			}
-			if (disable_timer_pin_1 > 0)
-				clear_IO_APIC_pin(0, pin1);
 			return;
 		}
 		clear_IO_APIC_pin(0, pin1);

But doing that is equivalent to reverting the whole patch, so it's
probably not the right solution. My computer has an Intel P4 CPU, ie
it's not x86_64.

lspci output:

00:00.0 Host bridge: ATI Technologies Inc Radeon 9100 IGP Host Bridge (rev 02)
00:01.0 PCI bridge: ATI Technologies Inc Radeon 9100 IGP AGP Bridge
00:13.0 USB Controller: ATI Technologies Inc OHCI USB Controller #1 (rev 01)
00:13.1 USB Controller: ATI Technologies Inc OHCI USB Controller #2 (rev 01)
00:14.0 SMBus: ATI Technologies Inc ATI SMBus (rev 16)
00:14.1 IDE interface: ATI Technologies Inc ATI Dual Channel Bus Master PCI IDE Controller
00:14.3 ISA bridge: ATI Technologies Inc: Unknown device 434c
00:14.4 PCI bridge: ATI Technologies Inc: Unknown device 4342
00:14.5 Multimedia audio controller: ATI Technologies Inc IXP150 AC'97 Audio Controller
00:14.6 Modem: ATI Technologies Inc IXP AC'97 Modem (rev 01)
01:05.0 VGA compatible controller: ATI Technologies Inc M9+ 5C61 [Radeon Mobility 9200 (AGP)] (rev 01)
02:00.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link)
02:02.0 Network controller: Broadcom Corporation BCM4306 802.11b/g Wireless LAN Controller (rev 03)
02:03.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
02:04.0 CardBus bridge: Texas Instruments PCI1620 PC Card Controller (rev 01)
02:04.1 CardBus bridge: Texas Instruments PCI1620 PC Card Controller (rev 01)
02:04.2 System peripheral: Texas Instruments PCI1620 Firmware Loading Function (rev 01)
02:07.0 USB Controller: NEC Corporation USB (rev 43)
02:07.1 USB Controller: NEC Corporation USB (rev 43)
02:07.2 USB Controller: NEC Corporation USB 2.0 (rev 04)

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340

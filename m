Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbUCDRiv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 12:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbUCDRiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 12:38:51 -0500
Received: from pxy5allmi.all.mi.charter.com ([24.247.15.44]:49889 "EHLO
	proxy5-grandhaven.chartermi.net") by vger.kernel.org with ESMTP
	id S262045AbUCDRis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 12:38:48 -0500
Message-ID: <404769B5.7080900@quark.didntduck.org>
Date: Thu, 04 Mar 2004 12:39:01 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Meelis Roos <mroos@linux.ee>, Brian Gerst <bgerst@didntduck.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] PnP BIOS exception fixes
References: <Pine.GSO.4.44.0403041657430.10910-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0403041657430.10910-100000@math.ut.ee>
Content-Type: multipart/mixed;
 boundary="------------080002060606060906060604"
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080002060606060906060604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes two errors in fixup_exception() for PnP BIOS faults:
- Check for the correct segments used for the BIOS
- Fix asm constraints so that EIP and ESP are properly reloaded

--
				Brian Gerst

--------------080002060606060906060604
Content-Type: text/plain;
 name="pnpsegs-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnpsegs-2"

diff -urN linux-bk/arch/i386/mm/extable.c linux/arch/i386/mm/extable.c
--- linux-bk/arch/i386/mm/extable.c	2004-02-15 00:41:41.000000000 -0500
+++ linux/arch/i386/mm/extable.c	2004-03-04 10:45:32.988904488 -0500
@@ -12,7 +12,7 @@
 	const struct exception_table_entry *fixup;
 
 #ifdef CONFIG_PNPBIOS
-	if (unlikely((regs->xcs | 8) == 0x88)) /* 0x80 or 0x88 */
+	if (unlikely((regs->xcs & ~15) == (GDT_ENTRY_PNPBIOS_BASE << 3)))
 	{
 		extern u32 pnp_bios_fault_eip, pnp_bios_fault_esp;
 		extern u32 pnp_bios_is_utter_crap;
@@ -21,7 +21,7 @@
 		__asm__ volatile(
 			"movl %0, %%esp\n\t"
 			"jmp *%1\n\t"
-			: "=a" (pnp_bios_fault_esp), "=b" (pnp_bios_fault_eip));
+			: : "g" (pnp_bios_fault_esp), "g" (pnp_bios_fault_eip));
 		panic("do_trap: can't hit this");
 	}
 #endif

--------------080002060606060906060604--

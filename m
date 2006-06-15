Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbWFODl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWFODl2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 23:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWFODl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 23:41:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:47242 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932424AbWFODl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 23:41:27 -0400
X-IronPort-AV: i="4.06,134,1149490800"; 
   d="scan'208"; a="51058191:sNHT30442622"
Subject: [PATCH] move do_suspend_lowlevel to correct segment
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 15 Jun 2006 11:39:26 +0800
Message-Id: <1150342766.21189.14.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Move do_suspend_lowlevel to correct segment. If it is in the same hugepage
with ro data, mark_rodata_ro will make it unexecutable.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---

 linux-2.6.17-rc5-root/arch/i386/kernel/acpi/wakeup.S |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff -puN arch/i386/kernel/acpi/wakeup.S~wakeup arch/i386/kernel/acpi/wakeup.S
--- linux-2.6.17-rc5/arch/i386/kernel/acpi/wakeup.S~wakeup	2006-06-14 09:21:26.000000000 +0800
+++ linux-2.6.17-rc5-root/arch/i386/kernel/acpi/wakeup.S	2006-06-14 09:21:57.000000000 +0800
@@ -265,11 +265,6 @@ ENTRY(acpi_copy_wakeup_routine)
 	movl	$0x12345678, saved_magic
 	ret
 
-.data
-ALIGN
-ENTRY(saved_magic)	.long	0
-ENTRY(saved_eip)	.long	0
-
 save_registers:
 	leal	4(%esp), %eax
 	movl	%eax, saved_context_esp
@@ -304,7 +299,11 @@ ret_point:
 	call	restore_processor_state
 	ret
 
+.data
 ALIGN
+ENTRY(saved_magic)	.long	0
+ENTRY(saved_eip)	.long	0
+
 # saved registers
 saved_gdt:	.long	0,0
 saved_idt:	.long	0,0
_

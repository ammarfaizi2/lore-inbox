Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbULWLVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbULWLVk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 06:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbULWLVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 06:21:40 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:32172 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261209AbULWLVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 06:21:35 -0500
Subject: [PATCH] Secondary cpus boot-up for non defalut location built
	kernels
From: Vivek Goyal <vgoyal@in.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: fastboot <fastboot@lists.osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       dipankar sarma <dipankar@in.ibm.com>
Content-Type: multipart/mixed; boundary="=-g3ER876ZvIFtdj5+5rrs"
Organization: 
Message-Id: <1103802944.8123.114.camel@2fwv946.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Dec 2004 17:25:44 +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-g3ER876ZvIFtdj5+5rrs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

This patch fixes the problem of secondary cpus boot up. This situation
is faced when kernel is built for non default locations like 16MB and
onwards. In this configuration, only primary cpu (BP) comes and
secondary cpus don't boot.

Problem occurs because in trampoline code, lgdt is not able to load the
GDT as it happens to be situated beyond 16MB. This is due to the fact
that cpu is still in real mode and default operand size is 16bit.

This patch uses lgdtl instead of lgdt to force operand size to 32
instead of 16.

Testing Details:
----------------

I have tested the patch on all combinations of following testing setup.

Kernel:
------
2.6.10-rc3-mm1

Hardware:
---------
1. 8way, PIII, 
2. 4way, Xeon, Hyper Threaded

Boot Loader:
-----------
1. Grub
2. LILO
3. Kexec

Memory Location Kernel built for:
--------------------------------
1MB
32MB

Kernel Image Type:
------------------
bzImage

Thanks
Vivek
-- 
Vivek Goyal
Linux Technology Center
India Software Labs
IBM India, Bangalore

--=-g3ER876ZvIFtdj5+5rrs
Content-Disposition: attachment; filename=boot_ap_for_nondefault_kernel.patch
Content-Type: text/plain; name=boot_ap_for_nondefault_kernel.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


This patch fixes the problem of secondary cpus not coming up over a reboot. 
This problem was seen when a kernel compiled for non default (16MB) location 
is booted.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.10-rc3-mm1-changes-root/arch/i386/kernel/trampoline.S |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletion(-)

diff -puN arch/i386/kernel/trampoline.S~boot_ap_for_nondefault_kernel arch/i386/kernel/trampoline.S
--- linux-2.6.10-rc3-mm1-changes/arch/i386/kernel/trampoline.S~boot_ap_for_nondefault_kernel	2004-12-22 16:36:50.000000000 +0530
+++ linux-2.6.10-rc3-mm1-changes-root/arch/i386/kernel/trampoline.S	2004-12-22 16:47:54.000000000 +0530
@@ -51,8 +51,14 @@ r_base = .
 	movl	$0xA5A5A5A5, trampoline_data - r_base
 				# write marker for master knows we're running
 
+	/* GDT tables in non default location kernel can be beyond 16MB and
+	 * lgdt will not be able to load the address as in real mode default
+	 * operand size is 16bit. Use lgdtl instead to force operand size
+	 * to 32 bit.
+	 */
+
 	lidt	boot_idt - r_base	# load idt with 0, 0
-	lgdt	boot_gdt - r_base	# load gdt with whatever is appropriate
+	lgdtl	boot_gdt - r_base	# load gdt with whatever is appropriate
 
 	xor	%ax, %ax
 	inc	%ax		# protected mode (PE) bit
_

--=-g3ER876ZvIFtdj5+5rrs--


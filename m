Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVDULTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVDULTn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 07:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVDULSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 07:18:04 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19589 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261291AbVDULRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 07:17:22 -0400
Date: Thu, 21 Apr 2005 13:09:36 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Cc: ak@suse.de
Subject: [patch] s-t-RAM: load gdt the right way
Message-ID: <20050421110936.GA18164@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sleep code uses wrong version of lgdt, that does the wrong thing when
gdt is beyond 16MB or so...

Signed-off-by: Pavel Machek <pavel@suse.cz>

--- clean/arch/i386/kernel/acpi/wakeup.S	2005-01-22 21:24:51.000000000 +0100
+++ linux/arch/i386/kernel/acpi/wakeup.S	2005-04-14 22:29:45.000000000 +0200
@@ -74,8 +90,9 @@
 	movw	%ax,%fs
 	movw	$0x0e00 + 'i', %fs:(0x12)
 	
-	# need a gdt
-	lgdt	real_save_gdt - wakeup_code
+	# need a gdt -- use lgdtl to force 32-bit operands, in case
+	# the GDT is located past 16 megabytes
+	lgdtl	real_save_gdt - wakeup_code
 
 	movl	real_save_cr0 - wakeup_code, %eax
 	movl	%eax, %cr0
--- clean/arch/x86_64/kernel/acpi/wakeup.S	2005-01-22 21:24:51.000000000 +0100
+++ linux/arch/x86_64/kernel/acpi/wakeup.S	2005-04-14 22:34:18.000000000 +0200
@@ -67,7 +67,7 @@
 	shll	$4, %eax
 	addl	$(gdta - wakeup_code), %eax
 	movl	%eax, gdt_48a +2 - wakeup_code
-	lgdt	%ds:gdt_48a - wakeup_code		# load gdt with whatever is
+	lgdtl	%ds:gdt_48a - wakeup_code	# load gdt with whatever is
 						# appropriate
 
 	movl	$1, %eax			# protected mode (PE) bit

-- 
Boycott Kodak -- for their patent abuse against Java.

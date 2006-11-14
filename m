Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966143AbWKNQKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966143AbWKNQKg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 11:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966141AbWKNQJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 11:09:22 -0500
Received: from cantor2.suse.de ([195.135.220.15]:28557 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S933454AbWKNQJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 11:09:03 -0500
From: Andi Kleen <ak@suse.de>
References: <20061114508.445749000@suse.de>
In-Reply-To: <20061114508.445749000@suse.de>
To: Steven Rostedt <rostedt@goodmis.org>, patches@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH for 2.6.19] [3/9] x86_64: shorten the x86_64 boot setup GDT to what the comment says
Message-Id: <20061114160853.9F16213C98@wotan.suse.de>
Date: Tue, 14 Nov 2006 17:08:53 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Steven Rostedt <rostedt@goodmis.org>

Stephen Tweedie, Herbert Xu, and myself have been struggling with a very
nasty bug in Xen.  But it also pointed out a small bug in the x86_64
kernel boot setup.

The GDT limit being setup by the initial bzImage code when entering into
protected mode is way too big.  The comment by the code states that the
size of the GDT is 2048, but the actual size being set up is much bigger
(32768). This happens simply because of one extra '0'.

Instead of setting up a 0x800 size, 0x8000 is set up.  On bare metal this
is fine because the CPU wont load any segments unless  they are
explicitly used.  But unfortunately, this breaks Xen on vmx FV, since it
(for now) blindly loads all the segments into the VMCS if they are less
than the gdt limit. Since the real mode segments are around 0x3000, we are
getting junk into the VMCS and that later causes an exception.

Stephen Tweedie has written up a patch to fix the Xen side and will be
submitting that to those folks. But that doesn't excuse the GDT limit
being a magnitude too big.

AK: changed to compute true gdt size in assembler, fixed comment

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/boot/setup.S |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

Index: linux/arch/x86_64/boot/setup.S
===================================================================
--- linux.orig/arch/x86_64/boot/setup.S
+++ linux/arch/x86_64/boot/setup.S
@@ -836,13 +836,12 @@ gdt:
 	.word	0x9200				# data read/write
 	.word	0x00CF				# granularity = 4096, 386
 						#  (+5th nibble of limit)
+gdt_end:
 idt_48:
 	.word	0				# idt limit = 0
 	.word	0, 0				# idt base = 0L
 gdt_48:
-	.word	0x8000				# gdt limit=2048,
-						#  256 GDT entries
-
+	.word	gdt_end-gdt-1			# gdt limit
 	.word	0, 0				# gdt base (filled in later)
 
 # Include video setup & detection code

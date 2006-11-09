Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754472AbWKIDB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754472AbWKIDB5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 22:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754517AbWKIDB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 22:01:57 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:64994 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1754472AbWKIDB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 22:01:56 -0500
Date: Wed, 8 Nov 2006 22:01:22 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: LKML <linux-kernel@vger.kernel.org>
cc: sct@redhat.com, ak@suse.de, herbert@gondor.apana.org.au,
       xen-devel@lists.xensource.com
Subject: [PATCH] shorten the x86_64 boot setup GDT to what the comment says
Message-ID: <Pine.LNX.4.58.0611082144410.17812@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi,

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

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.19-rc2/arch/x86_64/boot/setup.S
===================================================================
--- linux-2.6.19-rc2.orig/arch/x86_64/boot/setup.S	2006-11-08 21:37:58.000000000 -0500
+++ linux-2.6.19-rc2/arch/x86_64/boot/setup.S	2006-11-08 21:38:16.000000000 -0500
@@ -840,7 +840,7 @@ idt_48:
 	.word	0				# idt limit = 0
 	.word	0, 0				# idt base = 0L
 gdt_48:
-	.word	0x8000				# gdt limit=2048,
+	.word	0x800				# gdt limit=2048,
 						#  256 GDT entries

 	.word	0, 0				# gdt base (filled in later)

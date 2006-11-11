Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947096AbWKKFSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947096AbWKKFSL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 00:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947100AbWKKFSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 00:18:11 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:43661 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1947096AbWKKFSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 00:18:09 -0500
Date: Sat, 11 Nov 2006 00:17:25 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Andi Kleen <ak@suse.de>
cc: Alexander van Heukelum <heukelum@mailshack.com>,
       LKML <linux-kernel@vger.kernel.org>, sct@redhat.com,
       herbert@gondor.apana.org.au, xen-devel@lists.xensource.com
Subject: [PATCH] make x86_64 boot gdt size exact (like x86).
In-Reply-To: <200611101501.40007.ak@suse.de>
Message-ID: <Pine.LNX.4.58.0611110010330.5626@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0611082144410.17812@gandalf.stny.rr.com>
 <200611091433.09232.ak@suse.de> <20061109183111.GA32438@mailshack.com>
 <200611101501.40007.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi,

Here's another patch that is basically a copy from x86's boot/setup.S.
It makes the GDT limit the exact size that is needed.  I tested this with
the same Xen test that broke the original 0x8000 size, and it booted just
fine.

Note, If you already pushed my previous patch. This patch should easily be
applied by manually removing the extra zero.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.18-hack/arch/x86_64/boot/setup.S
===================================================================
--- linux-2.6.18-hack.orig/arch/x86_64/boot/setup.S
+++ linux-2.6.18-hack/arch/x86_64/boot/setup.S
@@ -836,13 +836,15 @@ gdt:
 	.word	0x9200				# data read/write
 	.word	0x00CF				# granularity = 4096, 386
 						#  (+5th nibble of limit)
+gdt_end:
+	.align	4
+
+	.word	0				# alignment byte
 idt_48:
 	.word	0				# idt limit = 0
 	.word	0, 0				# idt base = 0L
 gdt_48:
-	.word	0x8000				# gdt limit=2048,
-						#  256 GDT entries
-
+	.word	gdt_end - gdt - 1		# gdt limit
 	.word	0, 0				# gdt base (filled in later)

 # Include video setup & detection code

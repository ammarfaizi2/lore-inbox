Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbTEFGSg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 02:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbTEFGSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 02:18:36 -0400
Received: from zero.aec.at ([193.170.194.10]:64776 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262374AbTEFGSf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 02:18:35 -0400
Date: Tue, 6 May 2003 08:30:55 +0200
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix .altinstructions linking failures
Message-ID: <20030506063055.GA15424@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some configs didn't link anymore because they got references from
.altinstructions to __exit functions. Fixing it at the linker level
is not easily possible. This patch just discards .text.exit at runtime
instead of link time to avoid this.

Idea from Andrew Morton.

It will also fix a related problem with .eh_frame in modern gcc (so far 
only observed on x86-64, but could happen on i386 too) 

Index: linux/arch/i386/vmlinux.lds.S
===================================================================
RCS file: /home/cvs/linux-2.5/arch/i386/vmlinux.lds.S,v
retrieving revision 1.18
diff -u -u -r1.18 vmlinux.lds.S
--- linux/arch/i386/vmlinux.lds.S	30 Apr 2003 14:32:05 -0000	1.18
+++ linux/arch/i386/vmlinux.lds.S	6 May 2003 05:28:28 -0000
@@ -85,7 +85,10 @@
   __alt_instructions = .;
   .altinstructions : { *(.altinstructions) } 
   __alt_instructions_end = .; 
- .altinstr_replacement : { *(.altinstr_replacement) }
+ .altinstr_replacement : { *(.altinstr_replacement) } 
+  /* .exit.text is discard at runtime, not link time, to deal with references
+     from .altinstructions and .eh_frame */
+  .exit.text : { *(.exit.text) }
   . = ALIGN(4096);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
@@ -106,7 +109,6 @@
 
   /* Sections to be discarded */
   /DISCARD/ : {
-	*(.exit.text)
 	*(.exit.data)
 	*(.exitcall.exit)
 	}


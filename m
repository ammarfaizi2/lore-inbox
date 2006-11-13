Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755193AbWKMQxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755193AbWKMQxm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755206AbWKMQxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:53:42 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:28329 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1755193AbWKMQxl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:53:41 -0500
Date: Mon, 13 Nov 2006 11:35:42 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com
Subject: [RFC] [PATCH 7/16] x86_64: cleanup segments
Message-ID: <20061113163542.GH17429@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061113162135.GA17429@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061113162135.GA17429@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Move __KERNEL32_CS up into the unused gdt entry.  __KERNEL32_CS is
used when entering the kernel so putting it first is useful when
trying to keep boot gdt sizes to a minimum.

Set the accessed bit on all gdt entries.  We don't care
so there is no need for the cpu to burn the extra cycles,
and it potentially allows the pages to be immutable.  Plus
it is confusing when debugging and your gdt entries mysteriously
change.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/x86_64/kernel/head.S    |   12 ++++++------
 include/asm-x86_64/segment.h |    2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff -puN arch/x86_64/kernel/head.S~x86_64-cleanup-segments arch/x86_64/kernel/head.S
--- linux-2.6.19-rc5-reloc/arch/x86_64/kernel/head.S~x86_64-cleanup-segments	2006-11-09 22:58:28.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/arch/x86_64/kernel/head.S	2006-11-09 22:58:28.000000000 -0500
@@ -354,13 +354,13 @@ gdt:
 	
 ENTRY(cpu_gdt_table)
 	.quad	0x0000000000000000	/* NULL descriptor */
+	.quad	0x00cf9b000000ffff	/* __KERNEL32_CS */
+	.quad	0x00af9b000000ffff	/* __KERNEL_CS */
+	.quad	0x00cf93000000ffff	/* __KERNEL_DS */
+	.quad	0x00cffb000000ffff	/* __USER32_CS */
+	.quad	0x00cff3000000ffff	/* __USER_DS, __USER32_DS  */
+	.quad	0x00affb000000ffff	/* __USER_CS */
 	.quad	0x0			/* unused */
-	.quad	0x00af9a000000ffff	/* __KERNEL_CS */
-	.quad	0x00cf92000000ffff	/* __KERNEL_DS */
-	.quad	0x00cffa000000ffff	/* __USER32_CS */
-	.quad	0x00cff2000000ffff	/* __USER_DS, __USER32_DS  */		
-	.quad	0x00affa000000ffff	/* __USER_CS */
-	.quad	0x00cf9a000000ffff	/* __KERNEL32_CS */
 	.quad	0,0			/* TSS */
 	.quad	0,0			/* LDT */
 	.quad   0,0,0			/* three TLS descriptors */ 
diff -puN include/asm-x86_64/segment.h~x86_64-cleanup-segments include/asm-x86_64/segment.h
--- linux-2.6.19-rc5-reloc/include/asm-x86_64/segment.h~x86_64-cleanup-segments	2006-11-09 22:58:28.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/include/asm-x86_64/segment.h	2006-11-09 22:58:28.000000000 -0500
@@ -6,7 +6,7 @@
 #define __KERNEL_CS	0x10
 #define __KERNEL_DS	0x18
 
-#define __KERNEL32_CS   0x38
+#define __KERNEL32_CS   0x08
 
 /* 
  * we cannot use the same code segment descriptor for user and kernel
_

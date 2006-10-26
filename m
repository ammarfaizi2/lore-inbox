Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751738AbWJZHGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbWJZHGn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 03:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbWJZHGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 03:06:43 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:21950
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751738AbWJZHGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 03:06:42 -0400
Message-Id: <45407B05.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Thu, 26 Oct 2006 08:08:21 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: <vgoyal@in.ibm.com>,
       "linux kernel mailing list" <linux-kernel@vger.kernel.org>
Cc: "Andi Kleen" <ak@muc.de>, "Ian Campbell" <Ian.Campbell@xensource.com>
Subject: Re: [PATCH] x86_64: Some vmlinux.lds.S cleanups
References: <20061024210140.GB14225@in.ibm.com>
In-Reply-To: <20061024210140.GB14225@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was about to ack it when I saw that you left .bss in init - that doesn't seem
too good an idea... Jan

>>> Vivek Goyal <vgoyal@in.ibm.com> 24.10.06 23:01 >>>


o Some cleanups based on Jan Beulich's suggestions. It boots on my box. Hope
  does not break anything else.

o Renamed program header name data.init to init. "init" is now supposed
  to contain init text/data.

o Moved sections ".data.init_task" and ".data.page_aligned" into program
  header "data" as they don't fit logically into "init".

o Got rid of "R" permission for "note" phdr as only boot loaer is supposed
  to look at note phdr.

o Got rid of "E" permission for "data" phdr.  

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/x86_64/kernel/vmlinux.lds.S |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff -puN arch/x86_64/kernel/vmlinux.lds.S~x86_64-vmlinux-lds-S-cleanup arch/x86_64/kernel/vmlinux.lds.S
--- linux-2.6.19-rc3/arch/x86_64/kernel/vmlinux.lds.S~x86_64-vmlinux-lds-S-cleanup	2006-10-24 15:58:23.000000000
-0400
+++ linux-2.6.19-rc3-root/arch/x86_64/kernel/vmlinux.lds.S	2006-10-24 16:35:56.000000000 -0400
@@ -15,10 +15,10 @@ ENTRY(phys_startup_64)
 jiffies_64 = jiffies;
 PHDRS {
 	text PT_LOAD FLAGS(5);	/* R_E */
-	data PT_LOAD FLAGS(7);	/* RWE */
+	data PT_LOAD FLAGS(6);	/* RW_ */
 	user PT_LOAD FLAGS(7);	/* RWE */
-	data.init PT_LOAD FLAGS(7);	/* RWE */
-	note PT_NOTE FLAGS(4);	/* R__ */
+	init PT_LOAD FLAGS(7);	/* RWE */
+	note PT_NOTE FLAGS(0);	/* None */
 }
 SECTIONS
 {
@@ -78,9 +78,19 @@ SECTIONS
   	*(.data.read_mostly)
   }
 
+  . = ALIGN(8192);		/* init_task */
+  .data.init_task : AT(ADDR(.data.init_task) - LOAD_OFFSET) {
+	*(.data.init_task)
+  }
+
+  . = ALIGN(4096);
+  .data.page_aligned : AT(ADDR(.data.page_aligned) - LOAD_OFFSET) {
+	*(.data.page_aligned)
+  }
+
 #define VSYSCALL_ADDR (-10*1024*1024)
-#define VSYSCALL_PHYS_ADDR ((LOADADDR(.data.read_mostly) + SIZEOF(.data.read_mostly) + 4095) & ~(4095))
-#define VSYSCALL_VIRT_ADDR ((ADDR(.data.read_mostly) + SIZEOF(.data.read_mostly) + 4095) & ~(4095))
+#define VSYSCALL_PHYS_ADDR ((LOADADDR(.data.page_aligned) + SIZEOF(.data.page_aligned) + 4095) & ~(4095))
+#define VSYSCALL_VIRT_ADDR ((ADDR(.data.page_aligned) + SIZEOF(.data.page_aligned) + 4095) & ~(4095))
 
 #define VLOAD_OFFSET (VSYSCALL_ADDR - VSYSCALL_PHYS_ADDR)
 #define VLOAD(x) (ADDR(x) - VLOAD_OFFSET)
@@ -129,23 +139,13 @@ SECTIONS
 #undef VVIRT_OFFSET
 #undef VVIRT
 
-  . = ALIGN(8192);		/* init_task */
-  .data.init_task : AT(ADDR(.data.init_task) - LOAD_OFFSET) {
-	*(.data.init_task)
-  }:data.init
-
-  . = ALIGN(4096);
-  .data.page_aligned : AT(ADDR(.data.page_aligned) - LOAD_OFFSET) {
-	*(.data.page_aligned)
-  }
-
   /* might get freed after init */
   . = ALIGN(4096);
   __smp_alt_begin = .;
   __smp_alt_instructions = .;
   .smp_altinstructions : AT(ADDR(.smp_altinstructions) - LOAD_OFFSET) {
 	*(.smp_altinstructions)
-  }
+  }:init
   __smp_alt_instructions_end = .;
   . = ALIGN(8);
   __smp_locks = .;
_

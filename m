Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030354AbWJCRcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbWJCRcs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 13:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbWJCRcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 13:32:47 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:56044 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030366AbWJCRcU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 13:32:20 -0400
Date: Tue, 3 Oct 2006 13:09:08 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, horms@verge.net.au, lace@jankratochvil.net,
       hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, maneesh@in.ibm.com
Subject: [PATCH 3/12] i386: Force section size to be non-zero to prevent a symbol becoming absolute
Message-ID: <20061003170908.GC3164@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061003170032.GA30036@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003170032.GA30036@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Relocation patches for i386, moved the symbols in vmlinux.lds.S inside
  sections so that these symbols become section relative and are no more
  absolute. If these symbols become absolute, its bad as they are not
  relocated if kernel is not loaded at the address it has been compiled
  for.

o Ironically, just moving the symbols inside the section does not 
  gurantee that symbols inside will not become absolute. Recent 
  versions of linkers, do some optimization, and if section size is
  zero, it gets rid of the section and makes any defined symbol as absolute.

o This leads to a failure while second kernel is booting.
  arch/i386/alternative.c frees any pages present between __smp_alt_begin
  and __smp_alt_end. In my case size of section .smp_altinstructions is 
  zero and symbol __smpt_alt_begin becomes absolute and is not relocated
  and system crashes while it is trying to free the memory starting
  from __smp_alt_begin.

o This issue is being fixed by the linker guys and they are making sure
  that linker does not get rid of an empty section if there is any
  section relative symbol defined in it. But we need to fix it at
  kernel level too so that people using the linker version without fix,
  are not affected.

o One of the possible solutions is that force the section size to be
  non zero to make sure these symbols don't become absolute. This 
  patch implements that.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/i386/kernel/vmlinux.lds.S |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff -puN arch/i386/kernel/vmlinux.lds.S~i386-reloc-non-zero-size-section arch/i386/kernel/vmlinux.lds.S
--- linux-2.6.18-git17/arch/i386/kernel/vmlinux.lds.S~i386-reloc-non-zero-size-section	2006-10-02 13:17:58.000000000 -0400
+++ linux-2.6.18-git17-root/arch/i386/kernel/vmlinux.lds.S	2006-10-02 14:36:32.000000000 -0400
@@ -40,6 +40,7 @@ SECTIONS
   	__start___ex_table = .;
 	 *(__ex_table)
   	__stop___ex_table = .;
+	LONG(0)
   }
 
   RODATA
@@ -49,6 +50,7 @@ SECTIONS
   	__tracedata_start = .;
 	*(.tracedata)
   	__tracedata_end = .;
+	LONG(0)
   }
 
   /* writeable */
@@ -64,6 +66,7 @@ SECTIONS
 	*(.data.nosave)
   	. = ALIGN(4096);
   	__nosave_end = .;
+	LONG(0)
   }
 
   . = ALIGN(4096);
@@ -81,6 +84,7 @@ SECTIONS
   .data.read_mostly : AT(ADDR(.data.read_mostly) - LOAD_OFFSET) {
 	*(.data.read_mostly)
 	_edata = .;		/* End of data section */
+	LONG(0)
   }
 
 #ifdef CONFIG_STACK_UNWIND
@@ -89,6 +93,7 @@ SECTIONS
 	__start_unwind = .;
   	*(.eh_frame)
 	__end_unwind = .;
+	LONG(0)
   }
 #endif
 
@@ -104,17 +109,20 @@ SECTIONS
 	__smp_alt_instructions = .;
 	*(.smp_altinstructions)
 	__smp_alt_instructions_end = .;
+	LONG(0)
   }
   . = ALIGN(4);
   .smp_locks : AT(ADDR(.smp_locks) - LOAD_OFFSET) {
 	__smp_locks = .;
 	*(.smp_locks)
 	__smp_locks_end = .;
+	LONG(0)
   }
   .smp_altinstr_replacement : AT(ADDR(.smp_altinstr_replacement) - LOAD_OFFSET) {
 	*(.smp_altinstr_replacement)
 	. = ALIGN(4096);
 	__smp_alt_end = .;
+	LONG(0)
   }
 
   /* will be freed after init */
@@ -124,6 +132,7 @@ SECTIONS
 	_sinittext = .;
 	*(.init.text)
 	_einittext = .;
+	LONG(0)
   }
   .init.data : AT(ADDR(.init.data) - LOAD_OFFSET) { *(.init.data) }
   . = ALIGN(16);
@@ -131,6 +140,7 @@ SECTIONS
 	__setup_start = .;
 	*(.init.setup)
 	__setup_end = .;
+	LONG(0)
   }
   .initcall.init : AT(ADDR(.initcall.init) - LOAD_OFFSET) {
 	__initcall_start = .;
@@ -142,11 +152,13 @@ SECTIONS
 	*(.initcall6.init) 
 	*(.initcall7.init)
 	__initcall_end = .;
+	LONG(0)
   }
   .con_initcall.init : AT(ADDR(.con_initcall.init) - LOAD_OFFSET) {
 	__con_initcall_start = .;
 	*(.con_initcall.init)
 	__con_initcall_end = .;
+	LONG(0)
   }
   SECURITY_INIT
   . = ALIGN(4);
@@ -154,6 +166,7 @@ SECTIONS
 	__alt_instructions = .;
 	*(.altinstructions)
 	__alt_instructions_end = .;
+	LONG(0)
   }
   .altinstr_replacement : AT(ADDR(.altinstr_replacement) - LOAD_OFFSET) {
 	*(.altinstr_replacement)
@@ -167,12 +180,14 @@ SECTIONS
 	__initramfs_start = .;
 	*(.init.ramfs)
 	__initramfs_end = .;
+	LONG(0)
   }
   . = ALIGN(L1_CACHE_BYTES);
   .data.percpu  : AT(ADDR(.data.percpu) - LOAD_OFFSET) {
 	__per_cpu_start = .;
 	*(.data.percpu)
 	__per_cpu_end = .;
+	LONG(0)
   }
   . = ALIGN(4096);
   /* freed after init ends here */
_

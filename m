Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbWHVO0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWHVO0S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 10:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWHVO0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 10:26:17 -0400
Received: from 207.47.60.150.static.nextweb.net ([207.47.60.150]:24990 "EHLO
	webmail.xensource.com") by vger.kernel.org with ESMTP
	id S1751395AbWHVO0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 10:26:16 -0400
Subject: [PATCH 1 of 1] x86_64: Put .note.* sections into a PT_NOTE segment
	in vmlinux
From: Ian Campbell <Ian.Campbell@XenSource.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@XenSource.com>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Ian Pratt <ian.pratt@XenSource.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Virtualization <virtualization@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Christoph Lameter <clameter@sgi.com>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 15:26:17 +0100
Message-Id: <1156256777.5091.93.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Aug 2006 14:28:03.0023 (UTC) FILETIME=[2D0F9DF0:01C6C5F7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates x86_64 linker script to pack any .note.* sections
into a PT_NOTE segment in the output file.

To do this, we tell ld that we need a PT_NOTE segment.  This requires
us to start explicitly mapping sections to segments, so we also need
to explicitly create PT_LOAD segments for text and data, and map the
sections to them appropriately.  Fortunately, each section will
default to its previous section's segment, so it doesn't take many
changes to vmlinux.lds.S.

The corresponding change is already made for i386 in -mm and I'd like
this patch to join it. The section to segment mappings do change as do
the segment flags so some time in -mm would be good for that reason as
well, just in case.

In particular .data and .bss move from the text segment to the data
segment and .data.cacheline_aligned .data.read_mostly are put in the
data segment instead of a separate one.

I think that it would be possible to exactly match the existing section
to segment mapping and flags but it would be a more intrusive change and
I'm not sure there is a reason for the existing layout other than it is
what you get by default if you don't explicitly specify something else.
If there is a reason for the existing layout then I will of course make
the more intrusive change. If there is no reason we could probably drop
the executable or writable flags from some segments but I don't know how
much attention is paid to them anyway so it might not be worth the
effort.

The vsyscall related sections need to go in a different segment to the
normal data segment and so I invented a "user" segment to contain them.
I believe this should appear to be another data segment as far as the
kernel is concerned so the flags are setup accordingly.

The notes will be used in the Xen paravirt_ops backend to provide
additional information to the domain builder. I am in the process of
converting the xen-unstable kernels and tools over to this scheme at the
moment to support this in the future.

It has been suggested to me that the notes segment should have flags 0
(i.e. not readable) since it is only used by the loader and is not used
at runtime. For now I went with a readable segment since that is what
the i386 patch uses.

Signed-off-by: Ian Campbell <ian.campbell@xensource.com>

diff --git a/arch/x86_64/kernel/vmlinux.lds.S b/arch/x86_64/kernel/vmlinux.lds.S
index 7c4de31..ef418b3 100644
--- a/arch/x86_64/kernel/vmlinux.lds.S
+++ b/arch/x86_64/kernel/vmlinux.lds.S
@@ -13,6 +13,12 @@ OUTPUT_FORMAT("elf64-x86-64", "elf64-x86
 OUTPUT_ARCH(i386:x86-64)
 ENTRY(phys_startup_64)
 jiffies_64 = jiffies;
+PHDRS {
+	text PT_LOAD FLAGS(5);	/* R_E */
+	data PT_LOAD FLAGS(7);	/* RWE */
+	user PT_LOAD FLAGS(7);	/* RWE */
+	note PT_NOTE FLAGS(4);	/* R__ */
+}
 SECTIONS
 {
   . = __START_KERNEL;
@@ -31,7 +37,7 @@ SECTIONS
 	KPROBES_TEXT
 	*(.fixup)
 	*(.gnu.warning)
-	} = 0x9090
+	} :text = 0x9090
   				/* out-of-line lock text */
   .text.lock : AT(ADDR(.text.lock) - LOAD_OFFSET) { *(.text.lock) }
 
@@ -57,7 +63,7 @@ #endif
   .data : AT(ADDR(.data) - LOAD_OFFSET) {
 	*(.data)
 	CONSTRUCTORS
-	}
+	} :data
 
   _edata = .;			/* End of data section */
 
@@ -89,7 +95,7 @@ #define VVIRT_OFFSET (VSYSCALL_ADDR - VS
 #define VVIRT(x) (ADDR(x) - VVIRT_OFFSET)
 
   . = VSYSCALL_ADDR;
-  .vsyscall_0 :	 AT(VSYSCALL_PHYS_ADDR) { *(.vsyscall_0) }
+  .vsyscall_0 :	 AT(VSYSCALL_PHYS_ADDR) { *(.vsyscall_0) } :user
   __vsyscall_0 = VSYSCALL_VIRT_ADDR;
 
   . = ALIGN(CONFIG_X86_L1_CACHE_BYTES);
@@ -132,7 +138,7 @@ #undef VVIRT
   . = ALIGN(8192);		/* init_task */
   .data.init_task : AT(ADDR(.data.init_task) - LOAD_OFFSET) {
 	*(.data.init_task)
-  }
+  } :data
 
   . = ALIGN(4096);
   .data.page_aligned : AT(ADDR(.data.page_aligned) - LOAD_OFFSET) {
@@ -235,4 +241,6 @@ #endif
   STABS_DEBUG
 
   DWARF_DEBUG
+
+  NOTES
 }



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWHVLOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWHVLOS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 07:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWHVLOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 07:14:18 -0400
Received: from 207.47.60.150.static.nextweb.net ([207.47.60.150]:29824 "EHLO
	webmail.xensource.com") by vger.kernel.org with ESMTP
	id S1751076AbWHVLOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 07:14:17 -0400
Subject: [PATCH 1 of 1] x86_43: Put .note.* sections into a PT_NOTE segment
	in vmlinux
From: Ian Campbell <Ian.Campbell@XenSource.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeremy Fitzhardinge <jeremy@XenSource.com>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Ian Pratt <ian.pratt@XenSource.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Virtualization <virtualization@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Christoph Lameter <clameter@sgi.com>, Andi Kleen <ak@suse.de>
In-Reply-To: <2bf2abf6e97048bbef24.1154462451@ezr>
References: <2bf2abf6e97048bbef24.1154462451@ezr>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 12:14:18 +0100
Message-Id: <1156245258.5091.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Aug 2006 11:16:03.0451 (UTC) FILETIME=[5ADC6CB0:01C6C5DC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-01 at 13:00 -0700, Jeremy Fitzhardinge wrote:
> This patch will pack any .note.* section into a PT_NOTE segment in the
> output file.
[...]
> This only changes i386 for now, but I presume the corresponding
> changes for other architectures will be as simple.

Here is the patch for x86_64.

Signed-off-by: Ian Campbell <ian.campbell@xensource.com>

diff -urN ref-linux-2.6.16.13/arch/x86_64/kernel/vmlinux.lds.S x86-64_elfnotes/arch/x86_64/kernel/vmlinux.lds.S
--- ref-linux-2.6.16.13/arch/x86_64/kernel/vmlinux.lds.S	2006-05-02 22:38:44.000000000 +0100
+++ x86-64_elfnotes/arch/x86_64/kernel/vmlinux.lds.S	2006-08-22 11:39:14.000000000 +0100
@@ -14,6 +14,11 @@
 OUTPUT_ARCH(i386:x86-64)
 ENTRY(phys_startup_64)
 jiffies_64 = jiffies;
+PHDRS {
+	text PT_LOAD FLAGS(5);	/* R_E */
+	data PT_LOAD FLAGS(7);	/* RWE */
+	note PT_NOTE FLAGS(4);	/* R__ */
+}
 SECTIONS
 {
   . = __START_KERNEL;
@@ -26,7 +31,7 @@
 	KPROBES_TEXT
 	*(.fixup)
 	*(.gnu.warning)
-	} = 0x9090
+	} :text = 0x9090
   				/* out-of-line lock text */
   .text.lock : AT(ADDR(.text.lock) - LOAD_OFFSET) { *(.text.lock) }
 
@@ -43,7 +48,7 @@
   .data : AT(ADDR(.data) - LOAD_OFFSET) {
 	*(.data)
 	CONSTRUCTORS
-	}
+	} :data
 
   _edata = .;			/* End of data section */
 
@@ -201,4 +206,6 @@
   STABS_DEBUG
 
   DWARF_DEBUG
+
+  NOTES
 }



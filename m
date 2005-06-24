Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262881AbVFXA2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbVFXA2r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 20:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262938AbVFXA2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 20:28:47 -0400
Received: from fmr22.intel.com ([143.183.121.14]:45256 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262881AbVFXA2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 20:28:40 -0400
Date: Thu, 23 Jun 2005 17:28:33 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: akpm@osdl.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux IA64 <linux-ia64@vger.kernel.org>
Subject: [patch][ia64]Refuse kprobe on ivt code
Message-ID: <20050623172832.B26121@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Subject: Refuse kprobe insert on IVT code

Not safe to insert kprobes on IVT code.

This patch checks to see if the address on which Kprobes is being
inserted is  in ivt code and if it is in ivt code then
refuse to register kprobe.

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>

===============================================
 arch/ia64/kernel/kprobes.c |   13 +++++++++++++
 1 files changed, 13 insertions(+)

Index: linux-2.6.12-mm1/arch/ia64/kernel/kprobes.c
===================================================================
--- linux-2.6.12-mm1.orig/arch/ia64/kernel/kprobes.c
+++ linux-2.6.12-mm1/arch/ia64/kernel/kprobes.c
@@ -263,6 +263,13 @@ static inline void get_kprobe_inst(bundl
 	}
 }
 
+/* Returns non-zero if the PC is in the Interrupt Vector Table */
+static inline int in_ivt_code(unsigned long pc)
+{
+	extern char ia64_ivt[];
+	return (pc >= (u_long)ia64_ivt && pc < (u_long)ia64_ivt+32768);
+}
+
 static int valid_kprobe_addr(int template, int slot, unsigned long addr)
 {
 	if ((slot > 2) || ((bundle_encoding[template][1] == L) && slot > 1)) {
@@ -271,6 +278,12 @@ static int valid_kprobe_addr(int templat
 		return -EINVAL;
 	}
 
+ 	if (in_ivt_code(addr)) {
+ 		printk(KERN_WARNING "Kprobes can't be inserted inside "
+				"IVT code at 0x%lx\n", addr);
+ 		return -EINVAL;
+ 	}
+
 	if (slot == 1) {
 		printk(KERN_WARNING "Inserting kprobes on slot #1 "
 		       "is not supported\n");

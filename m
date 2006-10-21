Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993149AbWJUQyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993149AbWJUQyX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 12:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993137AbWJUQyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 12:54:06 -0400
Received: from cantor2.suse.de ([195.135.220.15]:7096 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S2993149AbWJUQvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 12:51:51 -0400
From: Andi Kleen <ak@suse.de>
References: <20061021 651.356252000@suse.de>
In-Reply-To: <20061021 651.356252000@suse.de>
To: Vivek Goyal <vgoyal@in.ibm.com>, Magnus Damm <magnus@valinux.co.jp>,
       Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       patches@x86-64.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [18/19] x86_64: Overlapping program headers in physical addr space fix
Message-Id: <20061021165138.B8B5E13C4D@wotan.suse.de>
Date: Sat, 21 Oct 2006 18:51:38 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Vivek Goyal <vgoyal@in.ibm.com>

o A recent change to vmlinux.ld.S file broke kexec as now resulting vmlinux
  program headers are overlapping in physical address space.

o Now all the vsyscall related sections are placed after data and after
  that mostly init data sections are placed. To avoid physical overlap
  among phdrs, there are three possible solutions.
	- Place vsyscall sections also in data phdrs instead of user
	- move vsyscal sections after init data in bss.
	- create another phdrs say data.init and move all the sections
	  after vsyscall into this new phdr.

o This patch implements the third solution.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
Signed-off-by: Andi Kleen <ak@suse.de>
Cc: Magnus Damm <magnus@valinux.co.jp>
Cc: Andi Kleen <ak@suse.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/x86_64/kernel/vmlinux.lds.S |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: linux/arch/x86_64/kernel/vmlinux.lds.S
===================================================================
--- linux.orig/arch/x86_64/kernel/vmlinux.lds.S
+++ linux/arch/x86_64/kernel/vmlinux.lds.S
@@ -17,6 +17,7 @@ PHDRS {
 	text PT_LOAD FLAGS(5);	/* R_E */
 	data PT_LOAD FLAGS(7);	/* RWE */
 	user PT_LOAD FLAGS(7);	/* RWE */
+	data.init PT_LOAD FLAGS(7);	/* RWE */
 	note PT_NOTE FLAGS(4);	/* R__ */
 }
 SECTIONS
@@ -131,7 +132,7 @@ SECTIONS
   . = ALIGN(8192);		/* init_task */
   .data.init_task : AT(ADDR(.data.init_task) - LOAD_OFFSET) {
 	*(.data.init_task)
-  } :data
+  }:data.init
 
   . = ALIGN(4096);
   .data.page_aligned : AT(ADDR(.data.page_aligned) - LOAD_OFFSET) {

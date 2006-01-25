Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWAYGxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWAYGxX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 01:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWAYGxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 01:53:23 -0500
Received: from ns.intellilink.co.jp ([61.115.5.249]:64159 "EHLO
	mail.intellilink.co.jp") by vger.kernel.org with ESMTP
	id S1750728AbWAYGxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 01:53:22 -0500
Subject: [PATCH 3/5] stack overflow safe kdump (2.6.16-rc1-i386) - fault
From: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: akpm@osdl.org, ak@suse.de, vgoyal@in.ibm.com, linux-kernel@vger.kernel.org,
       fastboot@lists.osdl.org
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=83=87=E3=83=BC=E3=82=BF=E5=85=88=E7=AB=AF=E6=8A=80?=
	=?UTF-8?Q?=E8=A1=93=E6=A0=AA=E5=BC=8F=E4=BC=9A=E7=A4=BE?=
Date: Wed, 25 Jan 2006 15:53:20 +0900
Message-Id: <1138172000.2370.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When we have a bloated stack it is likely that it ends up making an
invalid memory access that in turn causes a page fault. Take this case
into account in the page fault code.

Signed-off-by: Fernando Vazquez <fernando@intellilink.co.jp>
--- 

diff -urNp linux-2.6.16-rc1/arch/i386/mm/fault.c linux-2.6.16-rc1-sov/arch/i386/mm/fault.c
--- linux-2.6.16-rc1/arch/i386/mm/fault.c	2006-01-03 12:21:10.000000000 +0900
+++ linux-2.6.16-rc1-sov/arch/i386/mm/fault.c	2006-01-25 14:43:13.000000000 +0900
@@ -245,6 +245,11 @@ fastcall void __kprobes do_page_fault(st
 		local_irq_enable();
 
 	tsk = current;
+	/* We may have invalid '*current' due to a stack overflow. */
+	if (!virt_addr_valid(tsk)) {
+		printk("do_page_fault: Discarding invalid 'current' struct task_struct * = 0x%p\n", tsk);
+		tsk = NULL;
+	}
 
 	si_code = SEGV_MAPERR;
 
@@ -271,7 +276,14 @@ fastcall void __kprobes do_page_fault(st
 		goto bad_area_nosemaphore;
 	} 
 
-	mm = tsk->mm;
+	mm = NULL;
+	/* We may have invalid 'tsk' due to a i386 stack overflow */
+	if (tsk)
+		mm = tsk->mm;
+	if (mm && !virt_addr_valid(mm)) {
+		printk("do_page_fault: Discarding invalid current->mm struct mm_struct * = 0x%p\n", mm);
+		mm = NULL;
+	}
 
 	/*
 	 * If we're in an interrupt, have no user context or are running in an



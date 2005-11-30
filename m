Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbVK3HmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbVK3HmT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 02:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbVK3HmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 02:42:19 -0500
Received: from ns.intellilink.co.jp ([61.115.5.249]:25255 "EHLO
	mail.intellilink.co.jp") by vger.kernel.org with ESMTP
	id S1751111AbVK3HmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 02:42:18 -0500
Subject: [PATCH 4/4] stack overflow safe kdump (	2.6.15-rc3-i386) - fault
From: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=83=87=E3=83=BC=E3=82=BF=E5=85=88=E7=AB=AF=E6=8A=80?=
	=?UTF-8?Q?=E8=A1=93=E6=A0=AA=E5=BC=8F=E4=BC=9A=E7=A4=BE?=
Date: Wed, 30 Nov 2005 16:37:47 +0900
Message-Id: <1133336267.2412.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When we have a bloated stack it is likely that it ends up making an
invalid memory access that causes a page fault. Take this case into
account in the page fault code.

---
diff -urNp linux-2.6.15-rc3/arch/i386/mm/fault.c linux-2.6.15-rc3-sov/arch/i386/mm/fault.c
--- linux-2.6.15-rc3/arch/i386/mm/fault.c	2005-11-30 14:51:49.000000000 +0900
+++ linux-2.6.15-rc3-sov/arch/i386/mm/fault.c	2005-11-30 14:56:04.000000000 +0900
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



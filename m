Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbVK1SFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbVK1SFs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 13:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbVK1SFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 13:05:47 -0500
Received: from 58x158x20x104.ap58.ftth.ucom.ne.jp ([58.158.20.104]:39605 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932156AbVK1SFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 13:05:31 -0500
Subject: [PATCH 4/4] stack overflow safe kdump (i386) - fault
From: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=83=87=E3=83=BC=E3=82=BF=E5=85=88=E7=AB=AF=E6=8A=80?=
	=?UTF-8?Q?=E8=A1=93=E6=A0=AA=E5=BC=8F=E4=BC=9A=E7=A4=BE?=
Date: Tue, 29 Nov 2005 03:01:05 +0900
Message-Id: <1133200865.2425.103.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When we have a bloated stack it is likely that it ends up making an
invalid memory access that causes a page fault. Take this case into
account in the page fault code.

---

diff -urNp linux-2.6.15-rc2/arch/i386/mm/fault.c
linux-2.6.15-rc2-sov/arch/i386/mm/fault.c
--- linux-2.6.15-rc2/arch/i386/mm/fault.c	2005-11-29 01:46:34.000000000
+0900
+++ linux-2.6.15-rc2-sov/arch/i386/mm/fault.c	2005-11-29
01:48:21.000000000 +0900
@@ -245,6 +245,11 @@ fastcall void __kprobes do_page_fault(st
 		local_irq_enable();
 
 	tsk = current;
+	/* We may have invalid '*current' due to a stack overflow. */
+	if (!virt_addr_valid(tsk)) {
+		printk("do_page_fault: Discarding invalid 'current' struct
task_struct * = 0x%p\n", tsk);
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
+		printk("do_page_fault: Discarding invalid current->mm struct
mm_struct * = 0x%p\n", mm);
+		mm = NULL;
+	}
 
 	/*
 	 * If we're in an interrupt, have no user context or are running in an



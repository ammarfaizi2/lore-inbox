Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWESWJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWESWJJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 18:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWESWJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 18:09:09 -0400
Received: from scl-ims.phoenix.com ([216.148.212.222]:64379 "EHLO
	scl-exch2k.phoenix.com") by vger.kernel.org with ESMTP
	id S1751122AbWESWJI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 18:09:08 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] fix broken vm86 interrupt/signal handling
Date: Fri, 19 May 2006 15:09:07 -0700
Message-ID: <0EF82802ABAA22479BC1CE8E2F60E8C3EECE1B@scl-exch2k3.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] fix broken vm86 interrupt/signal handling
Thread-Index: AcZ7j9XOhbnxtff1TeCgB/QIa1gRPgAABn3A
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: <linux-kernel@vger.kernel.org>
Cc: <roland@redhat.com>, <anemo@mba.ocn.ne.jp>, <mingo@elte.hu>,
       "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 19 May 2006 22:09:07.0459 (UTC) FILETIME=[D91B4D30:01C67B90]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  This patch
www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h
=c3ff8ec31c1249d268cd11390649768a12bec1b9 has broken vm86
interrupt/signal handling in case when vm86 is called from kernel space.
In this scenario, if signal is pending because of vm86 interrupt,
do_notify_resume/do_signal exits immediately due to user_mode() check,
without processing any signals. Thus, resume_userspace handler is
spinning in a tight loop with signal pending and TIF_SIGPENDING is set.
Previously everything worked Ok.

  The following patch fixes the issue

Signed-off-by: Aleksey Gorelov <aleksey_gorelov@phoenix.com>

--- linux-2.6.16/arch/i386/kernel/entry.S-old	2006-05-19
14:31:41.000000000 -0700
+++ linux-2.6.16/arch/i386/kernel/entry.S	2006-05-19
14:33:31.000000000 -0700
@@ -82,6 +82,12 @@
 #define resume_kernel		restore_nocheck
 #endif
 
+#ifdef CONFIG_VM86
+#define resume_userspace_sig	check_userspace
+#else
+#define resume_userspace_sig	resume_userspace
+#endif
+
 #define SAVE_ALL \
 	cld; \
 	pushl %es; \
@@ -143,6 +149,7 @@
 	preempt_stop
 ret_from_intr:
 	GET_THREAD_INFO(%ebp)
+check_userspace:
 	movl EFLAGS(%esp), %eax		# mix EFLAGS and CS
 	movb CS(%esp), %al
 	testl $(VM_MASK | 3), %eax
@@ -319,7 +326,7 @@
 					# vm86-space
 	xorl %edx, %edx
 	call do_notify_resume
-	jmp resume_userspace
+	jmp resume_userspace_sig
 
 	ALIGN
 work_notifysig_v86:
@@ -330,7 +337,7 @@
 	movl %eax, %esp
 	xorl %edx, %edx
 	call do_notify_resume
-	jmp resume_userspace
+	jmp resume_userspace_sig
 #endif
 
 	# perform syscall exit tracing

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262271AbUKKQS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbUKKQS6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 11:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbUKKQS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 11:18:58 -0500
Received: from asplinux.ru ([195.133.213.194]:9481 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S262271AbUKKQSv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 11:18:51 -0500
Message-ID: <41939163.5020305@sw.ru>
Date: Thu, 11 Nov 2004 19:20:51 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH]: 4/4GB: 
Content-Type: multipart/mixed;
 boundary="------------030702070701070804010303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030702070701070804010303
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes exception handling in RESTORE_ALL macro on returing
to user space. Incorrect values in %ds/%es can lead to incorrect 
behaivour and iret to kernel space address. This patch moves
exception handler from .fixup section to .entry.text and makes it
to be between int80_ret_start_marker/int80_ret_end_marker markers.

Signed-Off-By: Kirill Korotaev <dev@sw.ru>

Kirill

P.S. These 4GB split patches are against modified 2.6.8.1 kernel, but 
should be appliable to last Fedora kernels

--------------030702070701070804010303
Content-Type: text/plain;
 name="diff-arch-4gb-restore"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-arch-4gb-restore"

--- ./arch/i386/kernel/entry.S.4gbrest	2004-11-10 11:21:32.000000000 +0300
+++ ./arch/i386/kernel/entry.S	2004-11-10 12:35:24.239613040 +0300
@@ -167,7 +167,7 @@ int80_ret_start_marker:					\
 	movl %edx, %esp; 				\
 	movl %ecx, %cr3;				\
 							\
-	__RESTORE_ALL;					\
+	__RESTORE_ALL_USER;				\
 int80_ret_end_marker:					\
 2:
 
@@ -204,14 +204,19 @@ int80_ret_end_marker:					\
 
 #define __RESTORE_REGS	\
 	__RESTORE_INT_REGS; \
+	popl %ds;	\
+	popl %es;
+
+#define __RESTORE_REGS_USER \
+	__RESTORE_INT_REGS; \
 111:	popl %ds;	\
 222:	popl %es;	\
-.section .fixup,"ax";	\
+	jmp 666f;	\
 444:	movl $0,(%esp);	\
 	jmp 111b;	\
 555:	movl $0,(%esp);	\
 	jmp 222b;	\
-.previous;		\
+666:			\
 .section __ex_table,"a";\
 	.align 4;	\
 	.long 111b,444b;\
@@ -220,6 +225,13 @@ int80_ret_end_marker:					\
 
 #define __RESTORE_ALL	\
 	__RESTORE_REGS	\
+	__RESTORE_IRET
+
+#define __RESTORE_ALL_USER \
+	__RESTORE_REGS_USER \
+	__RESTORE_IRET
+
+#define __RESTORE_IRET	\
 	addl $4, %esp;	\
 333:	iret;		\
 .section .fixup,"ax";   \

--------------030702070701070804010303--


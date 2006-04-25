Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWDYPKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWDYPKn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 11:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWDYPKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 11:10:43 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:31122 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932252AbWDYPKm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 11:10:42 -0400
Date: Tue, 25 Apr 2006 17:10:45 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [patch] s390: new system calls.
Message-ID: <20060425151045.GB16531@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch] s390: new system calls.

Add sys_set_robust_list, sys_get_robust_list, sys_splice,
sys_sync_file and sys_tee system calls.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/kernel/compat_wrapper.S |   42 ++++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/syscalls.S       |    5 ++++
 2 files changed, 47 insertions(+)

diff -urpN linux-2.6/arch/s390/kernel/compat_wrapper.S linux-2.6-patched/arch/s390/kernel/compat_wrapper.S
--- linux-2.6/arch/s390/kernel/compat_wrapper.S	2006-04-25 13:40:46.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/compat_wrapper.S	2006-04-25 14:46:49.000000000 +0200
@@ -1608,3 +1608,45 @@ compat_sys_ppoll_wrapper:
 sys_unshare_wrapper:
 	llgfr	%r2,%r2			# unsigned long
 	jg	sys_unshare
+
+	.globl compat_sys_set_robust_list_wrapper
+compat_sys_set_robust_list_wrapper:
+	llgtr	%r2,%r2			# struct compat_robust_list_head *
+	llgfr	%r3,%r3			# size_t
+	jg	compat_sys_set_robust_list
+
+	.globl compat_sys_get_robust_list_wrapper
+compat_sys_get_robust_list_wrapper:
+	lgfr	%r2,%r2			# int
+	llgtr	%r3,%r3			# compat_uptr_t_t *
+	llgtr	%r4,%r4			# compat_size_t *
+	jg	compat_sys_get_robust_list
+
+	.globl sys_splice_wrapper
+sys_splice_wrapper:
+	lgfr	%r2,%r2			# int
+	llgtr	%r3,%r3			# loff_t *
+	lgfr	%r4,%r4			# int
+	llgtr	%r5,%r5			# loff_t *
+	llgfr	%r6,%r6			# size_t
+	llgf	%r0,164(%r15)		# unsigned int
+	stg	%r0,160(%r15)
+	jg	sys_splice
+
+	.globl	sys_sync_file_range_wrapper
+sys_sync_file_range_wrapper:
+	lgfr	%r2,%r2			# int
+	sllg	%r3,%r3,32		# get high word of 64bit loff_t
+	or	%r3,%r4			# get low word of 64bit loff_t
+	sllg	%r4,%r5,32		# get high word of 64bit loff_t
+	or	%r4,%r6			# get low word of 64bit loff_t
+	llgf	%r5,164(%r15)		# unsigned int
+	jg	sys_sync_file_range
+
+	.globl	sys_tee_wrapper
+sys_tee_wrapper:
+	lgfr	%r2,%r2			# int
+	lgfr	%r3,%r3			# int
+	llgfr	%r4,%r4			# size_t
+	llgfr	%r5,%r5			# unsigned int
+	jg	sys_tee
diff -urpN linux-2.6/arch/s390/kernel/syscalls.S linux-2.6-patched/arch/s390/kernel/syscalls.S
--- linux-2.6/arch/s390/kernel/syscalls.S	2006-04-25 13:40:46.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/syscalls.S	2006-04-25 14:45:53.000000000 +0200
@@ -312,3 +312,8 @@ SYSCALL(sys_faccessat,sys_faccessat,sys_
 SYSCALL(sys_pselect6,sys_pselect6,compat_sys_pselect6_wrapper)
 SYSCALL(sys_ppoll,sys_ppoll,compat_sys_ppoll_wrapper)
 SYSCALL(sys_unshare,sys_unshare,sys_unshare_wrapper)
+SYSCALL(sys_set_robust_list,sys_set_robust_list,compat_sys_set_robust_list_wrapper)
+SYSCALL(sys_get_robust_list,sys_get_robust_list,compat_sys_get_robust_list_wrapper)
+SYSCALL(sys_splice,sys_splice,sys_splice_wrapper)
+SYSCALL(sys_sync_file_range,sys_sync_file_range,sys_sync_file_range_wrapper)
+SYSCALL(sys_tee,sys_tee,sys_tee_wrapper)

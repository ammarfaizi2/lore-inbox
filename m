Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbVFAS0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbVFAS0x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 14:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbVFASK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 14:10:29 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:17918 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S261516AbVFASC4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 14:02:56 -0400
Date: Wed, 1 Jun 2005 20:02:56 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 4/11] s390: uml ptrace fixes.
Message-ID: <20050601180256.GD6418@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 4/11] s390: uml ptrace fixes.

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

To make UML build and run on s390, I needed to do these two little
changes:

1) UML includes some of the subarch's (s390) headers. I had to
   change one of them with the following one-liner, to make this
   compile. AFAICS, this change doesn't break compilation of s390
   itself.

2) UML needs to intercept syscalls via ptrace to invalidate the syscall,
   read syscall's parameters and write the result with the result of
   UML's syscall processing. Also, UML needs to make sure, that the host
   does no syscall restart processing. On i386 for example, this can be
   done by writing -1 to orig_eax on the 2nd syscall interception
   (orig_eax is the syscall number, which after the interception is used
   as a "interrupt was a syscall" flag only.
   Unfortunately, s390 holds syscall number and syscall result in gpr2 and
   its "interrupt was a syscall" flag (trap) is unreachable via ptrace.
   So I changed the host to set trap to -1, if the syscall number is changed
   to an invalid value on the first syscall interception.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/ptrace.c |    7 +++++++
 include/asm-s390/user.h   |    2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/kernel/ptrace.c linux-2.6-patched/arch/s390/kernel/ptrace.c
--- linux-2.6/arch/s390/kernel/ptrace.c	2005-06-01 19:43:16.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/ptrace.c	2005-06-01 19:43:16.000000000 +0200
@@ -761,6 +761,13 @@ syscall_trace(struct pt_regs *regs, int 
 				 ? 0x80 : 0));
 
 	/*
+	 * If the debuffer has set an invalid system call number,
+	 * we prepare to skip the system call restart handling.
+	 */
+	if (!entryexit && regs->gprs[2] >= NR_syscalls)
+		regs->trap = -1;
+
+	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
 	 * stopping signal is not SIGTRAP.  -brl
diff -urpN linux-2.6/include/asm-s390/user.h linux-2.6-patched/include/asm-s390/user.h
--- linux-2.6/include/asm-s390/user.h	2005-03-02 08:38:38.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/user.h	2005-06-01 19:43:16.000000000 +0200
@@ -10,7 +10,7 @@
 #define _S390_USER_H
 
 #include <asm/page.h>
-#include <linux/ptrace.h>
+#include <asm/ptrace.h>
 /* Core file format: The core file is written in such a way that gdb
    can understand it and provide useful information to the user (under
    linux we use the 'trad-core' bfd).  There are quite a number of

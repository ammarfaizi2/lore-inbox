Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbUK3IsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbUK3IsV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 03:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbUK3IsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 03:48:21 -0500
Received: from gw.goop.org ([64.81.55.164]:11950 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S262020AbUK3IsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 03:48:17 -0500
Subject: Buffer overrun in arch/x86_64/sys_ia32.c:sys32_ni_syscall()
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 29 Nov 2004 20:05:20 -0800
Message-Id: <1101787520.4087.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-0.mozer.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

struct task_struct.comm is defined to be 16 chars, but
arch/x86_64/sys_ia32.c:sys32_ni_syscall() copies it into a static 8 byte
buffer, which will surely cause problems.  This patch makes lastcomm[]
the right size, and makes sure it can't be overrun.  Since the code also
goes to the effort of getting a local copy of current in "me", we may as
well use it for printing the message.

Patch is against 2.6.10-rc2-mm3.

	J

 arch/x86_64/ia32/sys_ia32.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff -puN arch/x86_64/ia32/sys_ia32.c~short-comm-string arch/x86_64/ia32/sys_ia32.c
--- local-2.6/arch/x86_64/ia32/sys_ia32.c~short-comm-string	2004-11-29 19:51:02.922621617 -0800
+++ local-2.6-jeremy/arch/x86_64/ia32/sys_ia32.c	2004-11-29 19:52:43.493561830 -0800
@@ -525,11 +525,12 @@ sys32_waitpid(compat_pid_t pid, unsigned
 int sys32_ni_syscall(int call)
 { 
 	struct task_struct *me = current;
-	static char lastcomm[8];
-	if (strcmp(lastcomm, me->comm)) {
-	printk(KERN_INFO "IA32 syscall %d from %s not implemented\n", call,
-	       current->comm);
-		strcpy(lastcomm, me->comm); 
+	static char lastcomm[sizeof(me->comm)];
+
+	if (strncmp(lastcomm, me->comm, sizeof(lastcomm))) {
+		printk(KERN_INFO "IA32 syscall %d from %s not implemented\n", call,
+		       me->comm);
+		strncpy(lastcomm, me->comm, sizeof(lastcomm));
 	} 
 	return -ENOSYS;	       
 } 

_



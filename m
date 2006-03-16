Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752237AbWCPH77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752237AbWCPH77 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 02:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752238AbWCPH77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 02:59:59 -0500
Received: from mail.macqel.be ([194.78.208.39]:1551 "EHLO mail.macqel.be")
	by vger.kernel.org with ESMTP id S1752235AbWCPH77 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 02:59:59 -0500
Date: Thu, 16 Mar 2006 08:59:56 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH] m68knommu : clear frame-pointer in start_thread
Message-ID: <20060316085955.C13021@mail.macqel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to print the calltrace of a user process on m68knommu targets
gdb follows the frame-pointer and falls on unreachable adresses, because
the frame pointer is not properly initialised by start_thread. This patch
initialises the frame pointer to NULL in start_thread.

Signed-off-by: Philippe De Muyter <phdm@macqel.be>

---

the only real change is the initialisation of a6, the rest is spacing fixes
	((struct switch_stack *)(_regs))[-1].a6 = 0;

Index: linux-2.6.x/include/asm-m68knommu/processor.h
===================================================================
RCS file: /newdev6/cvsrepos/uClinux-dist/linux-2.6.x/include/asm-m68knommu/processor.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 processor.h
--- linux-2.6.x/include/asm-m68knommu/processor.h	2004/05/07 08:40:13	1.1.1.1
+++ linux-2.6.x/include/asm-m68knommu/processor.h	2006/03/16 07:26:52
@@ -89,14 +89,15 @@
  * pass the data segment into user programs if it exists,
  * it can't hurt anything as far as I can tell
  */
-#define start_thread(_regs, _pc, _usp)           \
-do {                                             \
-	set_fs(USER_DS); /* reads from user space */ \
-	(_regs)->pc = (_pc);                         \
-	if (current->mm)                             \
-		(_regs)->d5 = current->mm->start_data;   \
-	(_regs)->sr &= ~0x2000;                      \
-	wrusp(_usp);                                 \
+#define start_thread(_regs, _pc, _usp)			\
+do {							\
+	set_fs(USER_DS); /* reads from user space */	\
+	(_regs)->pc = (_pc);				\
+	((struct switch_stack *)(_regs))[-1].a6 = 0;	\
+	if (current->mm)				\
+		(_regs)->d5 = current->mm->start_data;	\
+	(_regs)->sr &= ~0x2000;				\
+	wrusp(_usp);					\
 } while(0)
 
 /* Forward declaration, a strange C thing */

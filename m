Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbVKJQmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbVKJQmb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 11:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbVKJQmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 11:42:31 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:25563 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751147AbVKJQma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 11:42:30 -0500
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Tom Rini <trini@kernel.crashing.org>, lkml <linux-kernel@vger.kernel.org>
Message-Id: <20051110164227.20950.54730.sendpatchset@localhost.localdomain>
In-Reply-To: <20051110163906.20950.45704.sendpatchset@localhost.localdomain>
References: <20051110163906.20950.45704.sendpatchset@localhost.localdomain>
Subject: [PATCH,RFC 2.6.14 07/15] x86_64: Add a notifier hook to the "no context" part of do_page_fault
Date: Thu, 10 Nov 2005 11:41:58 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a call to notify_die() in the "no context" portion of
do_page_fault() as someone on the chain might care and want to do a fixup.

 arch/x86_64/mm/fault.c      |    4 ++++
 include/asm-x86_64/kdebug.h |    1 +
 2 files changed, 5 insertions(+)

Index: linux-2.6.14/arch/x86_64/mm/fault.c
===================================================================
--- linux-2.6.14.orig/arch/x86_64/mm/fault.c
+++ linux-2.6.14/arch/x86_64/mm/fault.c
@@ -518,6 +518,10 @@ no_context:
 	if (is_errata93(regs, address))
 		return; 
 
+	if (notify_die(DIE_PAGE_FAULT_NO_CONTEXT, "no context", regs,
+				error_code, 14, SIGSEGV) == NOTIFY_STOP)
+		return;
+
 /*
  * Oops. The kernel tried to access some bad page. We'll have to
  * terminate things with extreme prejudice.
Index: linux-2.6.14/include/asm-x86_64/kdebug.h
===================================================================
--- linux-2.6.14.orig/include/asm-x86_64/kdebug.h
+++ linux-2.6.14/include/asm-x86_64/kdebug.h
@@ -33,6 +33,7 @@ enum die_val { 
 	DIE_CALL,
 	DIE_NMI_IPI,
 	DIE_PAGE_FAULT,
+	DIE_PAGE_FAULT_NO_CONTEXT,
 }; 
 	
 static inline int notify_die(enum die_val val,char *str,struct pt_regs *regs,long err,int trap, int sig)

-- 
Tom

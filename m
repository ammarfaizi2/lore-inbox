Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752463AbWAFQcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463AbWAFQcJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752457AbWAFQas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:30:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38079 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752456AbWAFQaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:30:04 -0500
Date: Fri, 6 Jan 2006 16:29:36 GMT
Message-Id: <200601061629.k06GTaBT011369@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, aviro@redhat.com
Cc: linux-kernel@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 5/17] FRV: Support module exception tables
In-Reply-To: <dhowells1136564974@warthog.cambridge.redhat.com>
References: <dhowells1136564974@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch fixes the exception table handling so that modules
exceptions are dealt with.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-extab-2615.diff
 arch/frv/mm/extable.c |   34 +++++++++-------------------------
 1 files changed, 9 insertions(+), 25 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15/arch/frv/mm/extable.c linux-2.6.15-frv/arch/frv/mm/extable.c
--- /warthog/kernels/linux-2.6.15/arch/frv/mm/extable.c	2005-03-02 12:07:44.000000000 +0000
+++ linux-2.6.15-frv/arch/frv/mm/extable.c	2006-01-06 14:43:43.000000000 +0000
@@ -43,7 +43,7 @@ static inline unsigned long search_one_t
  */
 unsigned long search_exception_table(unsigned long pc)
 {
-	unsigned long ret = 0;
+	const struct exception_table_entry *extab;
 
 	/* determine if the fault lay during a memcpy_user or a memset_user */
 	if (__frame->lr == (unsigned long) &__memset_user_error_lr &&
@@ -55,9 +55,10 @@ unsigned long search_exception_table(uns
 		 */
 		return (unsigned long) &__memset_user_error_handler;
 	}
-	else if (__frame->lr == (unsigned long) &__memcpy_user_error_lr &&
-		 (unsigned long) &memcpy <= pc && pc < (unsigned long) &__memcpy_end
-		 ) {
+
+	if (__frame->lr == (unsigned long) &__memcpy_user_error_lr &&
+	    (unsigned long) &memcpy <= pc && pc < (unsigned long) &__memcpy_end
+	    ) {
 		/* the fault occurred in a protected memset
 		 * - we search for the return address (in LR) instead of the program counter
 		 * - it was probably during a copy_to/from_user()
@@ -65,27 +66,10 @@ unsigned long search_exception_table(uns
 		return (unsigned long) &__memcpy_user_error_handler;
 	}
 
-#ifndef CONFIG_MODULES
-	/* there is only the kernel to search.  */
-	ret = search_one_table(__start___ex_table, __stop___ex_table - 1, pc);
-	return ret;
-
-#else
-	/* the kernel is the last "module" -- no need to treat it special */
-	unsigned long flags;
-	struct module *mp;
+	extab = search_exception_tables(pc);
+	if (extab)
+		return extab->fixup;
 
-	spin_lock_irqsave(&modlist_lock, flags);
-
-	for (mp = module_list; mp != NULL; mp = mp->next) {
-		if (mp->ex_table_start == NULL || !(mp->flags & (MOD_RUNNING | MOD_INITIALIZING)))
-			continue;
-		ret = search_one_table(mp->ex_table_start, mp->ex_table_end - 1, pc);
-		if (ret)
-			break;
-	}
+	return 0;
 
-	spin_unlock_irqrestore(&modlist_lock, flags);
-	return ret;
-#endif
 } /* end search_exception_table() */

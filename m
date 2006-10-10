Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbWJJR7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbWJJR7R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 13:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWJJR7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 13:59:17 -0400
Received: from sinclair.provo.novell.com ([137.65.248.137]:35861 "EHLO
	sinclair.provo.novell.com") by vger.kernel.org with ESMTP
	id S964901AbWJJR7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 13:59:17 -0400
Message-Id: <452B7079.3C0A.0073.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Tue, 10 Oct 2006 11:59:10 -0600
From: "Adam Jerome" <abj@novell.com>
To: <linux-kernel@vger.kernel.org>
Cc: <Akpm@osdl.org>
Subject: [PATCH 002/001] /kernel: /proc/kallsyms reports lower-case
	types for some non-exported symbols       (Resend #1)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam B. Jerome <abj@novell.com>

This patch addresses incorrect symbol type information reported through /proc/kallsyms.
A lowercase character should designate the symbol as local (or non-exported).  An
uppercase character should designate the symbol as global (or external). Without this
patch, some non-exported symbols are incorrectly assigned an upper-case designation in
/proc/kallsyms.  This patch corrects this condition by converting non-exported symbols
types to lower case when appropriate and eliminates the superfluous upcase_if_global
function

Signed-off-by: Adam B. Jerome <abj@novell.com>

---

I do not subscribe to the list. Please CC posted answers/comments to me <abj@novell.com>.
Thanks; -adam

diff -urpN linux-2.6-git/kernel/kallsyms.c linux-2.6-cur/kernel/kallsyms.c
--- linux-2.6-git/kernel/kallsyms.c	2006-10-02 15:20:25.000000000 -0600
+++ linux-2.6-cur/kernel/kallsyms.c	2006-10-02 15:58:03.000000000 -0600
@@ -20,6 +20,7 @@
 #include <linux/proc_fs.h>
 #include <linux/sched.h>	/* for cond_resched */
 #include <linux/mm.h>
+#include <linux/ctype.h>
 
 #include <asm/sections.h>
 
@@ -264,13 +265,6 @@ struct kallsym_iter
 	char name[KSYM_NAME_LEN+1];
 };
 
-/* Only label it "global" if it is exported. */
-static void upcase_if_global(struct kallsym_iter *iter)
-{
-	if (is_exported(iter->name, iter->owner))
-		iter->type += 'A' - 'a';
-}
-
 static int get_ksymbol_mod(struct kallsym_iter *iter)
 {
 	iter->owner = module_get_kallsym(iter->pos - kallsyms_num_syms,
@@ -279,7 +273,10 @@ static int get_ksymbol_mod(struct kallsy
 	if (iter->owner == NULL)
 		return 0;
 
-	upcase_if_global(iter);
+	/* Label it "global" if it ix exported, "local" if not exported. */
+	iter->type = is_exported(iter->name, iter->owner)
+		? toupper(iter->type) : tolower(iter->type);
+
 	return 1;
 }


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422633AbWJPP2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422633AbWJPP2v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 11:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422637AbWJPP2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 11:28:51 -0400
Received: from sinclair.provo.novell.com ([137.65.248.137]:15137 "EHLO
	sinclair.provo.novell.com") by vger.kernel.org with ESMTP
	id S1422633AbWJPP2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 11:28:50 -0400
Message-Id: <4533361A.3C0A.0073.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Mon, 16 Oct 2006 09:28:39 -0600
From: "Adam Jerome" <abj@novell.com>
To: <linux-kernel@vger.kernel.org>
Cc: <Akpm@osdl.org>
Subject: [PATCH] kallsyms: report consistent types for non-exported
	symbols
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
function.

Please apply.

Signed-off-by: Adam B. Jerome <abj@novell.com>

---

I do not subscribe to the list. Please CC posted answers/comments to me <abj@novell.com>.
Thanks; -adam

diff -urpN linux-2.6-git/kernel/kallsyms.c linux-2.6-cur/kernel/kallsyms.c
--- linux-2.6-git/kernel/kallsyms.c	2006-10-16 08:53:33.000000000 -0600
+++ linux-2.6-cur/kernel/kallsyms.c	2006-10-16 09:09:36.000000000 -0600
@@ -20,6 +20,7 @@
 #include <linux/proc_fs.h>
 #include <linux/sched.h>	/* for cond_resched */
 #include <linux/mm.h>
+#include <linux/ctype.h>
 
 #include <asm/sections.h>
 
@@ -301,13 +302,6 @@ struct kallsym_iter
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
@@ -316,7 +310,10 @@ static int get_ksymbol_mod(struct kallsy
 	if (iter->owner == NULL)
 		return 0;
 
-	upcase_if_global(iter);
+	/* Label it "global" if it ix exported, "local" if not exported. */
+	iter->type = is_exported(iter->name, iter->owner)
+		? toupper(iter->type) : tolower(iter->type);
+
 	return 1;
 }


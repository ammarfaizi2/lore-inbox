Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964912AbWAFKpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbWAFKpv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 05:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWAFKpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 05:45:46 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:14995 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932395AbWAFKpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 05:45:35 -0500
Subject: [patch 5/7]  uninline capable()
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu
In-Reply-To: <1136543825.2940.8.camel@laptopd505.fenrus.org>
References: <1136543825.2940.8.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 11:42:40 +0100
Message-Id: <1136544160.2940.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: uninline capable()
From: Ingo Molnar <mingo@elte.hu>

uninline capable(). Saves 2K of kernel text on a generic .config, and 1K
on a tiny config. In addition it makes the use of capable more consistent
between CONFIG_SECURITY and !CONFIG_SECURITY

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 include/linux/sched.h |   15 ++-------------
 kernel/sys.c          |   11 +++++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

Index: linux-2.6.15/include/linux/sched.h
===================================================================
--- linux-2.6.15.orig/include/linux/sched.h
+++ linux-2.6.15/include/linux/sched.h
@@ -1102,19 +1102,8 @@ static inline int sas_ss_flags(unsigned 
 }
 
 
-#ifdef CONFIG_SECURITY
-/* code is in security.c */
+/* code is in security.c or kernel/sys.c if !SECURITY */
 extern int capable(int cap);
-#else
-static inline int capable(int cap)
-{
-	if (cap_raised(current->cap_effective, cap)) {
-		current->flags |= PF_SUPERPRIV;
-		return 1;
-	}
-	return 0;
-}
-#endif
 
 /*
  * Routines for handling mm_structs
Index: linux-2.6.15/kernel/sys.c
===================================================================
--- linux-2.6.15.orig/kernel/sys.c
+++ linux-2.6.15/kernel/sys.c
@@ -223,6 +223,18 @@ int unregister_reboot_notifier(struct no
 
 EXPORT_SYMBOL(unregister_reboot_notifier);
 
+#ifndef CONFIG_SECURITY
+int capable(int cap)
+{
+        if (cap_raised(current->cap_effective, cap)) {
+	       current->flags |= PF_SUPERPRIV;
+	       return 1;
+        }
+        return 0;
+}
+EXPORT_SYMBOL(capable);
+#endif
+
 static int set_one_prio(struct task_struct *p, int niceval, int error)
 {
 	int no_nice;



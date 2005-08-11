Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbVHKRX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbVHKRX1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 13:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbVHKRX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 13:23:27 -0400
Received: from verein.lst.de ([213.95.11.210]:59353 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751135AbVHKRX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 13:23:27 -0400
Date: Thu, 11 Aug 2005 19:23:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: dhowells@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH, RFC] kill odd mm context pinning hack in frv
Message-ID: <20050811172312.GA10202@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David, is that more than a debugging aid?   I'm trying to get rid of
tasklist_lock users and this one looks really suspicios..


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/frv/kernel/sysctl.c
===================================================================
--- linux-2.6.orig/arch/frv/kernel/sysctl.c	2005-08-11 16:45:53.000000000 +0200
+++ linux-2.6/arch/frv/kernel/sysctl.c	2005-08-11 19:17:24.000000000 +0200
@@ -117,69 +117,12 @@
 
 } /* end procctl_frv_cachemode() */
 
-/*****************************************************************************/
-/*
- * permit the mm_struct the nominated process is using have its MMU context ID pinned
- */
-#ifdef CONFIG_MMU
-static int procctl_frv_pin_cxnr(ctl_table *table, int write, struct file *filp,
-				void *buffer, size_t *lenp, loff_t *ppos)
-{
-	pid_t pid;
-	char buff[16], *p;
-	int len;
-
-	len = *lenp;
-
-	if (write) {
-		/* potential state change */
-		if (len <= 1 || len > sizeof(buff) - 1)
-			return -EINVAL;
-
-		if (copy_from_user(buff, buffer, len) != 0)
-			return -EFAULT;
-
-		if (buff[len - 1] == '\n')
-			buff[len - 1] = '\0';
-		else
-			buff[len] = '\0';
-
-		pid = simple_strtoul(buff, &p, 10);
-		if (*p)
-			return -EINVAL;
-
-		return cxn_pin_by_pid(pid);
-	}
-
-	/* read the currently pinned CXN */
-	if (filp->f_pos > 0) {
-		*lenp = 0;
-		return 0;
-	}
-
-	len = snprintf(buff, sizeof(buff), "%d\n", cxn_pinned);
-	if (len > *lenp)
-		len = *lenp;
-
-	if (copy_to_user(buffer, buff, len) != 0)
-		return -EFAULT;
-
-	*lenp = len;
-	filp->f_pos = len;
-	return 0;
-
-} /* end procctl_frv_pin_cxnr() */
-#endif
-
 /*
  * FR-V specific sysctls
  */
 static struct ctl_table frv_table[] =
 {
 	{ 1, "cache-mode",	NULL, 0, 0644, NULL, &procctl_frv_cachemode },
-#ifdef CONFIG_MMU
-	{ 2, "pin-cxnr",	NULL, 0, 0644, NULL, &procctl_frv_pin_cxnr },
-#endif
 	{ 0 }
 };
 
Index: linux-2.6/include/asm-frv/mmu.h
===================================================================
--- linux-2.6.orig/include/asm-frv/mmu.h	2005-08-11 16:46:04.000000000 +0200
+++ linux-2.6/include/asm-frv/mmu.h	2005-08-11 19:18:10.000000000 +0200
@@ -34,9 +34,4 @@
 
 } mm_context_t;
 
-#ifdef CONFIG_MMU
-extern int __nongpreldata cxn_pinned;
-extern int cxn_pin_by_pid(pid_t pid);
-#endif
-
 #endif /* _ASM_MMU_H */

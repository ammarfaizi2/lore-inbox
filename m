Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266820AbUIITYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266820AbUIITYG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 15:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266805AbUIITVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 15:21:02 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:35037 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263100AbUIITTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 15:19:13 -0400
Message-ID: <4140ABD2.90908@engr.sgi.com>
Date: Thu, 09 Sep 2004 12:15:30 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, lse-tech <lse-tech@lists.sourceforge.net>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       CSA-ML <csa@oss.sgi.com>, Arthur Corliss <corliss@digitalmages.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Erik Jacobson <erikj@dbear.engr.sgi.com>, Limin Gu <limin@engr.sgi.com>
Subject: [PATCH 2.6.8.1 3/4] CSA  csa_eop: accounting end-of-process hook
References: <4140A9D2.3010602@engr.sgi.com>
In-Reply-To: <4140A9D2.3010602@engr.sgi.com>
Content-Type: multipart/mixed;
 boundary="------------060502060308080802040301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060502060308080802040301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linux Comprehensive System Accounting (CSA) is a set of C programs and
shell scripts that, like other accounting packages, provide methods for
collecting per-process resource usage data, monitoring disk usage, and
charging fees to specific login accounts.

The CSA patchset includes csa_io, csa_mm, csa_eop and csa_module.
Patches csa_io, csa_mm, and csa_eop are responsible for system
accounting data collection and are independent of each other.

csa_eop is a patch that provides a hook for end-of-process handling.

Please find CSA project at http://oss.sgi.com/projects/csa. This set of
csa patches has been tested with the pagg and job kernel patches.
The information of pagg and job project can be found at
http://oss.sgi.com/projects/pagg/


Signed-off-by: Jay Lan <jlan@sgi.com>

--------------060502060308080802040301
Content-Type: text/plain;
 name="linux-2.6.8.1.csa_eop.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.8.1.csa_eop.patch"

Index: linux/kernel/exit.c
===================================================================
--- linux.orig/kernel/exit.c	2004-09-03 17:17:03.000000000 -0700
+++ linux/kernel/exit.c	2004-09-03 17:17:03.000000000 -0700
@@ -33,6 +33,8 @@
 
 extern void sem_exit (void);
 extern struct task_struct *child_reaper;
+void (*do_eop_acct) (int, struct task_struct *) = NULL;
+EXPORT_SYMBOL(do_eop_acct);
 
 int getrusage(struct task_struct *, int, struct rusage __user *);
 
@@ -826,6 +828,9 @@
 	csa_update_integrals();
 	update_mem_hiwater();
 	acct_process(code);
+	/* Handle end-of-process accounting */
+	if (do_eop_acct != NULL)
+		do_eop_acct(code, tsk);
 	__exit_mm(tsk);
 
 	exit_sem(tsk);
Index: linux/include/linux/acct.h
===================================================================
--- linux.orig/include/linux/acct.h	2004-08-13 22:36:32.000000000 -0700
+++ linux/include/linux/acct.h	2004-09-03 17:17:03.000000000 -0700
@@ -185,6 +185,13 @@
        return x;
 }
 
+/*
+ * extern declaration that provides the hook needed for processing of
+ * end-of-process accounting record
+ *
+ */
+extern void (*do_eop_acct) (int, struct task_struct *);
+
 #endif  /* __KERNEL */
 
 #endif	/* _LINUX_ACCT_H */

--------------060502060308080802040301--


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311262AbSCZL4p>; Tue, 26 Mar 2002 06:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311274AbSCZL4f>; Tue, 26 Mar 2002 06:56:35 -0500
Received: from hitpro.hitachi.co.jp ([133.145.224.7]:26355 "EHLO
	hitpro.hitachi.co.jp") by vger.kernel.org with ESMTP
	id <S311262AbSCZL40>; Tue, 26 Mar 2002 06:56:26 -0500
Date: Tue, 26 Mar 2002 20:11:12 +0900 (JST)
Message-Id: <20020326.201112.01364938.t-kawano@ebina.hitachi.co.jp>
To: linux-ia64@linuxia64.org, linux-kernel@vger.kernel.org
Subject: [PATCH]fix for double free in efi.c 
From: Takanori Kawano <t-kawano@ebina.hitachi.co.jp>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is a fix for a double free bug in fs/partitions/efi.c.

--- efi.c	Fri Mar  1 16:59:19 2002
+++ efi.c.fixed	Mon Mar 11 16:34:29 2002
@@ -546,8 +547,8 @@
 
 		*gpt = pgpt;
 		*ptes = pptes;
-		if (agpt)  kfree(agpt);
-		if (aptes) kfree(aptes);
+		if (agpt)   { kfree(agpt); agpt=NULL; }
+		if (aptes)  { kfree(aptes); aptes=NULL; }
 	} /* if primary is valid */
 	else {
 		/* Primary GPT is bad, check the Alternate GPT */
@@ -595,6 +596,8 @@
         if (agpt) {kfree(agpt); agpt = NULL;}
         if (pptes) {kfree(pptes); pptes = NULL;}
         if (aptes) {kfree(aptes); aptes = NULL;}
+        *gpt = NULL;
+        *ptes = NULL;
 	return 0;
 }


This patch is against redhat 2.4.9 kernel and has already 
been reported to redhat Bugzilla.

I suppose why such a serious bug has remained for a long time 
is that the current debug code in slab.c fails to detect 
double free in case the object holded by cpucaches is doubly 
freed.
I think the current debug code should be improved to detect
this case.

---
Takanori Kawano
Hitachi Ltd,
Internet Systems Platform Division
t-kawano@ebina.hitachi.co.jp




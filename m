Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbTHYKDk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 06:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbTHYKDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 06:03:40 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:41892 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S261586AbTHYKDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 06:03:36 -0400
To: <akpm@osdl.org>
Subject: [PATCH 2.6.0-test2] security fixes
From: <ffrederick@prov-liege.be>
Cc: <linux-kernel@vger.kernel.org>
Date: Mon, 25 Aug 2003 12:28:30 CEST
Reply-To: <ffrederick@prov-liege.be>
X-Priority: 3 (Normal)
X-Originating-Ip: [10.10.0.30]
X-Mailer: NOCC v0.9.5
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <S261586AbTHYKDg/20030825100336Z+189147@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
             Here's a patch against 2.6.0-test2 security :
Summary:
 	-Adding some doc to enough_memory proc
	-Reordering checks (overcommit_memory is _rare_ case)

	Could you apply ?

Regards,
Fabian

diff -Naur orig/security/capability.c edited/security/capability.c
--- orig/security/capability.c	2003-07-27 17:00:30.000000000 +0000
+++ edited/security/capability.c	2003-08-16 10:31:33.000000000 +0000
@@ -295,12 +295,7 @@
 
 	vm_acct_memory(pages);
 
-        /*
-	 * Sometimes we want to use more memory than we have
-	 */
-	if (sysctl_overcommit_memory == 1)
-		return 0;
-
+	/* We estimate memory ourselves (major cases)*/
 	if (sysctl_overcommit_memory == 0) {
 		free = get_page_cache_size();
 		free += nr_free_pages();
@@ -322,10 +317,16 @@
 
 		if (free > pages)
 			return 0;
+
 		vm_unacct_memory(pages);
 		return -ENOMEM;
 	}
 
+	/* Kernel assumes allocation */
+	if (sysctl_overcommit_memory == 1)
+		return 0;
+	
+	/* sysctl_overcommit_memory must be 2 which means strict_overcommit*/
 	allowed = totalram_pages * sysctl_overcommit_ratio / 100;
 	allowed += total_swap_pages;
 


___________________________________




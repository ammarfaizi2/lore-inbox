Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbUEQOeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbUEQOeY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 10:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUEQOeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 10:34:23 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:11188 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261443AbUEQOeU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 10:34:20 -0400
Subject: [PATCH][SELINUX] Fix error handling in selinuxfs
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Karl MacMillan <kmacmillan@tresys.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1084804438.27531.109.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 17 May 2004 10:33:58 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch against 2.6.6 fixes error handling for two out-of-memory
conditions in selinuxfs, avoiding potential deadlock due to returning
without releasing a semaphore.  The patch was submitted by Karl
MacMillan of Tresys.  Please apply.

 security/selinux/selinuxfs.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

Index: linux-2.6/security/selinux/selinuxfs.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/selinuxfs.c,v
retrieving revision 1.43
diff -u -r1.43 selinuxfs.c
--- linux-2.6/security/selinux/selinuxfs.c	20 Apr 2004 15:40:22 -0000	1.43
+++ linux-2.6/security/selinux/selinuxfs.c	17 May 2004 14:11:03 -0000
@@ -833,8 +833,10 @@
 		goto out;
 	}
 	page = (char*)__get_free_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
+	if (!page) {
+		length = -ENOMEM;
+		goto out;
+	}
 	memset(page, 0, PAGE_SIZE);
 
 	if (copy_from_user(page, buf, count))
@@ -889,8 +891,10 @@
 		goto out;
 	}
 	page = (char*)__get_free_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
+	if (!page) {
+		length = -ENOMEM;
+		goto out;
+	}
 
 	memset(page, 0, PAGE_SIZE);
 


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


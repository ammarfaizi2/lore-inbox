Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275360AbTHNT1V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 15:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275367AbTHNT1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 15:27:21 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:60583 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S275360AbTHNT1U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 15:27:20 -0400
Subject: [PATCH] Fix SELinux avc_log_lock
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1060888961.13964.71.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Aug 2003 15:22:41 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.0-test3-bk fixes a bug in the SELinux access vector 
cache code, which was incorrectly using spin_lock_irq rather than 
spin_lock_irqsave for the avc_log_lock.  As this code can be called from 
hardirq (e.g. from the file_send_sigiotask hook), we need irqsave/restore here.

 security/selinux/avc.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

===== security/selinux/avc.c 1.2 vs edited =====
--- 1.2/security/selinux/avc.c	Sun Aug 10 07:09:44 2003
+++ edited/security/selinux/avc.c	Thu Aug 14 14:44:36 2003
@@ -507,6 +507,7 @@
 	struct inode *inode = NULL;
 	char *p;
 	u32 denied, audited;
+	unsigned long flags;
 
 	denied = requested & ~avd->allowed;
 	if (denied) {
@@ -525,7 +526,7 @@
 		return;
 
 	/* prevent overlapping printks */
-	spin_lock_irq(&avc_log_lock);
+	spin_lock_irqsave(&avc_log_lock,flags);
 
 	printk("%s\n", avc_level_string);
 	printk("%savc:  %s ", avc_level_string, denied ? "denied" : "granted");
@@ -674,7 +675,7 @@
 	avc_dump_query(ssid, tsid, tclass);
 	printk("\n");
 
-	spin_unlock_irq(&avc_log_lock);
+	spin_unlock_irqrestore(&avc_log_lock,flags);
 }
 
 /**



-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


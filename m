Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271120AbUJVCng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271120AbUJVCng (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 22:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271111AbUJVCl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 22:41:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:3015 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271170AbUJVBEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 21:04:54 -0400
Date: Thu, 21 Oct 2004 18:04:51 -0700
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3][LSM] reduce noise during security_register
Message-ID: <20041021180451.I2357@build.pdx.osdl.net>
References: <20041021180345.H2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041021180345.H2357@build.pdx.osdl.net>; from chrisw@osdl.org on Thu, Oct 21, 2004 at 06:03:45PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Registering a security module can be a noisy operation, esp. when it
retries registration with the primary module.  Eliminate some noise, and
distinguish the return values for register_security so a module can tell
the difference between failure modes.

Signed-off-by: Chris Wright <chrisw@osdl.org>

 security.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

--- linus-2.6/security/security.c~verbose	2004-10-21 16:50:30.844353688 -0700
+++ linus-2.6/security/security.c	2004-10-21 17:00:54.386560864 -0700
@@ -29,11 +29,8 @@
 static inline int verify (struct security_operations *ops)
 {
 	/* verify the security_operations structure exists */
-	if (!ops) {
-		printk (KERN_INFO "Passed a NULL security_operations "
-			"pointer, %s failed.\n", __FUNCTION__);
+	if (!ops)
 		return -EINVAL;
-	}
 	security_fixup_ops (ops);
 	return 0;
 }
@@ -85,16 +82,13 @@
 int register_security (struct security_operations *ops)
 {
 	if (verify (ops)) {
-		printk (KERN_INFO "%s could not verify "
+		printk(KERN_DEBUG "%s could not verify "
 			"security_operations structure.\n", __FUNCTION__);
 		return -EINVAL;
 	}
 
-	if (security_ops != &dummy_security_ops) {
-		printk (KERN_INFO "There is already a security "
-			"framework initialized, %s failed.\n", __FUNCTION__);
-		return -EINVAL;
-	}
+	if (security_ops != &dummy_security_ops)
+		return -EAGAIN;
 
 	security_ops = ops;
 


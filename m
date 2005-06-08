Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbVFHXwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVFHXwe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 19:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbVFHXwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 19:52:33 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:55255 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261541AbVFHXwH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 19:52:07 -0400
Date: Wed, 8 Jun 2005 18:56:42 -0500
From: serue@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>
Subject: [patch 1/11] lsm stacking: don't default to dummy_##hook
Message-ID: <20050608235642.GA27314@serge.austin.ibm.com>
References: <20050608235505.GA27298@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608235505.GA27298@serge.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When stacking multiple LSMs, we do not want hooks which are undefined to
be substituted with the dummy_##hook.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 security/security.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-2.6.12-rc6/security/security.c
===================================================================
--- linux-2.6.12-rc6.orig/security/security.c
+++ linux-2.6.12-rc6/security/security.c
@@ -81,15 +81,15 @@ int __init security_init(void)
  */
 int register_security(struct security_operations *ops)
 {
+	if (security_ops != &dummy_security_ops)
+		return -EAGAIN;
+
 	if (verify(ops)) {
 		printk(KERN_DEBUG "%s could not verify "
 		       "security_operations structure.\n", __FUNCTION__);
 		return -EINVAL;
 	}
 
-	if (security_ops != &dummy_security_ops)
-		return -EAGAIN;
-
 	security_ops = ops;
 
 	return 0;
@@ -134,9 +134,9 @@ int unregister_security(struct security_
  */
 int mod_reg_security(const char *name, struct security_operations *ops)
 {
-	if (verify(ops)) {
-		printk(KERN_INFO "%s could not verify "
-		       "security operations.\n", __FUNCTION__);
+	if (!ops) {
+		printk(KERN_INFO "%s received NULL security operations",
+						       __FUNCTION__);
 		return -EINVAL;
 	}
 

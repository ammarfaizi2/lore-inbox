Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263037AbVF3Tsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263037AbVF3Tsw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 15:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263035AbVF3Tr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 15:47:26 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:35794 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262987AbVF3TmL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 15:42:11 -0400
Date: Thu, 30 Jun 2005 14:48:06 -0500
From: serue@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gerrit@us.ibm.com>
Subject: [patch 1/12] lsm stacking v0.2: don't default to dummy_##hook
Message-ID: <20050630194806.GA23538@serge.austin.ibm.com>
References: <20050630194458.GA23439@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050630194458.GA23439@serge.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When stacking multiple LSMs, we do not want hooks which are undefined to
be substituted with the dummy_##hook.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 security.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-2.6.13-rc1/security/security.c
===================================================================
--- linux-2.6.13-rc1.orig/security/security.c	2005-06-30 14:02:59.000000000 -0500
+++ linux-2.6.13-rc1/security/security.c	2005-06-30 14:03:54.000000000 -0500
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
 

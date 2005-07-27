Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVG0SZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVG0SZN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 14:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbVG0SXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 14:23:08 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:27311 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261328AbVG0SVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 14:21:22 -0400
Date: Wed, 27 Jul 2005 13:21:46 -0500
From: serue@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Emily Ratliff <emilyr@us.ibm.com>
Subject: [patch 3/15] lsm stacking v0.3: don't default to dummy_##hook
Message-ID: <20050727182146.GD22483@serge.austin.ibm.com>
References: <20050727181732.GA22483@serge.austin.ibm.com> <20050727181921.GB22483@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050727181921.GB22483@serge.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When stacking multiple LSMs, we do not want hooks which are undefined to
be substituted with the dummy_##hook.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
--
 security.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-2.6.13-rc3/security/security.c
===================================================================
--- linux-2.6.13-rc3.orig/security/security.c	2005-07-18 15:49:52.000000000 -0500
+++ linux-2.6.13-rc3/security/security.c	2005-07-18 15:51:40.000000000 -0500
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
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbVCUUIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbVCUUIx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 15:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVCUUIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 15:08:53 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:29628 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S261843AbVCUUHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:07:16 -0500
Subject: [PATCH][SELINUX] Audit unrecognized netlink messages
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Mon, 21 Mar 2005 14:59:24 -0500
Message-Id: <1111435164.13101.59.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes SELinux to audit any unrecognized netlink messages
in controlled classes rather than silently rejecting them, and to
allow them if in permissive mode.  Please apply.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by:  James Morris <jmorris@redhat.com>

 security/selinux/hooks.c |   10 ++++++++++
 1 files changed, 10 insertions(+)
 
Index: linux-2.6/security/selinux/hooks.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/hooks.c,v
retrieving revision 1.158
diff -u -p -r1.158 hooks.c
--- linux-2.6/security/selinux/hooks.c	21 Mar 2005 15:56:37 -0000	1.158
+++ linux-2.6/security/selinux/hooks.c	21 Mar 2005 16:24:06 -0000
@@ -67,6 +67,7 @@
 #include <linux/hugetlb.h>
 #include <linux/personality.h>
 #include <linux/sysctl.h>
+#include <linux/audit.h>
 
 #include "avc.h"
 #include "objsec.h"
@@ -3377,6 +3378,15 @@ static int selinux_nlmsg_perm(struct soc
 	
 	err = selinux_nlmsg_lookup(isec->sclass, nlh->nlmsg_type, &perm);
 	if (err) {
+		if (err == -EINVAL) {
+			audit_log(current->audit_context,
+				  "SELinux:  unrecognized netlink message"
+				  " type=%hu for sclass=%hu\n",
+				  nlh->nlmsg_type, isec->sclass);
+			if (!selinux_enforcing)
+				err = 0;
+		}
+
 		/* Ignore */
 		if (err == -ENOENT)
 			err = 0;


-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263129AbUDTPLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbUDTPLw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 11:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262800AbUDTPLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 11:11:52 -0400
Received: from [144.51.25.10] ([144.51.25.10]:51872 "EHLO epoch.ncsc.mil")
	by vger.kernel.org with ESMTP id S263129AbUDTPLt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 11:11:49 -0400
Subject: [PATCH][SELINUX] Change context_to_sid handling for no-policy case
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>, selinux@tycho.nsa.gov
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1082473877.7481.37.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 20 Apr 2004 11:11:17 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.6-rc1-mm1 changes the behavior of
security_context_to_sid in the no-policy case so that it simply accepts
all contexts and maps them to the kernel SID rather than rejecting
anything other than an initial SID.  The change avoids error conditions
when using SELinux in permissive/no-policy mode, so that any file
contexts left on disk from prior use of SELinux with a policy will not
cause an error when they are looked up and userspace attempts to set
contexts can succeed.  Please apply.

 security/selinux/ss/services.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

diff -X /home/sds/dontdiff -ru linux-2.6.old/security/selinux/ss/services.c linux-2.6/security/selinux/ss/services.c
--- linux-2.6.old/security/selinux/ss/services.c	2004-04-20 09:37:45.000000000 -0400
+++ linux-2.6/security/selinux/ss/services.c	2004-04-20 09:53:02.834624857 -0400
@@ -456,9 +456,7 @@
 				goto out;
 			}
 		}
-		printk(KERN_ERR "security_context_to_sid: called before "
-		       "initial load_policy on unknown context %s\n", scontext);
-		rc = -EINVAL;
+		*sid = SECINITSID_KERNEL;
 		goto out;
 	}
 	*sid = SECSID_NULL;


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


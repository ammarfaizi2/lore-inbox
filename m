Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270008AbUJHPVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270008AbUJHPVD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 11:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270014AbUJHPVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 11:21:02 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:11226 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S270008AbUJHPUu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 11:20:50 -0400
Subject: [PATCH][SELINUX] Retain ptracer SID across fork
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>, selinux@tycho.nsa.gov
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1097248647.16641.123.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 08 Oct 2004 11:17:27 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.9-rc3-mm3 fixes a bug in SELinux to retain the
ptracer SID (if any) across fork.  Otherwise, SELinux will always deny
attempts by traced children to exec domain-changing programs even if the
policy would have allowed the tracer to trace the new domains as well. 
Please apply.

Signed-off-by: Stephen Smalley <sds@epoch.ncsc.mil>
Signed-off-by: James Morris <jmorris@redhat.com>

 security/selinux/hooks.c |    5 +++++
 1 files changed, 5 insertions(+)

diff -X /home/sds/dontdiff -rup linux-2.6.9-rc3-mm3/security/selinux/hooks.c linux-2.6.9-rc3-mm3-ptrace/security/selinux/hooks.c
--- linux-2.6.9-rc3-mm3/security/selinux/hooks.c	2004-10-08 09:16:48.000000000 -0400
+++ linux-2.6.9-rc3-mm3-ptrace/security/selinux/hooks.c	2004-10-08 09:44:51.705623352 -0400
@@ -2622,6 +2622,11 @@ static int selinux_task_alloc_security(s
 	tsec2->exec_sid = tsec1->exec_sid;
 	tsec2->create_sid = tsec1->create_sid;
 
+	/* Retain ptracer SID across fork, if any.
+	   This will be reset by the ptrace hook upon any 
+	   subsequent ptrace_attach operations. */
+	tsec2->ptrace_sid = tsec1->ptrace_sid;
+
 	return 0;
 }
 

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


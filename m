Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUFANLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUFANLS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 09:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265031AbUFANLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 09:11:18 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:23452 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S265035AbUFANK5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 09:10:57 -0400
Subject: [PATCH][SELINUX] Check processed security context length
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>, selinux@tycho.nsa.gov
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1086095432.13325.39.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 01 Jun 2004 09:10:32 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.7-rc2 changes security_context_to_sid to check the length of the
processed security context against the full length of the provided
context, rejecting any further data.  Please apply.

 security/selinux/ss/mls.c      |    2 +-
 security/selinux/ss/services.c |    5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

Signed-off-by:  Stephen Smalley <sds@epoch.ncsc.mil>

Index: linux-2.6/security/selinux/ss/services.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/ss/services.c,v
retrieving revision 1.42
diff -u -p -r1.42 services.c
--- linux-2.6/security/selinux/ss/services.c	10 May 2004 13:01:09 -0000	1.42
+++ linux-2.6/security/selinux/ss/services.c	28 May 2004 12:10:33 -0000
@@ -532,6 +532,11 @@ int security_context_to_sid(char *sconte
 	if (rc)
 		goto out_unlock;
 
+	if ((p - scontext2) < scontext_len) {
+		rc = -EINVAL;
+		goto out_unlock;
+	}
+
 	/* Check the validity of the new context. */
 	if (!policydb_context_isvalid(&policydb, &context)) {
 		rc = -EINVAL;

Index: linux-2.6/security/selinux/ss/mls.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/ss/mls.c,v
retrieving revision 1.18
diff -u -p -r1.18 mls.c
--- linux-2.6/security/selinux/ss/mls.c	28 Oct 2003 14:08:27 -0000	1.18
+++ linux-2.6/security/selinux/ss/mls.c	28 May 2004 18:36:51 -0000
@@ -290,7 +290,7 @@ int mls_context_to_sid(char oldc,
 		if (rc)
 			goto out;
 	}
-	*scontext = p;
+	*scontext = ++p;
 	rc = 0;
 out:
 	return rc;


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


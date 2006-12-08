Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1426177AbWLHTjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1426177AbWLHTjL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 14:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426175AbWLHTjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 14:39:10 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:59198 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1426170AbWLHTjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 14:39:05 -0500
Date: Fri, 8 Dec 2006 13:39:03 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux-security-module@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>
Subject: [PATCH 2/2] file capabilities: honor !SECURE_NOROOT
Message-ID: <20061208193903.GD18566@sergelap.austin.ibm.com>
References: <20061208193657.GB18566@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061208193657.GB18566@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge E. Hallyn <serue@us.ibm.com>
Subject: [PATCH 2/2] file capabilities: honor !SECURE_NOROOT

When the SECURE_NOROOT securebit is not set, allow root to
keep it's capabilities over exec, rather than compute the
capabilities based on file capabilities.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 security/commoncap.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index fde9695..be86acb 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -202,12 +202,16 @@ #endif
 
 int cap_bprm_set_security (struct linux_binprm *bprm)
 {
+	int ret;
+
 	/* Copied from fs/exec.c:prepare_binprm. */
 
 	cap_clear (bprm->cap_inheritable);
 	cap_clear (bprm->cap_permitted);
 	cap_clear (bprm->cap_effective);
 
+	ret = set_file_caps(bprm);
+
 	/*  To support inheritance of root-permissions and suid-root
 	 *  executables under compatibility mode, we raise all three
 	 *  capability sets for the file.
@@ -225,7 +229,7 @@ int cap_bprm_set_security (struct linux_
 			cap_set_full (bprm->cap_effective);
 	}
 
-	return set_file_caps(bprm);
+	return ret;
 }
 
 void cap_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
-- 
1.4.1


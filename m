Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266458AbUG0Q3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266458AbUG0Q3j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 12:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266460AbUG0Q2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 12:28:04 -0400
Received: from [144.51.25.10] ([144.51.25.10]:21447 "EHLO epoch.ncsc.mil")
	by vger.kernel.org with ESMTP id S266458AbUG0QX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 12:23:59 -0400
Subject: [patch][selinux] Fix clearing of new personality bit on security
	transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1090945303.2448.161.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 27 Jul 2004 12:21:43 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.8-rc2-bk6 moves the clearing of the new
personality bit from selinux_bprm_apply_creds (called from
compute_creds) to selinux_bprm_set_security (called from
prepare_binprm).  This ensures that the bit is cleared at the same point
in exec processing as for setuid/setgid binaries, prior to setting up
the new image.  Please apply.

Signed-off-by:  Stephen Smalley <sds@epoch.ncsc.mil>

 security/selinux/hooks.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.7/security/selinux/hooks.c.orig	2004-07-27 11:42:12.347833384 -0400
+++ linux-2.6.7/security/selinux/hooks.c	2004-07-27 11:43:12.748651064 -0400
@@ -1685,6 +1685,9 @@ static int selinux_bprm_set_security(str
 		if (rc)
 			return rc;
 
+		/* Clear any possibly unsafe personality bits on exec: */
+		current->personality &= ~PER_CLEAR_ON_SETID;
+
 		/* Set the security field to the new SID. */
 		bsec->sid = newsid;
 	}
@@ -1895,9 +1898,6 @@ static void selinux_bprm_apply_creds(str
 			task_unlock(current);
 		}
 
-		/* Clear any possibly unsafe personality bits on exec: */
-		current->personality &= ~PER_CLEAR_ON_SETID;
-
 		/* Close files for which the new task SID is not authorized. */
 		flush_unauthorized_files(current->files);
 

 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


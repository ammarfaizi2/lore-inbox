Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262032AbVBAPAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbVBAPAB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 10:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbVBAPAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 10:00:01 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:29410 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S262032AbVBAO7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 09:59:35 -0500
Subject: [PATCH][SELINUX] Audit any unmapped permissions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1107269563.26936.137.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 01 Feb 2005 09:52:43 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.11-rc2-mm2 changes SELinux to display any
permission values that could not be mapped to names as a hex value when
generating an audit message.  Please apply.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by:  James Morris <jmorris@redhat.com>

 security/selinux/avc.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

Index: linux-2.6/security/selinux/avc.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/avc.c,v
retrieving revision 1.50
diff -u -p -r1.50 avc.c
--- linux-2.6/security/selinux/avc.c	10 Dec 2004 17:16:30 -0000	1.50
+++ linux-2.6/security/selinux/avc.c	1 Feb 2005 12:50:14 -0000
@@ -162,8 +162,10 @@ void avc_dump_av(struct audit_buffer *ab
 	i = 0;
 	perm = 1;
 	while (perm < common_base) {
-		if (perm & av)
+		if (perm & av) {
 			audit_log_format(ab, " %s", common_pts[i]);
+			av &= ~perm;
+		}
 		i++;
 		perm <<= 1;
 	}
@@ -175,14 +177,19 @@ void avc_dump_av(struct audit_buffer *ab
 				    (av_perm_to_string[i2].value == perm))
 					break;
 			}
-			if (i2 < ARRAY_SIZE(av_perm_to_string))
+			if (i2 < ARRAY_SIZE(av_perm_to_string)) {
 				audit_log_format(ab, " %s",
 						 av_perm_to_string[i2].name);
+				av &= ~perm;
+			}
 		}
 		i++;
 		perm <<= 1;
 	}
 
+	if (av)
+		audit_log_format(ab, " 0x%x", av);
+
 	audit_log_format(ab, " }");
 }
 

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


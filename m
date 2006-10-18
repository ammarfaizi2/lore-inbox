Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161227AbWJRQhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161227AbWJRQhL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161234AbWJRQhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:37:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:61156 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161227AbWJRQhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:37:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:message-id;
        b=qoklmqGv29S17eJu5gsSSLal2SpMHzFoVEp06jckMrDbN0tTyYC4FPnM3MkqwmM/BGhLmeW+VbqCiwvwCE3JRXjAyCeiHoH2EPoMdHvCztaUQ3OkQXVaDJ4QkjvyhZ76baaZxBFVEFsUX49KTGgLgoRwk38Ef9S604BFM+5nPrs=
From: James Lamanna <jlamanna@gmail.com>
To: linux-kernel@vger.kernel.org, Joerg.Schilling@fokus.fraunhofer.de,
       ismail@pardus.org.tr
Subject: [PATCH] Support ISO-9660 RockRidge v. 1.12 V2
Date: Wed, 18 Oct 2006 09:36:53 -0700 (PDT)
Message-ID: <45365825.05759a90.7d7c.ffffe441@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Joerg Schilling pointed out that RockRidge v. 1.12 extends the PX entry.
This patch stores the inode number that is now included.
He has also mentioned 'implementing support for new inode features' wrt to a
mkisofs fingerprint. Perhaps that will come at a later date.
Regardless, that can be built on this patch since now the inode number gets
stored.

This patch has been tested against mounting an ISO-9660 image in
loopback that supports RockRidge v. 1.12 (thank you to Joerg for a beta 
of mkisofs that does this).
This should apply against the latest git.

--- 
Add support of RockRidge v. 1.12.
RockRidge v. 1.12 adds an inode number field to the PX entry, so we might as
well store it too.

Signed-off-by: James Lamanna <jlamanna@gmail.com>
---
diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
index f3a1db3..241d8b6 100644
--- a/fs/isofs/rock.c
+++ b/fs/isofs/rock.c
@@ -4,6 +4,9 @@
  *  (C) 1992, 1993  Eric Youngdale
  *
  *  Rock Ridge Extensions to iso9660
+ * 
+ *  James Lamanna              : Support v. 1.12 PX Entry
+ *  (jlamanna@gmail.com)       : 17th Oct 2006
  */
 
 #include <linux/slab.h>
@@ -148,8 +151,14 @@ static int rock_check_overflow(struct ro
 		len = sizeof(struct RR_RR_s);
 		break;
 	case SIG('P', 'X'):
-		len = sizeof(struct RR_PX_s);
+	{
+		struct rock_ridge *rr = (struct rock_ridge *)rs->chr;
+		if (rr->len == PX_112_LEN)
+			len = sizeof(struct RR_PX_112_s);
+		else
+			len = sizeof(struct RR_PX_s);
 		break;
+	}
 	case SIG('P', 'N'):
 		len = sizeof(struct RR_PN_s);
 		break;
@@ -349,6 +358,9 @@ #endif
 			inode->i_nlink = isonum_733(rr->u.PX.n_links);
 			inode->i_uid = isonum_733(rr->u.PX.uid);
 			inode->i_gid = isonum_733(rr->u.PX.gid);
+
+			if (rr->len == PX_112_LEN)
+				inode->i_ino = isonum_733(rr->u.PX_112.ino);
 			break;
 		case SIG('P', 'N'):
 			{
diff --git a/fs/isofs/rock.h b/fs/isofs/rock.h
index ed09e2b..4b5c721 100644
--- a/fs/isofs/rock.h
+++ b/fs/isofs/rock.h
@@ -35,6 +35,16 @@ struct RR_PX_s {
 	char gid[8];
 };
 
+/* RR 1.12 extends the PX entry with a POSIX File Serial Number */
+#define PX_112_LEN (sizeof(struct RR_PX_112_s) + offsetof(struct rock_ridge, u))
+struct RR_PX_112_s {
+	char mode[8];
+	char n_links[8];
+	char uid[8];
+	char gid[8];
+	char ino[8];
+};
+
 struct RR_PN_s {
 	char dev_high[8];
 	char dev_low[8];
@@ -102,6 +112,7 @@ struct rock_ridge {
 		struct SU_ER_s ER;
 		struct RR_RR_s RR;
 		struct RR_PX_s PX;
+		struct RR_PX_112_s PX_112;
 		struct RR_PN_s PN;
 		struct RR_SL_s SL;
 		struct RR_NM_s NM;

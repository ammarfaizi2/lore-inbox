Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264280AbUDNRM7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 13:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264298AbUDNRM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 13:12:59 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:50098 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264280AbUDNRMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 13:12:41 -0400
Date: Wed, 14 Apr 2004 18:11:47 +0100
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, petrides@redhat.com
Subject: [SECURITY] CAN-2004-0109 isofs fix.
Message-ID: <20040414171147.GB23419@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, petrides@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Merged in 2.4, and various vendor kernels today..

  iDefense reported a buffer overflow flaw in the ISO9660 filesystem code.
  An attacker could create a malicious filesystem in such a way that they
  could gain root privileges if that filesystem is mounted. The Common
  Vulnerabilities and Exposures project (cve.mitre.org) has assigned the name
  CAN-2004-0109 to this issue.

Ernie Petrides came up with the following patch which I fixed up a slight
reject in to apply to 2.6. Otherwise, unchanged from the 2.4 patch.

diff against bk-HEAD from a few minutes ago.

		Dave

--- linux/fs/isofs/rock.c.orig
+++ linux/fs/isofs/rock.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
+#include <asm/page.h>
 
 #include "rock.h"
@@ -419,7 +420,7 @@ int parse_rock_ridge_inode_internal(stru
   return 0;
 }
 
-static char *get_symlink_chunk(char *rpnt, struct rock_ridge *rr)
+static char *get_symlink_chunk(char *rpnt, struct rock_ridge *rr, char *plimit)
 {
 	int slen;
 	int rootflag;
@@ -431,16 +432,25 @@ static char *get_symlink_chunk(char *rpn
 		rootflag = 0;
 		switch (slp->flags & ~1) {
 		case 0:
+			if (slp->len > plimit - rpnt)
+				return NULL;
 			memcpy(rpnt, slp->text, slp->len);
 			rpnt+=slp->len;
 			break;
+		case 2:
+			if (rpnt >= plimit)
+				return NULL;
+			*rpnt++='.';
+			break;
 		case 4:
+			if (2 > plimit - rpnt)
+				return NULL;
 			*rpnt++='.';
-			/* fallthru */
-		case 2:
 			*rpnt++='.';
 			break;
 		case 8:
+			if (rpnt >= plimit)
+				return NULL;
 			rootflag = 1;
 			*rpnt++='/';
 			break;
@@ -457,17 +467,23 @@ static char *get_symlink_chunk(char *rpn
 			 * If there is another SL record, and this component
 			 * record isn't continued, then add a slash.
 			 */
-			if ((!rootflag) && (rr->u.SL.flags & 1) && !(oldslp->flags & 1))
+			if ((!rootflag) && (rr->u.SL.flags & 1) &&
+			    !(oldslp->flags & 1)) {
+				if (rpnt >= plimit)
+					return NULL;
 				*rpnt++='/';
+			}
 			break;
 		}
 
 		/*
 		 * If this component record isn't continued, then append a '/'.
 		 */
-		if (!rootflag && !(oldslp->flags & 1))
+		if (!rootflag && !(oldslp->flags & 1)) {
+			if (rpnt >= plimit)
+				return NULL;
 			*rpnt++='/';
-
+		}
 	}
 	return rpnt;
 }
@@ -548,7 +564,10 @@ static int rock_ridge_symlink_readpage(s
 			CHECK_SP(goto out);
 			break;
 		case SIG('S', 'L'):
-			rpnt = get_symlink_chunk(rpnt, rr);
+			rpnt = get_symlink_chunk(rpnt, rr,
+						 link + (PAGE_SIZE - 1));
+			if (rpnt == NULL)
+				goto out;
 			break;
 		case SIG('C', 'E'):
 			/* This tells is if there is a continuation record */


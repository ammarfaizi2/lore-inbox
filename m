Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWJQSiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWJQSiG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 14:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWJQSiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 14:38:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:42468 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751398AbWJQShf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 14:37:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:in-reply-to:date:message-id;
        b=nULLV3K1wraJYgNg1A8GerV8z9fLMrj2ixOA+zJfzDnz9HLBitx49GPxSyl2oMhF5rmilVFAqXhIs6WHr/2Jsb9AQwVAEmA6A368kkk4Dbmjbr5LSvMG+eOn2czPgz2cpFB5TfEUuGFnalQTIHXUcd4lMjC6kgsREVseFy4CT/s=
From: James Lamanna <jlamanna@gmail.com>
To: linux-kernel@vger.kernel.org, schilling@fokus.fraunhofer.de
Subject: Re: Linux ISO-9660 Rock Ridge bug needs fix
In-Reply-To: <200610171445.k9HEji8R018455@burner.fokus.fraunhofer.de>
Date: Tue, 17 Oct 2006 11:37:33 -0700 (PDT)
Message-ID: <453522ed.1a57ae7d.6b06.5d31@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Joerg Schilling wrote:
> Hi,
> 
> while working on better ISO-9660 support for the Solaris Kernel,
> I recently enhanced mkisofs to support the Rock Ridge Standard version 1.12
> from 1994.
> 
> The difference bewteen version 1.12 and 1.10 (this is what previous
> mkisofs versions did implement) is that the "PX" field is now 8 Byte
> bigger than before (44 instead of 36 bytes).
> 
> As Rock Ridge is a protocol that implements a list of size tagged fields,
> this change in mkisofs should not be a problem and in fact is not for Solaris
> or FreeBSD. As Linux does not implement Rock Rige correctly, Linux will
> reject CDs/DVDs that have been created by a recent mkisofs.
> 
> As Linux will completely disable RR because of this bug, it must be called
> a showstopper bug that needs immediate fixing and that also needs to be 
> backported.

Hi Joerg,

It looks like Linux would definitely have an issue with field sizes changing 
because it does an overflow calculation (see rock_check_overflow()) 
based on struct sizes.
Have you seen the error that Linux generates? If so please post it. I'm
assuming its probably something along the lines of:
"rock: directory entry would overflow storage...."

I've attached a patch that may fix the problem for now. 
This is only compile-tested, not run tested or tested against any 
RockRidge 1.12 images yet. Unfortunately I'm not by any machines with any 
flavor of linux or cdrecord that actually have a CD burner I can test this on.

As I am not any sort of ISOFS maintainer by any stretch of the imagination all
review is welcome.

Thanks.

-- James Lamanna

Add a PX entry structure that includes the File Serial Number field per
RockRidge version 1.12.

Signed-off-by: James Lamanna <jlamanna@gmail.com>
---
diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
index f3a1db3..48be069 100644
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
+				inode->i_ino = isonum_733(rr->u.PX_112.serial);
 			break;
 		case SIG('P', 'N'):
 			{
diff --git a/fs/isofs/rock.h b/fs/isofs/rock.h
index ed09e2b..fc4478f 100644
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
+	char serial[8];
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

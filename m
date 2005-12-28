Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbVL1RNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbVL1RNj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 12:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbVL1RNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 12:13:39 -0500
Received: from xproxy.gmail.com ([66.249.82.207]:42761 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932540AbVL1RNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 12:13:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=hv5yXLKsOf8QefpSBaEINXca68ECcax5jSnCRIu7phcok4WAbqyOM2ybwHQ5X7H7DPg5k963Qr74iEFww//9Vr+oIC4RRMGpqtAw9p1UYWl7494lcjcmT9HlOrstheSONCckGdXx+5rBrLe0zGCyrslHXwGzSYpPoSdmF6PMwfs=
Message-ID: <82e4877d0512280913s66a43d4ida9eda3640520c1@mail.gmail.com>
Date: Wed, 28 Dec 2005 12:13:37 -0500
From: Parag Warudkar <parag.warudkar@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.15-rc7] udf/balloc.c : Fix use of uninitialized data
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_50419_29127110.1135790017586"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_50419_29127110.1135790017586
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

2.6.15-rc7 - GCC warns correctly -
 fs/udf/balloc.c: In function 'udf_table_new_block':
 fs/udf/balloc.c:757: warning: 'goal_eloc.logicalBlockNum' may be used
uninitialized in this function

Variable goal_eloc is automatic, non-static and initialized conditionally -

 if (nspread < spread)
 {
     ...........
     goal_eloc =3D eloc;
     ...........
 }

 The following patch fixes this by initializing the goal_eloc variable to z=
ero.
Hopefully zero should be better than some random data! (Patch also
attached in case of problem with below inline version.) Compile
tested.

--- linux-2.6/fs/udf/balloc.c.orig      2005-12-28 11:53:12.000000000 -0500
+++ linux-2.6/fs/udf/balloc.c   2005-12-28 11:53:19.000000000 -0500
@@ -754,7 +754,8 @@ static int udf_table_new_block(struct su
        uint32_t spread =3D 0xFFFFFFFF, nspread =3D 0xFFFFFFFF;
        uint32_t newblock =3D 0, adsize;
        uint32_t extoffset, goal_extoffset, elen, goal_elen =3D 0;
-       kernel_lb_addr bloc, goal_bloc, eloc, goal_eloc;
+       kernel_lb_addr bloc, goal_bloc, eloc,
+       goal_eloc =3D { .logicalBlockNum=3D0, .partitionReferenceNum=3D0 } =
;
        struct buffer_head *bh, *goal_bh;
        int8_t etype;

------=_Part_50419_29127110.1135790017586
Content-Type: application/octet-stream; name=patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch"

--- linux-2.6/fs/udf/balloc.c.orig	2005-12-28 11:53:12.000000000 -0500
+++ linux-2.6/fs/udf/balloc.c	2005-12-28 11:53:19.000000000 -0500
@@ -754,7 +754,8 @@ static int udf_table_new_block(struct su
 	uint32_t spread = 0xFFFFFFFF, nspread = 0xFFFFFFFF;
 	uint32_t newblock = 0, adsize;
 	uint32_t extoffset, goal_extoffset, elen, goal_elen = 0;
-	kernel_lb_addr bloc, goal_bloc, eloc, goal_eloc;
+	kernel_lb_addr bloc, goal_bloc, eloc, 
+	goal_eloc = { .logicalBlockNum=0, .partitionReferenceNum=0 } ;
 	struct buffer_head *bh, *goal_bh;
 	int8_t etype;
 

------=_Part_50419_29127110.1135790017586--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133064AbRDRJVi>; Wed, 18 Apr 2001 05:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133065AbRDRJV3>; Wed, 18 Apr 2001 05:21:29 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:57000 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S133064AbRDRJVR>; Wed, 18 Apr 2001 05:21:17 -0400
Date: Tue, 17 Apr 2001 23:00:59 -0700
From: Scott Maxwell <maxwell@ScottMaxwell.org>
Subject: [PATCH] SysV IPC loop speedups, kernel 2.4.3
To: linux-kernel@vger.kernel.org
Cc: manfreds@colorfullife.com
Message-id: <3ADD2D9B.75927E9C@ScottMaxwell.org>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.12-20 i686)
Content-type: multipart/mixed; boundary="------------1823B5F00D0D214EF46A04BE"
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1823B5F00D0D214EF46A04BE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This patch contains a couple of micro-optimizations for the loops in
ipc/msg.c's load_msg() and store_msg().  It works fine for me under
2.4.3.

-- 
-------------------------+--------------------------------------------
R H L U  Scott Maxwell:  | ``Life results from the non-random survival
E A I X     maxwell@     |   of randomly varying replicators.''
D T N 6 ScottMaxwell.org |     -- Richard Dawkins
--------------1823B5F00D0D214EF46A04BE
Content-Type: text/plain; charset=us-ascii;
 name="ipc-msg-loop.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipc-msg-loop.patch"

diff -urN linux-2.4.3/ipc/msg.c linux/ipc/msg.c
--- linux-2.4.3/ipc/msg.c	Mon Feb 19 10:18:18 2001
+++ linux/ipc/msg.c	Tue Apr 17 22:34:36 2001
@@ -177,28 +177,30 @@
 		goto out_err;
 	}
 
-	len -= alen;
-	src = ((char*)src)+alen;
-	pseg = &msg->next;
-	while(len > 0) {
-		struct msg_msgseg* seg;
-		alen = len;
-		if(alen > DATALEN_SEG)
-			alen = DATALEN_SEG;
-		seg = (struct msg_msgseg *) kmalloc (sizeof(*seg) + alen, GFP_KERNEL);
-		if(seg==NULL) {
-			err=-ENOMEM;
-			goto out_err;
-		}
-		*pseg = seg;
-		seg->next = NULL;
-		if(copy_from_user (seg+1, src, alen)) {
-			err = -EFAULT;
-			goto out_err;
+	if (len > DATALEN_MSG) {
+		pseg = &msg->next;
+		while(len > alen) {
+			struct msg_msgseg* seg;
+
+			len -= alen;
+			src = ((char*)src)+alen;
+
+			alen = len;
+			if(alen > DATALEN_SEG)
+				alen = DATALEN_SEG;
+			seg = (struct msg_msgseg *) kmalloc (sizeof(*seg) + alen, GFP_KERNEL);
+			if(seg==NULL) {
+				err=-ENOMEM;
+				goto out_err;
+			}
+			*pseg = seg;
+			seg->next = NULL;
+			if(copy_from_user (seg+1, src, alen)) {
+				err = -EFAULT;
+				goto out_err;
+			}
+			pseg = &seg->next;
 		}
-		pseg = &seg->next;
-		len -= alen;
-		src = ((char*)src)+alen;
 	}
 	return msg;
 
@@ -218,18 +220,20 @@
 	if(copy_to_user (dest, msg+1, alen))
 		return -1;
 
-	len -= alen;
-	dest = ((char*)dest)+alen;
-	seg = msg->next;
-	while(len > 0) {
-		alen = len;
-		if(alen > DATALEN_SEG)
-			alen = DATALEN_SEG;
-		if(copy_to_user (dest, seg+1, alen))
-			return -1;
-		len -= alen;
-		dest = ((char*)dest)+alen;
-		seg=seg->next;
+	if (len > DATALEN_MSG) {
+		seg = msg->next;
+		while(len > alen) {
+			len -= alen;
+			dest = ((char*)dest)+alen;
+
+			alen = len;
+			if(alen > DATALEN_SEG)
+				alen = DATALEN_SEG;
+			if(copy_to_user (dest, seg+1, alen))
+				return -1;
+
+			seg=seg->next;
+		}
 	}
 	return 0;
 }

--------------1823B5F00D0D214EF46A04BE--


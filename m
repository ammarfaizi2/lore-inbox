Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284067AbRLALY2>; Sat, 1 Dec 2001 06:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281562AbRLALYV>; Sat, 1 Dec 2001 06:24:21 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:53646 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S280203AbRLALYH>; Sat, 1 Dec 2001 06:24:07 -0500
Date: Sat, 1 Dec 2001 13:28:56 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: <sct@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] JBD code path (kfree cleanup)
Message-ID: <Pine.LNX.4.33.0112011324370.11026-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The intent of this patch is to remove unecessary if (foo) kfree(foo)
checks and also a slight change in the code path. This is a small part of
my i-spent-friday-night-at-home-grepping-for-kfree patch to cleanup kfree
usage.

Please comment on the code path change, it seems sane to me.

Regards,
	Zwane Mwaikambo

diffed against 2.5.1-pre4

diff -urN linux-2.5.1-pre4.orig/fs/jbd/commit.c linux-2.5.1-pre4.kfree/fs/jbd/commit.c
--- linux-2.5.1-pre4.orig/fs/jbd/commit.c	Sat Nov 10 00:25:04 2001
+++ linux-2.5.1-pre4.kfree/fs/jbd/commit.c	Fri Nov 30 23:08:58 2001
@@ -619,17 +619,15 @@
 		 *
 		 * Otherwise, we can just throw away the frozen data now.
 		 */
-		if (jh->b_committed_data) {
-			kfree(jh->b_committed_data);
-			jh->b_committed_data = NULL;
-			if (jh->b_frozen_data) {
-				jh->b_committed_data = jh->b_frozen_data;
-				jh->b_frozen_data = NULL;
-			}
-		} else if (jh->b_frozen_data) {
+		kfree(jh->b_committed_data);
+		jh->b_committed_data = NULL;
+
+		if (jh->b_frozen_data)
+			jh->b_committed_data = jh->b_frozen_data;
+		else
 			kfree(jh->b_frozen_data);
-			jh->b_frozen_data = NULL;
-		}
+
+		jh->b_frozen_data = NULL;

 		spin_lock(&journal_datalist_lock);
 		cp_transaction = jh->b_cp_transaction;
diff -urN linux-2.5.1-pre4.orig/fs/jbd/transaction.c linux-2.5.1-pre4.kfree/fs/jbd/transaction.c
--- linux-2.5.1-pre4.orig/fs/jbd/transaction.c	Sat Nov 10 00:25:04 2001
+++ linux-2.5.1-pre4.kfree/fs/jbd/transaction.c	Fri Nov 30 23:29:20 2001
@@ -739,8 +739,7 @@
 	journal_cancel_revoke(handle, jh);

 out_unlocked:
-	if (frozen_buffer)
-		kfree(frozen_buffer);
+	kfree(frozen_buffer);

 	JBUFFER_TRACE(jh, "exit");
 	return error;


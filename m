Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279754AbRKMWc6>; Tue, 13 Nov 2001 17:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279768AbRKMWcs>; Tue, 13 Nov 2001 17:32:48 -0500
Received: from maild.telia.com ([194.22.190.101]:24033 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S279749AbRKMWcf>;
	Tue, 13 Nov 2001 17:32:35 -0500
From: "Per Persson" <per.persson@gnosjo.pp.se>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] {double,triple}_down() in fs.h
Date: Tue, 13 Nov 2001 23:32:47 +0100
Message-ID: <NDBBJMOHILCIIKFHCBHAGEOECAAA.per.persson@gnosjo.pp.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This time I've read SubmittingPatches and tried to follow the rules,
especially the one saying that a patch shouldn't be sent as an attachment.

The code of triple_down() looked ugly and complicated, but I found that it
just sorted the semaphores and down()ed them. So I rewrote the code making
it simpler and more efficient.

The patch was made w.r.t 2.4.14.

Per Persson
per.persson@gnosjo.pp.se


--- include/linux/fs.h.orig	Mon Nov 12 01:14:10 2001
+++ include/linux/fs.h	Tue Nov 13 17:35:16 2001
@@ -1478,14 +1478,25 @@
 /*
  * Whee.. Deadlock country. Happily there are only two VFS
  * operations that does this..
+ *
+ * {double,triple}_down modified by Per Persson in September, 2001
  */
+
+#define exch(x,y)			\
+do {					\
+	typeof(x) __tmp__ = (x);	\
+	(x) = (y);			\
+	(y) = __tmp__;			\
+} while(0)
+
+#define sort(x,y)			\
+if((x) < (y))				\
+	exch((x), (y))
+
 static inline void double_down(struct semaphore *s1, struct semaphore *s2)
 {
-	if (s1 != s2) {
-		if ((unsigned long) s1 < (unsigned long) s2) {
-			struct semaphore *tmp = s2;
-			s2 = s1; s1 = tmp;
-		}
+	if (s1 != s2)
+		sort((ulong)s1, (ulong)s2);	// s1 > s2
 		down(s1);
 	}
 	down(s2);
@@ -1495,9 +1506,10 @@
  * Ewwwwwwww... _triple_ lock. We are guaranteed that the 3rd argument is
  * not equal to 1st and not equal to 2nd - the first case (target is parent
of
  * source) would be already caught, the second is plain impossible (target
is
- * its own parent and that case would be caught even earlier). Very messy.
- * I _think_ that it works, but no warranties - please, look it through.
- * Pox on bloody lusers who mandated overwriting rename() for
directories...
+ * its own parent and that case would be caught even earlier).
+ *
+ * Cleaner and more efficient code than the original.
+ *     /Per
  */

 static inline void triple_down(struct semaphore *s1,
@@ -1505,33 +1517,17 @@
 			       struct semaphore *s3)
 {
 	if (s1 != s2) {
-		if ((unsigned long) s1 < (unsigned long) s2) {
-			if ((unsigned long) s1 < (unsigned long) s3) {
-				struct semaphore *tmp = s3;
-				s3 = s1; s1 = tmp;
-			}
-			if ((unsigned long) s1 < (unsigned long) s2) {
-				struct semaphore *tmp = s2;
-				s2 = s1; s1 = tmp;
-			}
-		} else {
-			if ((unsigned long) s1 < (unsigned long) s3) {
-				struct semaphore *tmp = s3;
-				s3 = s1; s1 = tmp;
-			}
-			if ((unsigned long) s2 < (unsigned long) s3) {
-				struct semaphore *tmp = s3;
-				s3 = s2; s2 = tmp;
-			}
-		}
+		sort((ulong)s1, (ulong)s2);	// s1 > s2
+		sort((ulong)s1, (ulong)s3);	// s1 > s3
 		down(s1);
-	} else if ((unsigned long) s2 < (unsigned long) s3) {
-		struct semaphore *tmp = s3;
-		s3 = s2; s2 = tmp;
 	}
+	sort((ulong)s2, (ulong)s3);		// s2 > s3
 	down(s2);
 	down(s3);
 }
+
+#undef sort
+#undef exch

 static inline void double_up(struct semaphore *s1, struct semaphore *s2)
 {


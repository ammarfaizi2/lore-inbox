Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273928AbRIXOy1>; Mon, 24 Sep 2001 10:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273929AbRIXOyS>; Mon, 24 Sep 2001 10:54:18 -0400
Received: from mailf.telia.com ([194.22.194.25]:24537 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S273928AbRIXOyI>;
	Mon, 24 Sep 2001 10:54:08 -0400
From: "Per Persson" <per.persson@gnosjo.pp.se>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] triple_down in fs.h
Date: Mon, 24 Sep 2001 16:50:41 +0200
Message-ID: <NDBBJMOHILCIIKFHCBHAEEKGCAAA.per.persson@gnosjo.pp.se>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0000_01C14519.0BD39880"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01C14519.0BD39880
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Cleaned up some code.
Hope I didn't break anything.

[PATCH attached]

Per Persson
per.persson@gnosjo.pp.se

------=_NextPart_000_0000_01C14519.0BD39880
Content-Type: application/octet-stream;
	name="fs.h.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="fs.h.patch"

--- include/linux/fs.h.orig	Mon Sep 24 12:43:10 2001=0A=
+++ include/linux/fs.h	Mon Sep 24 16:37:39 2001=0A=
@@ -1441,14 +1441,22 @@=0A=
 /*=0A=
  * Whee.. Deadlock country. Happily there are only two VFS=0A=
  * operations that does this..=0A=
+ *=0A=
+ * {double,triple}_down modified by Per Persson in September, 2001=0A=
  */=0A=
+=0A=
+#define exch(x,y)			\=0A=
+do {					\=0A=
+	typeof(x) __tmp__ =3D (x);	\=0A=
+	(x) =3D (y);			\=0A=
+	(y) =3D __tmp__;			\=0A=
+} while(0)=0A=
+=0A=
 static inline void double_down(struct semaphore *s1, struct semaphore =
*s2)=0A=
 {=0A=
 	if (s1 !=3D s2) {=0A=
-		if ((unsigned long) s1 < (unsigned long) s2) {=0A=
-			struct semaphore *tmp =3D s2;=0A=
-			s2 =3D s1; s1 =3D tmp;=0A=
-		}=0A=
+		if ((ulong) s1 < (ulong) s2)=0A=
+			exch(s1, s2);		// s1 > s2=0A=
 		down(s1);=0A=
 	}=0A=
 	down(s2);=0A=
@@ -1458,9 +1466,11 @@=0A=
  * Ewwwwwwww... _triple_ lock. We are guaranteed that the 3rd argument =
is=0A=
  * not equal to 1st and not equal to 2nd - the first case (target is =
parent of=0A=
  * source) would be already caught, the second is plain impossible =
(target is=0A=
- * its own parent and that case would be caught even earlier). Very =
messy.=0A=
- * I _think_ that it works, but no warranties - please, look it through.=0A=
- * Pox on bloody lusers who mandated overwriting rename() for =
directories...=0A=
+ * its own parent and that case would be caught even earlier).=0A=
+ *=0A=
+ * Hopefully it does the same thing as the old code,=0A=
+ * but in a cleaner and more efficient way.=0A=
+ *     /Per=0A=
  */=0A=
 =0A=
 static inline void triple_down(struct semaphore *s1,=0A=
@@ -1468,30 +1478,14 @@=0A=
 			       struct semaphore *s3)=0A=
 {=0A=
 	if (s1 !=3D s2) {=0A=
-		if ((unsigned long) s1 < (unsigned long) s2) {=0A=
-			if ((unsigned long) s1 < (unsigned long) s3) {=0A=
-				struct semaphore *tmp =3D s3;=0A=
-				s3 =3D s1; s1 =3D tmp;=0A=
-			}=0A=
-			if ((unsigned long) s1 < (unsigned long) s2) {=0A=
-				struct semaphore *tmp =3D s2;=0A=
-				s2 =3D s1; s1 =3D tmp;=0A=
-			}=0A=
-		} else {=0A=
-			if ((unsigned long) s1 < (unsigned long) s3) {=0A=
-				struct semaphore *tmp =3D s3;=0A=
-				s3 =3D s1; s1 =3D tmp;=0A=
-			}=0A=
-			if ((unsigned long) s2 < (unsigned long) s3) {=0A=
-				struct semaphore *tmp =3D s3;=0A=
-				s3 =3D s2; s2 =3D tmp;=0A=
-			}=0A=
-		}=0A=
+		if ((ulong) s1 < (ulong) s2)=0A=
+			exch(s1, s2);		// s1 > s2=0A=
+		if ((ulong) s1 < (ulong) s3)=0A=
+			exch(s1, s3);		// s1 > s2,  s1 > s3=0A=
 		down(s1);=0A=
-	} else if ((unsigned long) s2 < (unsigned long) s3) {=0A=
-		struct semaphore *tmp =3D s3;=0A=
-		s3 =3D s2; s2 =3D tmp;=0A=
 	}=0A=
+	if((ulong) s2 < (ulong) s3)=0A=
+		exch(s2, s3);			// s2 > s3=0A=
 	down(s2);=0A=
 	down(s3);=0A=
 }=0A=

------=_NextPart_000_0000_01C14519.0BD39880--


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276654AbRJBTqN>; Tue, 2 Oct 2001 15:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276653AbRJBTqE>; Tue, 2 Oct 2001 15:46:04 -0400
Received: from mailb.telia.com ([194.22.194.6]:33802 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S276649AbRJBTp4>;
	Tue, 2 Oct 2001 15:45:56 -0400
From: "Per Persson" <per.persson@gnosjo.pp.se>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] triple_down in fs.h
Date: Tue, 2 Oct 2001 21:42:12 +0200
Message-ID: <NDBBJMOHILCIIKFHCBHAEELACAAA.per.persson@gnosjo.pp.se>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0000_01C14B8B.1926E000"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01C14B8B.1926E000
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Cleaned up some code.

[PATCH of 2.4.10 attached]

Per Persson
per.persson@gnosjo.pp.se

------=_NextPart_000_0000_01C14B8B.1926E000
Content-Type: application/octet-stream;
	name="fs.h.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="fs.h.patch"

--- include/linux/fs.h.orig	Sat Sep 29 22:10:21 2001=0A=
+++ include/linux/fs.h	Sat Sep 29 22:32:28 2001=0A=
@@ -1476,14 +1476,25 @@=0A=
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
+#define sort(x,y)			\=0A=
+if((x) > (y))				\=0A=
+	exch((x), (y))=0A=
+=0A=
 static inline void double_down(struct semaphore *s1, struct semaphore =
*s2)=0A=
 {=0A=
 	if (s1 !=3D s2) {=0A=
-		if ((unsigned long) s1 < (unsigned long) s2) {=0A=
-			struct semaphore *tmp =3D s2;=0A=
-			s2 =3D s1; s1 =3D tmp;=0A=
-		}=0A=
+		sort((ulong) s2, (ulong) s1);	// s2 < s1=0A=
 		down(s1);=0A=
 	}=0A=
 	down(s2);=0A=
@@ -1493,9 +1504,11 @@=0A=
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
@@ -1503,30 +1516,11 @@=0A=
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
+		sort((ulong) s2, (ulong) s1);	// s2 < s1=0A=
+		sort((ulong) s3, (ulong) s1);	// s3 < s1=0A=
 		down(s1);=0A=
-	} else if ((unsigned long) s2 < (unsigned long) s3) {=0A=
-		struct semaphore *tmp =3D s3;=0A=
-		s3 =3D s2; s2 =3D tmp;=0A=
 	}=0A=
+	sort((ulong) s3, (ulong) s2);		// s2 > s3=0A=
 	down(s2);=0A=
 	down(s3);=0A=
 }=0A=

------=_NextPart_000_0000_01C14B8B.1926E000--


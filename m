Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277626AbRJRNRR>; Thu, 18 Oct 2001 09:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277703AbRJRNRJ>; Thu, 18 Oct 2001 09:17:09 -0400
Received: from maila.telia.com ([194.22.194.231]:3564 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S277700AbRJRNQ7>;
	Thu, 18 Oct 2001 09:16:59 -0400
From: "Per Persson" <per.persson@gnosjo.pp.se>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] triple_down in fs.h
Date: Thu, 18 Oct 2001 15:10:34 +0200
Message-ID: <NDBBJMOHILCIIKFHCBHAAELPCAAA.per.persson@gnosjo.pp.se>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0002_01C157E7.0923FD60"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0002_01C157E7.0923FD60
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

First, I'd like to send a thank to the Linux community from my father who
passed away this morning. He was very impressed by Linux and other free or
semi-free software like Samba, MySQL, GIMP and StarOffice.


Now to the patch:
I've made a couple of minor (but important?) changes in my patch of
{double,triple}_down in include/linux/fs.h.

Changes:

1) Added #undef's of my macros.
   Thanks to Mitchell Blank Jr who proposed this change.
   Also thanks to Yaroslav Popovitch who told me he had got an error caused
by the lack of #undef's.

2) Changed the names of the macros to further minimize the risk for name
collision; exch -> exch_vars,  sort -> sort_vars.


Per Persson
per.persson@gnosjo.pp.se

------=_NextPart_000_0002_01C157E7.0923FD60
Content-Type: application/octet-stream;
	name="fs.h.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="fs.h.patch"

--- include/linux/fs.h.orig	Sat Sep 29 22:10:21 2001=0A=
+++ include/linux/fs.h	Mon Oct  8 13:03:24 2001=0A=
@@ -1476,14 +1476,27 @@=0A=
 /*=0A=
  * Whee.. Deadlock country. Happily there are only two VFS=0A=
  * operations that does this..=0A=
+ *=0A=
+ * {double,triple}_down modified by Per Persson in September, 2001=0A=
  */=0A=
+=0A=
+#define exch_vars(x,y)				\=0A=
+do {						\=0A=
+	typeof(x) __tmp__ =3D (x);		\=0A=
+	(x) =3D (y);				\=0A=
+	(y) =3D __tmp__;				\=0A=
+						\=0A=
+	(void)(&(x) =3D=3D &(y))  /* typecheck */	\=0A=
+} while(0)=0A=
+=0A=
+#define sort_vars(x,y)			\=0A=
+if((x) > (y))				\=0A=
+	exch_vars((x), (y))=0A=
+=0A=
 static inline void double_down(struct semaphore *s1, struct semaphore =
*s2)=0A=
 {=0A=
 	if (s1 !=3D s2) {=0A=
-		if ((unsigned long) s1 < (unsigned long) s2) {=0A=
-			struct semaphore *tmp =3D s2;=0A=
-			s2 =3D s1; s1 =3D tmp;=0A=
-		}=0A=
+		sort_vars((ulong) s2, (ulong) s1);	// s2 < s1=0A=
 		down(s1);=0A=
 	}=0A=
 	down(s2);=0A=
@@ -1493,9 +1506,11 @@=0A=
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
@@ -1503,33 +1518,17 @@=0A=
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
+		sort_vars((ulong) s2, (ulong) s1);	// s2 < s1=0A=
+		sort_vars((ulong) s3, (ulong) s1);	// s3 < s1=0A=
 		down(s1);=0A=
-	} else if ((unsigned long) s2 < (unsigned long) s3) {=0A=
-		struct semaphore *tmp =3D s3;=0A=
-		s3 =3D s2; s2 =3D tmp;=0A=
 	}=0A=
+	sort_vars((ulong) s3, (ulong) s2);		// s2 > s3=0A=
 	down(s2);=0A=
 	down(s3);=0A=
 }=0A=
+=0A=
+#undef exch_vars=0A=
+#undef sort_vars=0A=
 =0A=
 static inline void double_up(struct semaphore *s1, struct semaphore *s2)=0A=
 {=0A=

------=_NextPart_000_0002_01C157E7.0923FD60--


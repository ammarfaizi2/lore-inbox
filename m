Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278370AbRJSLyV>; Fri, 19 Oct 2001 07:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278371AbRJSLyL>; Fri, 19 Oct 2001 07:54:11 -0400
Received: from pa92.nowy-targ.sdi.tpnet.pl ([217.97.37.92]:18418 "EHLO
	nt.kegel.com.pl") by vger.kernel.org with ESMTP id <S278370AbRJSLyC>;
	Fri, 19 Oct 2001 07:54:02 -0400
Message-ID: <001e01c15894$cfdf3340$0100050a@abartoszko>
From: "Albert Bartoszko" <albertb@nt.kegel.com.pl>
To: <rguenth@tat.physik.uni-tuebingen.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] binfmt_misc.c, kernel-2.4.12
Date: Fri, 19 Oct 2001 13:54:23 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_001B_01C158A5.8F1D6140"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_001B_01C158A5.8F1D6140
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit

Hello

I find bug in  binfmt_misc.c from kernel 2.4.12 source. The read() syscal
return bad value, causes some application SIGSEGV.

Example:

# modprobe binfmt_misc
# echo ':Java:M::\xca\xfe\xba\xbe::/usr/local/bin/javawrapper:'
>/proc/sys/fs/binfmt_misc/register

# strace less /proc/sys/fs/binfmt_misc/Java
...............................................................
...............................................................
open("/proc/sys/fs/binfmt_misc/Java", O_RDONLY) = 3
lseek(3, 1, SEEK_SET)                   = 1
lseek(3, 0, SEEK_SET)                   = 0
read(3, "enabled\ninterpreter /usr/local/b"..., 64) = 71

^^^^^^^^
--- SIGSEGV (Segmentation fault) ---
+++ killed by SIGSEGV +++

I send a patch I wrote that correct this problem and do same cleanup, so
source and object are a bit smaller.

Albert Bartoszko
albertb@nt.kegel.com.pl



------=_NextPart_000_001B_01C158A5.8F1D6140
Content-Type: application/octet-stream;
	name="binfmt_misc.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="binfmt_misc.patch"

--- /usr/src/linux/fs/binfmt_misc.c.org	Fri Feb  9 20:29:44 2001=0A=
+++ /usr/src/linux/fs/binfmt_misc.c	Fri Oct 19 02:32:24 2001=0A=
@@ -13,6 +13,8 @@=0A=
  *  1997-06-26 hpa: pass the real filename rather than argv[0]=0A=
  *  1997-06-30 minor cleanup=0A=
  *  1997-08-09 removed extension stripping, locking cleanup=0A=
+ *  2001-10-15 Albert Bartoszko: cleanup, =0A=
+ *		correct return value of proc_read_status()=0A=
  */=0A=
 =0A=
 #include <linux/config.h>=0A=
@@ -354,28 +356,19 @@=0A=
 	char *dp;=0A=
 	int elen, i, err;=0A=
 =0A=
-#ifndef VERBOSE_STATUS=0A=
-	if (data) {=0A=
+	if (!data) =0A=
+	    sprintf(page, "%s\n", "enabled");=0A=
+	else {=0A=
 		if (!(e =3D get_entry((int) data))) {=0A=
 			err =3D -ENOENT;=0A=
 			goto _err;=0A=
-		}=0A=
-		i =3D e->flags & ENTRY_ENABLED;=0A=
-		put_entry(e);=0A=
-	} else {=0A=
-		i =3D enabled;=0A=
-	} =0A=
-	sprintf(page, "%s\n", (i ? "enabled" : "disabled"));=0A=
+		} =0A=
+#ifndef VERBOSE_STATUS		=0A=
+    		sprintf(page, "%s\n", =0A=
+			(e->flags & ENTRY_ENABLED) ? "enabled" : "disabled");=0A=
 #else=0A=
-	if (!data)=0A=
-		sprintf(page, "%s\n", (enabled ? "enabled" : "disabled"));=0A=
-	else {=0A=
-		if (!(e =3D get_entry((long) data))) {=0A=
-			err =3D -ENOENT;=0A=
-			goto _err;=0A=
-		}=0A=
-		sprintf(page, "%s\ninterpreter %s\n",=0A=
-		        (e->flags & ENTRY_ENABLED ? "enabled" : "disabled"),=0A=
+		sprintf(page, "%s\ninterpreter %s\n", =0A=
+			(e->flags & ENTRY_ENABLED) ? "enabled" : "disabled",	=0A=
 			e->interpreter);=0A=
 		dp =3D page + strlen(page);=0A=
 		if (!(e->flags & ENTRY_MAGIC)) {=0A=
@@ -399,13 +392,14 @@=0A=
 			*dp++ =3D '\n';=0A=
 			*dp =3D '\0';=0A=
 		}=0A=
-		put_entry(e);=0A=
-	}=0A=
 #endif=0A=
-=0A=
+		put_entry(e);	=0A=
+	}=0A=
 	elen =3D strlen(page) - off;=0A=
 	if (elen < 0)=0A=
 		elen =3D 0;=0A=
+	if (elen > count)=0A=
+		elen =3D count;=0A=
 	*eof =3D (elen <=3D count) ? 1 : 0;=0A=
 	*start =3D page + off;=0A=
 	err =3D elen;=0A=

------=_NextPart_000_001B_01C158A5.8F1D6140
Content-Type: application/octet-stream;
	name="README"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="README"

SUBJECT: Patch for bad return value in binfmt_misc.c, AUTHOR:Albert =
Bartoszko <albertb@nt.kegel.com.pl>
------=_NextPart_000_001B_01C158A5.8F1D6140--


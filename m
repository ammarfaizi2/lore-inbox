Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266868AbTBGXvD>; Fri, 7 Feb 2003 18:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266908AbTBGXvD>; Fri, 7 Feb 2003 18:51:03 -0500
Received: from www.amthinking.net ([65.104.119.37]:46132 "EHLO
	ex0.amthinking.net") by vger.kernel.org with ESMTP
	id <S266868AbTBGXuy>; Fri, 7 Feb 2003 18:50:54 -0500
From: "James Lamanna" <james.lamanna@appliedminds.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.59: scanf to honor field widths for numerics
Date: Fri, 7 Feb 2003 16:00:29 -0800
Message-ID: <01be01c2cf05$17c1acf0$39140b0a@amthinking.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_01BF_01C2CEC2.099E6CF0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 08 Feb 2003 00:00:30.0526 (UTC) FILETIME=[180FA5E0:01C2CF05]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_01BF_01C2CEC2.099E6CF0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

This is a fix to bug #189, vscanf/scanf ignoring field_widths for
numerical arguments.
Please review for inclusion.

It follows the same semantics as glibc, where '-', '0x', and '0' are
included in the field_width.

I've attached it to not make this message cluttered.

--James

------=_NextPart_000_01BF_01C2CEC2.099E6CF0
Content-Type: application/octet-stream;
	name="vsprintf.c.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="vsprintf.c.diff"

--- linux-2.5.59/lib/vsprintf.c	2003-01-16 18:22:42.000000000 -0800=0A=
+++ linux-2.5.59-devel/lib/vsprintf.c	2003-02-07 15:55:46.000000000 -0800=0A=
@@ -23,12 +23,13 @@=0A=
 #include <asm/div64.h>=0A=
 =0A=
 /**=0A=
- * simple_strtoul - convert a string to an unsigned long=0A=
+ * simple_strtoul_width - convert a string to an unsigned long=0A=
  * @cp: The start of the string=0A=
  * @endp: A pointer to the end of the parsed string will be placed here=0A=
  * @base: The number base to use=0A=
+ * @cendp: End of the string to convert=0A=
  */=0A=
-unsigned long simple_strtoul(const char *cp,char **endp,unsigned int =
base)=0A=
+static unsigned long simple_strtoul_width(const char *cp,char =
**endp,unsigned int base,const char *cendp)=0A=
 {=0A=
 	unsigned long result =3D 0,value;=0A=
 =0A=
@@ -37,14 +38,14 @@=0A=
 		if (*cp =3D=3D '0') {=0A=
 			base =3D 8;=0A=
 			cp++;=0A=
-			if ((*cp =3D=3D 'x') && isxdigit(cp[1])) {=0A=
+			if ((toupper(*cp) =3D=3D 'X') && isxdigit(cp[1])) {=0A=
 				cp++;=0A=
-				base =3D 16;=0A=
 			}=0A=
 		}=0A=
 	}=0A=
 	while (isxdigit(*cp) &&=0A=
-	       (value =3D isdigit(*cp) ? *cp-'0' : toupper(*cp)-'A'+10) < =
base) {=0A=
+	       (value =3D isdigit(*cp) ? *cp-'0' : toupper(*cp)-'A'+10) < base =
&&=0A=
+		   cp !=3D cendp) {=0A=
 		result =3D result*base + value;=0A=
 		cp++;=0A=
 	}=0A=
@@ -54,25 +55,27 @@=0A=
 }=0A=
 =0A=
 /**=0A=
- * simple_strtol - convert a string to a signed long=0A=
+ * simple_strtol_width - convert a string to a signed long=0A=
  * @cp: The start of the string=0A=
  * @endp: A pointer to the end of the parsed string will be placed here=0A=
  * @base: The number base to use=0A=
+ * @cendp: End of the string to convert=0A=
  */=0A=
-long simple_strtol(const char *cp,char **endp,unsigned int base)=0A=
+static long simple_strtol_width(const char *cp,char **endp,unsigned int =
base,const char *cendp)=0A=
 {=0A=
 	if(*cp=3D=3D'-')=0A=
-		return -simple_strtoul(cp+1,endp,base);=0A=
-	return simple_strtoul(cp,endp,base);=0A=
+		return -simple_strtoul_width(cp+1,endp,base,cendp);=0A=
+	return simple_strtoul_width(cp,endp,base,cendp);=0A=
 }=0A=
 =0A=
 /**=0A=
- * simple_strtoull - convert a string to an unsigned long long=0A=
+ * simple_strtoull_width - convert a string to an unsigned long long=0A=
  * @cp: The start of the string=0A=
  * @endp: A pointer to the end of the parsed string will be placed here=0A=
  * @base: The number base to use=0A=
+ * @cendp: End of the string to convert=0A=
  */=0A=
-unsigned long long simple_strtoull(const char *cp,char **endp,unsigned =
int base)=0A=
+static unsigned long long simple_strtoull_width(const char *cp,char =
**endp,unsigned int base,const char *cendp)=0A=
 {=0A=
 	unsigned long long result =3D 0,value;=0A=
 =0A=
@@ -81,14 +84,15 @@=0A=
 		if (*cp =3D=3D '0') {=0A=
 			base =3D 8;=0A=
 			cp++;=0A=
-			if ((*cp =3D=3D 'x') && isxdigit(cp[1])) {=0A=
+			if ((toupper(*cp) =3D=3D 'X') && isxdigit(cp[1])) {=0A=
 				cp++;=0A=
 				base =3D 16;=0A=
 			}=0A=
 		}=0A=
 	}=0A=
 	while (isxdigit(*cp) && (value =3D isdigit(*cp) ? *cp-'0' : =
(islower(*cp)=0A=
-	    ? toupper(*cp) : *cp)-'A'+10) < base) {=0A=
+	    ? toupper(*cp) : *cp)-'A'+10) < base &&=0A=
+		cp !=3D cendp) {=0A=
 		result =3D result*base + value;=0A=
 		cp++;=0A=
 	}=0A=
@@ -98,16 +102,41 @@=0A=
 }=0A=
 =0A=
 /**=0A=
- * simple_strtoll - convert a string to a signed long long=0A=
+ * simple_strtoll_width - convert a string to a signed long long=0A=
  * @cp: The start of the string=0A=
  * @endp: A pointer to the end of the parsed string will be placed here=0A=
  * @base: The number base to use=0A=
+ * @cendp: End of the string to convert=0A=
  */=0A=
-long long simple_strtoll(const char *cp,char **endp,unsigned int base)=0A=
+static long long simple_strtoll_width(const char *cp,char =
**endp,unsigned int base,const char *cendp)=0A=
 {=0A=
 	if(*cp=3D=3D'-')=0A=
-		return -simple_strtoull(cp+1,endp,base);=0A=
-	return simple_strtoull(cp,endp,base);=0A=
+		return -simple_strtoull_width(cp+1,endp,base,cendp);=0A=
+	return simple_strtoull_width(cp,endp,base,cendp);=0A=
+}=0A=
+=0A=
+unsigned long simple_strtoul(const char *cp, char **endp, =0A=
+	unsigned int base)=0A=
+{=0A=
+	return simple_strtoul_width(cp, endp, base, NULL);=0A=
+}=0A=
+=0A=
+long simple_strtol(const char *cp, char **endp, =0A=
+	unsigned int base)=0A=
+{=0A=
+	return simple_strtol_width(cp, endp, base, NULL);=0A=
+}=0A=
+=0A=
+unsigned long long simple_strtoull(const char *cp, char **endp, =0A=
+	unsigned int base)=0A=
+{=0A=
+	return simple_strtoull_width(cp, endp, base, NULL);=0A=
+}=0A=
+=0A=
+long long simple_strtoll(const char *cp, char **endp, =0A=
+	unsigned int base)=0A=
+{=0A=
+	return simple_strtoll_width(cp, endp, base, NULL);=0A=
 }=0A=
 =0A=
 static int skip_atoi(const char **s)=0A=
@@ -516,6 +545,7 @@=0A=
 int vsscanf(const char * buf, const char * fmt, va_list args)=0A=
 {=0A=
 	const char *str =3D buf;=0A=
+	const char *strendp;=0A=
 	char *next;=0A=
 	char digit;=0A=
 	int num =3D 0;=0A=
@@ -651,47 +681,49 @@=0A=
                     || (base =3D=3D 0 && !isdigit(digit)))=0A=
 				break;=0A=
 =0A=
+		strendp =3D (field_width =3D=3D -1) ? NULL : str + field_width;=0A=
+=0A=
 		switch(qualifier) {=0A=
 		case 'h':=0A=
 			if (is_sign) {=0A=
 				short *s =3D (short *) va_arg(args,short *);=0A=
-				*s =3D (short) simple_strtol(str,&next,base);=0A=
+				*s =3D (short) simple_strtol_width(str,&next,base,strendp);=0A=
 			} else {=0A=
 				unsigned short *s =3D (unsigned short *) va_arg(args, unsigned =
short *);=0A=
-				*s =3D (unsigned short) simple_strtoul(str, &next, base);=0A=
+				*s =3D (unsigned short) simple_strtoul_width(str,&next, =
base,strendp);=0A=
 			}=0A=
 			break;=0A=
 		case 'l':=0A=
 			if (is_sign) {=0A=
 				long *l =3D (long *) va_arg(args,long *);=0A=
-				*l =3D simple_strtol(str,&next,base);=0A=
+				*l =3D simple_strtol_width(str,&next,base,strendp);=0A=
 			} else {=0A=
 				unsigned long *l =3D (unsigned long*) va_arg(args,unsigned long*);=0A=
-				*l =3D simple_strtoul(str,&next,base);=0A=
+				*l =3D simple_strtoul_width(str,&next,base,strendp);=0A=
 			}=0A=
 			break;=0A=
 		case 'L':=0A=
 			if (is_sign) {=0A=
 				long long *l =3D (long long*) va_arg(args,long long *);=0A=
-				*l =3D simple_strtoll(str,&next,base);=0A=
+				*l =3D simple_strtoll_width(str,&next,base,strendp);=0A=
 			} else {=0A=
 				unsigned long long *l =3D (unsigned long long*) =
va_arg(args,unsigned long long*);=0A=
-				*l =3D simple_strtoull(str,&next,base);=0A=
+				*l =3D simple_strtoull_width(str,&next,base,strendp);=0A=
 			}=0A=
 			break;=0A=
 		case 'Z':=0A=
 		{=0A=
 			size_t *s =3D (size_t*) va_arg(args,size_t*);=0A=
-			*s =3D (size_t) simple_strtoul(str,&next,base);=0A=
+			*s =3D (size_t) simple_strtoul_width(str,&next,base,strendp);=0A=
 		}=0A=
 		break;=0A=
 		default:=0A=
 			if (is_sign) {=0A=
 				int *i =3D (int *) va_arg(args, int*);=0A=
-				*i =3D (int) simple_strtol(str,&next,base);=0A=
+				*i =3D (int) simple_strtol_width(str,&next,base,strendp);=0A=
 			} else {=0A=
 				unsigned int *i =3D (unsigned int*) va_arg(args, unsigned int*);=0A=
-				*i =3D (unsigned int) simple_strtoul(str,&next,base);=0A=
+				*i =3D (unsigned int) simple_strtoul_width(str,&next,base,strendp);=0A=
 			}=0A=
 			break;=0A=
 		}=0A=

------=_NextPart_000_01BF_01C2CEC2.099E6CF0--


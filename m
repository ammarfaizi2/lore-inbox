Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266933AbTBHAg5>; Fri, 7 Feb 2003 19:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266936AbTBHAg4>; Fri, 7 Feb 2003 19:36:56 -0500
Received: from www.amthinking.net ([65.104.119.37]:2616 "EHLO
	ex0.amthinking.net") by vger.kernel.org with ESMTP
	id <S266933AbTBHAgt>; Fri, 7 Feb 2003 19:36:49 -0500
From: "James Lamanna" <james.lamanna@appliedminds.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.59: scanf to honor field widths for numerics
Date: Fri, 7 Feb 2003 16:46:28 -0800
Message-ID: <01de01c2cf0b$8430dd60$39140b0a@amthinking.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 08 Feb 2003 00:46:29.0637 (UTC) FILETIME=[849E9350:01C2CF0B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This mailer is incredibly stupid, and I think that some of you may have 
gotten a garbled piece of trash as an attachment so here is the patch 
inline: 

> This is a fix to bug #189, vscanf/scanf ignoring field_widths for 
> numerical arguments. 
> Please review for inclusion. 
> It follows the same semantics as glibc, where '-', '0x', and '0' are 
> included in the field_width. 

--- linux-2.5.59/lib/vsprintf.c	2003-01-16 18:22:42.000000000 -0800
+++ linux-2.5.59-devel/lib/vsprintf.c	2003-02-07 15:55:46.000000000
-0800
@@ -23,12 +23,13 @@
 #include <asm/div64.h>
 
 /**
- * simple_strtoul - convert a string to an unsigned long
+ * simple_strtoul_width - convert a string to an unsigned long
  * @cp: The start of the string
  * @endp: A pointer to the end of the parsed string will be placed here
  * @base: The number base to use
+ * @cendp: End of the string to convert
  */
-unsigned long simple_strtoul(const char *cp,char **endp,unsigned int
base)
+static unsigned long simple_strtoul_width(const char *cp,char
**endp,unsigned int base,const char *cendp)
 {
 	unsigned long result = 0,value;
 
@@ -37,14 +38,14 @@
 		if (*cp == '0') {
 			base = 8;
 			cp++;
-			if ((*cp == 'x') && isxdigit(cp[1])) {
+			if ((toupper(*cp) == 'X') && isxdigit(cp[1])) {
 				cp++;
-				base = 16;
 			}
 		}
 	}
 	while (isxdigit(*cp) &&
-	       (value = isdigit(*cp) ? *cp-'0' : toupper(*cp)-'A'+10) <
base) {
+	       (value = isdigit(*cp) ? *cp-'0' : toupper(*cp)-'A'+10) <
base &&
+		   cp != cendp) {
 		result = result*base + value;
 		cp++;
 	}
@@ -54,25 +55,27 @@
 }
 
 /**
- * simple_strtol - convert a string to a signed long
+ * simple_strtol_width - convert a string to a signed long
  * @cp: The start of the string
  * @endp: A pointer to the end of the parsed string will be placed here
  * @base: The number base to use
+ * @cendp: End of the string to convert
  */
-long simple_strtol(const char *cp,char **endp,unsigned int base)
+static long simple_strtol_width(const char *cp,char **endp,unsigned int
base,const char *cendp)
 {
 	if(*cp=='-')
-		return -simple_strtoul(cp+1,endp,base);
-	return simple_strtoul(cp,endp,base);
+		return -simple_strtoul_width(cp+1,endp,base,cendp);
+	return simple_strtoul_width(cp,endp,base,cendp);
 }
 
 /**
- * simple_strtoull - convert a string to an unsigned long long
+ * simple_strtoull_width - convert a string to an unsigned long long
  * @cp: The start of the string
  * @endp: A pointer to the end of the parsed string will be placed here
  * @base: The number base to use
+ * @cendp: End of the string to convert
  */
-unsigned long long simple_strtoull(const char *cp,char **endp,unsigned
int base)
+static unsigned long long simple_strtoull_width(const char *cp,char
**endp,unsigned int base,const char *cendp)
 {
 	unsigned long long result = 0,value;
 
@@ -81,14 +84,15 @@
 		if (*cp == '0') {
 			base = 8;
 			cp++;
-			if ((*cp == 'x') && isxdigit(cp[1])) {
+			if ((toupper(*cp) == 'X') && isxdigit(cp[1])) {
 				cp++;
 				base = 16;
 			}
 		}
 	}
 	while (isxdigit(*cp) && (value = isdigit(*cp) ? *cp-'0' :
(islower(*cp)
-	    ? toupper(*cp) : *cp)-'A'+10) < base) {
+	    ? toupper(*cp) : *cp)-'A'+10) < base &&
+		cp != cendp) {
 		result = result*base + value;
 		cp++;
 	}
@@ -98,16 +102,41 @@
 }
 
 /**
- * simple_strtoll - convert a string to a signed long long
+ * simple_strtoll_width - convert a string to a signed long long
  * @cp: The start of the string
  * @endp: A pointer to the end of the parsed string will be placed here
  * @base: The number base to use
+ * @cendp: End of the string to convert
  */
-long long simple_strtoll(const char *cp,char **endp,unsigned int base)
+static long long simple_strtoll_width(const char *cp,char
**endp,unsigned int base,const char *cendp)
 {
 	if(*cp=='-')
-		return -simple_strtoull(cp+1,endp,base);
-	return simple_strtoull(cp,endp,base);
+		return -simple_strtoull_width(cp+1,endp,base,cendp);
+	return simple_strtoull_width(cp,endp,base,cendp);
+}
+
+unsigned long simple_strtoul(const char *cp, char **endp, 
+	unsigned int base)
+{
+	return simple_strtoul_width(cp, endp, base, NULL);
+}
+
+long simple_strtol(const char *cp, char **endp, 
+	unsigned int base)
+{
+	return simple_strtol_width(cp, endp, base, NULL);
+}
+
+unsigned long long simple_strtoull(const char *cp, char **endp, 
+	unsigned int base)
+{
+	return simple_strtoull_width(cp, endp, base, NULL);
+}
+
+long long simple_strtoll(const char *cp, char **endp, 
+	unsigned int base)
+{
+	return simple_strtoll_width(cp, endp, base, NULL);
 }
 
 static int skip_atoi(const char **s)
@@ -516,6 +545,7 @@
 int vsscanf(const char * buf, const char * fmt, va_list args)
 {
 	const char *str = buf;
+	const char *strendp;
 	char *next;
 	char digit;
 	int num = 0;
@@ -651,47 +681,49 @@
                     || (base == 0 && !isdigit(digit)))
 				break;
 
+		strendp = (field_width == -1) ? NULL : str +
field_width;
+
 		switch(qualifier) {
 		case 'h':
 			if (is_sign) {
 				short *s = (short *) va_arg(args,short
*);
-				*s = (short)
simple_strtol(str,&next,base);
+				*s = (short)
simple_strtol_width(str,&next,base,strendp);
 			} else {
 				unsigned short *s = (unsigned short *)
va_arg(args, unsigned short *);
-				*s = (unsigned short)
simple_strtoul(str, &next, base);
+				*s = (unsigned short)
simple_strtoul_width(str,&next, base,strendp);
 			}
 			break;
 		case 'l':
 			if (is_sign) {
 				long *l = (long *) va_arg(args,long *);
-				*l = simple_strtol(str,&next,base);
+				*l =
simple_strtol_width(str,&next,base,strendp);
 			} else {
 				unsigned long *l = (unsigned long*)
va_arg(args,unsigned long*);
-				*l = simple_strtoul(str,&next,base);
+				*l =
simple_strtoul_width(str,&next,base,strendp);
 			}
 			break;
 		case 'L':
 			if (is_sign) {
 				long long *l = (long long*)
va_arg(args,long long *);
-				*l = simple_strtoll(str,&next,base);
+				*l =
simple_strtoll_width(str,&next,base,strendp);
 			} else {
 				unsigned long long *l = (unsigned long
long*) va_arg(args,unsigned long long*);
-				*l = simple_strtoull(str,&next,base);
+				*l =
simple_strtoull_width(str,&next,base,strendp);
 			}
 			break;
 		case 'Z':
 		{
 			size_t *s = (size_t*) va_arg(args,size_t*);
-			*s = (size_t) simple_strtoul(str,&next,base);
+			*s = (size_t)
simple_strtoul_width(str,&next,base,strendp);
 		}
 		break;
 		default:
 			if (is_sign) {
 				int *i = (int *) va_arg(args, int*);
-				*i = (int)
simple_strtol(str,&next,base);
+				*i = (int)
simple_strtol_width(str,&next,base,strendp);
 			} else {
 				unsigned int *i = (unsigned int*)
va_arg(args, unsigned int*);
-				*i = (unsigned int)
simple_strtoul(str,&next,base);
+				*i = (unsigned int)
simple_strtoul_width(str,&next,base,strendp);
 			}
 			break;
 		}


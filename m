Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274112AbRIXSGq>; Mon, 24 Sep 2001 14:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274110AbRIXSGh>; Mon, 24 Sep 2001 14:06:37 -0400
Received: from member.michigannet.com ([207.158.188.18]:50693 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S274112AbRIXSG2>; Mon, 24 Sep 2001 14:06:28 -0400
Date: Mon, 24 Sep 2001 14:05:19 -0400
From: Paul <set@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] Fix sscanf (more fixes)
Message-ID: <20010924140519.A16708@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>, linux-kernel@vger.kernel.org,
	alan@lxorguk.ukuu.org.uk
In-Reply-To: <200109240354.WAA03909@ccure.karaya.com> <20010924031320.X16708@squish.home.loc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010924031320.X16708@squish.home.loc>; from set@pobox.com on Mon, Sep 24, 2001 at 03:13:20AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	This patch includes my previous modifications and also
corrects behaviour to match sscanf(3) as far as matching white
space and avoiding a false match in some cases.

Paul
set@pobox.com

--- 2.4.9-ac13-user/lib/vsprintf.c.old	Fri Sep 21 19:42:25 2001
+++ 2.4.9-ac13-user/lib/vsprintf.c	Mon Sep 24 13:52:05 2001
@@ -18,6 +18,7 @@
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
+#include <linux/kernel.h>
 
 #include <asm/div64.h>
 
@@ -515,36 +516,44 @@
 	int num = 0;
 	int qualifier;
 	int base;
-	unsigned int field_width;
+	int field_width = -1;
 	int is_sign = 0;
 
-	for (; *fmt; fmt++) {
+	while(*fmt && *str) {
 		/* skip any white space in format */
+		/* white space in format matchs any amount of
+		 * white space, including none, in the input.
+		 */
 		if (isspace(*fmt)) {
-			continue;
+			while (isspace(*fmt))
+				++fmt;
+			while (isspace(*str))
+				++str;
 		}
 
 		/* anything that is not a conversion must match exactly */
-		if (*fmt != '%') {
+		if (*fmt != '%' && *fmt) {
 			if (*fmt++ != *str++)
-				return num;
+				break;
 			continue;
 		}
+
+		if (!*fmt)
+			break;
 		++fmt;
 		
 		/* skip this conversion.
 		 * advance both strings to next white space
 		 */
 		if (*fmt == '*') {
-			while (!isspace(*fmt))
+			while (!isspace(*fmt) && *fmt)
 				fmt++;
-			while(!isspace(*str))
+			while (!isspace(*str) && *str)
 				str++;
 			continue;
 		}
 
 		/* get field width */
-		field_width = 0xffffffffUL;
 		if (isdigit(*fmt))
 			field_width = skip_atoi(&fmt);
 
@@ -557,25 +566,32 @@
 		base = 10;
 		is_sign = 0;
 
-		switch(*fmt) {
+		if (!*fmt || !*str)
+			break;
+
+		switch(*fmt++) {
 		case 'c':
 		{
 			char *s = (char *) va_arg(args,char*);
+			if (field_width == -1)
+				field_width = 1;
 			do {
 				*s++ = *str++;
-			} while(field_width-- > 0);
+			} while(field_width-- > 0 && *str);
 			num++;
 		}
 		continue;
 		case 's':
 		{
 			char *s = (char *) va_arg(args, char *);
+			if(field_width == -1)
+				field_width = INT_MAX;
 			/* first, skip leading white space in buffer */
 			while (isspace(*str))
 				str++;
 
 			/* now copy until next white space */
-			while (!isspace(*str) && field_width--) {
+			while (*str && !isspace(*str) && field_width--) {
 				*s++ = *str++;
 			}
 			*s = '\0';
@@ -617,6 +633,9 @@
 		while (isspace(*str))
 			str++;
 
+		if (!*str || !isdigit(*str))
+			break;
+
 		switch(qualifier) {
 		case 'h':
 			if (is_sign) {

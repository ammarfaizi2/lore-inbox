Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273813AbRIXHO1>; Mon, 24 Sep 2001 03:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273815AbRIXHOS>; Mon, 24 Sep 2001 03:14:18 -0400
Received: from member.michigannet.com ([207.158.188.18]:63249 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S273813AbRIXHOL>; Mon, 24 Sep 2001 03:14:11 -0400
Date: Mon, 24 Sep 2001 03:13:20 -0400
From: Paul <set@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix sscanf (the 3rd verse)
Message-ID: <20010924031320.X16708@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200109240354.WAA03909@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200109240354.WAA03909@ccure.karaya.com>; from jdike@karaya.com on Sun, Sep 23, 2001 at 10:54:10PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@karaya.com>, on Sun Sep 23, 2001 [10:54:10 PM] said:
> sscanf double-increments fmt in a couple of places, causing format characters
> to be skipped.  Patch follows.
> 
> I'm a bit unhappy about the second chunk, but I don't see a cleaner way to
> do it offhand.
> 
> 				Jeff
> 


	Hi.

	I found buffer overruns and other problems when I looked
at this function again in more detail. (%c and %s format parsing
went horribly wrong in initial tests.)  This patch tries to fix
those also. (and avoids the increment/decrement ugly) I have
tested it a little in a userspace program, and it passes uml's
sscanf usage:) Should check it again in the morning... it may not
be perfect, but at least I hope this makes it a little safer.

Paul
set@pobox.com

--- 2.4.9-ac13-user/lib/vsprintf.c.old	Fri Sep 21 19:42:25 2001
+++ 2.4.9-ac13-user/lib/vsprintf.c	Mon Sep 24 02:53:03 2001
@@ -508,6 +508,7 @@
  * @fmt:	format of buffer
  * @args:	arguments
  */
+
 int vsscanf(const char * buf, const char * fmt, va_list args)
 {
 	const char *str = buf;
@@ -515,36 +516,37 @@
 	int num = 0;
 	int qualifier;
 	int base;
-	unsigned int field_width;
+	int field_width = -1;
 	int is_sign = 0;
 
-	for (; *fmt; fmt++) {
+	while(*fmt && *str) {
 		/* skip any white space in format */
-		if (isspace(*fmt)) {
-			continue;
-		}
+		while (isspace(*fmt))
+			++fmt;
 
 		/* anything that is not a conversion must match exactly */
-		if (*fmt != '%') {
+		if (*fmt != '%' && *fmt) {
 			if (*fmt++ != *str++)
 				return num;
 			continue;
 		}
-		++fmt;
+		if (*fmt)
+			++fmt;
+		else
+			return num;
 		
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
 
@@ -557,25 +559,32 @@
 		base = 10;
 		is_sign = 0;
 
-		switch(*fmt) {
+		if (!*fmt || !*str)
+			return num;
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
+				field_width = 0x7ffffff;
 			/* first, skip leading white space in buffer */
 			while (isspace(*str))
 				str++;
 
 			/* now copy until next white space */
-			while (!isspace(*str) && field_width--) {
+			while (*str && !isspace(*str) && field_width--) {
 				*s++ = *str++;
 			}
 			*s = '\0';
@@ -617,6 +626,9 @@
 		while (isspace(*str))
 			str++;
 
+		if (!*str)
+			return num;
+
 		switch(qualifier) {
 		case 'h':
 			if (is_sign) {

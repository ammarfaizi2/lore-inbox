Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWFTXsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWFTXsw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 19:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbWFTXsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 19:48:52 -0400
Received: from gw.goop.org ([64.81.55.164]:24008 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751387AbWFTXsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 19:48:51 -0400
Message-ID: <44988965.9010906@goop.org>
Date: Tue, 20 Jun 2006 16:48:53 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Chris Wright <chrisw@sous-sol.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: [PATCH] Fix bounds check in vsnprintf, to allow for a 0 size and
 NULL buffer
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Fitzhardinge <jeremy@xensource.com>

This change allows callers to use a 0-byte buffer and a NULL buffer 
pointer with vsnprintf, so it can be used to determine how large the 
resulting formatted string will be.

Previously the code effectively treated a size of 0 as a size of 4G (on 
32-bit systems), with other checks preventing it from actually trying to 
emit the string - but the terminal \0 would still be written, which 
would crash if the buffer is NULL.

This change changes the boundary check so that 'end' points to the 
putative location of the terminal '\0', which is only written if size > 0.

vsnprintf still allows the buffer size to be set very large, to allow 
unbounded buffer sizes (to implement sprintf, etc).

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 lib/vsprintf.c |   67 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 34 insertions(+), 33 deletions(-)


diff -r 509769aa6636 lib/vsprintf.c
--- a/lib/vsprintf.c	Tue Jun 20 16:40:33 2006 -0700
+++ b/lib/vsprintf.c	Tue Jun 20 16:47:51 2006 -0700
@@ -187,49 +187,49 @@ static char * number(char * buf, char * 
 	size -= precision;
 	if (!(type&(ZEROPAD+LEFT))) {
 		while(size-->0) {
-			if (buf <= end)
+			if (buf < end)
 				*buf = ' ';
 			++buf;
 		}
 	}
 	if (sign) {
-		if (buf <= end)
+		if (buf < end)
 			*buf = sign;
 		++buf;
 	}
 	if (type & SPECIAL) {
 		if (base==8) {
-			if (buf <= end)
+			if (buf < end)
 				*buf = '0';
 			++buf;
 		} else if (base==16) {
-			if (buf <= end)
+			if (buf < end)
 				*buf = '0';
 			++buf;
-			if (buf <= end)
+			if (buf < end)
 				*buf = digits[33];
 			++buf;
 		}
 	}
 	if (!(type & LEFT)) {
 		while (size-- > 0) {
-			if (buf <= end)
+			if (buf < end)
 				*buf = c;
 			++buf;
 		}
 	}
 	while (i < precision--) {
-		if (buf <= end)
+		if (buf < end)
 			*buf = '0';
 		++buf;
 	}
 	while (i-- > 0) {
-		if (buf <= end)
+		if (buf < end)
 			*buf = tmp[i];
 		++buf;
 	}
 	while (size-- > 0) {
-		if (buf <= end)
+		if (buf < end)
 			*buf = ' ';
 		++buf;
 	}
@@ -272,7 +272,8 @@ int vsnprintf(char *buf, size_t size, co
 				/* 'z' changed to 'Z' --davidm 1/25/99 */
 				/* 't' added for ptrdiff_t */
 
-	/* Reject out-of-range values early */
+	/* Reject out-of-range values early.  Large positive sizes are
+	   used for unknown buffer sizes. */
 	if (unlikely((int) size < 0)) {
 		/* There can be only one.. */
 		static int warn = 1;
@@ -282,16 +283,17 @@ int vsnprintf(char *buf, size_t size, co
 	}
 
 	str = buf;
-	end = buf + size - 1;
-
-	if (end < buf - 1) {
-		end = ((void *) -1);
-		size = end - buf + 1;
+	end = buf + size;
+
+	/* Make sure end is always >= buf */
+	if (end < buf) {
+		end = ((void *) ~0ull);
+		size = end - buf;
 	}
 
 	for (; *fmt ; ++fmt) {
 		if (*fmt != '%') {
-			if (str <= end)
+			if (str < end)
 				*str = *fmt;
 			++str;
 			continue;
@@ -357,17 +359,17 @@ int vsnprintf(char *buf, size_t size, co
 			case 'c':
 				if (!(flags & LEFT)) {
 					while (--field_width > 0) {
-						if (str <= end)
+						if (str < end)
 							*str = ' ';
 						++str;
 					}
 				}
 				c = (unsigned char) va_arg(args, int);
-				if (str <= end)
+				if (str < end)
 					*str = c;
 				++str;
 				while (--field_width > 0) {
-					if (str <= end)
+					if (str < end)
 						*str = ' ';
 					++str;
 				}
@@ -382,18 +384,18 @@ int vsnprintf(char *buf, size_t size, co
 
 				if (!(flags & LEFT)) {
 					while (len < field_width--) {
-						if (str <= end)
+						if (str < end)
 							*str = ' ';
 						++str;
 					}
 				}
 				for (i = 0; i < len; ++i) {
-					if (str <= end)
+					if (str < end)
 						*str = *s;
 					++str; ++s;
 				}
 				while (len < field_width--) {
-					if (str <= end)
+					if (str < end)
 						*str = ' ';
 					++str;
 				}
@@ -426,7 +428,7 @@ int vsnprintf(char *buf, size_t size, co
 				continue;
 
 			case '%':
-				if (str <= end)
+				if (str < end)
 					*str = '%';
 				++str;
 				continue;
@@ -449,11 +451,11 @@ int vsnprintf(char *buf, size_t size, co
 				break;
 
 			default:
-				if (str <= end)
+				if (str < end)
 					*str = '%';
 				++str;
 				if (*fmt) {
-					if (str <= end)
+					if (str < end)
 						*str = *fmt;
 					++str;
 				} else {
@@ -483,14 +485,13 @@ int vsnprintf(char *buf, size_t size, co
 		str = number(str, end, num, base,
 				field_width, precision, flags);
 	}
-	if (str <= end)
-		*str = '\0';
-	else if (size > 0)
-		/* don't write out a null byte if the buf size is zero */
-		*end = '\0';
-	/* the trailing null byte doesn't count towards the total
-	* ++str;
-	*/
+	if (size > 0) {
+		if (str < end)
+			*str = '\0';
+		else
+			*end = '\0';
+	}
+	/* the trailing null byte doesn't count towards the total */
 	return str-buf;
 }
 


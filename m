Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbQLTOkA>; Wed, 20 Dec 2000 09:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129410AbQLTOju>; Wed, 20 Dec 2000 09:39:50 -0500
Received: from cocopah.gate.net ([216.219.246.49]:9464 "EHLO cocopah.gate.net")
	by vger.kernel.org with ESMTP id <S129401AbQLTOjf>;
	Wed, 20 Dec 2000 09:39:35 -0500
Message-ID: <000e01c06a8e$6945db60$bc1a24cf@master>
From: "Steve Grubb" <ddata@gate.net>
To: <linux-kernel@vger.kernel.org>
Subject: [Patch] performance enhancement for simple_strtoul
Date: Wed, 20 Dec 2000 09:09:03 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The following patch is a faster implementation of the simple_strtoul
function. This function differs from the original in that it reduces the
multiplies to shifts and logical operations wherever possible. My testing
shows that it adds around 100 bytes, but is about 6% faster on a K6-2. (It
is 40% faster that glibc's strtoul, but that's a different story.) My guess
is that the performance gain will be higher on platforms with slower
multiplication instructions. I have tested it for numerical accuracy so I
think this is safe to apply. If anyone is interested, I can also supply a
test application that demonstrates the performance gain. This patch was
generated against 2.2.16, but should apply to 2.2.19 cleanly. In
2.4.0-test9, simple_strtoul starts on line 19 rather than 17, hopefully
that's not a problem.

Cheers,
Steve Grubb

-------------------------

--- lib/vsprintf.orig Fri Dec  1 08:58:02 2000
+++ lib/vsprintf.c Wed Dec 20 08:42:26 2000
@@ -14,10 +14,13 @@
 #include <linux/string.h>
 #include <linux/ctype.h>

+/*
+* This function converts base 8, 10, or 16 only - Steve Grubb
+*/
 unsigned long simple_strtoul(const char *cp,char **endp,unsigned int base)
 {
- unsigned long result = 0,value;
-
+ unsigned char c;
+ unsigned long result = 0;
  if (!base) {
   base = 10;
   if (*cp == '0') {
@@ -29,11 +32,36 @@
    }
   }
  }
- while (isxdigit(*cp) && (value = isdigit(*cp) ? *cp-'0' : (islower(*cp)
-     ? toupper(*cp) : *cp)-'A'+10) < base) {
-  result = result*base + value;
-  cp++;
- }
+ c = *cp;
+        switch (base) {
+                case 10:
+                        while (isdigit(c)) {
+                                result = (result*10) + (c & 0x0f);
+                                c = *(++cp);
+                        }
+                        break;
+                case 16:
+                        while (isxdigit(c)) {
+                                result = result<<4;
+                                if (c&0x40)
+                                         result += (c & 0x07) + 9;
+                                else
+                                        result += c & 0x0f;
+                                c = *(++cp);
+                        }
+                        break;
+                case 8:
+                        while (isdigit(c)) {
+                                if ((c&0x37) == c)
+                                        result = (result<<3) + (c & 0x07);
+                                else
+                                        break;
+                                c = *(++cp);
+                        }
+                        break;
+                default: /* Is anything else used by the kernel? */
+                        break;
+        }
  if (endp)
   *endp = (char *)cp;
  return result;



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129790AbQLTTNo>; Wed, 20 Dec 2000 14:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130215AbQLTTNe>; Wed, 20 Dec 2000 14:13:34 -0500
Received: from flathead.gate.net ([216.219.246.5]:26312 "EHLO
	flathead.gate.net") by vger.kernel.org with ESMTP
	id <S129790AbQLTTN2>; Wed, 20 Dec 2000 14:13:28 -0500
Message-ID: <001401c06ab4$ac8615e0$7d1a24cf@master>
From: "Steve Grubb" <ddata@gate.net>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <000e01c06a8e$6945db60$bc1a24cf@master> <20001220100446.A1249@inetnebr.com>
Subject: Re: [Patch] performance enhancement for simple_strtoul
Date: Wed, 20 Dec 2000 13:42:56 -0500
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

I continued experimenting with the Test Case and found a further speed
improvement & I am re-submiting the patch. It is the same as the first one
with the two local variables changed to register storage types.

On a K6-2, I now see:
Base 10 - 28% speedup
Base 16 - 24% speedup
Base 8 - 30% speedup

On a P3 system, I now see:
Base 10 - 25% speedup
Base 16 - 17% speedup
Base 8 - 20% speedup

It seems gcc creates much better code with the variables set to register
types. Please apply the following patch. It should apply to any recent 2.2.x
without problems. In 2.4 the function starts 2 lines later.

Cheers,
Steve Grubb

----------------------------------

 --- lib/vsprintf.orig Fri Dec  1 08:58:02 2000
+++ lib/vsprintf.c Wed Dec 20 13:14:13 2000
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
+ register unsigned char c;
+ register unsigned long result = 0;
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

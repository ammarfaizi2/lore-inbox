Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262480AbSKHWHd>; Fri, 8 Nov 2002 17:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262484AbSKHWHd>; Fri, 8 Nov 2002 17:07:33 -0500
Received: from air-2.osdl.org ([65.172.181.6]:60908 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262480AbSKHWHc>;
	Fri, 8 Nov 2002 17:07:32 -0500
Date: Fri, 8 Nov 2002 14:09:09 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Douglas Gilbert <dougg@torque.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: sscanf("-1", "%d", &i) fails, returns 0
In-Reply-To: <Pine.LNX.4.44.0211081211141.4471-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L2.0211081407560.32726-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2002, Linus Torvalds wrote:

|
| On Fri, 8 Nov 2002, Randy.Dunlap wrote:
| ?
| > Sure, it looks cleaner that way, although gcc has already put <*dig>
| > in a local register; i.e., it's not pulled from memory for each test.
| > Here's a (tested) version that does that.
|
| Why do you have that "dig" pointer at all? It's not really used.
|
| Why not just do
|
| 	+	char digit;
| 	...
|
| 	+	digit = str;
| 	+	if (digit == '-')
| 	+		digit = str[1];
|
|
| (and maybe it should also test for whether signed stuff is even alloed or
| not, ie maybe the test should be "if (is_sign && digit == '-')" instead)

OK, I've cleaned it up as suggested...

-- 
~Randy



--- ./lib/vsprintf.c%signed	Mon Nov  4 14:30:49 2002
+++ ./lib/vsprintf.c	Fri Nov  8 13:54:33 2002
@@ -517,6 +517,7 @@
 {
 	const char *str = buf;
 	char *next;
+	char digit;
 	int num = 0;
 	int qualifier;
 	int base;
@@ -638,12 +639,16 @@
 		while (isspace(*str))
 			str++;

-		if (!*str
-                    || (base == 16 && !isxdigit(*str))
-                    || (base == 10 && !isdigit(*str))
-                    || (base == 8 && (!isdigit(*str) || *str > '7'))
-                    || (base == 0 && !isdigit(*str)))
-			break;
+		digit = *str;
+		if (is_sign && digit == '-')
+			digit = *(str + 1);
+
+		if (!digit
+                    || (base == 16 && !isxdigit(digit))
+                    || (base == 10 && !isdigit(digit))
+                    || (base == 8 && (!isdigit(digit) || digit > '7'))
+                    || (base == 0 && !isdigit(digit)))
+				break;

 		switch(qualifier) {
 		case 'h':


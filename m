Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262324AbSKHT6G>; Fri, 8 Nov 2002 14:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262327AbSKHT6G>; Fri, 8 Nov 2002 14:58:06 -0500
Received: from air-2.osdl.org ([65.172.181.6]:5816 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262324AbSKHT6D>;
	Fri, 8 Nov 2002 14:58:03 -0500
Date: Fri, 8 Nov 2002 11:59:36 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Douglas Gilbert <dougg@torque.net>, <linux-kernel@vger.kernel.org>,
       <torvalds@transmeta.com>
Subject: Re: [PATCH] Re: sscanf("-1", "%d", &i) fails, returns 0
In-Reply-To: <Pine.LNX.3.95.1021108143738.1000A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.33L2.0211081153480.32726-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2002, Richard B. Johnson wrote:

| On Fri, 8 Nov 2002, Randy.Dunlap wrote:
|
| > On Sat, 9 Nov 2002, Douglas Gilbert wrote:
| >
| > | In lk 2.5.46-bk3 the expression in the subject line
| > | fails to write into "i" and returns 0. Drop the minus
| > | sign and it works.
| >
| > Here's an unobstrusive patch to correct that.
| > Please apply.
| >
| > --
| > ~Randy
| > -
|
| I was thinking that if anybody ever had to change any of this
| stuff, it might be a good idea to do the indirection only once?
| All those "splats" over and over again are costly.

Sure, it looks cleaner that way, although gcc has already put <*dig>
in a local register; i.e., it's not pulled from memory for each test.
Here's a (tested) version that does that.

-- 
~Randy



--- ./lib/vsprintf.c%signed	Mon Nov  4 14:30:49 2002
+++ ./lib/vsprintf.c	Fri Nov  8 12:03:15 2002
@@ -517,6 +517,7 @@
 {
 	const char *str = buf;
 	char *next;
+	char *dig, onedig;
 	int num = 0;
 	int qualifier;
 	int base;
@@ -638,12 +639,14 @@
 		while (isspace(*str))
 			str++;

-		if (!*str
-                    || (base == 16 && !isxdigit(*str))
-                    || (base == 10 && !isdigit(*str))
-                    || (base == 8 && (!isdigit(*str) || *str > '7'))
-                    || (base == 0 && !isdigit(*str)))
-			break;
+		dig = (*str == '-') ? (str + 1) : str;
+		onedig = *dig;
+		if (!onedig
+                    || (base == 16 && !isxdigit(onedig))
+                    || (base == 10 && !isdigit(onedig))
+                    || (base == 8 && (!isdigit(onedig) || onedig > '7'))
+                    || (base == 0 && !isdigit(onedig)))
+				break;

 		switch(qualifier) {
 		case 'h':


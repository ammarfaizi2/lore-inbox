Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273746AbRIXCgw>; Sun, 23 Sep 2001 22:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273747AbRIXCgl>; Sun, 23 Sep 2001 22:36:41 -0400
Received: from mnh-1-24.mv.com ([207.22.10.56]:9 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S273746AbRIXCgb>;
	Sun, 23 Sep 2001 22:36:31 -0400
Message-Id: <200109240354.WAA03909@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix sscanf
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 23 Sep 2001 22:54:10 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sscanf double-increments fmt in a couple of places, causing format characters
to be skipped.  Patch follows.

I'm a bit unhappy about the second chunk, but I don't see a cleaner way to
do it offhand.

				Jeff

--- orig/lib/vsprintf.c	Sun Sep 23 19:20:54 2001
+++ 2.4.10/lib/vsprintf.c	Sun Sep 23 21:28:55 2001
@@ -530,7 +530,8 @@
 
 		/* anything that is not a conversion must match exactly */
 		if (*fmt != '%') {
-			if (*fmt++ != *str++)
+		        /* Don't bump fmt because the for header will do it */
+			if (*fmt != *str++)
 				return num;
 			continue;
 		}
@@ -542,6 +543,10 @@
 		if (*fmt == '*') {
 			while (!isspace(*fmt))
 				fmt++;
+			/* Back it up one because the for header will move it
+			 * it forward again
+			 */
+			fmt--;
 			while(!isspace(*str))
 				str++;
 			continue;


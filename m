Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130112AbRAKItY>; Thu, 11 Jan 2001 03:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129735AbRAKItO>; Thu, 11 Jan 2001 03:49:14 -0500
Received: from zeus.kernel.org ([209.10.41.242]:64478 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129749AbRAKItF>;
	Thu, 11 Jan 2001 03:49:05 -0500
From: "Troels Walsted Hansen" <troels@thule.no>
To: linux-kernel@vger.kernel.org, greg@wind.enjellic.com, joey@linux.de
Subject: [PATCH] klogd busy loop on zero byte (output from 3c59x driver)
Date: Thu, 11 Jan 2001 09:48:57 +0100
Message-ID: <CKECLHEEHJOPHGPCOCKPEECCCCAA.troels@thule.no>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I found a bug in the sysklogd package version 1.4. When it encounters a zero
byte in the kernel logging output, the text parser enters a busy loop. I
came upon it when the 3c59x driver from kernel 2.4.0 started outputting two
zero bytes for the product code of my laptop's 3Com card. It could be argued
that the kernel should never output zero bytes in the logging info, but
obviously that will happen from time to time.

I fear this bug might be considered a security issue as well, if the kernel
can be coerced to output a zero byte somehow, all kernel logging will stop.

I have included a patch to klogd.c to correct the issue.

--- sysklogd-1.4.orig/klogd.c	Mon Sep 18 09:34:11 2000
+++ sysklogd-1.4/klogd.c	Thu Jan 11 09:26:10 2001
@@ -739,6 +758,13 @@
 		  break;  /* full line_buff or end of input buffer */
                }

+               if( *ptr == '\0' ) /* zero byte */
+               {
+                  ptr++;	/* skip zero byte */
+                  space -= 1;
+                  len   -= 1;
+                  break;
+               }
                if( *ptr == '\n' )  /* newline */
                {
                   ptr++;	/* skip newline */

--
Troels Walsted Hansen
troels@thule.no

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263570AbUCTXO7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 18:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263571AbUCTXO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 18:14:59 -0500
Received: from lmail.actcom.co.il ([192.114.47.13]:51086 "EHLO
	smtp1.actcom.co.il") by vger.kernel.org with ESMTP id S263570AbUCTXOp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 18:14:45 -0500
Date: Sun, 21 Mar 2004 01:14:39 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Muli Ben-Yehuda <mulix@mulix.org>
Subject: [PATCH/RFC] don't support %n in printk
Message-ID: <20040320231438.GX13042@mulix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The printf man page has this to say about '%n': 

"The number of characters written so far is stored into the integer
indicated by the int * (or variant)  pointer argument.   No argument
is converted." 

Very little code actually uses %n for that. Now days, %n has a much
more common use - in printf format string exploits. Since no kernel
code appears to be using %n (thus said grep), this patch removes
support for it. To preempt the obvious argument, I agree that printk
should look and behave as much as possible as printf - except where
it's harmful. We don't support floating point, for example, and I
doubt we should support %n - although I don't strongly care one way or
another. 

diff -Naurp -X /home/muli/w/dontdiff linux-2.5/lib/vsprintf.c no-n-percent/lib/vsprintf.c
--- linux-2.5/lib/vsprintf.c	2004-02-19 06:49:34.000000000 +0200
+++ no-n-percent/lib/vsprintf.c	2004-03-20 22:38:54.000000000 +0200
@@ -14,6 +14,9 @@
  * - changed to provide snprintf and vsnprintf functions
  * So Feb  1 16:51:32 CET 2004 Juergen Quade <quade@hsnr.de>
  * - scnprintf and vscnprintf
+ * Sat Mar 20 22:38:09 2004 Muli Ben-Yehuda <mulix@mulix.org>
+ * - remove '%n' support from vsnprintf, as nothing is using it, and it 
+ *   has very few legitimate uses (and many many illegitimate ones)
  */
 
 #include <stdarg.h>
@@ -401,22 +404,6 @@ int vsnprintf(char *buf, size_t size, co
 						16, field_width, precision, flags);
 				continue;
 
-
-			case 'n':
-				/* FIXME:
-				* What does C99 say about the overflow case here? */
-				if (qualifier == 'l') {
-					long * ip = va_arg(args, long *);
-					*ip = (str - buf);
-				} else if (qualifier == 'Z' || qualifier == 'z') {
-					size_t * ip = va_arg(args, size_t *);
-					*ip = (str - buf);
-				} else {
-					int * ip = va_arg(args, int *);
-					*ip = (str - buf);
-				}
-				continue;
-
 			case '%':
 				if (str <= end)
 					*str = '%';
Cheers, 
Muli 
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/


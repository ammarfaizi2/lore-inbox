Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275925AbSIURvG>; Sat, 21 Sep 2002 13:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275928AbSIURvF>; Sat, 21 Sep 2002 13:51:05 -0400
Received: from [204.60.230.251] ([204.60.230.251]:11137 "EHLO karaya.com")
	by vger.kernel.org with ESMTP id <S275925AbSIURvF>;
	Sat, 21 Sep 2002 13:51:05 -0400
Message-Id: <200209211758.g8LHwUd17425@karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: marcelo@conectiva.com.br
cc: linux-kernel@vger.kernel.org, sapan@corewars.org
Subject: [PATCH] n_tty.c buglet breaks error returns
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 21 Sep 2002 13:58:30 -0400
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The tty SIGIO fix that went into 2.4.19 breaks error returns from the 
underlying driver.  Currently, any errors from the driver causes write_chan
to call schedule() rather than returning the error.

This broke the UML test suite, the fix below makes it work again.

				Jeff


--- orig/drivers/char/n_tty.c	Tue Sep  3 17:07:15 2002
+++ um/drivers/char/n_tty.c	Sat Sep 21 13:22:32 2002
@@ -1180,7 +1180,7 @@
 			while (nr > 0) {
 				ssize_t num = opost_block(tty, b, nr);
 				if (num < 0){
-				        if(num != -EAGAIN)
+				        if(num == -EAGAIN)
 					        break;
 					retval = num;
 					goto break_out;


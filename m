Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbUDCLPo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 06:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbUDCLPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 06:15:44 -0500
Received: from mx.sz.bfs.de ([194.94.69.70]:10169 "EHLO mx.sz.bfs.de")
	by vger.kernel.org with ESMTP id S261690AbUDCLPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 06:15:42 -0500
Date: Sat, 3 Apr 2004 13:16:23 +0200
Illegal-Object: Syntax error in Message-ID: value found on vger.kernel.org:
	Message-ID:	=?ISO-8859-1?Q?=20<vines.sxdD+5od=D0?= =?ISO-8859-1?Q?+A@SZKOM.BFS.DE>
				^		  ^-illegal end of message identification
			 \-Extraneous program text, illegal start of message identification
X-Priority: 3 (Normal)
To: <linux-kernel@vger.kernel.org>
From: <WHarms@bfs.de> (Walter Harms)
Reply-To: <WHarms@bfs.de>
Subject: patch: linux-2.6.4/lib/int_sqrt.c long aware
X-Incognito-SN: 25185
X-Incognito-Version: 5.1.0.84
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
X-Amavis-Alert: BAD HEADER Non-encoded 8-bit data (char D0 hex) in message header 'Message-ID'
  Message-ID: <vines.sxdD+5od\320+A@SZKOM.BFS.DE>\n
                             ^
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Message-Id: <S261690AbUDCLPo/20040403111544Z+2692@vger.kernel.org>

hi list,
this patch make int_sqrt() handle long properly. i tested it
on my alpha and i386. also some comparision again an alternativ int_sqrt() code.
The placement (and using) of 'tmp' is a bit odd but faster (on alpha, no matter on i386).

happy hacking,
walter

ps: i must use c&p so be aware of possible tab->space translations


--- linux-2.6.4/lib/int_sqrt.c.org	2004-03-21 12:58:55.783035928 +0100
+++ linux-2.6.4/lib/int_sqrt.c	2004-03-21 13:16:20.999138928 +0100
@@ -10,22 +10,23 @@
  */
 unsigned long int_sqrt(unsigned long x)
 {
-	unsigned long op, res, one;
+	unsigned long op, res, one,tmp;
 
 	op = x;
 	res = 0;
 
-	one = 1 << 30;
+	one = 1UL << (BITS_PER_LONG-2);
 	while (one > op)
 		one >>= 2;
 
 	while (one != 0) {
+		tmp=res + one;
 		if (op >= res + one) {
-			op = op - (res + one);
-			res = res +  2 * one;
+			op = op - tmp;
+			res = tmp + one;
 		}
-		res /= 2;
-		one /= 4;
+		res >>= 1;
+		one >>= 2;
 	}
 	return res;
 }


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314811AbSG3IA4>; Tue, 30 Jul 2002 04:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314835AbSG3IA4>; Tue, 30 Jul 2002 04:00:56 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:27401 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S314811AbSG3IAz>;
	Tue, 30 Jul 2002 04:00:55 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200207300804.g6U84E017782@oboe.it.uc3m.es>
Subject: [PATCH] scanf broken in lib for %i (hex/oct) in 2.4.18
To: linux kernel <linux-kernel@vger.kernel.org>
Date: Tue, 30 Jul 2002 10:04:14 +0200 (MET DST)
Cc: crutcher+kernel@datastacks.com
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The %i directive is broken in scanf in lib/vsprintf in 2.4.18.  The
problem is that when we hit a %i fmt we should start to parse the
corresponding str with simple_strtoul, passing it a 0 base value to
indicate that it should look for itself to determine if the number is
hex, octal or decimal.  But the base=0 has somehow got lost from within
the case switch in some reorganization or other ..

It's broken as far back as 2.4.13 at least, but it's been fixed in
2.5.28, so marcelo should look at this.  Umm ..  I believe it's broken
in 2.2.20 as well.  Alan?



--- vsprintf.c.orig	Tue Jul 30 09:45:29 2002
+++ vsprintf.c	Tue Jul 30 09:39:25 2002
@@ -618,9 +618,14 @@
 			base = 16;
 			break;
 		case 'd':
-		case 'i':
+		        base = 10;
 			is_sign = 1;
 			break;
+		case 'i':
+                       /* base = 0 causes simple_strtoul to guess */
+                       base = 0;
+			is_sign = 1;
+			break;
 		case 'u':
 		        base = 10;
 			break;


Peter

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbTION7d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 09:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbTION7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 09:59:33 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:36837 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261373AbTION72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 09:59:28 -0400
Date: Mon, 15 Sep 2003 15:59:15 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: timofeev@granch.ru
Cc: linux-net@vger.kernel.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix sbni.c compile with gcc 3.3
Message-ID: <20030915135915.GF126@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sbni.c in 2.6.0-test5 fails to compile with gcc 3.3 with the following 
error:

<--  snip  -->

...
  CC      drivers/net/wan/sbni.o
...
drivers/net/wan/sbni.c: In function `calc_crc32':
drivers/net/wan/sbni.c:1568: error: asm-specifier for variable `_crc' 
conflicts with asm clobber list
make[3]: *** [drivers/net/wan/sbni.o] Error 1

<--  snip  -->

Below is the patch by Margit Schubert-White to fix this issue (it is 
already in 2.4).

cu
Adrian

--- linux/drivers/net/wan/sbni.c	2003-09-08 21:50:01.000000000 +0200
+++ linux/drivers/net/wan/sbni.c	2003-08-25 13:44:42.000000000 +0200
@@ -1562,13 +1552,13 @@
 static u32
 calc_crc32( u32  crc,  u8  *p,  u32  len )
 {
-	register u32  _crc __asm ( "ax" );
+	register u32  _crc;
 	_crc = crc;
 	
 	__asm __volatile (
 		"xorl	%%ebx, %%ebx\n"
-		"movl	%1, %%esi\n" 
-		"movl	%2, %%ecx\n" 
+		"movl	%2, %%esi\n" 
+		"movl	%3, %%ecx\n" 
 		"movl	$crc32tab, %%edi\n"
 		"shrl	$2, %%ecx\n"
 		"jz	1f\n"
@@ -1604,7 +1594,7 @@
 		"jnz	0b\n"
 
 	"1:\n"
-		"movl	%2, %%ecx\n"
+		"movl	%3, %%ecx\n"
 		"andl	$3, %%ecx\n"
 		"jz	2f\n"
 
@@ -1629,9 +1619,9 @@
 		"xorb	2(%%esi), %%bl\n"
 		"xorl	(%%edi,%%ebx,4), %%eax\n"
 	"2:\n"
-		:
-		: "a" (_crc), "g" (p), "g" (len)
-		: "ax", "bx", "cx", "dx", "si", "di"
+		: "=a" (_crc)
+		: "0" (_crc), "g" (p), "g" (len)
+		: "bx", "cx", "dx", "si", "di"
 	);
 
 	return  _crc;



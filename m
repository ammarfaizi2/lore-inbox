Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264558AbUAaMw4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 07:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264563AbUAaMw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 07:52:56 -0500
Received: from pop.gmx.de ([213.165.64.20]:17894 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264558AbUAaMwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 07:52:51 -0500
X-Authenticated: #21910825
Message-ID: <401BA520.7070204@gmx.net>
Date: Sat, 31 Jan 2004 13:52:48 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] [2.6.2-rc3] Fix module.c pointer arithmetics
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040506040303040806050402"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040506040303040806050402
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus,
Rusty,

while studying the module code closely, I found a problem in
kernel/module.c:153ff.

for (i = 0; __start___ksymtab+i < __stop___ksymtab; i++)

In combination with __start___ksymtab[i].name this will go eight times too
far. Proposed fix is attached.

Please apply before 2.6.2. If you think this makes the code too slow, I
can offer an alternative which will even speed up the current code.

Thanks,
Carl-Daniel

--------------040506040303040806050402
Content-Type: text/plain;
 name="modulefix.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="modulefix.txt"

===== kernel/module.c 1.99 vs edited =====
--- 1.99/kernel/module.c	Wed Jan 21 02:50:58 2004
+++ edited/kernel/module.c	Sat Jan 31 13:50:47 2004
@@ -150,14 +150,14 @@
 
 	/* Core kernel first. */ 
 	*owner = NULL;
-	for (i = 0; __start___ksymtab+i < __stop___ksymtab; i++) {
+	for (i = 0; __start___ksymtab+i*sizeof(struct kernel_symbol) < __stop___ksymtab; i++) {
 		if (strcmp(__start___ksymtab[i].name, name) == 0) {
 			*crc = symversion(__start___kcrctab, i);
 			return __start___ksymtab[i].value;
 		}
 	}
 	if (gplok) {
-		for (i = 0; __start___ksymtab_gpl+i<__stop___ksymtab_gpl; i++)
+		for (i = 0; __start___ksymtab_gpl+i*sizeof(struct kernel_symbol) < __stop___ksymtab_gpl; i++)
 			if (strcmp(__start___ksymtab_gpl[i].name, name) == 0) {
 				*crc = symversion(__start___kcrctab_gpl, i);
 				return __start___ksymtab_gpl[i].value;
@@ -1308,7 +1308,7 @@
 	unsigned int i;
 
 	if (!mod) {
-		for (i = 0; __start___ksymtab+i < __stop___ksymtab; i++)
+		for (i = 0; __start___ksymtab+i*sizeof(struct kernel_symbol) < __stop___ksymtab; i++)
 			if (strcmp(__start___ksymtab[i].name, name) == 0)
 				return 1;
 		return 0;

--------------040506040303040806050402--


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266003AbUFOWkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266003AbUFOWkW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 18:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266004AbUFOWkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 18:40:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:24481 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266003AbUFOWkP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 18:40:15 -0400
Date: Tue, 15 Jun 2004 15:40:11 -0700
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix simple_strtoul base 16 handling
Message-ID: <20040615154011.D22989@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know it's simple_strtoul, but is it meant to be that simple?  Fix up
for both simple_strtoul and simple_strtoull.

simple_strtoul(0x401b, NULL, 0) = 0x401b
simple_strtoul(0X401b, NULL, 0) = 0x0
simple_strtoul(0x401b, NULL, 16) = 0x0
simple_strtoul(0X401b, NULL, 16) = 0x0

simple_strtoull(0x401b, NULL, 0) = 0x401b
simple_strtoull(0X401b, NULL, 0) = 0x0
simple_strtoull(0x401b, NULL, 16) = 0x0
simple_strtoull(0X401b, NULL, 16) = 0x0

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== lib/vsprintf.c 1.22 vs edited =====
--- 1.22/lib/vsprintf.c	2004-02-18 19:42:41 -08:00
+++ edited/lib/vsprintf.c	2004-06-15 14:41:22 -07:00
@@ -40,11 +40,14 @@
 		if (*cp == '0') {
 			base = 8;
 			cp++;
-			if ((*cp == 'x') && isxdigit(cp[1])) {
+			if ((toupper(*cp) == 'X') && isxdigit(cp[1])) {
 				cp++;
 				base = 16;
 			}
 		}
+	} else if (base == 16) {
+		if (cp[0] == '0' && toupper(cp[1]) == 'X')
+			cp += 2;
 	}
 	while (isxdigit(*cp) &&
 	       (value = isdigit(*cp) ? *cp-'0' : toupper(*cp)-'A'+10) < base) {
@@ -88,11 +91,14 @@
 		if (*cp == '0') {
 			base = 8;
 			cp++;
-			if ((*cp == 'x') && isxdigit(cp[1])) {
+			if ((toupper(*cp) == 'X') && isxdigit(cp[1])) {
 				cp++;
 				base = 16;
 			}
 		}
+	} else if (base == 16) {
+		if (cp[0] == '0' && toupper(cp[1]) == 'X')
+			cp += 2;
 	}
 	while (isxdigit(*cp) && (value = isdigit(*cp) ? *cp-'0' : (islower(*cp)
 	    ? toupper(*cp) : *cp)-'A'+10) < base) {

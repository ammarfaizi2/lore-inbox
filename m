Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129190AbRBZRch>; Mon, 26 Feb 2001 12:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129257AbRBZRc1>; Mon, 26 Feb 2001 12:32:27 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:772 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S129190AbRBZRcU>; Mon, 26 Feb 2001 12:32:20 -0500
Date: Mon, 26 Feb 2001 20:31:41 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] isofs/joliet broken on alpha
Message-ID: <20010226203141.A513@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

uni16_to_x8() loads unaligned u16 words, returning bogus file names
on an ev5 and older alpha CPUs...

Ivan.

--- 2.4.2-ac4/fs/isofs/joliet.c	Fri Feb  9 22:29:44 2001
+++ linux/fs/isofs/joliet.c	Mon Feb 26 17:06:54 2001
@@ -10,6 +10,7 @@
 #include <linux/nls.h>
 #include <linux/slab.h>
 #include <linux/iso_fs.h>
+#include <asm/unaligned.h>
 
 /*
  * Convert Unicode 16 to UTF8 or ASCII.
@@ -17,15 +18,15 @@
 static int
 uni16_to_x8(unsigned char *ascii, u16 *uni, int len, struct nls_table *nls)
 {
-	wchar_t *ip;
+	wchar_t *ip, ch;
 	unsigned char *op;
 
 	ip = uni;
 	op = ascii;
 
-	while (*ip && len) {
+	while ((ch = get_unaligned(ip)) && len) {
 		int llen;
-		wchar_t ch = be16_to_cpu(*ip);
+		ch = be16_to_cpu(ch);
 		if ((llen = nls->uni2char(ch, op, NLS_MAX_CHARSET_SIZE)) > 0)
 			op += llen;
 		else

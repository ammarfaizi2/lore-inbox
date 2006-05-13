Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbWEMXG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWEMXG2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 19:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWEMXG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 19:06:28 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:19371 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750996AbWEMXG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 19:06:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RKGIk6f1198Jun4Wldyah9Ixc5Ft4M4Lq+xQ1xW6R36eWibNkv5WRiOCiT/Fd2ieI5QrXtWkiJ9PM/HE5xH6TI1LZwEAIRUuRYlEenqJIG+QvFHyx5UkGTbovWjm7HdnK9A4/d1H3Jhqfl2b6fBr3ol7nrQViBfOuQWOr4wNPh4=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: fix memory leaks in phram_setup
Date: Sun, 14 May 2006 01:07:18 +0200
User-Agent: KMail/1.9.1
Cc: Jochen =?iso-8859-1?q?Sch=E4uble?= <psionic@psionic.de>,
       =?iso-8859-1?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Thomas Gleixner <tglx@linutronix.de>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605140107.18293.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There are two code paths in drivers/mtd/devices/phram.c::phram_setup() that
will leak memory.
Memory is allocated to the variable 'name' with kmalloc() by the 
parse_name() function, but if we leave by way of the parse_err() macro, 
then that memory is never kfree()'d, nor is it ever used with 
register_device() so it won't be freed later either - leak.

Found by the Coverity checker as #593 - simple fix below.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---


 drivers/mtd/devices/phram.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)


--- linux-2.6.17-rc4-git2-orig/drivers/mtd/devices/phram.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.17-rc4-git2/drivers/mtd/devices/phram.c	2006-05-14 01:05:27.000000000 +0200
@@ -266,12 +266,16 @@ static int phram_setup(const char *val, 
 		return 0;
 
 	ret = parse_num32(&start, token[1]);
-	if (ret)
+	if (ret) {
+		kfree(name);
 		parse_err("illegal start address\n");
+	}
 
 	ret = parse_num32(&len, token[2]);
-	if (ret)
+	if (ret) {
+		kfree(name);
 		parse_err("illegal device length\n");
+	}
 
 	register_device(name, start, len);
 





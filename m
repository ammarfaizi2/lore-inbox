Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbWEMXlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWEMXlg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 19:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWEMXlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 19:41:36 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:7643 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964807AbWEMXle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 19:41:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RLAp1XmoOtE8e1ZZtx6H/427IZTch53XJa+0lDPnIOAis3olIkcjKztZOIHYnZcayDgwD4yj/0Oad2GyWrZsHbciXsxXUHUNowes84BUgKgzzLooeaRGOFwtwdAjp0ywjr8moDRSTllnPTP6egZaXNPpLKbyWRzgRnGVj/VA1a4=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: fix memory leak in block2mtd_setup()
Date: Sun, 14 May 2006 01:42:25 +0200
User-Agent: KMail/1.9.1
Cc: Simon Evans <spse@secret.org.uk>,
       =?iso-8859-1?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       David Woodhouse <dwmw2@infradead.org>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605140142.25486.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's a mem leak in drivers/mtd/devices/block2mtd.c::block2mtd_setup()

We can leak 'name' allocated with kmalloc in 'parse_name' if leave via
the 'parse_err' macro since it contains a return but doesn't do any 
freeing.

Spotted by coverity checker as bug 615.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---


 drivers/mtd/devices/block2mtd.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)


--- linux-2.6.17-rc4-git2-orig/drivers/mtd/devices/block2mtd.c	2006-05-13 21:28:27.000000000 +0200
+++ linux-2.6.17-rc4-git2/drivers/mtd/devices/block2mtd.c	2006-05-14 01:33:36.000000000 +0200
@@ -418,7 +418,8 @@ static inline void kill_final_newline(ch
 
 static int block2mtd_setup(const char *val, struct kernel_param *kp)
 {
-	char buf[80+12], *str=buf; /* 80 for device, 12 for erase size */
+	char buf[80+12]; /* 80 for device, 12 for erase size */
+	char *str = buf;
 	char *token[2];
 	char *name;
 	size_t erase_size = PAGE_SIZE;
@@ -430,7 +431,7 @@ static int block2mtd_setup(const char *v
 	strcpy(str, val);
 	kill_final_newline(str);
 
-	for (i=0; i<2; i++)
+	for (i = 0; i < 2; i++)
 		token[i] = strsep(&str, ",");
 
 	if (str)
@@ -449,8 +450,10 @@ static int block2mtd_setup(const char *v
 
 	if (token[1]) {
 		ret = parse_num(&erase_size, token[1]);
-		if (ret)
+		if (ret) {
+			kfree(name);
 			parse_err("illegal erase size");
+		}
 	}
 
 	add_device(name, erase_size);





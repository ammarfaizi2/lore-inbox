Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267992AbUIAVWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267992AbUIAVWy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267935AbUIAVTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:19:53 -0400
Received: from mail.dif.dk ([193.138.115.101]:6584 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S267864AbUIAVTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 17:19:07 -0400
Date: Wed, 1 Sep 2004 23:25:00 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@muc.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH][x86_64] read_ldt() neglects checking of clear_user() return
 value - for x86_64 this time.
Message-ID: <Pine.LNX.4.61.0409012310130.2724@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

Here's an identical patch to the one that just went into 2.6.9-rc1-mm2 for 
i386, but this time for x86_64. read_ldt() never checks the return value 
of clear_user(). Since I don't have x86_64 hardware I'm not able to test 
this like I did the i386 version.

Please consider applying.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.9-rc1-bk6/arch/x86_64/kernel/ldt.c~ linux-2.6.9-rc1-bk6/arch/x86_64/kernel/ldt.c
--- linux-2.6.9-rc1-bk6/arch/x86_64/kernel/ldt.c~	2004-09-01 23:08:15.000000000 +0200
+++ linux-2.6.9-rc1-bk6/arch/x86_64/kernel/ldt.c	2004-09-01 23:08:15.000000000 +0200
@@ -135,6 +135,7 @@ static int read_ldt(void __user * ptr, u
 		return 0;
 	if (bytecount > LDT_ENTRY_SIZE*LDT_ENTRIES)
 		bytecount = LDT_ENTRY_SIZE*LDT_ENTRIES;
+
 	down(&mm->context.sem);
 	size = mm->context.size*LDT_ENTRY_SIZE;
 	if (size > bytecount)
@@ -145,12 +146,17 @@ static int read_ldt(void __user * ptr, u
 		err = -EFAULT;
 	up(&mm->context.sem);
 	if (err < 0)
-	return err;
+		goto error_return;
 	if (size != bytecount) {
 		/* zero-fill the rest */
-		clear_user(ptr+size, bytecount-size);
+		if (clear_user(ptr+size, bytecount-size) != 0) {
+			err = -EFAULT;
+			goto error_return;
+		}
 	}
 	return bytecount;
+error_return:
+	return err;
 }
 
 static int read_default_ldt(void __user * ptr, unsigned long bytecount)



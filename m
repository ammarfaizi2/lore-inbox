Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265144AbUH3XFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbUH3XFQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 19:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUH3XFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 19:05:16 -0400
Received: from mail.dif.dk ([193.138.115.101]:60600 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S265144AbUH3XFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 19:05:00 -0400
Date: Tue, 31 Aug 2004 01:10:52 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Ingo Molnar <mingo@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] read_ldt() neglects to check clear_user() return value
Message-ID: <Pine.LNX.4.61.0408310049020.2711@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

I just noticed a small warning when building 2.6.9-rc1-bk6 :

arch/i386/kernel/ldt.c: In function read_ldt':
arch/i386/kernel/ldt.c:148: warning: ignoring return value of clear_user', declared with attribute warn_unused_result

So I went to investigate, and indeed, read_ldt() does neglect to check the 
return value from clear_user().
I propose the patch below to fix it, but I'm not 100% sure that returning 
-EFAULT is the correct thing to do here, so please review.
It /seems/ to me that -EFAULT is appropriate in this case, it would make 
sense to me - if we can't clear the rest of the memory pointed to by the 
user*, surely that should generate a FAULT - or?
The kernel builds fine with this change applied (and does kill the warning 
of course).
The kernel boots fine with this change (running it at the moment and so 
far I've not noticed any ill effects).

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.9-rc1-bk6/arch/i386/kernel/ldt.c~ linux-2.6.9-rc1-bk6/arch/i386/kernel/ldt.c
--- linux-2.6.9-rc1-bk6/arch/i386/kernel/ldt.c~	2004-08-31 00:36:22.000000000 +0200
+++ linux-2.6.9-rc1-bk6/arch/i386/kernel/ldt.c	2004-08-31 00:36:22.000000000 +0200
@@ -142,12 +142,17 @@ static int read_ldt(void __user * ptr, u
 		err = -EFAULT;
 	up(&mm->context.sem);
 	if (err < 0)
-		return err;
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



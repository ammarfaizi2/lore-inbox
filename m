Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130142AbRCBX3u>; Fri, 2 Mar 2001 18:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130143AbRCBX3k>; Fri, 2 Mar 2001 18:29:40 -0500
Received: from [62.172.234.2] ([62.172.234.2]:23080 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S130142AbRCBX3T>; Fri, 2 Mar 2001 18:29:19 -0500
Date: Fri, 2 Mar 2001 23:29:02 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Russell King <rmk@arm.linux.org.uk>, "Theodore Ts'o" <tytso@mit.edu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] alloc_tty_struct() wastage?
In-Reply-To: <E14YteS-00020L-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0103022326070.1719-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been puzzling over alloc_tty_struct(), which seems determined
to waste memory on a machine of page size 8KB.  I've come to the
conclusion that it represents great caution on Russell's part
when introducing ARM, not to interfere with existing code of
other architectures - is that so, Russell?

But wouldn't we do better to use kmalloc() in all cases?  Unless
you know some reason why a tty_struct is better on its own page:
patch below against 2.4.2-ac9, applies with noise to 2.4.[012].

(I'm not about to follow this with a thousand patches,
replacing page allocation by kmalloc() in sundry places:
now's not the time, but this instance struck me as odd.)

Hugh

--- 2.4.2-ac9/drivers/char/tty_io.c	Fri Mar  2 18:22:36 2001
+++ linux/drivers/char/tty_io.c	Fri Mar  2 18:23:42 2001
@@ -173,22 +173,15 @@
 {
 	struct tty_struct *tty;
 
-	if (PAGE_SIZE > 8192) {
-		tty = kmalloc(sizeof(struct tty_struct), GFP_KERNEL);
-		if (tty)
-			memset(tty, 0, sizeof(struct tty_struct));
-	} else
-		tty = (struct tty_struct *)get_zeroed_page(GFP_KERNEL);
-
+	tty = kmalloc(sizeof(struct tty_struct), GFP_KERNEL);
+	if (tty)
+		memset(tty, 0, sizeof(struct tty_struct));
 	return tty;
 }
 
 static inline void free_tty_struct(struct tty_struct *tty)
 {
-	if (PAGE_SIZE > 8192)
-		kfree(tty);
-	else
-		free_page((unsigned long) tty);
+	kfree(tty);
 }
 
 /*
@@ -2239,9 +2232,6 @@
  */
 void __init tty_init(void)
 {
-	if (sizeof(struct tty_struct) > PAGE_SIZE)
-		panic("size of tty structure > PAGE_SIZE!");
-
 	/*
 	 * dev_tty_driver and dev_console_driver are actually magic
 	 * devices which get redirected at open time.  Nevertheless,


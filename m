Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284781AbRLKBwX>; Mon, 10 Dec 2001 20:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284779AbRLKBwN>; Mon, 10 Dec 2001 20:52:13 -0500
Received: from zero.tech9.net ([209.61.188.187]:775 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S284781AbRLKBwC>;
	Mon, 10 Dec 2001 20:52:02 -0500
Subject: [PATCH] console close race fix resend
From: Robert Love <rml@tech9.net>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.06.08.57 (Preview Release)
Date: 10 Dec 2001 20:51:51 -0500
Message-Id: <1008035512.4287.1.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

[ Resend of previous patch, now against pre8.  Note it (a) is a bug fix
and (b) was in Alan's tree ]

The attached is a fix originally by Andrew Morton and discovered by the
preempt-kernel patch.  It is in Alan's tree but was never merged into
Linus's.

There is a race between con_close and con_flush_chars. 
n_tty_receive_buf writes to the tty queue and then flushes it via
con_flush_chars.  If the console closes in between these operations,
con_flush_char barfs.

Please, for all that is righteous, apply.

	Robert Love

diff -urN linux-2.4.17-pre8/drivers/char/console.c linux/drivers/char/console.c
--- linux-2.4.17-pre8/drivers/char/console.c	Thu Dec  6 14:08:14 2001
+++ linux/drivers/char/console.c	Thu Dec  6 14:09:06 2001
@@ -2356,8 +2356,14 @@
 		return;
 
 	pm_access(pm_con);
+	
+	/*
+	 * If we raced with con_close(), `vt' may be null.
+	 * Hence this bandaid.   - akpm
+	 */
 	acquire_console_sem();
-	set_cursor(vt->vc_num);
+	if (vt)
+		set_cursor(vt->vc_num);
 	release_console_sem();
 }


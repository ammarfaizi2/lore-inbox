Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284636AbRLIXQa>; Sun, 9 Dec 2001 18:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284638AbRLIXQZ>; Sun, 9 Dec 2001 18:16:25 -0500
Received: from zero.tech9.net ([209.61.188.187]:32006 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S284636AbRLIXP2>;
	Sun, 9 Dec 2001 18:15:28 -0500
Subject: [PATCH] console close race fix
From: Robert Love <rml@tech9.net>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.06.08.57 (Preview Release)
Date: 09 Dec 2001 18:15:26 -0500
Message-Id: <1007939727.1237.5.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

The attached is a fix originally by Andrew Morton and discovered by the
preempt-kernel patch.  It is in Alan's tree but was never merged into
Linus's.

There is a race between con_close and con_flush_chars. 
n_tty_receive_buf writes to the tty queue and then flushes it via
con_flush_chars.  If the console closes in between these operations,
con_flush_char barfs.

Please, for all that is righteous, apply.

	Robert Love

diff -urN linux-2.4.17-pre7/drivers/char/console.c linux/drivers/char/console.c
--- linux-2.4.17-pre6/drivers/char/console.c	Thu Dec  6 14:08:14 2001
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


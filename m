Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279837AbRJ3DNh>; Mon, 29 Oct 2001 22:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279835AbRJ3DN1>; Mon, 29 Oct 2001 22:13:27 -0500
Received: from zero.tech9.net ([209.61.188.187]:268 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S279834AbRJ3DNQ>;
	Mon, 29 Oct 2001 22:13:16 -0500
Subject: Re: [PATCH] tty race on con_close and con_flush_chars
From: Robert Love <rml@tech9.net>
To: Robert Love <rml@tech9.net>
Cc: linus@transmeta.com, laughing@shared-source.org,
        linux-kernel@vger.kernel.org, tytso@thunk.org, andrewm@uow.edu.au
In-Reply-To: <1004403868.809.147.camel@phantasy>
In-Reply-To: <1004403868.809.147.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.28.13.59 (Preview Release)
Date: 29 Oct 2001 22:13:55 -0500
Message-Id: <1004411636.807.262.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone pointed out (via private email) that a race can still exist
between checking that vt is non-zero and acquiring the semaphore,
especially since we can sleep doing that.

I agree; the following patch should alleviate that race.

diff -u linux-2.4.13-ac5/drivers/char/console.c
linux/drivers/char/console.c
--- linux-2.4.13-ac5/drivers/char/console.c	Mon Oct 29 17:27:19 2001
+++ linux/drivers/char/console.c	Mon Oct 29 22:11:27 2001
@@ -2387,8 +2387,14 @@
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
 

	Robert Love


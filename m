Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262094AbVCNJwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbVCNJwJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 04:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbVCNJwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 04:52:09 -0500
Received: from fire.osdl.org ([65.172.181.4]:24013 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262089AbVCNJvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 04:51:54 -0500
Date: Mon, 14 Mar 2005 01:51:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [TTY] overrun notify issue during 5 minutes after booting
Message-Id: <20050314015141.26d42c1a.akpm@osdl.org>
In-Reply-To: <20050314093145.56419.qmail@web25109.mail.ukl.yahoo.com>
References: <20050314093145.56419.qmail@web25109.mail.ukl.yahoo.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

moreau francis <francis_moreau2000@yahoo.fr> wrote:
>
> I noticed that TTY is not able to notify overrun issue
>  in "n_tty_receive_overrun". Actually it's because of
>  "time_before" macro which tests "tty->overrun_time" 
>  (equals to 0) against "jiffies - HZ" (something very
>  big
>  after booting).
>  I guess a simple way to solve it, is to initialize
>  "tty->overrun_time" to "jiffies". But it won't work if
>  an overrun appear after a very long while....

How does this look?


--- 25/drivers/char/tty_io.c~tty-overrun-time-fix	2005-03-14 01:45:43.000000000 -0800
+++ 25-akpm/drivers/char/tty_io.c	2005-03-14 01:46:02.000000000 -0800
@@ -2632,6 +2632,7 @@ static void initialize_tty_struct(struct
 	tty->magic = TTY_MAGIC;
 	tty_ldisc_assign(tty, tty_ldisc_get(N_TTY));
 	tty->pgrp = -1;
+	tty->overrun_time = jiffies;
 	tty->flip.char_buf_ptr = tty->flip.char_buf;
 	tty->flip.flag_buf_ptr = tty->flip.flag_buf;
 	INIT_WORK(&tty->flip.work, flush_to_ldisc, tty);
diff -puN drivers/char/n_tty.c~tty-overrun-time-fix drivers/char/n_tty.c
--- 25/drivers/char/n_tty.c~tty-overrun-time-fix	2005-03-14 01:49:25.000000000 -0800
+++ 25-akpm/drivers/char/n_tty.c	2005-03-14 01:50:10.000000000 -0800
@@ -606,9 +606,11 @@ static inline void n_tty_receive_overrun
 	char buf[64];
 
 	tty->num_overrun++;
-	if (time_before(tty->overrun_time, jiffies - HZ)) {
-		printk(KERN_WARNING "%s: %d input overrun(s)\n", tty_name(tty, buf),
-		       tty->num_overrun);
+	if (time_before(tty->overrun_time, jiffies - HZ) ||
+			time_after(tty->overrun_time, jiffies)) {
+		printk(KERN_WARNING "%s: %d input overrun(s)\n",
+			tty_name(tty, buf),
+			tty->num_overrun);
 		tty->overrun_time = jiffies;
 		tty->num_overrun = 0;
 	}
_


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbUCaC0c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 21:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbUCaC0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 21:26:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:55246 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261678AbUCaC0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 21:26:31 -0500
Date: Tue, 30 Mar 2004 18:26:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc3-mm1
Message-Id: <20040330182627.0e43f1ae.akpm@osdl.org>
In-Reply-To: <20040330162850.50a0fad4.akpm@osdl.org>
References: <20040330023437.72bb5192.akpm@osdl.org>
	<20040331000301.GB9269@kroah.com>
	<20040330162850.50a0fad4.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> I'm thinking that this can be fixed from the other direction: just before
>  release_dev() calls close (dropping BKL), if tty->count==1, make the
>  going-away tty ineligible for concurrent lookups.  Do that by setting
>  tty->driver->ttys[idx] to NULL.  Maybe.

Famous last word: Volia!


diff -puN drivers/char/tty_io.c~tty-race-fix-42 drivers/char/tty_io.c
--- 25/drivers/char/tty_io.c~tty-race-fix-42	Tue Mar 30 16:30:55 2004
+++ 25-akpm/drivers/char/tty_io.c	Tue Mar 30 16:35:21 2004
@@ -1142,6 +1142,17 @@ static void release_dev(struct file * fi
 	}
 #endif
 
+	/*
+	 * ->close can sleep, and drop the BKL.  If this tty is about to
+	 * be destroyed we need to prevent other threads from coming in and
+	 * grabbing a new ref against the about-to-die tty.  Those threads
+	 * perform the lookup via tty->driver->ttys[], in init_dev().
+	 */
+	if (tty->count == 1) {
+		if (!(tty->driver->flags & TTY_DRIVER_DEVPTS_MEM))
+			tty->driver->ttys[idx] = NULL;
+	}
+
 	if (tty->driver->close)
 		tty->driver->close(tty, filp);
 



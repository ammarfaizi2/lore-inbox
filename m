Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWBMWnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWBMWnI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 17:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbWBMWnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 17:43:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43156 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964846AbWBMWnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 17:43:07 -0500
Date: Mon, 13 Feb 2006 17:51:41 -0500 (EST)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-105.boston.redhat.com
To: Paul Fulghum <paulkf@microgate.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "jesper.juhl@gmail.com" <jesper.juhl@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] tty reference count fix
In-Reply-To: <1139861610.3573.24.camel@amdx2.microgate.com>
Message-ID: <Pine.LNX.4.61.0602131747570.19384@dhcp83-105.boston.redhat.com>
References: <1139861610.3573.24.camel@amdx2.microgate.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Feb 2006, Paul Fulghum wrote:

> Fix hole where tty structure can be released when reference
> count is non zero. Existing code can sleep without tty_sem
> protection between deciding to release the tty structure
> (setting local variables tty_closing and otty_closing)
> and setting TTY_CLOSING to prevent further opens.
> An open can occur during this interval causing release_dev()
> to free the tty structure while it is still referenced.
> 
> This should fix bugzilla.kernel.org
> [Bug 6041] New: Unable to handle kernel paging request
> 
> In Bug 6041, tty_open() oopes on accessing the tty structure
> it has successfully claimed. Bug was on SMP machine
> with the same tty being opened and closed by
> multiple processes, and DEBUG_PAGEALLOC enabled.
> 

patch looks good to me. Or you could even drop the tty_sem completely from 
the release_dev path (patch below) since lock_kernel() is held in both 
tty_open() and the release_dev paths() (and there is no sleeping b/w 
setting the tty_closing flag and setting the TTY_CLOSING bit).

-Jason


Signed-off-by: Jason Baron <jbaron@redhat.com>

--- linux-2.6-working/drivers/char/tty_io.c.bak
+++ linux-2.6-working/drivers/char/tty_io.c
@@ -1829,14 +1829,9 @@ static void release_dev(struct file * fi
 	 * each iteration we avoid any problems.
 	 */
 	while (1) {
-		/* Guard against races with tty->count changes elsewhere and
-		   opens on /dev/tty */
-		   
-		down(&tty_sem);
 		tty_closing = tty->count <= 1;
 		o_tty_closing = o_tty &&
 			(o_tty->count <= (pty_master ? 1 : 0));
-		up(&tty_sem);
 		do_sleep = 0;
 
 		if (tty_closing) {
@@ -1873,7 +1868,6 @@ static void release_dev(struct file * fi
 	 * block, so it's safe to proceed with closing.
 	 */
 	 
-	down(&tty_sem);
 	if (pty_master) {
 		if (--o_tty->count < 0) {
 			printk(KERN_WARNING "release_dev: bad pty slave count "
@@ -1887,7 +1881,6 @@ static void release_dev(struct file * fi
 		       tty->count, tty_name(tty, buf));
 		tty->count = 0;
 	}
-	up(&tty_sem);
 	
 	/*
 	 * We've decremented tty->count, so we need to remove this file

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVAWSXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVAWSXI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 13:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVAWSXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 13:23:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:2013 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261246AbVAWSXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 13:23:02 -0500
Date: Sun, 23 Jan 2005 10:22:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Sergey Vlasov <vsu@altlinux.ru>
cc: ierdnah <ierdnah@go.ro>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel oops!
In-Reply-To: <20050123161512.149cc9de.vsu@altlinux.ru>
Message-ID: <Pine.LNX.4.58.0501230956100.4191@ppc970.osdl.org>
References: <1106437010.32072.0.camel@ierdnac> <Pine.LNX.4.58.0501222223090.4191@ppc970.osdl.org>
 <20050123161512.149cc9de.vsu@altlinux.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 23 Jan 2005, Sergey Vlasov wrote:
> 
> tty_poll() grabs ldisc reference for the tty it was called with;
> however, in this case pty_chars_in_buffer() accesses another ldisc
> (tty->link->ldisc) without grabbing a reference to it.  BTW, many other
> pty_* functions do the same thing.

Yes, I think you put the finger on it.

> Is calling tty_ldisc_ref(tty->link) safe here?  There is a comment
> warning about possible deadlocks before pty_write().

I think it's only the tty_ldisc_ref_wait() thing that can deadlock (and 
even that is likely safe if you just specify an order - "masters first" or 
something). Adding a nonblocking "tty_ldisc_ref()" looks safe, ie 
something like the appended.

This has the problem (apart from the fact that it's obviously totally
untested ;) that it looks like every single pty function would need to do
it, so it would be nicer if "tty_ldisc_ref_wait()" would just always get
both references (ie do the ordering). Alan?

		Linus
----
--- 1.32/drivers/char/pty.c	2005-01-10 17:29:36 -08:00
+++ edited/drivers/char/pty.c	2005-01-23 10:21:04 -08:00
@@ -149,13 +149,17 @@
 static int pty_chars_in_buffer(struct tty_struct *tty)
 {
 	struct tty_struct *to = tty->link;
-	int count;
+	int count = 0;
 
-	if (!to || !to->ldisc.chars_in_buffer)
-		return 0;
-
-	/* The ldisc must report 0 if no characters available to be read */
-	count = to->ldisc.chars_in_buffer(to);
+	if (to) {
+		struct tty_ldisc *ld = tty_ldisc_ref(to);
+		if (ld) {
+			if (ld->chars_in_buffer) {
+				count = ld->chars_in_buffer(to);
+				tty_ldisc_deref(ld);
+			}
+		}
+	}
 
 	if (tty->driver->subtype == PTY_TYPE_SLAVE) return count;
 

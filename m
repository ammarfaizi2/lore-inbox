Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVAWRwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVAWRwF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 12:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVAWRwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 12:52:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:43716 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261335AbVAWRv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 12:51:59 -0500
Date: Sun, 23 Jan 2005 09:51:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: ierdnah <ierdnah@go.ro>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel oops!
In-Reply-To: <1106483340.21951.4.camel@ierdnac>
Message-ID: <Pine.LNX.4.58.0501230943020.4191@ppc970.osdl.org>
References: <1106437010.32072.0.camel@ierdnac>  <Pine.LNX.4.58.0501222223090.4191@ppc970.osdl.org>
 <1106483340.21951.4.camel@ierdnac>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 23 Jan 2005, ierdnah wrote:
> 
> (gdb) disassemble pty_chars_in_buffer
...
> 0xc02c97a7 <pty_chars_in_buffer+23>:    mov    0x28(%edx),%ecx **
> 0xc02c97aa <pty_chars_in_buffer+26>:    test   %ecx,%ecx
> 0xc02c97ac <pty_chars_in_buffer+28>:    jne    0xc02c97b6
> 0xc02c97ae <pty_chars_in_buffer+30>:    mov    0x4(%esp,1),%ebx
> 0xc02c97b2 <pty_chars_in_buffer+34>:    add    $0x8,%esp
> 0xc02c97b5 <pty_chars_in_buffer+37>:    ret
> 0xc02c97b6 <pty_chars_in_buffer+38>:    mov    %edx,(%esp,1)
> 0xc02c97b9 <pty_chars_in_buffer+41>:    call   *0x28(%edx) **

Ahh, indeed. When I compiled this function, it kept 0x28(%edx) in a 
register. Your config/compiler combination does not, so there actually is 
a race condition if somebody changes the function pointer.

> this is another compiled kernel, but is compiled with the same .config
> file and same gcc version...because I only have the bzImage, how do I
> convert it to vmlinux?

Don't worry, it clearly shows that it's at least possible, and worth 
looking at. 

For testing, a patch like this might get rid of the problem by hiding the
race (but for all I know, gcc ends up re-loading it anyway) - you might 
want to check the disassembly. 

However, this patch is just for testing, to verify that your problem 
really is that particular race. It's not a proper fix.

I suspect that pty's should always lock each others line disciplines too, 
not just their "own" side.

		Linus

----
--- 1.32/drivers/char/pty.c	2005-01-10 17:29:36 -08:00
+++ edited/drivers/char/pty.c	2005-01-23 09:49:16 -08:00
@@ -149,13 +149,15 @@
 static int pty_chars_in_buffer(struct tty_struct *tty)
 {
 	struct tty_struct *to = tty->link;
+	ssize_t (*chars_in_buffer)(struct tty_struct *);
 	int count;
 
-	if (!to || !to->ldisc.chars_in_buffer)
+	/* We should get the line discipline lock for "tty->link" */
+	if (!to || !(chars_in_buffer = to->ldisc.chars_in_buffer))
 		return 0;
 
 	/* The ldisc must report 0 if no characters available to be read */
-	count = to->ldisc.chars_in_buffer(to);
+	count = chars_in_buffer(to);
 
 	if (tty->driver->subtype == PTY_TYPE_SLAVE) return count;
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVA0WsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVA0WsX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 17:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVA0Wrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 17:47:51 -0500
Received: from s2.home.ro ([193.231.236.41]:9089 "EHLO s2.home.ro")
	by vger.kernel.org with ESMTP id S261261AbVA0Wrd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 17:47:33 -0500
Subject: Re: kernel oops!
From: ierdnah <ierdnah@go.ro>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0501230943020.4191@ppc970.osdl.org>
References: <1106437010.32072.0.camel@ierdnac>
	 <Pine.LNX.4.58.0501222223090.4191@ppc970.osdl.org>
	 <1106483340.21951.4.camel@ierdnac>
	 <Pine.LNX.4.58.0501230943020.4191@ppc970.osdl.org>
Content-Type: text/plain
Date: Fri, 28 Jan 2005 00:47:46 +0200
Message-Id: <1106866066.20523.3.camel@ierdnac>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-23 at 09:51 -0800, Linus Torvalds wrote:


with this patch the oops is gone(also tested with PREEMPT and no oops)
> 
> ----
> --- 1.32/drivers/char/pty.c	2005-01-10 17:29:36 -08:00
> +++ edited/drivers/char/pty.c	2005-01-23 09:49:16 -08:00
> @@ -149,13 +149,15 @@
>  static int pty_chars_in_buffer(struct tty_struct *tty)
>  {
>  	struct tty_struct *to = tty->link;
> +	ssize_t (*chars_in_buffer)(struct tty_struct *);
>  	int count;
>  
> -	if (!to || !to->ldisc.chars_in_buffer)
> +	/* We should get the line discipline lock for "tty->link" */
> +	if (!to || !(chars_in_buffer = to->ldisc.chars_in_buffer))
>  		return 0;
>  
>  	/* The ldisc must report 0 if no characters available to be read */
> -	count = to->ldisc.chars_in_buffer(to);
> +	count = chars_in_buffer(to);
>  
>  	if (tty->driver->subtype == PTY_TYPE_SLAVE) return count;
>  

is this patch better? should i test this too?

--- 1.32/drivers/char/pty.c     2005-01-10 17:29:36 -08:00
+++ edited/drivers/char/pty.c   2005-01-23 10:21:04 -08:00
@@ -149,13 +149,17 @@
 static int pty_chars_in_buffer(struct tty_struct *tty)
 {
        struct tty_struct *to = tty->link;
-       int count;
+       int count = 0;
 
-       if (!to || !to->ldisc.chars_in_buffer)
-               return 0;
-
-       /* The ldisc must report 0 if no characters available to be read
*/
-       count = to->ldisc.chars_in_buffer(to);
+       if (to) {
+               struct tty_ldisc *ld = tty_ldisc_ref(to);
+               if (ld) {
+                       if (ld->chars_in_buffer) {
+                               count = ld->chars_in_buffer(to);
+                               tty_ldisc_deref(ld);
+                       }
+               }
+       }
 
        if (tty->driver->subtype == PTY_TYPE_SLAVE) return count;
 




-- 
ierdnah <ierdnah@go.ro>


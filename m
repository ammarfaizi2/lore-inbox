Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262746AbVA1UHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbVA1UHV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 15:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbVA1UGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 15:06:22 -0500
Received: from s2.home.ro ([193.231.236.41]:64995 "EHLO s2.home.ro")
	by vger.kernel.org with ESMTP id S262746AbVA1UBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 15:01:13 -0500
Subject: Re: kernel oops!
From: ierdnah <ierdnah@go.ro>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0501271532420.2362@ppc970.osdl.org>
References: <1106437010.32072.0.camel@ierdnac>
	 <Pine.LNX.4.58.0501222223090.4191@ppc970.osdl.org>
	 <1106483340.21951.4.camel@ierdnac>
	 <Pine.LNX.4.58.0501230943020.4191@ppc970.osdl.org>
	 <1106866066.20523.3.camel@ierdnac>
	 <Pine.LNX.4.58.0501271532420.2362@ppc970.osdl.org>
Content-Type: text/plain
Date: Fri, 28 Jan 2005 22:00:01 +0200
Message-Id: <1106942401.27217.8.camel@ierdnac>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-27 at 15:35 -0800, Linus Torvalds wrote:

the last patch works, but the load increases very much (normally with
200 VPN connections I have a load of maximum 10, with this patch I have
a load of 50-100 - after 30 min of uptime)

> You probably should. The patch you've tested is really ugly, and not a fix 
> at all - it's really just depending on the compiler generating a specific 
> code sequence that will hide the race.  As such, it's a patch I would only 
> accept in the standard kernel as an absolute last resort.
> 
> In contrast, the second patch I tested may actually _fix_ the race. 
> 
> The fact that the first patch makes the oops go away is a good thing, 
> though: it shows that your oops really was due to that small race window, 
> and as such it helps validate that it wasn't anything else.

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


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262736AbUJ1UL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbUJ1UL6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 16:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262949AbUJ1UHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 16:07:45 -0400
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:23945
	"EHLO localhost") by vger.kernel.org with ESMTP id S262736AbUJ1UFp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 16:05:45 -0400
Subject: [patch 1/1] uml: fix mainline lazyness about TTY layer patch
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 28 Oct 2004 22:04:51 +0200
Message-Id: <20041028200635.3366D7436@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While changing the TTY layer, an API parameter was removed, so it was removed
by almost all calls, changing their prototype. But one use of one such
function was not updated, breaking UML compilation. This is the fix.

Should go in directly - trivial fix.

Thanks for the breakage, too :-).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/drivers/line.c |    2 --
 vanilla-linux-2.6.9-paolo/arch/um/drivers/ssl.c  |    2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff -puN arch/um/drivers/ssl.c~uml-mainline-is-lazy-fix arch/um/drivers/ssl.c
--- vanilla-linux-2.6.9/arch/um/drivers/ssl.c~uml-mainline-is-lazy-fix	2004-10-27 01:47:58.000000000 +0200
+++ vanilla-linux-2.6.9-paolo/arch/um/drivers/ssl.c	2004-10-27 01:48:07.000000000 +0200
@@ -119,7 +119,7 @@ static int ssl_write(struct tty_struct *
 
 static void ssl_put_char(struct tty_struct *tty, unsigned char ch)
 {
-	line_write(serial_lines, tty, 0, &ch, sizeof(ch));
+	line_write(serial_lines, tty, &ch, sizeof(ch));
 }
 
 static void ssl_flush_chars(struct tty_struct *tty)
diff -puN arch/um/drivers/line.c~uml-mainline-is-lazy-fix arch/um/drivers/line.c
--- vanilla-linux-2.6.9/arch/um/drivers/line.c~uml-mainline-is-lazy-fix	2004-10-27 01:49:16.000000000 +0200
+++ vanilla-linux-2.6.9-paolo/arch/um/drivers/line.c	2004-10-27 01:49:47.000000000 +0200
@@ -110,7 +110,6 @@ static int flush_buffer(struct line *lin
 int line_write(struct line *lines, struct tty_struct *tty, const char *buf, int len)
 {
 	struct line *line;
-	char *new;
 	unsigned long flags;
 	int n, err, i, ret = 0;
 
@@ -143,7 +142,6 @@ int line_write(struct line *lines, struc
 	}
  out_up:
 	up(&line->sem);
- out_free:
 	return(ret);
 }
 
_

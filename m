Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265153AbSJWTEr>; Wed, 23 Oct 2002 15:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265161AbSJWTEr>; Wed, 23 Oct 2002 15:04:47 -0400
Received: from blowme.phunnypharm.org ([65.207.35.140]:12550 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S265153AbSJWTEp>; Wed, 23 Oct 2002 15:04:45 -0400
Date: Wed, 23 Oct 2002 15:10:57 -0400
From: Ben Collins <bcollins@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] potential NULL deref in serial/core.c
Message-ID: <20021023191057.GH536@phunnypharm.org>
References: <20021023190211.GG536@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021023190211.GG536@phunnypharm.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 03:02:11PM -0400, Ben Collins wrote:
> Not sure if it's supposed to be a BUG() for tty to be NULL, but it's
> surely a bug to dereference it before checking for that.
> 

Ug. Find one more after I sent this email.


--- drivers/serial/core.c~	2002-10-23 14:59:17.000000000 -0400
+++ drivers/serial/core.c	2002-10-23 15:07:55.000000000 -0400
@@ -472,10 +472,12 @@
 
 static void uart_put_char(struct tty_struct *tty, unsigned char ch)
 {
-	struct uart_info *info = tty->driver_data;
+	struct uart_info *info;
 
-	if (tty)
+	if (tty) {
+		info = tty->driver_data;
 		__uart_put_char(info->port, &info->xmit, ch);
+	}
 }
 
 static void uart_flush_chars(struct tty_struct *tty)
@@ -487,10 +489,15 @@
 uart_write(struct tty_struct *tty, int from_user, const unsigned char * buf,
 	   int count)
 {
-	struct uart_info *info = tty->driver_data;
+	struct uart_info *info;
 	int ret;
 
-	if (!tty || !info->xmit.buf)
+	if (!tty)
+		return 0;
+
+	info = tty->driver_data;
+
+	if (!info->xmit.buf)
 		return 0;
 
 	if (from_user)

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/

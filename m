Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbTEXRuM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 13:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbTEXRuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 13:50:12 -0400
Received: from verein.lst.de ([212.34.189.10]:1923 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262497AbTEXRuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 13:50:10 -0400
Date: Sat, 24 May 2003 20:03:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make vt_ioctl ix86isms explicit
Message-ID: <20030524180317.GA5383@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20030524173713.GA4939@lst.de> <Pine.LNX.4.44.0305241046590.10806-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305241046590.10806-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 24, 2003 at 10:55:41AM -0700, Linus Torvalds wrote:
> They were added because this was how the X server got IO permissions a 
> million years ago.  It comes from some random old UNIX/386 thing, it 
> predates Linux itself as far as I know.
> 
> I'm fairly certain that X itself no longer uses it at all, but there may
> be other programs that still do (unlikely). Your patch looks sane,
> although it might be equally sane to just remove the code altogether.

What about this one instead?  If no one sees this messages we can just
rip it out in 2.7.<early>


--- 1.23/drivers/char/vt_ioctl.c	Mon May 12 16:12:47 2003
+++ edited/drivers/char/vt_ioctl.c	Fri May 23 22:13:19 2003
@@ -59,7 +59,7 @@
  */
 unsigned char keyboard_type = KB_101;
 
-#if !defined(__alpha__) && !defined(__ia64__) && !defined(__mips__) && !defined(__arm__) && !defined(__sh__)
+#ifdef CONFIG_X86
 asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on);
 #endif
 
@@ -424,23 +424,29 @@
 		ucval = keyboard_type;
 		goto setchar;
 
-#if !defined(__alpha__) && !defined(__ia64__) && !defined(__mips__) && !defined(__arm__) && !defined(__sh__)
 		/*
 		 * These cannot be implemented on any machine that implements
-		 * ioperm() in user level (such as Alpha PCs).
+		 * ioperm() in user level (such as Alpha PCs) or not at all.
+		 *
+		 * XXX: you should never use these, just call ioperm directly..
 		 */
+#ifdef CONFIG_X86
 	case KDADDIO:
 	case KDDELIO:
 		/*
 		 * KDADDIO and KDDELIO may be able to add ports beyond what
 		 * we reject here, but to be safe...
 		 */
+		printk(KERN_INFO "[%s]: using obsolete KDADDIO/KDDELIO ioctl\n",
+				current->comm);
 		if (arg < GPFIRST || arg > GPLAST)
 			return -EINVAL;
 		return sys_ioperm(arg, 1, (cmd == KDADDIO)) ? -ENXIO : 0;
 
 	case KDENABIO:
 	case KDDISABIO:
+		printk(KERN_INFO "[%s]: using obsolete KDENABIO/KDDISABIO ioctl\n",
+				current->comm);
 		return sys_ioperm(GPFIRST, GPNUM,
 				  (cmd == KDENABIO)) ? -ENXIO : 0;
 #endif

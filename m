Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbUDVDP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbUDVDP1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 23:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbUDVDP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 23:15:27 -0400
Received: from smtp.gentoo.org ([128.193.0.39]:19395 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S262027AbUDVDPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 23:15:16 -0400
From: Jason Cox <steel300@gentoo.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Change number of tty devices
In-Reply-To: <Pine.LNX.4.44.0404212109580.10680-100000@phoenix.infradead.org>
References: <E1BFhPh-00027s-IL@smtp.gentoo.org>
	<Pine.LNX.4.44.0404212109580.10680-100000@phoenix.infradead.org>
Organization: Gentoo
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E1BGUgG-0001u1-2h@smtp.gentoo.org>
Date: Thu, 22 Apr 2004 03:15:16 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2004 21:14:38 +0100 (BST)
James Simmons <jsimmons@infradead.org> wrote:

> 
> > Often, I have wondered what the need for 64 tty devices in /dev is.
> > I began tinkering with the code and am wondering why it's not user
> > configurable. I came up with a quick patch to add it as an option
> > under drivers/char/Kconfig. I also made a lower bound of 12. If this
> > is an idea worth pursuing, please let me know. If this idea has been
> > rejected before, I apologize. What do you think of this idea?
> 
> The reason for 64 is that the major number is shared between the
> serial tty and VT tty drivers. The first 64 to Vts and the rest to
> serial devices. What is even more is that athere exist ioctls that
> return shorts which means only 16 VCs can be accounted for on a VT.
> When the kernel supports multi-desktop systems we will have to deal
> with the serial and VT issue. Most likely the serial tty drivers will
> be given a different major number. I personally believe that because
> of the 16 bit limit that there should be 16 VCs per VT terminal. 


Ok, I made a new patch where the upper limit is set to 63. It is there
anything wrong with doing this per se?

diff -urN linux-2.6.5/drivers/char/Kconfig linux-2.6.5-work/drivers/char/Kconfig
--- linux-2.6.5/drivers/char/Kconfig	2004-04-03 21:36:15.000000000 -0600
+++ linux-2.6.5-work/drivers/char/Kconfig	2004-04-21 22:04:11.647195120 -0500
@@ -57,6 +57,18 @@
 
 	  If unsure, say Y.
 
+config NR_TTY_DEVICES
+	int "Maximum tty device number"
+	depends on VT
+	default 63
+	---help---
+	  This is the highest numbered device created in /dev. You will actually have
+	  NR_TTY_DEVICES+1 devices in /dev. The default is 63, which will result in
+	  64 /dev entries. The lowest number you can set is 11, anything below that, 
+	  and it will default to 11. 63 is also the upper limit so we don't overrun
+	  the serial consoles.
+
+
 config HW_CONSOLE
 	bool
 	depends on VT && !S390 && !UM
diff -urN linux-2.6.5/include/linux/tty.h linux-2.6.5-work/include/linux/tty.h
--- linux-2.6.5/include/linux/tty.h	2004-04-03 21:37:07.000000000 -0600
+++ linux-2.6.5-work/include/linux/tty.h	2004-04-21 22:06:18.000000000 -0500
@@ -10,8 +10,19 @@
  * resizing).
  */
 #define MIN_NR_CONSOLES 1       /* must be at least 1 */
-#define MAX_NR_CONSOLES	63	/* serial lines start at 64 */
-#define MAX_NR_USER_CONSOLES 63	/* must be root to allocate above this */
+#if (CONFIG_NR_TTY_DEVICES < 11)
+/* Lower Limit */
+#define MAX_NR_CONSOLES	11	
+#define MAX_NR_USER_CONSOLES 11
+#elseif (CONFIG_NR_TTY_DEVICES > 63)
+/* Upper Limit */
+#define MAX_NR_CONSOLES 63
+#define MAX_NR_USER_CONSOLES 63
+#else
+/* They chose a sensible number */
+#define MAX_NR_CONSOLES CONFIG_NR_TTY_DEVICES
+#define MAX_NR_USER_CONSOLES CONFIG_NR_TTY_DEVICES
+#endif
 		/* Note: the ioctl VT_GETSTATE does not work for
 		   consoles 16 and higher (since it returns a short) */



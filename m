Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262758AbUDTMir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbUDTMir (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 08:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbUDTMir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 08:38:47 -0400
Received: from smtp.gentoo.org ([128.193.0.39]:24204 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S262758AbUDTMin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 08:38:43 -0400
From: Jason Cox <steel300@gentoo.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Change number of tty devices
In-Reply-To: <E1BFhPh-00027s-IL@smtp.gentoo.org>
References: <E1BFhPh-00027s-IL@smtp.gentoo.org>
Organization: Gentoo
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E1BFuWQ-0004hx-Vw@smtp.gentoo.org>
Date: Tue, 20 Apr 2004 12:38:43 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2004 22:38:53 +0000
Jason Cox <steel300@gentoo.org> wrote:

> Hello all,
> 
> Often, I have wondered what the need for 64 tty devices in /dev is. I began tinkering with the code and am wondering why it's not user configurable. I came up with a quick patch to add it as an option under drivers/char/Kconfig. I also made a lower bound of 12. If this is an idea worth pursuing, please let me know. If this idea has been rejected before, I apologize. What do you think of this idea?
> 
> Thanks You,
> Jason Cox
> 
> 

I have come up with a saner patch which adds VT as a dependancy and a help option. Please review and tell me where I went wrong. This is diffed against 2.6.6-rc1-mm1.

Thanks again,
Jason Cox


diff -urN linux-2.6.5/drivers/char/Kconfig linux-2.6.6_rc1-love1/drivers/char/Kconfig
--- linux-2.6.5/drivers/char/Kconfig    2004-04-19 16:01:50.000000000 -0500
+++ linux-2.6.6_rc1-love1/drivers/char/Kconfig  2004-04-19 22:13:27.888080179 -0500
@@ -57,6 +57,16 @@

          If unsure, say Y.

+config NR_TTY_DEVICES
+       int "Maximum tty device number"
+       depends on VT
+       default 63
+       ---help---
+         This is the highest numbered device created in /dev. You will actually have
+         NR_TTY_DEVICES+1 devices in /dev. The default is 63, which will result in
+         64 /dev entries. The lowest number you can set is 11, anything below that,
+         and it will default to 11.
+
 config HW_CONSOLE
        bool
        depends on VT && !S390 && !UM
diff -urN linux-2.6.5/include/linux/tty.h linux-2.6.6_rc1-love1/include/linux/tty.h
--- linux-2.6.5/include/linux/tty.h     2004-04-19 11:04:19.000000000 -0500
+++ linux-2.6.6_rc1-love1/include/linux/tty.h   2004-04-19 22:05:48.824673446 -0500
@@ -10,8 +10,13 @@
  * resizing).
  */
 #define MIN_NR_CONSOLES 1       /* must be at least 1 */
-#define MAX_NR_CONSOLES        63      /* serial lines start at 64 */
-#define MAX_NR_USER_CONSOLES 63        /* must be root to allocate above this */
+#if (CONFIG_NR_TTY_DEVICES < 11)
+#define MAX_NR_CONSOLES        11
+#define MAX_NR_USER_CONSOLES 11
+#else
+#define MAX_NR_CONSOLES CONFIG_NR_TTY_DEVICES
+#define MAX_NR_USER_CONSOLES CONFIG_NR_TTY_DEVICES
+#endif
                /* Note: the ioctl VT_GETSTATE does not work for
                   consoles 16 and higher (since it returns a short) */


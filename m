Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVFZIXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVFZIXI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 04:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVFZIXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 04:23:07 -0400
Received: from mail.linicks.net ([217.204.244.146]:42756 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261405AbVFZIWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 04:22:48 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Fw: [PATCH] Allow number of IDE interfaces to be selected (X86)
Date: Sun, 26 Jun 2005 09:22:35 +0100
User-Agent: KMail/1.8.1
References: <20050625123345.364d8ddd.akpm@osdl.org> <20050625200043.GQ12006@waste.org> <20050625132957.1ed2aa96.akpm@osdl.org>
In-Reply-To: <20050625132957.1ed2aa96.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506260922.35746.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 June 2005 21:29, you wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> > On Sat, Jun 25, 2005 at 12:33:45PM -0700, Andrew Morton wrote:
> > > I have a vague feeling that this'll save some memory?
> >
> > It's the biggest static structure in the kernel, so yes. I've had a
> > similar patch in -tiny since the beginning.
> >
> > Not sure if I like exposing this as a general config option without
> > CONFIG_EMBEDDED.
>
> OK.  Nick, could you make it depend on EMBEDDED as well, work out how much
> memory it'll save then resend?

As discussed, here is the fixed patch as required - now depends on EMBEDDED on 
an X86 architecture (default N) - ALPHA and SUPERH continue as before 
(default Y).

Nick



 drivers/ide/Kconfig    |   17 ++++++++++++++++-
 include/asm-i386/ide.h |    4 ++++
 2 files changed, 20 insertions(+), 1 deletion(-)


--- linux-2.6.12orig/include/asm-i386/ide.h     2005-06-17 20:48:29.000000000 
+0100
+++ linux-2.6.12/include/asm-i386/ide.h 2005-06-25 14:13:43.000000000 +0100
@@ -16,11 +16,15 @@
 #include <linux/config.h>

 #ifndef MAX_HWIFS
+#ifndef CONFIG_IDE_HWIFS_NUM
 # ifdef CONFIG_BLK_DEV_IDEPCI
 #define MAX_HWIFS      10
 # else
 #define MAX_HWIFS      6
 # endif
+#else
+#define MAX_HWIFS       CONFIG_IDE_MAX_HWIFS
+#endif
 #endif

 #define IDE_ARCH_OBSOLETE_DEFAULTS


--- linux-2.6.12orig/drivers/ide/Kconfig        2005-06-17 20:48:29.000000000 
+0100
+++ linux-2.6.12/drivers/ide/Kconfig    2005-06-26 09:04:45.000000000 +0100
@@ -52,14 +52,29 @@

 if IDE

+config IDE_HWIFS_NUM
+        bool "Specify the number of IDE Interfaces"
+       depends on (ALPHA || SUPERH || (X86 && EMBEDDED))
+       default y if !(X86)
+       help
+
+         ALPHA and SUPERH say Y here (default).
+
+         X86 say Y to this if you wish to specify the number of IDE
+         interfaces on your system.  If unsure, say N to use
+         the kernel default options (6 or 10).
+
 config IDE_MAX_HWIFS
        int "Max IDE interfaces"
-       depends on ALPHA || SUPERH
+       depends on IDE_HWIFS_NUM
        default 4
        help
          This is the maximum number of IDE hardware interfaces that will
          be supported by the driver. Make sure it is at least as high as
          the number of IDE interfaces in your system.
+
+         On X86 architecture default is 6 or 10 IDE interfaces if this
+         is not used (IDE_HWIFS_NUM = N).

 config BLK_DEV_IDE
        tristate "Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy support"


-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."

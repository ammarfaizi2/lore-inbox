Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262850AbVCPXAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbVCPXAZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 18:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262854AbVCPW7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 17:59:46 -0500
Received: from fire.osdl.org ([65.172.181.4]:3046 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262848AbVCPW5z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 17:57:55 -0500
Date: Wed, 16 Mar 2005 14:57:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: James Simmons <jsimmons@pentafluge.infradead.org>
Cc: matthew@wil.cx, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CON_BOOT
Message-Id: <20050316145734.4075185b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.56.0503162153330.30645@pentafluge.infradead.org>
References: <20050315222706.GI21986@parcelfarce.linux.theplanet.co.uk>
	<20050315143711.4ae21d88.akpm@osdl.org>
	<20050316130759.GL21986@parcelfarce.linux.theplanet.co.uk>
	<20050316130948.678ca2f2.akpm@osdl.org>
	<Pine.LNX.4.56.0503162153330.30645@pentafluge.infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons <jsimmons@pentafluge.infradead.org> wrote:
>
> Where is this patch?


From: Matthew Wilcox <matthew@wil.cx>

CON_BOOT is like early printk in that it allows for output really early on.
 It's better than early printk because it unregisters automatically when a
real console is initialised.  So if you don't get consoles registering in
console_init, there isn't a huge delay between the boot console
unregistering and the real console starting.  This is the case on PA-RISC
where we have serial ports that aren't discovered until the PCI bus has
been walked.

I think all the current early printk users could be converted to this
scheme with a minimal amount of effort.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/linux/console.h |    1 +
 25-akpm/kernel/printk.c         |    5 +++++
 2 files changed, 6 insertions(+)

diff -puN include/linux/console.h~new-console-flag-con_boot include/linux/console.h
--- 25/include/linux/console.h~new-console-flag-con_boot	2005-03-15 22:47:16.000000000 -0800
+++ 25-akpm/include/linux/console.h	2005-03-15 22:47:16.000000000 -0800
@@ -84,6 +84,7 @@ void give_up_console(const struct consw 
 #define CON_PRINTBUFFER	(1)
 #define CON_CONSDEV	(2) /* Last on the command line */
 #define CON_ENABLED	(4)
+#define CON_BOOT	(8)
 
 struct console
 {
diff -puN kernel/printk.c~new-console-flag-con_boot kernel/printk.c
--- 25/kernel/printk.c~new-console-flag-con_boot	2005-03-15 22:47:16.000000000 -0800
+++ 25-akpm/kernel/printk.c	2005-03-15 22:47:16.000000000 -0800
@@ -861,6 +861,11 @@ void register_console(struct console * c
 	if (!(console->flags & CON_ENABLED))
 		return;
 
+	if (console_drivers && (console_drivers->flags & CON_BOOT)) {
+		unregister_console(console_drivers);
+		console->flags &= ~CON_PRINTBUFFER;
+	}
+
 	/*
 	 *	Put this console in the list - keep the
 	 *	preferred driver at the head of the list.
_


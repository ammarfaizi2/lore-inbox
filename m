Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261990AbVCOWay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbVCOWay (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 17:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbVCOW33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 17:29:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26799 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261970AbVCOW1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 17:27:12 -0500
Date: Tue, 15 Mar 2005 22:27:06 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] CON_BOOT
Message-ID: <20050315222706.GI21986@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


New console flag: CON_BOOT

CON_BOOT is like early printk in that it allows for output really
early on.  It's better than early printk because it unregisters
automatically when a real console is initialised.  So if you don't get
consoles registering in console_init, there isn't a huge delay between
the boot console unregistering and the real console starting.  This is
the case on PA-RISC where we have serial ports that aren't discovered
until the PCI bus has been walked.

I think all the current early printk users could be converted to this
scheme with a minimal amount of effort.

diff -urpNX dontdiff linus-2.6/include/linux/console.h parisc-2.6/include/linux/console.h
--- linus-2.6/include/linux/console.h	2005-03-02 04:35:07.000000000 -0700
+++ parisc-2.6/include/linux/console.h	2005-03-02 04:25:54.000000000 -0700
@@ -84,6 +84,7 @@ void give_up_console(const struct consw 
 #define CON_PRINTBUFFER	(1)
 #define CON_CONSDEV	(2) /* Last on the command line */
 #define CON_ENABLED	(4)
+#define CON_BOOT	(8)
 
 struct console
 {
diff -urpNX dontdiff linus-2.6/kernel/printk.c parisc-2.6/kernel/printk.c
--- linus-2.6/kernel/printk.c	2005-03-02 04:35:10.000000000 -0700
+++ parisc-2.6/kernel/printk.c	2005-03-15 09:20:32.339891098 -0700
@@ -804,6 +804,11 @@ void register_console(struct console * c
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

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbUK2Xt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbUK2Xt3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 18:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbUK2Xt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 18:49:29 -0500
Received: from mail.dif.dk ([193.138.115.101]:64962 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261858AbUK2XtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 18:49:12 -0500
Date: Tue, 30 Nov 2004 00:58:58 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Roger Luethi <rl@hellgate.ch>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] net/via-rhine: convert MODULE_PARM to module_param
Message-ID: <Pine.LNX.4.61.0411300053190.3432@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These warnings told me that it was time to move to module_param() :)

drivers/net/via-rhine.c:229: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
drivers/net/via-rhine.c:230: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
drivers/net/via-rhine.c:231: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)

So I made this small patch to do so.
Compile and boot tested on my box, and it seems to work just fine, the 
module works perfectly with my via-rhine card, and the parameters are 
exposed through sysfs as expected : 

juhl@dragon:~$ ls -l /sys/module/via_rhine/parameters/*
-rw-r--r--  1 root root    0 2004-11-30 00:51 /sys/module/via_rhine/parameters/debug
-r--r--r--  1 root root    0 2004-11-30 00:50 /sys/module/via_rhine/parameters/max_interrupt_work
-r--r--r--  1 root root 4096 2004-11-30 00:50 /sys/module/via_rhine/parameters/rx_copybreak

juhl@dragon:~$ cat /sys/module/via_rhine/parameters/debug
1
juhl@dragon:~$ cat /sys/module/via_rhine/parameters/max_interrupt_work
20
juhl@dragon:~$ cat /sys/module/via_rhine/parameters/rx_copybreak
0


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc2-bk13-orig/drivers/net/via-rhine.c linux-2.6.10-rc2-bk13/drivers/net/via-rhine.c
--- linux-2.6.10-rc2-bk13-orig/drivers/net/via-rhine.c	2004-11-17 01:19:51.000000000 +0100
+++ linux-2.6.10-rc2-bk13/drivers/net/via-rhine.c	2004-11-30 00:16:36.000000000 +0100
@@ -226,9 +226,9 @@ MODULE_AUTHOR("Donald Becker <becker@scy
 MODULE_DESCRIPTION("VIA Rhine PCI Fast Ethernet driver");
 MODULE_LICENSE("GPL");
 
-MODULE_PARM(max_interrupt_work, "i");
-MODULE_PARM(debug, "i");
-MODULE_PARM(rx_copybreak, "i");
+module_param(max_interrupt_work, int, 0444);
+module_param(debug, int, 0644);
+module_param(rx_copybreak, int, 0444);
 MODULE_PARM_DESC(max_interrupt_work, "VIA Rhine maximum events handled per interrupt");
 MODULE_PARM_DESC(debug, "VIA Rhine debug level (0-7)");
 MODULE_PARM_DESC(rx_copybreak, "VIA Rhine copy breakpoint for copy-only-tiny-frames");



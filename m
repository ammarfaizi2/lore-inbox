Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264672AbSKNAIH>; Wed, 13 Nov 2002 19:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264677AbSKNAIH>; Wed, 13 Nov 2002 19:08:07 -0500
Received: from smtp.terra.es ([213.4.129.129]:42324 "EHLO tsmtp5.mail.isp")
	by vger.kernel.org with ESMTP id <S264672AbSKNAIG>;
	Wed, 13 Nov 2002 19:08:06 -0500
Date: Thu, 14 Nov 2002 01:14:58 +0100
From: Arador <diegocg@teleline.es>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Subject: [PATCH] opl3 fails to release_region()
Message-Id: <20021114011458.2ad9f2a1.diegocg@teleline.es>
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch is need in 2.4.19 so opl3 will not fail
freeing resources when compiled as module.

When opl3 is compiled as module, and we don't
insert it with the io=0xXXX parameter, the actual
code will left the /proc/ioports resource allocated at rmmod
as he expects always the io parameter. The io parameter
isn't needed with adlib_card.c, who calls opl3_detect
and doesn't set the opl3.c:io variable that
is needed to release_region().

This patch adds io = ioaddr in opl3_init(ioaddr, ....).
It doesn't change the behaviour of the opl3 code when inserting it
as module with the io parameter or when it's built-in in the kernel
(in these cases, io contains the address, which is passed to ioaddr,
so we don't change the io value)

Also it moves the "static int io = -a" declaration at the top of the file
so it can be used in opl3_init.

Note that this still has a bug: if you insert opl3.o as module
without the io parameter (as happens when you modprobe adlib_card)
if you rmmod adlib_card without removing opl3, insmod adlib_card will fail
until you rmmod opl3 load it again. But now, at least you don't have to reboot
to free the /proc/ioports value ;)

(Side note: This is my first patch....so i dedicate it at the kernelnewbies.org
project guys at irc.oftc.net #kernelnewbies, who helped me to understand the problem,
and they make me to learn a lot of new things every day ;)

So many comments for a patch so small...


--- opl3.c.bak	2002-11-13 01:33:39.000000000 +0100
+++ opl3.c	2002-11-14 00:46:07.000000000 +0100
@@ -40,6 +40,13 @@
 #define MAX_VOICE	18
 #define OFFS_4OP	11
 
+/*
+ * This shouldn't be here, but it's neccesary so
+ * opl3.c can be loaded as module without parameters,
+ * as happens with adlib_card.c.
+ */
+static int io = -1;
+
 struct voice_info
 {
 	unsigned char   keyon_byte;
@@ -1118,6 +1125,13 @@
 		printk(KERN_WARNING "opl3: Too many synthesizers\n");
 		return -1;
 	}
+	
+	/* we can safely do this, we pass io as ioaddr parameter 
+	 * when MODULE is not defined. When it's, we also call
+	 * opl3_init with io as ioaddr if insmod opl3 io=0xXXX
+	 * and if not, adlib_card.o does it.
+	 */
+	io = ioaddr;
 
 	devc->nr_voice = 9;
 
@@ -1196,8 +1210,6 @@
 
 static int me;
 
-static int io = -1;
-
 MODULE_PARM(io, "i");
 
 static int __init init_opl3 (void)

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271264AbTHCSJy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 14:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271266AbTHCSJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 14:09:54 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:20610 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S271264AbTHCSJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 14:09:51 -0400
Date: Sun, 3 Aug 2003 20:09:50 +0200
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: devik@cdi.cz
Subject: [PATCH] Allow /dev/{,k}mem to be disabled to prevent kernel from being modified easily
Message-ID: <20030803180950.GA11575@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, devik@cdi.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

After being gloriously rootkitted with a program coded by HTB author Martin
Devera (lots of thanks, devik, your work is appreciated, I suggest you read
up about Oppenheimer when disclaiming that you are 'just a coder'. The item
to google on is: "ethics sweetness hydrogen bomb Oppenheimer"), I wrote
a patch to disable /dev/kmem and /dev/mem, which is harmless on servers
without X.

It blocks attempts by rootkits, such as devik's SucKIT, to hide themselves.

It is not a final solution but it raises the bar a lot. Please apply.

By default, nothing is changed, but I'd turn this feature on on servers
without X. Patch:

--- linux-2.6.0-test1/drivers/char/Kconfig.orig	Mon Jul 14 05:29:27 2003
+++ linux-2.6.0-test1/drivers/char/Kconfig	Sun Aug  3 19:55:37 2003
@@ -1003,5 +1003,20 @@
 	  out to lunch past a certain margin.  It can reboot the system
 	  or merely print a warning.
 
+config MEMORY_ACCESS
+	bool "Allow userspace access to memory" 
+	default y
+	help
+          Security paranoid operators may want to disable userspace
+          from accessing raw memory or kernel memory via /dev/mem and
+          /dev/kmem. Some malware hides itself from sight by manipulating
+          the kernel directly via raw memory, disabling this feature
+          gives some protection against rootkits.
+
+	  Answering 'N' generally breaks the X Window System.
+
+          Answer 'Y' unless you are paranoid about security or don't
+	  care about X.
+
 endmenu
 
--- linux-2.6.0-test1/drivers/char/mem.c.orig	Sun Aug  3 19:22:29 2003
+++ linux-2.6.0-test1/drivers/char/mem.c	Sun Aug  3 19:34:04 2003
@@ -608,12 +608,14 @@
 static int memory_open(struct inode * inode, struct file * filp)
 {
 	switch (minor(inode->i_rdev)) {
+#if defined(CONFIG_MEMORY_ACCESS)
 		case 1:
 			filp->f_op = &mem_fops;
 			break;
 		case 2:
 			filp->f_op = &kmem_fops;
 			break;
+#endif
 		case 3:
 			filp->f_op = &null_fops;
 			break;
@@ -655,8 +657,10 @@
 	umode_t			mode;
 	struct file_operations	*fops;
 } devlist[] = { /* list of minor devices */
+#if defined(CONFIG_MEMORY_ACCESS)
 	{1, "mem",     S_IRUSR | S_IWUSR | S_IRGRP, &mem_fops},
 	{2, "kmem",    S_IRUSR | S_IWUSR | S_IRGRP, &kmem_fops},
+#endif	
 	{3, "null",    S_IRUGO | S_IWUGO,           &null_fops},
 #if defined(CONFIG_ISA) || !defined(__mc68000__)
 	{4, "port",    S_IRUSR | S_IWUSR | S_IRGRP, &port_fops},




-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO

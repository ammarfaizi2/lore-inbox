Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbWGHSGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbWGHSGE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 14:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbWGHSGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 14:06:03 -0400
Received: from verein.lst.de ([213.95.11.210]:1768 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S964931AbWGHSGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 14:06:01 -0400
Date: Sat, 8 Jul 2006 20:05:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org, ghoward@sgi.com, ayoung@sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] snsc: switch from force_sig to kill_proc
Message-ID: <20060708180550.GA7034@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

currently the snsc driver uses force_sig to send init a SIGPWR
when the system overheats.  This patch switches it to kill_proc
instead which has the following advantages:

 (1) gets rid of one of the last remaining tasklist_lock users
     in modular code
 (2) simplifies the snsc code significantly

The downside is that an init implementation could in theory block
SIGPWR and it would not get delivered.  The sysvinit code used by
all major distributions doesn't do this and blocking this signal
in init would be a rather stupid thing to do.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/drivers/char/snsc_event.c
===================================================================
--- linux-2.6.orig/drivers/char/snsc_event.c	2006-07-08 13:13:28.000000000 +0200
+++ linux-2.6/drivers/char/snsc_event.c	2006-07-08 13:14:21.000000000 +0200
@@ -220,20 +220,7 @@
 			       " Sending SIGPWR to init...\n");
 
 		/* give a SIGPWR signal to init proc */
-
-		/* first find init's task */
-		read_lock(&tasklist_lock);
-		for_each_process(p) {
-			if (p->pid == 1)
-				break;
-		}
-		if (p) {
-			force_sig(SIGPWR, p);
-		} else {
-			printk(KERN_ERR "Failed to signal init!\n");
-			snsc_shutting_down = 0; /* so can try again (?) */
-		}
-		read_unlock(&tasklist_lock);
+		kill_proc(1, SIGPWR, 0);
 	} else {
 		/* print to system log */
 		printk("%s|$(0x%x)%s\n", severity, esp_code, desc);

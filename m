Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVFDHup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVFDHup (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 03:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVFDHup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 03:50:45 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:4880 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S261287AbVFDHuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 03:50:37 -0400
Date: Sat, 4 Jun 2005 15:40:43 +0800 (WST)
From: raven@themaw.net
To: Andrew Morton <akpm@osdl.org>
cc: Michael Blandford <michael@kmaclub.com>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       Jeff Moyer <jmoyer@redhat.com>,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] autofs4 - post expire race fix
Message-ID: <Pine.LNX.4.62.0506041528070.8502@donald.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-98.6, required 8,
	NO_REAL_NAME, PATCH_UNIFIED_DIFF, RCVD_IN_ORBS,
	RCVD_IN_OSIRUSOFT_COM, USER_AGENT_PINE, USER_IN_WHITELIST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


At the tail end of an expire it's possible for a process to enter
autofs4_wait, with a waitq type of NFY_NONE but find that the expire
is finished. In this cause autofs4_wait will try to create a new wait but 
not notify the daemon leading to a hang. As the wait type is meant to 
delay mount requests from revalidate or lookup during an expire and the 
expire is done all we need to do is check if the dentry is a mountpoint. 
If it's not then we're done.


diff -Nur linux-2.6.12-rc2-mm3.orig/fs/autofs4/waitq.c linux-2.6.12-rc2-mm3/fs/autofs4/waitq.c
--- linux-2.6.12-rc2-mm3.orig/fs/autofs4/waitq.c	2005-05-01 17:04:49.000000000 +0800
+++ linux-2.6.12-rc2-mm3/fs/autofs4/waitq.c	2005-05-01 17:07:18.000000000 +0800
@@ -191,6 +191,13 @@
 	}
 
 	if ( !wq ) {
+		/* Can't wait for an expire if there's no mount */
+		if (notify == NFY_NONE && !d_mountpoint(dentry)) {
+			kfree(name);
+			up(&sbi->wq_sem);
+			return -ENOENT;
+		}
+
 		/* Create a new wait queue */
 		wq = kmalloc(sizeof(struct autofs_wait_queue),GFP_KERNEL);
 		if ( !wq ) {

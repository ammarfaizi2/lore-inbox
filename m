Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbTEABnp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 21:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbTEABnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 21:43:45 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:37833 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S262069AbTEABno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 21:43:44 -0400
Date: Wed, 30 Apr 2003 21:34:27 -0400
From: Ben Collins <bcollins@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix NULL handler for compat_ioctl
Message-ID: <20030501013427.GA516@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pretty serious ommision, but I'm guessing there's not too many users of
the {un,}register_ioctl32_conversion calls. Linux1394 just happens to
use it quite extensively, so this showed up on my radar by coincidence.

You are supposed to be able to pass a NULL handler to
register_ioctl32_conversion to signify a compatible translation, IOW,
use the 64-bit ioctl handler. Without this patch, we would instead jump
to a NULL address.

Applies to current 2.5.68-bk (see Larry, someone is using bk-cvs for
something good :).


diff -u -u -r1.8 compat.c
--- linux/fs/compat.c	30 Apr 2003 16:17:21 -0000	1.8
+++ linux/fs/compat.c	1 May 2003 01:45:46 -0000
@@ -229,7 +229,10 @@
 	
 	t->next = NULL;
 	t->cmd = cmd;
-	t->handler = handler; 
+	if (!handler)
+		t->handler = (void *)sys_ioctl;
+	else
+		t->handler = handler; 
 	ioctl32_insert_translation(t);
 
 	unlock_kernel();

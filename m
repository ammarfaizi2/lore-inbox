Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263095AbUESKXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263095AbUESKXy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 06:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbUESKXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 06:23:54 -0400
Received: from cantor.suse.de ([195.135.220.2]:12443 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263095AbUESKXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 06:23:52 -0400
Date: Wed, 19 May 2004 12:23:50 +0200
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, rusty@rustcorp.com.au
Subject: [PATCH] Remove bogus WARN_ON in futex_wait
Message-Id: <20040519122350.2792e050.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


futex_wait goes to an interruptible sleep, but does a WARN_ON later
if it wakes up early. But waking up early is totally legal, since
the sleep is interruptible and any signal can wake it up.

Remove the WARN_ON checking for that.

diff -u linux/kernel/Makefile-o linux/kernel/Makefile
diff -u linux/kernel/futex.c-o linux/kernel/futex.c
--- linux/kernel/futex.c-o	2004-03-21 21:12:13.000000000 +0100
+++ linux/kernel/futex.c	2004-05-19 10:01:02.000000000 +0200
@@ -504,8 +504,6 @@
 		return 0;
 	if (time == 0)
 		return -ETIMEDOUT;
-	/* A spurious wakeup should never happen. */
-	WARN_ON(!signal_pending(current));
 	return -EINTR;
 
  out_unqueue:

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbTJFTww (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 15:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbTJFTww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 15:52:52 -0400
Received: from mail6.bluewin.ch ([195.186.4.229]:36822 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S261646AbTJFTwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 15:52:51 -0400
Date: Mon, 6 Oct 2003 21:52:36 +0200
From: Roger Luethi <rl@hellgate.ch>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.6] Fix early __might_sleep() calls
Message-ID: <20031006195236.GA24413@k3.hellgate.ch>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.0-test6 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__might_sleep prints warnings only after jiffies wrap (typically after 5
minutes of uptime).

Patch against 2.6 CVS.

Roger

--- linux-2.5/kernel/sched.c.orig	2003-10-06 20:58:47.258167317 +0200
+++ linux-2.5/kernel/sched.c	2003-10-06 21:31:32.676707449 +0200
@@ -2847,7 +2847,7 @@ void __might_sleep(char *file, int line)
 	static unsigned long prev_jiffy;	/* ratelimiting */
 
 	if (in_atomic() || irqs_disabled()) {
-		if (time_before(jiffies, prev_jiffy + HZ))
+		if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
 			return;
 		prev_jiffy = jiffies;
 		printk(KERN_ERR "Debug: sleeping function called from invalid"

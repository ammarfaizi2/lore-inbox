Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262649AbUKXNEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbUKXNEf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 08:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262664AbUKXNDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:03:46 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:40084 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262647AbUKXNBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:01:24 -0500
Subject: Suspend 2 merge:L 12/51: Disable OOM killer when suspending.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101294601.5805.237.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Nov 2004 23:57:45 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When preparing the image, suspend eats all the memory in sight, both to
reduce the image size and to improve the reliability of our stats (We've
worked hard to make it work reliably under heavy load - 100+). Of course
this can result in the OOM killer being triggered, so this simple test
stops that happening.

diff -ruN 501-disable-oom-killer-when-suspending-old/mm/oom_kill.c 501-disable-oom-killer-when-suspending-new/mm/oom_kill.c
--- 501-disable-oom-killer-when-suspending-old/mm/oom_kill.c	2004-11-03 21:53:47.000000000 +1100
+++ 501-disable-oom-killer-when-suspending-new/mm/oom_kill.c	2004-11-04 16:27:40.000000000 +1100
@@ -20,6 +20,7 @@
 #include <linux/swap.h>
 #include <linux/timex.h>
 #include <linux/jiffies.h>
+#include <linux/suspend.h>
 
 /* #define DEBUG */
 
@@ -237,6 +238,9 @@
 	static unsigned long first, last, count, lastkill;
 	unsigned long now, since;
 
+	if (test_suspend_state(SUSPEND_FREEZER_ON))
+		return;
+	
 	spin_lock(&oom_lock);
 	now = jiffies;
 	since = now - last;



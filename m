Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262639AbUKXNKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbUKXNKz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 08:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262640AbUKXNJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:09:24 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:44180 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262639AbUKXNBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:01:46 -0500
Subject: Suspend 2 merge: 16/51: Disable cache reaping during suspend.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101295167.5805.254.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Nov 2004 23:58:04 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have to admit to being a little unsure as to why this is needed, but
suspend's reliability is helped a lot by disabling cache reaping while
suspending. Perhaps one of the mm guys will be able to enlighten me
here. Might be SMP related.

diff -ruN 505-disable-cache-reaping-during-suspend-old/mm/slab.c 505-disable-cache-reaping-during-suspend-new/mm/slab.c
--- 505-disable-cache-reaping-during-suspend-old/mm/slab.c	2004-11-03 21:55:05.000000000 +1100
+++ 505-disable-cache-reaping-during-suspend-new/mm/slab.c	2004-11-06 09:25:01.972547184 +1100
@@ -92,6 +92,7 @@
 #include	<linux/sysctl.h>
 #include	<linux/module.h>
 #include	<linux/rcupdate.h>
+#include	<linux/suspend.h>
 
 #include	<asm/uaccess.h>
 #include	<asm/cacheflush.h>
@@ -2730,7 +2731,9 @@
 {
 	struct list_head *walk;
 
-	if (down_trylock(&cache_chain_sem)) {
+	if ((unlikely(test_suspend_state(SUSPEND_RUNNING))) ||
+		(down_trylock(&cache_chain_sem))) 
+	{
 		/* Give up. Setup the next iteration. */
 		schedule_delayed_work(&__get_cpu_var(reap_work), REAPTIMEOUT_CPUC + smp_processor_id());
 		return;



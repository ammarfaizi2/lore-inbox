Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262720AbUKXODq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbUKXODq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 09:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262698AbUKXOC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 09:02:58 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:18327 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262651AbUKXN2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:28:17 -0500
Subject: Suspend 2 merge: 14/51: Disable page alloc failure message when
	suspending
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101294838.5805.245.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Nov 2004 23:57:55 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While eating memory, we will potentially trigger this a lot. We
therefore disable the message when suspending.

diff -ruN 503-disable-page-alloc-warnings-while-suspending-old/mm/page_alloc.c 503-disable-page-alloc-warnings-while-suspending-new/mm/page_alloc.c
--- 503-disable-page-alloc-warnings-while-suspending-old/mm/page_alloc.c	2004-11-06 09:24:37.231308424 +1100
+++ 503-disable-page-alloc-warnings-while-suspending-new/mm/page_alloc.c	2004-11-06 09:24:40.844759096 +1100
@@ -725,7 +725,10 @@
 	}
 
 nopage:
-	if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit()) {
+	if ((!(gfp_mask & __GFP_NOWARN)) && 
+		(!test_suspend_state(SUSPEND_RUNNING)) &&
+		printk_ratelimit()) {
+
 		printk(KERN_WARNING "%s: page allocation failure."
 			" order:%d, mode:0x%x\n",
 			p->comm, order, gfp_mask);



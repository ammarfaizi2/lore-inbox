Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWGCMHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWGCMHv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 08:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWGCMHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 08:07:51 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:55739 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751131AbWGCMHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 08:07:51 -0400
Date: Mon, 3 Jul 2006 14:07:40 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andrew Morton <akpm@osdl.org>
cc: ltuikov@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched.h: increment TASK_COMM_LEN to 20 bytes
In-Reply-To: <20060630181915.638166c2.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0607011102030.25773@yvahk01.tjqt.qr>
References: <20060701010606.4694.qmail@web31809.mail.mud.yahoo.com>
 <20060630181915.638166c2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>We do occasionally hit task_struct.comm[] truncation, when people use
>"too-long-a-name%d" for their kernel thread names.  But we seem to manage.
>

Maybe this one can help?

Have kthread_create() print a warning message if the command name is 
going to be truncated, for ease of development.

diff --fast -dpru linux-2.6.17~/kernel/kthread.c linux-2.6.17+/kernel/kthread.c
--- linux-2.6.17~/kernel/kthread.c	2006-06-06 02:57:02.000000000 +0200
+++ linux-2.6.17+/kernel/kthread.c	2006-07-01 11:08:57.687698000 +0200
@@ -147,8 +147,11 @@ struct task_struct *kthread_create(int (
 	if (!IS_ERR(create.result)) {
 		va_list args;
 		va_start(args, namefmt);
-		vsnprintf(create.result->comm, sizeof(create.result->comm),
-			  namefmt, args);
+		if(vsnprintf(create.result->comm, sizeof(create.result->comm),
+		  namefmt, args) != strlen(create.result->comm))
+			printk(KERN_WARNING "kthread_create: command name of "
+			  "pid %d truncated to \"%s\"\n", create.result->pid,
+			  create.result->comm);
 		va_end(args);
 	}
 
#<<eof>>


Jan Engelhardt
-- 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263450AbSITUER>; Fri, 20 Sep 2002 16:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263456AbSITUER>; Fri, 20 Sep 2002 16:04:17 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:24588
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263450AbSITUEP>; Fri, 20 Sep 2002 16:04:15 -0400
Subject: Re: pre-empt and smp in 2.5.37 - is it supposed to work?
From: Robert Love <rml@tech9.net>
To: thunder7@xs4all.nl
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020920200441.GA3677@middle.of.nowhere>
References: <20020920200441.GA3677@middle.of.nowhere>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 20 Sep 2002 16:09:22 -0400
Message-Id: <1032552562.966.832.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-20 at 16:04, Jurriaan wrote:

> I get a large screen full of hex addresses even before my framebuffer
> activates, so I wonder if breakage when using preempt and smp is a known
> issue in 2.5.37 or not?

You need this yet-to-be-merged patch.  It should work fine with it.

It is just an overzealous debugging test..

	Robert Love

diff -urN linux-2.5.37/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.37/kernel/sched.c	Fri Sep 20 11:20:32 2002
+++ linux/kernel/sched.c	Fri Sep 20 15:49:05 2002
@@ -940,8 +940,17 @@
 	struct list_head *queue;
 	int idx;
 
-	if (unlikely(in_atomic()))
-		BUG();
+	/*
+	 * Test if we are atomic.  Since do_exit() needs to call into
+	 * schedule() atomically, we ignore that path for now.
+	 * Otherwise, whine if we are scheduling when we should not be.
+	 */
+	if (likely(current->state != TASK_ZOMBIE)) {
+		if (unlikely(in_atomic())) {
+			printk(KERN_ERR "bad: scheduling while atomic!\n");
+			dump_stack();
+		}
+	}
 
 #if CONFIG_DEBUG_HIGHMEM
 	check_highmem_ptes();


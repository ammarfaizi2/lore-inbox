Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWBFSyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWBFSyc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 13:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbWBFSyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 13:54:32 -0500
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:39177 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932154AbWBFSyb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 13:54:31 -0500
Date: Mon, 6 Feb 2006 19:55:04 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stop ==== emergency
Message-Id: <20060206195504.16b60b93.khali@linux-fr.org>
In-Reply-To: <Pine.LNX.4.61.0602060841540.6574@goblin.wat.veritas.com>
References: <mailman.1139006040.12873.linux-kernel2news@redhat.com>
	<20060205205709.0b88171b.zaitcev@redhat.com>
	<Pine.LNX.4.61.0602060841540.6574@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh, Pete,

> > This is wrong, Hugh. What do you think the priority of the second printk?
> > It's not log_lvl, that's for sure.
> 
> Are you sure?  I've not delved into the printk code itself, but this
> does follow the same pattern as in show_stack_log_lvl itself e.g. its
> "Call Trace:\n" line.  (I am assuming print_context_stack ends with a
> newline, as it does.)

The code was correct (and was applied already as far as I can see.)
However, given that printk calls aren't exactly cheap, don't we want to
merge them where possible?


Merge a few printk calls in i386 traps.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 arch/i386/kernel/traps.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

--- linux-2.6.16-rc2.orig/arch/i386/kernel/traps.c	2006-02-06 07:50:57.000000000 +0100
+++ linux-2.6.16-rc2/arch/i386/kernel/traps.c	2006-02-06 19:42:10.000000000 +0100
@@ -114,8 +114,7 @@
 
 static void print_addr_and_symbol(unsigned long addr, char *log_lvl)
 {
-	printk(log_lvl);
-	printk(" [<%08lx>] ", addr);
+	printk("%s [<%08lx>] ", log_lvl, addr);
 	print_symbol("%s", addr);
 	printk("\n");
 }
@@ -166,8 +165,7 @@
 		stack = (unsigned long*)context->previous_esp;
 		if (!stack)
 			break;
-		printk(log_lvl);
-		printk(" =======================\n");
+		printk("%s =======================\n", log_lvl);
 	}
 }
 
@@ -196,14 +194,12 @@
 			break;
 		if (i && ((i % 8) == 0)) {
 			printk("\n");
-			printk(log_lvl);
-			printk("       ");
+			printk("%s       ", log_lvl);
 		}
 		printk("%08lx ", *stack++);
 	}
 	printk("\n");
-	printk(log_lvl);
-	printk("Call Trace:\n");
+	printk("%sCall Trace:\n", log_lvl);
 	show_trace_log_lvl(task, esp, log_lvl);
 }
 

More merges are possible, but I'm not sure how far we want to go.

Thanks,
-- 
Jean Delvare

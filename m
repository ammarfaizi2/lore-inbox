Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbWBXGjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWBXGjz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 01:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932687AbWBXGjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 01:39:55 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:40914 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750978AbWBXGjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 01:39:54 -0500
Date: Fri, 24 Feb 2006 07:38:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.15-rt17
Message-ID: <20060224063822.GC1431@elte.hu>
References: <20060221155548.GA30146@elte.hu> <6bffcb0e0602210916n3ddbd50i@mail.gmail.com> <Pine.LNX.4.58.0602220715460.4164@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0602220715460.4164@gandalf.stny.rr.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> +	printk("| This is not a BUG\n");
> +	printk("| turn off CONFIG_DEBUG_STACK_OVERFLOW if you don't want this\n");

i added the patch below - we want to know about too high stack 
footprints.

	Ingo

Index: linux-rt.q/kernel/latency.c
===================================================================
--- linux-rt.q.orig/kernel/latency.c
+++ linux-rt.q/kernel/latency.c
@@ -414,10 +414,17 @@ static void show_stackframe(void)
 
 static notrace void __print_worst_stack(void)
 {
+	unsigned long fill_ratio;
 	printk("----------------------------->\n");
-	printk("| new stack-footprint maximum: %s/%d, %ld bytes (out of %ld bytes).\n",
+	printk("| new stack fill maximum: %s/%d, %ld bytes (out of %ld bytes).\n",
 		worst_stack_comm, worst_stack_pid,
 		MAX_STACK-worst_stack_left, (long)MAX_STACK);
+	fill_ratio = (MAX_STACK-worst_stack_left)*100/(long)MAX_STACK;
+	printk("| Stack fill ratio: %02ld%%", fill_ratio);
+	if (fill_ratio >= 90)
+		printk(" - BUG: that's quite high, please report this!\n");
+	else
+		printk(" - that's still OK, no need to report this.\n");
 	printk("------------|\n");
 
 	show_stackframe();

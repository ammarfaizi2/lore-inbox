Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbVEEPdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbVEEPdJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 11:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVEEPdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 11:33:08 -0400
Received: from mailfe02.swip.net ([212.247.154.33]:40326 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262013AbVEEPdD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 11:33:03 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: A patch for the file kernel/fork.c
From: Alexander Nyberg <alexn@dsv.su.se>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, cw@f00f.org, andre@cachola.com.br,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1115300887.21180.14.camel@localhost.localdomain>
References: <4278E03A.1000605@cachola.com.br>
	 <20050504175457.GA31789@taniwha.stupidest.org>
	 <427913E4.3070908@cachola.com.br>
	 <20050504184318.GA644@taniwha.stupidest.org>
	 <42791CD2.5070408@cachola.com.br>
	 <1115234213.2562.28.camel@localhost.localdomain>
	 <20050504124104.3573e7f3.akpm@osdl.org>
	 <1115241687.2562.50.camel@localhost.localdomain>
	 <1115300887.21180.14.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 05 May 2005 17:32:56 +0200
Message-Id: <1115307176.3993.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Instead of the for(;;) msleep, why not just take it permanently off the
> run queue? With the following:
> 
>    set_current_state(TASK_UNINTERRUPTIBLE);
>    schedule();
> 
> It basically gives the same effect, but is cleaner.

Ah perfect, now it looks ok. Thanks!

Prevent recursive faults in do_exit() by leaving the task alone and wait
for reboot. This may allow a more graceful shutdown and possibly save
the original oops.


Signed-off-by: Alexander Nyberg <alexn@telia.com>

Index: mm/kernel/exit.c
===================================================================
--- mm.orig/kernel/exit.c	2005-05-05 16:44:20.000000000 +0200
+++ mm/kernel/exit.c	2005-05-05 17:29:40.000000000 +0200
@@ -797,6 +797,14 @@
 		ptrace_notify((PTRACE_EVENT_EXIT << 8) | SIGTRAP);
 	}
 
+	/* We're taking recursive faults here in do_exit. Safest 
+	 * is to just leave this task alone and wait for reboot. */
+	if (unlikely(tsk->flags & PF_EXITING)) {
+		printk(KERN_ALERT "\nFixing recursive fault but reboot is needed!\n");
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule();
+	}
+
 	tsk->flags |= PF_EXITING;
 
 	/*



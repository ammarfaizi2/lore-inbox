Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263241AbTJBFH7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 01:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263242AbTJBFH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 01:07:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:737 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263241AbTJBFH6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 01:07:58 -0400
Date: Wed, 1 Oct 2003 22:09:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] export [__]set_special_pids()
Message-Id: <20031001220914.7664d6e3.akpm@osdl.org>
In-Reply-To: <20031001214132.5070b6b5.rddunlap@osdl.org>
References: <20031001214132.5070b6b5.rddunlap@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
> EXPORT [__]set_special_pids(); Ingo added these
>  		in include/linux/sched.h but didn't export them;
>  		jffs uses set_special_pids();

jffs seems to be trying to do daemonize()-by-hand.  It would be better for
it to get its act together and just call daemonize().

Is anyone actively testing and using jffs in 2.6?  How does one get it
going with blkmtd??

diff -puN fs/jffs/intrep.c~jffs-use-daemonize fs/jffs/intrep.c
--- 25/fs/jffs/intrep.c~jffs-use-daemonize	2003-10-01 22:01:21.000000000 -0700
+++ 25-akpm/fs/jffs/intrep.c	2003-10-01 22:02:26.000000000 -0700
@@ -3337,18 +3337,16 @@ jffs_garbage_collect_thread(void *ptr)
 	int result = 0;
 	D1(int i = 1);
 
+	daemonize("jffs_gcd");
+
 	c->gc_task = current;
 
 	lock_kernel();
-	exit_mm(c->gc_task);
-
-	set_special_pids(1, 1);
 	init_completion(&c->gc_thread_comp); /* barrier */ 
 	spin_lock_irq(&current->sighand->siglock);
 	siginitsetinv (&current->blocked, sigmask(SIGHUP) | sigmask(SIGKILL) | sigmask(SIGSTOP) | sigmask(SIGCONT));
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
-	strcpy(current->comm, "jffs_gcd");
 
 	D1(printk (KERN_NOTICE "jffs_garbage_collect_thread(): Starting infinite loop.\n"));
 

_


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbUCHLyP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 06:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262477AbUCHLyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 06:54:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:29074 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262461AbUCHLyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 06:54:13 -0500
Date: Mon, 8 Mar 2004 03:54:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org, george@mvista.com,
       pavel@ucw.cz
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
Message-Id: <20040308035416.62929bfe.akpm@osdl.org>
In-Reply-To: <200403081714.05521.amitkale@emsyssoft.com>
References: <200403081504.30840.amitkale@emsyssoft.com>
	<20040308030722.01948c93.akpm@osdl.org>
	<200403081650.18641.amitkale@emsyssoft.com>
	<200403081714.05521.amitkale@emsyssoft.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Amit S. Kale" <amitkale@emsyssoft.com> wrote:
>
> Here is the intrusive piece of code that helps get thread state correctly. Any 
>  ideas on cleaning it?

I think George's stub has diverged rather a lot from yours.  Much more than
I was aware.


>  --- linux-2.6.3-kgdb.orig/include/linux/sched.h	2004-02-24 10:44:47.000000000 
>  +0530
>  +++ linux-2.6.3-kgdb/include/linux/sched.h	2004-03-04 18:42:56.324188184 +0530
>  @@ -173,7 +173,9 @@
>   
>   #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
>   extern signed long FASTCALL(schedule_timeout(signed long timeout));
>  -asmlinkage void schedule(void);
>  +asmlinkage void do_schedule(void);
>  +asmlinkage void kern_schedule(void);
>  +asmlinkage void kern_do_schedule(struct pt_regs);

The stub in -mm has only a single change to sched.c:

diff -puN kernel/sched.c~kgdb-ga kernel/sched.c
--- 25/kernel/sched.c~kgdb-ga	2004-03-07 01:57:48.000000000 -0800
+++ 25-akpm/kernel/sched.c	2004-03-07 01:57:48.000000000 -0800
@@ -2015,6 +2015,13 @@ out_unlock:
 
 EXPORT_SYMBOL(set_user_nice);
 
+#if defined( CONFIG_KGDB)
+struct task_struct * kgdb_get_idle(int this_cpu)
+{
+        return cpu_rq(this_cpu)->idle;
+}
+#endif
+
 #ifndef __alpha__
 
 /*


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbTIYSmU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 14:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbTIYSmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 14:42:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:7913 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261711AbTIYSmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 14:42:03 -0400
Date: Thu, 25 Sep 2003 11:41:50 -0700
From: Chris Wright <chrisw@osdl.org>
To: "Milton D. Miller II" <miltonm@realtime.net>
Cc: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Omen Wild <Omen.Wild@Dartmouth.EDU>, linux-kernel@vger.kernel.org
Subject: Re: call_usermodehelper does not report exit status?
Message-ID: <20030925114150.A18074@osdlab.pdx.osdl.net>
References: <20030919124213.7fc93067.akpm@osdl.org> <200309201855.h8KItHuf000466@sullivan.realtime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200309201855.h8KItHuf000466@sullivan.realtime.net>; from miltonm@realtime.net on Sat, Sep 20, 2003 at 01:55:17PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Milton D. Miller II (miltonm@realtime.net) wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> > This might fix it.
> 
> I think you missed the why behind the comment just above your first change.

Anything wrong with just setting a SIG_DFL handler?  W.R.T. the kernel
pointer, either Andrew's patch which does put_user/__put_user depending
on context, or some ugly set_fs() should work.  This simplistic approach
works for me, thoughts?

thanks,
-chris

-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net


--- linux-2.6.0-test5-mm4/kernel/kmod.c	2003-09-08 12:49:59.000000000 -0700
+++ 2.6.0-test5-mm4/kernel/kmod.c	2003-09-25 11:34:59.000000000 -0700
@@ -181,16 +181,24 @@
 {
 	struct subprocess_info *sub_info = data;
 	pid_t pid;
+	struct k_sigaction sa;
+
+	sa.sa.sa_handler = SIG_DFL;
+	sa.sa.sa_flags = 0;
+	siginitset(&sa.sa.sa_mask, sigmask(SIGCHLD));
+	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
 
 	sub_info->retval = 0;
 	pid = kernel_thread(____call_usermodehelper, sub_info, SIGCHLD);
 	if (pid < 0)
 		sub_info->retval = pid;
-	else
-		/* We don't have a SIGCHLD signal handler, so this
-		 * always returns -ECHILD, but the important thing is
-		 * that it blocks. */
-		sys_wait4(pid, NULL, 0, NULL);
+	else {
+		mm_segment_t old_fs;
+		old_fs = get_fs();
+		set_fs(KERNEL_DS);
+		sys_wait4(pid, &sub_info->retval, 0, NULL);
+		set_fs(old_fs);
+	}
 
 	complete(sub_info->complete);
 	return 0;

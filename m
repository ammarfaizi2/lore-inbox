Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266158AbUFYBtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266158AbUFYBtH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 21:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266160AbUFYBtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 21:49:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:11440 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266158AbUFYBsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 21:48:52 -0400
Date: Thu, 24 Jun 2004 18:47:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: 2.6.7 and khelper
Message-Id: <20040624184749.008358b0.akpm@osdl.org>
In-Reply-To: <40DB76F1.9010107@tequila.co.jp>
References: <40DB76F1.9010107@tequila.co.jp>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clemens Schwaighofer <cs@tequila.co.jp> wrote:
>
> First of I have no idea what khelper actually does, but it seems to make
> a problem on my box.

It is a kernel thread which is used for making calls out to userspace
applications from within the kernel.

> I have a Debian/unstable box here (the same one that has these "fast
> clock problems with 2.6.7-mm1) and every night after the syslog restart
> the process with the id "4", which is khelper is reported to be
> respawning to fast.

Strange.  I assume that what's happening is that the children of khelper
are being created and are dying, and init is somehow seeing this happen. 
Maybe SIGCHLD, probably via wait4().  Perhaps init should be changed to not
complain about processes which it did't parent.  But then, that should
already be the case.


Could you please apply the below debug patch, then send us all the relevant
syslog output, including the messages from init?

Thanks.


diff -puN kernel/kmod.c~khelper-child-sequence kernel/kmod.c
--- 25/kernel/kmod.c~khelper-child-sequence	2004-06-24 18:42:34.351391688 -0700
+++ 25-akpm/kernel/kmod.c	2004-06-24 18:45:01.186069424 -0700
@@ -155,6 +155,9 @@ static int ____call_usermodehelper(void 
 	struct subprocess_info *sub_info = data;
 	int retval;
 	cpumask_t mask = CPU_MASK_ALL;
+	static int call_umh_id;
+
+	sprintf(current->comm, "call_umh%d\n", call_umh_id++);
 
 	/* Unblock all signals. */
 	flush_signals(current);
@@ -182,6 +185,9 @@ static int wait_for_helper(void *data)
 	struct subprocess_info *sub_info = data;
 	pid_t pid;
 	struct k_sigaction sa;
+	static int khelper_id;
+
+	sprintf(current->comm, "waiter%d", khelper_id++);
 
 	/* Install a handler: if SIGCLD isn't handled sys_wait4 won't
 	 * populate the status, but will return -ECHILD. */
_



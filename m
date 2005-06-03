Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVFCK6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVFCK6b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 06:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVFCK6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 06:58:31 -0400
Received: from mx1.elte.hu ([157.181.1.137]:62946 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261213AbVFCK6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 06:58:02 -0400
Date: Fri, 3 Jun 2005 12:57:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: Linus Torvalds <torvalds@osdl.org>, Pekka Enberg <penberg@gmail.com>,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: TASK_NONINTERACTIVE (was: Machine Freezes while Running Crossover Office)
Message-ID: <20050603105713.GA29060@elte.hu>
References: <Pine.LNX.4.58.0505291059540.10545@ppc970.osdl.org> <84144f0205052911202863ecd5@mail.gmail.com> <Pine.LNX.4.58.0505291143350.10545@ppc970.osdl.org> <1117399764.9619.12.camel@localhost> <Pine.LNX.4.58.0505291543070.10545@ppc970.osdl.org> <1117466611.9323.6.camel@localhost> <Pine.LNX.4.58.0505301024080.10545@ppc970.osdl.org> <courier.429C05C1.00005CC5@courier.cs.helsinki.fi> <20050601073544.GA21384@elte.hu> <courier.42A01623.00005D5C@courier.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <courier.42A01623.00005D5C@courier.cs.helsinki.fi>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Pekka J Enberg <penberg@cs.helsinki.fi> wrote:

> Unfortunately I have to take that comment back. Under heavy CPU load 
> [*], the interactivity is worse than with 2.6.11.10. XMMS skips and 
> the X mouse cursor is all jerky. A better short-term fix would be to 
> reduce pipe buffer size to 4 KB.
> 
> [*] Running Eclipse and Tomcat while exercising Selenium JavaScript 
> tests in Firefox. In other words, a JavaScript bot going through a 
> Java web application.

could you please make it double sure and try the attached patch ontop of 
the other patch? It adds a /proc/sys/kernel/pipe_noninteractive tunable 
(default: off). It's quite tricky to test interactivity between kernels 
(there's too much other state that may matter), so having a runtime 
tunable can help significantly. Could you enable/disable it and see 
whether it has a negative impact on interactivity? (besides fixing the 
Wine problem too, of course)

	Ingo

--- linux/fs/pipe.c.orig2	
+++ linux/fs/pipe.c	
@@ -34,16 +34,19 @@
  * -- Manfred Spraul <manfred@colorfullife.com> 2002-05-09
  */
 
+int pipe_noninteractive;
+
 /* Drop the inode semaphore and wait for a pipe event, atomically */
 void pipe_wait(struct inode * inode)
 {
+	int flag = pipe_noninteractive ? TASK_NONINTERACTIVE : 0;
 	DEFINE_WAIT(wait);
 
 	/*
 	 * Pipes are system-local resources, so sleeping on them
 	 * is considered a noninteractive wait:
 	 */
-	prepare_to_wait(PIPE_WAIT(*inode), &wait, TASK_INTERRUPTIBLE|TASK_NONINTERACTIVE);
+	prepare_to_wait(PIPE_WAIT(*inode), &wait, TASK_INTERRUPTIBLE|flag);
 	up(PIPE_SEM(*inode));
 	schedule();
 	finish_wait(PIPE_WAIT(*inode), &wait);
--- linux/kernel/sysctl.c.orig2	
+++ linux/kernel/sysctl.c	
@@ -66,6 +66,8 @@ extern int printk_ratelimit_jiffies;
 extern int printk_ratelimit_burst;
 extern int pid_max_min, pid_max_max;
 
+extern int pipe_noninteractive;
+
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 int unknown_nmi_panic;
 extern int proc_unknown_nmi_panic(ctl_table *, int, struct file *,
@@ -275,6 +277,14 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 	{
+		.ctl_name	= KERN_PANIC,
+		.procname	= "pipe_noninteractive",
+		.data		= &pipe_noninteractive,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
 		.ctl_name	= KERN_CORE_USES_PID,
 		.procname	= "core_uses_pid",
 		.data		= &core_uses_pid,
